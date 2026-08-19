/-
章「周期成分に付随する再帰的前像木符号の完全性」の具体版（前半）。
人手証明の正本は
structured-latex/content/recursive-preimage-tree-code.ts。

このファイルでは、人手証明の定義順に、非周期一段前像、最小前周期の増分と
有限上界、有限深さの入れ子多重集合符号、周期軌道と写像符号を形式化し、
共役不変性（写像符号の保存まで）を証明する。
符号一致からの再帰構成・完全性・有限決定は後続 tick で形式化する。
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

/-- 反復の加法則 `F^{m+n} = F^m ∘ F^n`（`m` の帰納法）。 -/
theorem iterate_add (m n : ℕ) (y : V → State) :
    iterate N f (m + n) y = iterate N f m (iterate N f n y) := by
  induction m with
  | zero => rw [Nat.zero_add, iterate_zero]
  | succ m ih => rw [Nat.succ_add, iterate_succ, ih, iterate_succ]

/-- 周期点は最小周期回の反復で自分自身へ戻る
    （最小前周期が零であることと周期性の組の定義による）。 -/
theorem iterate_minPeriod_eq_self (q : V → State) (hq : IsPeriodicPoint N f q) :
    iterate N f (minPeriod N f q) q = q := by
  have hμ : minPreperiod N f q = 0 := (isPeriodicPoint_iff_minPreperiod_zero N f q).1 hq
  have hpair := minPeriod_spec N f q
  rw [isPeriodicityPair_iff_collision] at hpair
  have hcol := hpair.2
  rw [hμ, Nat.zero_add, iterate_zero] at hcol
  exact hcol

/-- 周期点は最小周期の倍数回の反復で自分自身へ戻る（倍数の帰納法）。 -/
theorem iterate_mul_minPeriod_eq_self (q : V → State)
    (hq : IsPeriodicPoint N f q) (k : ℕ) :
    iterate N f (k * minPeriod N f q) q = q := by
  induction k with
  | zero => rw [Nat.zero_mul, iterate_zero]
  | succ k ih =>
      rw [Nat.succ_mul, iterate_add, iterate_minPeriod_eq_self N f q hq]
      exact ih

/-- 周期点の周期軌道の所属は、反復回数の存在量化と同値である
    （反復回数を最小周期で割った剰余に取り替える）。 -/
theorem mem_periodicOrbit_iff_exists (q z : V → State) (hq : IsPeriodicPoint N f q) :
    z ∈ periodicOrbit N f q ↔ ∃ n : ℕ, iterate N f n q = z := by
  constructor
  · intro hz
    obtain ⟨n, _, hn⟩ := Finset.mem_image.mp hz
    exact ⟨n, hn⟩
  · rintro ⟨n, rfl⟩
    have hlam : 0 < minPeriod N f q := one_le_minPeriod N f q
    refine Finset.mem_image.mpr
      ⟨n % minPeriod N f q, Finset.mem_range.mpr (Nat.mod_lt n hlam), ?_⟩
    conv_rhs => rw [← Nat.mod_add_div' n (minPeriod N f q)]
    rw [iterate_add, iterate_mul_minPeriod_eq_self N f q hq]

/-- 周期点はその周期軌道に属する。 -/
theorem mem_periodicOrbit_self (q : V → State) (hq : IsPeriodicPoint N f q) :
    q ∈ periodicOrbit N f q :=
  (mem_periodicOrbit_iff_exists N f q q hq).2 ⟨0, rfl⟩

/-- 周期軌道の元は周期点である（基点の最小周期が周期の証人になる）。 -/
theorem isPeriodicPoint_of_mem_periodicOrbit (q z : V → State)
    (hq : IsPeriodicPoint N f q) (hz : z ∈ periodicOrbit N f q) :
    IsPeriodicPoint N f z := by
  obtain ⟨n, rfl⟩ := (mem_periodicOrbit_iff_exists N f q z hq).1 hz
  refine ⟨minPeriod N f q, one_le_minPeriod N f q, ?_⟩
  rw [← iterate_add, Nat.add_comm, iterate_add, iterate_minPeriod_eq_self N f q hq]

/-- 周期軌道はその任意の元を基点にしても変わらない
    （基点から届く元は取り替えた基点からも届き、逆向きは周期で一周して戻る）。 -/
theorem periodicOrbit_eq_of_mem (q z : V → State)
    (hq : IsPeriodicPoint N f q) (hz : z ∈ periodicOrbit N f q) :
    periodicOrbit N f z = periodicOrbit N f q := by
  obtain ⟨n, hn⟩ := (mem_periodicOrbit_iff_exists N f q z hq).1 hz
  have hzper := isPeriodicPoint_of_mem_periodicOrbit N f q z hq hz
  have hlam : 1 ≤ minPeriod N f q := one_le_minPeriod N f q
  have hle : n ≤ n * minPeriod N f q := by
    calc n = n * 1 := (Nat.mul_one n).symm
    _ ≤ n * minPeriod N f q := Nat.mul_le_mul_left n hlam
  have hreach : iterate N f (n * minPeriod N f q - n) z = q := by
    rw [← hn, ← iterate_add]
    have hsum : n * minPeriod N f q - n + n = n * minPeriod N f q := by omega
    rw [hsum, iterate_mul_minPeriod_eq_self N f q hq]
  ext u
  rw [mem_periodicOrbit_iff_exists N f z u hzper,
    mem_periodicOrbit_iff_exists N f q u hq]
  constructor
  · rintro ⟨m, rfl⟩
    exact ⟨m + n, by rw [iterate_add, hn]⟩
  · rintro ⟨k, rfl⟩
    exact ⟨k + (n * minPeriod N f q - n), by rw [iterate_add, hreach]⟩

/-- 成分符号は周期軌道の基点の取り方に依存しない
    （`def_recursive_preimage_tree_code_component_code` の基点非依存性）。 -/
theorem componentCode_eq_of_mem (q z : V → State)
    (hq : IsPeriodicPoint N f q) (hz : z ∈ periodicOrbit N f q) :
    componentCode N f z = componentCode N f q := by
  unfold componentCode
  rw [periodicOrbit_eq_of_mem N f q z hq hz]

/-- 周期軌道の有限表の所属の言い換え。 -/
theorem mem_periodicOrbitTable_iff (O : Finset (V → State)) :
    O ∈ periodicOrbitTable N f ↔
      ∃ q, IsPeriodicPoint N f q ∧ periodicOrbit N f q = O := by
  simp [periodicOrbitTable]

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

/-- 共役全単射は周期軌道の有限表全体を全単射に移す。 -/
theorem image_periodicOrbitTable :
    (periodicOrbitTable N f).image (Finset.image h) = periodicOrbitTable NW fW := by
  ext O
  rw [mem_periodicOrbitTable_iff]
  constructor
  · intro hO
    obtain ⟨P, hP, rfl⟩ := Finset.mem_image.mp hO
    obtain ⟨q, hq, rfl⟩ := (mem_periodicOrbitTable_iff N f P).1 hP
    exact ⟨h q, (isPeriodicPoint_iff N f NW fW h hconj q).1 hq,
      (image_periodicOrbit N f NW fW h hconj q).symm⟩
  · rintro ⟨q', hq', rfl⟩
    obtain ⟨z, rfl⟩ := h.surjective q'
    have hz : IsPeriodicPoint N f z := (isPeriodicPoint_iff N f NW fW h hconj z).2 hq'
    exact Finset.mem_image.mpr ⟨periodicOrbit N f z,
      (mem_periodicOrbitTable_iff N f _).2 ⟨z, hz, rfl⟩,
      image_periodicOrbit N f NW fW h hconj z⟩

/-- 共役全単射は写像全体の符号を保存する
    （`claim_recursive_preimage_tree_code_conjugacy_invariance` の結論）。 -/
theorem mapCode_transport : mapCode NW fW = mapCode N f := by
  unfold mapCode
  rw [← image_periodicOrbitTable N f NW fW h hconj,
    Finset.image_val_of_injOn (Finset.image_injective h.injective).injOn,
    Multiset.map_map]
  refine Multiset.map_congr rfl fun O hO => ?_
  have hOmem : O ∈ periodicOrbitTable N f := hO
  obtain ⟨q, hq, rfl⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
  have hne : (periodicOrbit N f q).Nonempty := ⟨q, mem_periodicOrbit_self N f q hq⟩
  have hneW : ((periodicOrbit N f q).image h).Nonempty := hne.image h
  simp only [Function.comp_apply]
  rw [dif_pos hneW, dif_pos hne]
  obtain ⟨z, hzmem, hzeq⟩ := Finset.mem_image.mp hneW.choose_spec
  rw [← hzeq, componentCode_transport N f NW fW h hconj z,
    componentCode_eq_of_mem N f q z hq hzmem,
    componentCode_eq_of_mem N f q hne.choose hq hne.choose_spec]

end ConjugacyTransport

end CellularAutomata.RecursivePreimageTreeCode
