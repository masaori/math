/-
章「周期成分に付随する再帰的前像木符号の完全性」の具体版（前半）。
人手証明の正本は
structured-latex/content/recursive-preimage-tree-code.ts。

このファイルでは、人手証明の定義順に、非周期一段前像、最小前周期の増分と
有限上界、有限深さの入れ子多重集合符号、周期軌道と写像符号を形式化する。
共役不変性・符号一致からの再帰構成・完全性は後半で形式化する。
有限集合、自然数、写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberDepth
import CellularAutomata.IterateMonoidConjugacyInvariance
import CellularAutomata.PeriodicPointCount
import Mathlib.Data.Multiset.Sort

namespace CellularAutomata.RecursivePreimageTreeCode

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.GlobalMapIteration
open CellularAutomata.MinimalPreperiodPeriod
open CellularAutomata.PeriodicPointCount
open CellularAutomata.IterateMonoidStableFiberDepth

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

noncomputable local instance (p : Prop) : Decidable p := Classical.propDecidable p

/-- `C_F(y)`: 周期点から出る辺を除いた `y` の一段前像。 -/
noncomputable def nonperiodicChildren (y : V → State) : Finset (V → State) :=
  Finset.univ.filter fun z => globalMap N f z = y ∧ ¬ IsPeriodicPoint N f z

theorem mem_nonperiodicChildren_iff (y z : V → State) :
    z ∈ nonperiodicChildren N f y ↔
      globalMap N f z = y ∧ ¬ IsPeriodicPoint N f z := by
  simp [nonperiodicChildren]

/-- 非周期一段前像の最小前周期は親より一つ大きい。 -/
theorem child_minPreperiod_eq_add_one (y z : V → State)
    (hz : z ∈ nonperiodicChildren N f y) :
    minPreperiod N f z = minPreperiod N f y + 1 := by
  have hzdata := (mem_nonperiodicChildren_iff N f y z).1 hz
  have hzmu : minPreperiod N f z ≠ 0 := by
    intro hzero
    exact hzdata.2 ((isPeriodicPoint_iff_minPreperiod_zero N f z).2 hzero)
  have hzpos : 0 < minPreperiod N f z := Nat.pos_of_ne_zero hzmu
  have hdecrement := minPreperiod_globalMap_eq_sub_one N f z hzpos
  rw [hzdata.1] at hdecrement
  omega

/-- `μ(y) ≤ 2^|V| - 1`。 -/
theorem minPreperiod_le_configuration_card_sub_one (y : V → State) :
    minPreperiod N f y ≤ 2 ^ Fintype.card V - 1 := by
  have hsum := minPreperiod_add_minPeriod_le N f y
  have hperiod := one_le_minPeriod N f y
  omega

/-- 深さを有限値で打ち切った再帰的前像木符号の自然数表示。
    空多重集合を `1`、子符号の多重集合を対応する素数の積で表す。
    素因数分解の一意性により順序を捨て、重複度を保つ。 -/
noncomputable def codeAtDepth : ℕ → (V → State) → ℕ
  | 0, _ => 1
  | depth + 1, y =>
      Encodable.encode
        (((nonperiodicChildren N f y).val.map (codeAtDepth depth)).sort (· ≤ ·))

/-- 人手証明の上界 `2^|V|-1-μ(y)` を使った再帰的前像木符号。 -/
noncomputable def recursiveCode (y : V → State) : ℕ :=
  codeAtDepth N f (2 ^ Fintype.card V - 1 - minPreperiod N f y) y

/-- 深さ 0 では符号は空多重集合である。 -/
theorem codeAtDepth_zero (y : V → State) :
    codeAtDepth N f 0 y = 1 := rfl

/-- 後続深さでは子の符号を重複込みで集める。 -/
theorem codeAtDepth_succ (depth : ℕ) (y : V → State) :
    codeAtDepth N f (depth + 1) y =
      Encodable.encode
        (((nonperiodicChildren N f y).val.map (codeAtDepth N f depth)).sort (· ≤ ·)) := rfl

/-- 周期点 `q` を基点とする一周期の有限表。 -/
noncomputable def periodicOrbit (q : V → State) : Finset (V → State) :=
  (Finset.range (minPeriod N f q)).image fun n => iterate N f n q

/-- 周期点の基点語。 -/
noncomputable def baseWord (q : V → State) : List ℕ :=
  List.ofFn fun n : Fin (minPeriod N f q) => recursiveCode N f (iterate N f n q)

/-- 一つの周期軌道を、全基点語の有限集合で表した成分符号。 -/
noncomputable def componentCode (q : V → State) : Finset (List ℕ) :=
  (periodicOrbit N f q).image (baseWord N f)

/-- 全ての周期軌道を重複なく列挙する有限表。 -/
noncomputable def periodicOrbitTable : Finset (Finset (V → State)) :=
  ((Finset.univ.filter fun q => IsPeriodicPoint N f q).image (periodicOrbit N f))

/-- 写像全体の符号。異なる軌道の同じ成分符号は多重度を保つ。 -/
noncomputable def mapCode : Multiset (Finset (List ℕ)) :=
  (periodicOrbitTable N f).val.map fun orbit =>
    if h : orbit.Nonempty then componentCode N f h.choose else ∅

section ConjugacyTransport

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)
variable (h : (V → State) ≃ (W → State))
variable (hconj : ∀ y, h (globalMap N f y) = globalMap NW fW (h y))

include h hconj

/-- 共役全単射は周期点を両方向に移す。 -/
theorem isPeriodicPoint_iff (y : V → State) :
    IsPeriodicPoint N f y ↔ IsPeriodicPoint NW fW (h y) := by
  constructor
  · rintro ⟨n, hn, hperiod⟩
    refine ⟨n, hn, ?_⟩
    rw [← IterateMonoidConjugacyInvariance.conjugate_iterate
      N f NW fW h hconj n y, hperiod]
  · rintro ⟨n, hn, hperiod⟩
    refine ⟨n, hn, ?_⟩
    apply h.injective
    rw [IterateMonoidConjugacyInvariance.conjugate_iterate
      N f NW fW h hconj n y]
    exact hperiod

/-- 共役全単射は非周期一段前像を点ごとに移す。 -/
theorem mem_nonperiodicChildren_iff_transport (y z : V → State) :
    h z ∈ nonperiodicChildren NW fW (h y) ↔
      z ∈ nonperiodicChildren N f y := by
  rw [mem_nonperiodicChildren_iff, mem_nonperiodicChildren_iff]
  constructor
  · rintro ⟨hmap, hnonperiodic⟩
    refine ⟨h.injective ?_, ?_⟩
    · rw [hconj]
      exact hmap
    · intro hperiodic
      exact hnonperiodic ((isPeriodicPoint_iff N f NW fW h hconj z).1 hperiodic)
  · rintro ⟨hmap, hnonperiodic⟩
    refine ⟨?_, ?_⟩
    · rw [← hconj, hmap]
    · intro hperiodic
      exact hnonperiodic ((isPeriodicPoint_iff N f NW fW h hconj z).2 hperiodic)

/-- 共役全単射は非周期一段前像の有限表を全単射に移す。 -/
theorem image_nonperiodicChildren (y : V → State) :
    (nonperiodicChildren N f y).image h =
      nonperiodicChildren NW fW (h y) := by
  ext u
  constructor
  · intro hu
    obtain ⟨z, hz, rfl⟩ := Finset.mem_image.mp hu
    exact (mem_nonperiodicChildren_iff_transport N f NW fW h hconj y z).2 hz
  · intro hu
    obtain ⟨z, rfl⟩ := h.surjective u
    exact Finset.mem_image.mpr ⟨z,
      (mem_nonperiodicChildren_iff_transport N f NW fW h hconj y z).1 hu, rfl⟩

/-- 共役全単射は周期性の組を点ごとに両方向へ移す。 -/
theorem isPeriodicityPair_iff_transport (y : V → State) (i p : ℕ) :
    IsPeriodicityPair NW fW (h y) i p ↔ IsPeriodicityPair N f y i p := by
  rw [isPeriodicityPair_iff_collision, isPeriodicityPair_iff_collision]
  constructor
  · rintro ⟨hp, hcol⟩
    refine ⟨hp, h.injective ?_⟩
    rw [IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj,
      IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj, hcol]
  · rintro ⟨hp, hcol⟩
    refine ⟨hp, ?_⟩
    rw [← IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj,
      ← IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj, hcol]

/-- 共役全単射は各配位の最小前周期を保存する。 -/
theorem minPreperiod_transport (y : V → State) :
    minPreperiod NW fW (h y) = minPreperiod N f y := by
  apply le_antisymm
  · apply minPreperiod_le
    obtain ⟨p, hp⟩ := minPreperiod_spec N f y
    exact ⟨p, (isPeriodicityPair_iff_transport N f NW fW h hconj y _ p).2 hp⟩
  · apply minPreperiod_le
    obtain ⟨p, hp⟩ := minPreperiod_spec NW fW (h y)
    exact ⟨p, (isPeriodicityPair_iff_transport N f NW fW h hconj y _ p).1 hp⟩

/-- 共役全単射は各配位の最小周期を保存する。 -/
theorem minPeriod_transport (y : V → State) :
    minPeriod NW fW (h y) = minPeriod N f y := by
  have hμ := minPreperiod_transport N f NW fW h hconj y
  apply le_antisymm
  · apply minPeriod_le
    have hpair := (isPeriodicityPair_iff_transport N f NW fW h hconj y
      (minPreperiod N f y) (minPeriod N f y)).2 (minPeriod_spec N f y)
    rwa [← hμ] at hpair
  · apply minPeriod_le
    have hpair := (isPeriodicityPair_iff_transport N f NW fW h hconj y
      (minPreperiod NW fW (h y)) (minPeriod NW fW (h y))).1 (minPeriod_spec NW fW (h y))
    rwa [hμ] at hpair

omit hconj in
/-- 共役全単射が存在すれば二つの舞台のセル数は等しい
    （配位集合の個数 `2^|V|` が全単射で保存されることによる）。 -/
theorem card_cells_eq : Fintype.card V = Fintype.card W := by
  have hcard : (2 : ℕ) ^ Fintype.card V = 2 ^ Fintype.card W := by
    rw [← card_config (V := V), ← card_config (V := W)]
    exact Fintype.card_congr h
  exact Nat.pow_right_injective (le_refl 2) hcard

/-- 共役全単射は打ち切り深さごとの符号を保存する（深さの帰納法）。 -/
theorem codeAtDepth_transport (depth : ℕ) (y : V → State) :
    codeAtDepth NW fW depth (h y) = codeAtDepth N f depth y := by
  induction depth generalizing y with
  | zero => rfl
  | succ depth ih =>
      rw [codeAtDepth_succ, codeAtDepth_succ]
      congr 1
      have hval : (nonperiodicChildren NW fW (h y)).val
          = (nonperiodicChildren N f y).val.map h := by
        rw [← image_nonperiodicChildren N f NW fW h hconj y]
        exact Finset.image_val_of_injOn h.injective.injOn
      rw [hval, Multiset.map_map]
      congr 1
      exact Multiset.map_congr rfl fun z _ => ih z

/-- 共役全単射は再帰的前像木符号を点ごとに保存する。 -/
theorem recursiveCode_transport (y : V → State) :
    recursiveCode NW fW (h y) = recursiveCode N f y := by
  have hcard := card_cells_eq h
  simp only [recursiveCode, minPreperiod_transport N f NW fW h hconj y, ← hcard]
  exact codeAtDepth_transport N f NW fW h hconj _ y

/-- 共役全単射は周期点の基点語を保存する。 -/
theorem baseWord_transport (q : V → State) :
    baseWord NW fW (h q) = baseWord N f q := by
  simp only [baseWord, minPeriod_transport N f NW fW h hconj q]
  congr 1
  funext n
  simp only [Fin.val_cast]
  rw [← IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj (n : ℕ) q,
    recursiveCode_transport N f NW fW h hconj]

/-- 共役全単射は周期軌道の有限表を全単射に移す。 -/
theorem image_periodicOrbit (q : V → State) :
    (periodicOrbit N f q).image h = periodicOrbit NW fW (h q) := by
  simp only [periodicOrbit, minPeriod_transport N f NW fW h hconj q,
    Finset.image_image]
  exact Finset.image_congr fun n _ =>
    IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj n q

/-- 共役全単射は周期軌道の成分符号を保存する。 -/
theorem componentCode_transport (q : V → State) :
    componentCode NW fW (h q) = componentCode N f q := by
  simp only [componentCode]
  rw [← image_periodicOrbit N f NW fW h hconj q, Finset.image_image]
  exact Finset.image_congr fun r _ => baseWord_transport N f NW fW h hconj r

end ConjugacyTransport

end CellularAutomata.RecursivePreimageTreeCode
