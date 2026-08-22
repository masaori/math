/-
章「周期成分に付随する再帰的前像木符号の完全性」の具体版（構成途中）。
人手証明の正本は
structured-latex/content/recursive-preimage-tree-code.ts。

このファイルでは、人手証明の定義順に、非周期一段前像、最小前周期の増分と
有限上界、有限深さの入れ子多重集合符号、周期軌道と写像符号を形式化し、
共役不変性（写像符号の保存まで）を証明する。さらに、符号一致からの
再帰構成の最初の段として、等しい子符号多重集合から重複度を保つ子の
出現の全単射を構成し、その対応が子符号と親への一段写像を同時に保存する
ことを証明する。さらに、対応する周期成分の符号が等しいとき、等しい基点語を
持つ周期点を選び、その最小周期と周期上の各位置の再帰符号が一致することを示す。
共通深さの前像木対応から、各周期位置に付く前像木の節点数一致と、
その一周期にわたる有限和の一致も導く。各配位を最小前周期だけ進めて
到達する周期点の有限ファイバーが、全配位を重複なく被覆することも示す。
最小前周期差で切った相対深さ層と、その非周期一段前像ごとの再帰分解も示す。
十分な深さでの再帰的節点数と有限ファイバーの個数の一致も示す。
対応周期成分の節点数を全成分にわたって足し、写像符号の等号から
全配位数とセル数の一致も導く。
写像符号から得た配位数一致を使い、全配位集合の全単射も定義する。
再帰的な子対応が両側の一段発展を親へ移す局所可換性も証明する。
周期成分表が全配位を重複なく被覆し、各配位の成分添字が一意であることも示す。
対応する周期成分表ごとの有限全単射を、一意な成分添字に従って全配位写像へ接着する。
この写像を再帰的前像木対応で置き換えた全単射性・共役条件・完全性・有限決定は後続 tick で形式化する。
有限集合、自然数、写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.IterateMonoidStableFiberDepth
import CellularAutomata.IterateMonoidConjugacyInvariance
import CellularAutomata.PeriodicPointCount
import Mathlib.Data.Multiset.Fintype
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
    各段で子符号を整列した有限列にして符号化する。深さ零は、
    後続段で子がない場合と同じ空の有限列の符号にする。
    符号化の単射性により順序を捨て、重複度を保つ。 -/
noncomputable def codeAtDepth : ℕ → (V → State) → ℕ
  | 0, _ => Encodable.encode ([] : List ℕ)
  | depth + 1, y =>
      Encodable.encode
        (((nonperiodicChildren N f y).val.map (codeAtDepth depth)).sort (· ≤ ·))

/-- 人手証明の上界 `2^|V|-1-μ(y)` を使った再帰的前像木符号。 -/
noncomputable def recursiveCode (y : V → State) : ℕ :=
  codeAtDepth N f (2 ^ Fintype.card V - 1 - minPreperiod N f y) y

/-- 深さ 0 では符号は空多重集合である。 -/
theorem codeAtDepth_zero (y : V → State) :
    codeAtDepth N f 0 y = Encodable.encode ([] : List ℕ) := rfl

/-- 後続深さでは子の符号を重複込みで集める。 -/
theorem codeAtDepth_succ (depth : ℕ) (y : V → State) :
    codeAtDepth N f (depth + 1) y =
      Encodable.encode
        (((nonperiodicChildren N f y).val.map (codeAtDepth N f depth)).sort (· ≤ ·)) := rfl

/-- 非周期一段前像が空なら、深さ零と任意の正の深さは同じ空多重集合を符号化する。 -/
theorem codeAtDepth_succ_eq_zero_of_children_empty
    (depth : ℕ) (y : V → State)
    (hchildren : nonperiodicChildren N f y = ∅) :
    codeAtDepth N f (depth + 1) y = codeAtDepth N f 0 y := by
  rw [codeAtDepth_succ, codeAtDepth_zero, hchildren]
  congr 1
  simp

/-- 人手証明の残り深さを越えて打ち切りを延ばしても、再帰符号は変わらない。
    子では最小前周期が一つ増えるので残り深さが一つ減り、残り深さが零なら
    非周期一段前像は空であることだけを使う。 -/
theorem codeAtDepth_eq_recursiveCode_of_remaining_le
    (y : V → State) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 - minPreperiod N f y ≤ depth) :
    codeAtDepth N f depth y = recursiveCode N f y := by
  generalize hremaining : 2 ^ Fintype.card V - 1 - minPreperiod N f y = remaining at hdepth ⊢
  induction remaining using Nat.strong_induction_on generalizing y depth with
  | h remaining ih =>
      by_cases hzero : remaining = 0
      · have hchildren : nonperiodicChildren N f y = ∅ := by
          rw [Finset.eq_empty_iff_forall_notMem]
          intro z hz
          have hzmu := child_minPreperiod_eq_add_one N f y z hz
          have hzbound := minPreperiod_le_configuration_card_sub_one N f z
          omega
        cases depth with
        | zero => simp [recursiveCode, hremaining, hzero]
        | succ depth =>
            rw [codeAtDepth_succ_eq_zero_of_children_empty N f depth y hchildren]
            simp [recursiveCode, hremaining, hzero]
      · obtain ⟨remaining', hremainingSucc⟩ := Nat.exists_eq_succ_of_ne_zero hzero
        rw [hremainingSucc] at hdepth
        obtain ⟨depth', hdepthEq⟩ := Nat.exists_eq_add_of_le hdepth
        subst depth
        rw [Nat.succ_add]
        rw [codeAtDepth_succ, recursiveCode]
        rw [hremaining, hremainingSucc]
        congr 1
        congr 1
        apply Multiset.map_congr rfl
        intro z hz
        have hzfin : z ∈ nonperiodicChildren N f y := hz
        have hzmu := child_minPreperiod_eq_add_one N f y z hzfin
        have hzremaining :
            2 ^ Fintype.card V - 1 - minPreperiod N f z = remaining' := by
          omega
        calc
          codeAtDepth N f (remaining' + depth') z = recursiveCode N f z :=
            ih remaining' (by omega) z (remaining' + depth')
              hzremaining (Nat.le_add_right remaining' depth')
          _ = codeAtDepth N f remaining' z := by
            rw [recursiveCode, hzremaining]

/-- 二つの多重集合を写した結果が等しければ、各値を保つ出現の全単射を取れる。
    多重集合の出現型を使うので、同じ値を持つ相異なる子の重複度を失わない。 -/
theorem exists_occurrence_equiv_of_map_eq
    {X Y C : Type} [DecidableEq X] [DecidableEq Y]
    (s : Multiset X) (t : Multiset Y)
    (a : X → C) (b : Y → C) (hmap : s.map a = t.map b) :
    ∃ e : s ≃ t, ∀ x : s, b (e x) = a x := by
  let e : s ≃ t :=
    (s.mapEquiv a).trans (Multiset.cast hmap) |>.trans (t.mapEquiv b).symm
  refine ⟨e, fun x => ?_⟩
  have happly := Multiset.mapEquiv_apply t b
    ((t.mapEquiv b).symm ((Multiset.cast hmap) (s.mapEquiv a x)))
  simpa [e] using happly.symm

/-- 多重集合の出現型の元が表す値は、元の多重集合に属する。 -/
theorem occurrence_mem {X : Type} [DecidableEq X]
    (s : Multiset X) (x : s) : (x : X) ∈ s := by
  exact Multiset.coe_mem

section ChildCodeMatching

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

/-- 後続深さの符号が等しい二頂点では、非周期一段前像の一つ前の深さの
    符号多重集合が等しい。上の出現対応定理と合わせると、完全性証明の
    「等しい子符号の有限多重集合を対応させる」段になる。 -/
theorem child_code_multisets_eq_of_codeAtDepth_succ_eq
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hcode : codeAtDepth NW fW (depth + 1) yW = codeAtDepth N f (depth + 1) y) :
    (nonperiodicChildren N f y).val.map (codeAtDepth N f depth) =
      (nonperiodicChildren NW fW yW).val.map (codeAtDepth NW fW depth) := by
  rw [codeAtDepth_succ, codeAtDepth_succ] at hcode
  have hsorted := Encodable.encode_injective hcode
  have hcoerced := congrArg (fun xs : List ℕ => (xs : Multiset ℕ)) hsorted.symm
  simpa only [Multiset.sort_eq] using hcoerced

/-- 後続深さの符号が等しい二頂点の子の出現には、重複度を保ち、
    一つ前の深さの符号を保存する全単射がある。出現型の両側はそれぞれ
    親の非周期一段前像多重集合なので、この対応は前像木の一段を接着する。 -/
theorem exists_child_occurrence_equiv_of_codeAtDepth_succ_eq
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hcode : codeAtDepth NW fW (depth + 1) yW = codeAtDepth N f (depth + 1) y) :
    ∃ e : (nonperiodicChildren N f y).val ≃ (nonperiodicChildren NW fW yW).val,
      ∀ z : (nonperiodicChildren N f y).val,
        codeAtDepth NW fW depth (e z) = codeAtDepth N f depth z := by
  have hchildren := child_code_multisets_eq_of_codeAtDepth_succ_eq
    N f NW fW depth y yW hcode
  obtain ⟨e, hcode_preserved⟩ := exists_occurrence_equiv_of_map_eq
    (nonperiodicChildren N f y).val (nonperiodicChildren NW fW yW).val
    (codeAtDepth N f depth) (codeAtDepth NW fW depth) hchildren
  exact ⟨e, hcode_preserved⟩

/-- 深さ `depth` までの前像木の再帰的対応。後続段では、子の出現を
    重複度つきで全単射に対応させ、対応する各子で一つ浅い対応を要求する。 -/
def HasTreeMatching : (depth : ℕ) → (V → State) → (W → State) → Prop
  | 0, _, _ => True
  | depth + 1, y, yW =>
      ∃ e : (nonperiodicChildren N f y).val ≃ (nonperiodicChildren NW fW yW).val,
        ∀ z : (nonperiodicChildren N f y).val, HasTreeMatching depth z (e z)

/-- 正の深さの前像木対応から選ぶ子の全単射は、対応する各子を
    それぞれの親へ送る一段発展を両側で保存する。これは完全性証明の
    非周期辺上の共役条件そのものであり、全配位への接着はまだ行わない。 -/
theorem exists_child_equiv_preserving_parent_edges
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hmatch : HasTreeMatching N f NW fW (depth + 1) y yW) :
    ∃ e : (nonperiodicChildren N f y).val ≃ (nonperiodicChildren NW fW yW).val,
      ∀ z : (nonperiodicChildren N f y).val,
        HasTreeMatching N f NW fW depth z (e z) ∧
          globalMap N f z = y ∧ globalMap NW fW (e z) = yW := by
  obtain ⟨e, he⟩ := hmatch
  refine ⟨e, fun z => ⟨he z, ?_, ?_⟩⟩
  · exact (mem_nonperiodicChildren_iff N f y z).1
      (occurrence_mem (nonperiodicChildren N f y).val z) |>.1
  · exact (mem_nonperiodicChildren_iff NW fW yW (e z)).1
      (occurrence_mem (nonperiodicChildren NW fW yW).val (e z)) |>.1

/-- 打ち切り前像木の節点数。深さ零では根だけを数え、後続段では
    根と各非周期子を根とする一つ浅い木を数える。 -/
noncomputable def treeNodeCount : ℕ → (V → State) → ℕ
  | 0, _ => 1
  | depth + 1, y =>
      1 + ∑ z : (nonperiodicChildren N f y).val, treeNodeCount depth z

/-- 有限集合の基礎多重集合の出現型に沿う和は、有限集合上の和に等しい。 -/
theorem sum_occurrences_eq_finset_sum {X : Type} [Fintype X] [DecidableEq X]
    (s : Finset X) (g : X → ℕ) :
    (∑ z : s.val, g z) = ∑ z ∈ s, g z := by
  calc
    (∑ z : s.val, g z) = ∑ u : s.val.map g, (u : ℕ) := by
      rw [← Equiv.sum_comp (s.val.mapEquiv g) (fun u : (s.val.map g) ↦ (u : ℕ))]
      exact Fintype.sum_congr _ _ fun z => (Multiset.mapEquiv_apply s.val g z).symm
    _ = (s.val.map g).sum := (Multiset.sum_eq_sum_coe _).symm
    _ = ∑ z ∈ s, g z := rfl

/-- `k` が最小前周期を越えない範囲では、`k` 回反復した配位の
    最小前周期はちょうど `k` だけ減る。人手証明の
    `claim_recursive_preimage_tree_code_child_preperiod_increment` を
    経路に沿って繰り返す段に対応する。 -/
theorem minPreperiod_iterate_eq_sub
    (x : V → State) (k : ℕ) (hk : k ≤ minPreperiod N f x) :
    minPreperiod N f (iterate N f k x) = minPreperiod N f x - k := by
  induction k with
  | zero => simp [iterate_zero]
  | succ k ih =>
      have hk' : k ≤ minPreperiod N f x := by omega
      have hpos : 0 < minPreperiod N f (iterate N f k x) := by
        rw [ih hk']
        omega
      rw [iterate_succ, minPreperiod_globalMap_eq_sub_one N f _ hpos, ih hk']
      omega

/-- 根 `y` から逆向きにちょうど `k` 段にある節点の有限表。
    最小前周期差と `k` 回反復の二条件を同時に記録するため、
    周期辺を除いた前像木の層だけを数える。 -/
noncomputable def relativePreimageTreeLayer
    (y : V → State) (k : ℕ) : Finset (V → State) :=
  Finset.univ.filter fun x =>
    minPreperiod N f x = minPreperiod N f y + k ∧ iterate N f k x = y

theorem mem_relativePreimageTreeLayer_iff
    (y x : V → State) (k : ℕ) :
    x ∈ relativePreimageTreeLayer N f y k ↔
      minPreperiod N f x = minPreperiod N f y + k ∧ iterate N f k x = y := by
  simp [relativePreimageTreeLayer]

/-- 相対深さ零の層は根だけからなる。 -/
theorem relativePreimageTreeLayer_zero (y : V → State) :
    relativePreimageTreeLayer N f y 0 = {y} := by
  ext x
  simp only [mem_relativePreimageTreeLayer_iff, Nat.add_zero, iterate_zero,
    Finset.mem_singleton]
  constructor
  · exact fun h => h.2
  · intro hxy
    subst x
    exact ⟨rfl, rfl⟩

/-- 一つ深い相対層は、非周期一段前像を根とする相対層へ重複なく分かれる。
    `card_eq_sum_card_fiberwise` の分類写像は、深さ `k+1` の節点を
    `k` 回進めて得る `y` の非周期一段前像である。 -/
theorem relativePreimageTreeLayer_card_succ
    (y : V → State) (k : ℕ) :
    (relativePreimageTreeLayer N f y (k + 1)).card =
      ∑ z ∈ nonperiodicChildren N f y,
        (relativePreimageTreeLayer N f z k).card := by
  let source := relativePreimageTreeLayer N f y (k + 1)
  let target := nonperiodicChildren N f y
  let parent : (V → State) → (V → State) := fun x => iterate N f k x
  have hmaps : ∀ x ∈ source, parent x ∈ target := by
    intro x hx
    have hxdata := (mem_relativePreimageTreeLayer_iff N f y x (k + 1)).1 hx
    have hkmu : k ≤ minPreperiod N f x := by omega
    have hmuParent := minPreperiod_iterate_eq_sub N f x k hkmu
    have hparentNonperiodic : ¬ IsPeriodicPoint N f (parent x) := by
      intro hperiodic
      have hzero := (isPeriodicPoint_iff_minPreperiod_zero N f (parent x)).1 hperiodic
      rw [hmuParent] at hzero
      omega
    apply (mem_nonperiodicChildren_iff N f y (parent x)).2
    refine ⟨?_, hparentNonperiodic⟩
    change globalMap N f (iterate N f k x) = y
    rw [← iterate_succ]
    exact hxdata.2
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  calc
    ∑ z ∈ target, (source.filter fun x => parent x = z).card =
        ∑ z ∈ target, (relativePreimageTreeLayer N f z k).card := by
      apply Finset.sum_congr rfl
      intro z hz
      apply congrArg Finset.card
      ext x
      have hzchild : z ∈ nonperiodicChildren N f y := hz
      have hzmu := child_minPreperiod_eq_add_one N f y z hzchild
      simp only [Finset.mem_filter]
      dsimp only [source, parent]
      change
        (x ∈ relativePreimageTreeLayer N f y (k + 1) ∧ iterate N f k x = z) ↔
          x ∈ relativePreimageTreeLayer N f z k
      rw [mem_relativePreimageTreeLayer_iff, mem_relativePreimageTreeLayer_iff]
      constructor
      · rintro ⟨hxlayer, hparent⟩
        refine ⟨?_, hparent⟩
        omega
      · rintro ⟨hxmu, hxiterate⟩
        refine ⟨⟨?_, ?_⟩, hxiterate⟩
        · omega
        · rw [iterate_succ, hxiterate]
          exact (mem_nonperiodicChildren_iff N f y z).1 hzchild |>.1

/-- 打ち切り前像木の再帰的な節点数は、根からの相対深さが
    打ち切り深さ以下である層の個数の和に等しい。一つ深い層の
    一段再帰分解を、深さに関する帰納法で足し上げる。 -/
theorem treeNodeCount_eq_sum_relativePreimageTreeLayer_card
    (y : V → State) (depth : ℕ) :
    treeNodeCount N f depth y =
      ∑ k ∈ Finset.range (depth + 1),
        (relativePreimageTreeLayer N f y k).card := by
  induction depth generalizing y with
  | zero =>
      simp [treeNodeCount, relativePreimageTreeLayer_zero]
  | succ depth ih =>
      rw [treeNodeCount]
      rw [sum_occurrences_eq_finset_sum]
      simp_rw [ih]
      rw [Finset.sum_comm]
      simp_rw [← relativePreimageTreeLayer_card_succ N f]
      rw [Nat.add_comm]
      simpa [relativePreimageTreeLayer_zero, Nat.add_assoc] using
        (Finset.sum_range_succ'
          (fun k => (relativePreimageTreeLayer N f y k).card) (depth + 1)).symm

/-- 前像木対応は、同じ打ち切り深さまでの節点数を保存する。 -/
theorem treeNodeCount_eq_of_hasTreeMatching
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hmatch : HasTreeMatching N f NW fW depth y yW) :
    treeNodeCount NW fW depth yW = treeNodeCount N f depth y := by
  induction depth generalizing y yW with
  | zero => rfl
  | succ depth ih =>
      obtain ⟨e, he⟩ := hmatch
      simp only [treeNodeCount]
      congr 1
      rw [← e.sum_comp]
      exact Fintype.sum_congr _ _ fun z => ih z (e z) (he z)

/-- 等しい打ち切り符号から、その深さ全体にわたる前像木の対応を
    深さ帰納法で構成できる。各帰納段は直前の子出現対応だけを使う。 -/
theorem hasTreeMatching_of_codeAtDepth_eq
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hcode : codeAtDepth NW fW depth yW = codeAtDepth N f depth y) :
    HasTreeMatching N f NW fW depth y yW := by
  induction depth generalizing y yW with
  | zero => trivial
  | succ depth ih =>
      obtain ⟨e, he⟩ := exists_child_occurrence_equiv_of_codeAtDepth_succ_eq
        N f NW fW depth y yW hcode
      exact ⟨e, fun z => ih z (e z) (he z)⟩

end ChildCodeMatching

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

/-- 最小周期より前の反復値は相異なる。周期軌道の有限表を、
    反復回数の有限区間から重複なく添字付けするために使う。 -/
theorem iterate_injective_before_minPeriod (q : V → State)
    (hq : IsPeriodicPoint N f q) :
    Set.InjOn (fun n => iterate N f n q) (Finset.range (minPeriod N f q)) := by
  intro a ha b hb hab
  simp only [Finset.mem_coe, Finset.mem_range] at ha hb
  by_contra hne
  have impossible {a b : ℕ} (ha : a < minPeriod N f q)
      (hb : b < minPeriod N f q) (hablt : a < b)
      (hab : iterate N f a q = iterate N f b q) : False := by
    have hreturn : iterate N f (b - a) q = q := by
      apply_fun (iterate N f (minPeriod N f q - a)) at hab
      rw [← iterate_add, ← iterate_add] at hab
      have hleft : minPeriod N f q - a + a = minPeriod N f q := by omega
      have hright : minPeriod N f q - a + b = minPeriod N f q + (b - a) := by omega
      rw [hleft, hright, iterate_minPeriod_eq_self N f q hq] at hab
      rw [Nat.add_comm (minPeriod N f q) (b - a), iterate_add,
        iterate_minPeriod_eq_self N f q hq] at hab
      exact hab.symm
    have hpair : IsPeriodicityPair N f q 0 (b - a) := by
      rw [isPeriodicityPair_iff_collision]
      exact ⟨by omega, by simpa [iterate_zero] using hreturn⟩
    have hmu : minPreperiod N f q = 0 :=
      (isPeriodicPoint_iff_minPreperiod_zero N f q).1 hq
    have hle : minPeriod N f q ≤ b - a := by
      apply minPeriod_le N f q
      simpa [hmu] using hpair
    omega
  rcases lt_or_gt_of_ne hne with hablt | hbalt
  · exact impossible ha hb hablt hab
  · exact impossible hb ha hbalt hab.symm

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

section ComponentCodeMatching

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

/-- 対応する周期成分の符号が等しければ、両周期軌道から等しい基点語を
    持つ周期点を選べる。成分符号を有限集合として定義した段をそのまま戻す。 -/
theorem exists_baseWord_eq_of_componentCode_eq
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q)
    (hcode : componentCode NW fW qW = componentCode N f q) :
    ∃ r : V → State, ∃ rW : W → State,
      r ∈ periodicOrbit N f q ∧ rW ∈ periodicOrbit NW fW qW ∧
        baseWord NW fW rW = baseWord N f r := by
  have hqmem : q ∈ periodicOrbit N f q := mem_periodicOrbit_self N f q hq
  have hword : baseWord N f q ∈ componentCode N f q := by
    exact Finset.mem_image.mpr ⟨q, hqmem, rfl⟩
  rw [← hcode] at hword
  obtain ⟨rW, hrW, hbase⟩ := Finset.mem_image.mp hword
  exact ⟨q, rW, hqmem, hrW, hbase⟩

/-- 等しい基点語の長さは等しいので、二つの基点の最小周期は等しい。 -/
theorem minPeriod_eq_of_baseWord_eq
    (r : V → State) (rW : W → State)
    (hbase : baseWord NW fW rW = baseWord N f r) :
    minPeriod NW fW rW = minPeriod N f r := by
  have hlength := congrArg List.length hbase
  simpa [baseWord] using hlength

/-- 等しい基点語を持つ周期点では、一周期の対応する各位置に付く
    再帰的前像木符号が一致する。これは周期辺を接着する際の頂点ごとの条件である。 -/
theorem recursiveCode_iterate_eq_of_baseWord_eq
    (r : V → State) (rW : W → State)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : ℕ) (hn : n < minPeriod N f r) :
    recursiveCode NW fW (iterate NW fW n rW) =
      recursiveCode N f (iterate N f n r) := by
  have hperiod := minPeriod_eq_of_baseWord_eq N f NW fW r rW hbase
  have hnW : n < minPeriod NW fW rW := by simpa [hperiod] using hn
  have hentry := congrArg (fun xs : List ℕ => xs[n]?) hbase
  simpa [baseWord, hn, hnW] using hentry

/-- 等しい基点語を持つ周期点では、同じ有限添字で並べた周期点対応が
    周期辺を保存する。最後の添字から基点へ戻る場合も、両側の最小周期が
    等しいことと最小周期回の帰還だけを使う。 -/
theorem periodic_index_matching_preserves_edges
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : ℕ) (hn : n < minPeriod N f r) :
    globalMap N f (iterate N f n r) =
        (if n + 1 < minPeriod N f r then iterate N f (n + 1) r else r) ∧
      globalMap NW fW (iterate NW fW n rW) =
        (if n + 1 < minPeriod N f r then iterate NW fW (n + 1) rW else rW) := by
  have hperiod := minPeriod_eq_of_baseWord_eq N f NW fW r rW hbase
  by_cases hnext : n + 1 < minPeriod N f r
  · simp only [hnext, if_true]
    exact ⟨iterate_succ N f n r, iterate_succ NW fW n rW⟩
  · simp only [hnext, if_false]
    have hnlast : n + 1 = minPeriod N f r := by omega
    constructor
    · rw [← iterate_succ, hnlast, iterate_minPeriod_eq_self N f r hr]
    · rw [← iterate_succ, hnlast, ← hperiod,
        iterate_minPeriod_eq_self NW fW rW hrW]

end ComponentCodeMatching

/-- 周期軌道の有限表の所属の言い換え。 -/
theorem mem_periodicOrbitTable_iff (O : Finset (V → State)) :
    O ∈ periodicOrbitTable N f ↔
      ∃ q, IsPeriodicPoint N f q ∧ periodicOrbit N f q = O := by
  simp [periodicOrbitTable]

/-- 周期軌道表の各元は空でない。写像符号で用いる代表元の選択が、
    周期点自身を証人として常に可能であることを明示する。 -/
theorem periodicOrbitTable_member_nonempty
    (O : Finset (V → State)) (hO : O ∈ periodicOrbitTable N f) : O.Nonempty := by
  obtain ⟨q, hq, rfl⟩ := (mem_periodicOrbitTable_iff N f O).1 hO
  exact ⟨q, mem_periodicOrbit_self N f q hq⟩

/-- 周期軌道表の元に属する配位は周期点である。 -/
theorem isPeriodicPoint_of_mem_periodicOrbitTable
    (O : Finset (V → State)) (hO : O ∈ periodicOrbitTable N f)
    (q : V → State) (hq : q ∈ O) : IsPeriodicPoint N f q := by
  obtain ⟨r, hr, rfl⟩ := (mem_periodicOrbitTable_iff N f O).1 hO
  exact isPeriodicPoint_of_mem_periodicOrbit N f r q hr hq

section OrbitOccurrenceMatching

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

/-- 写像符号の多重集合が等しければ、周期軌道の出現を重複度つきで
    全単射に対応させられ、対応する軌道では選択した代表元の成分符号が等しい。 -/
theorem exists_periodicOrbit_occurrence_equiv_of_mapCode_eq
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        (if hO : (e O : Finset (W → State)).Nonempty then
            componentCode NW fW hO.choose else ∅) =
          (if hO : (O : Finset (V → State)).Nonempty then
            componentCode N f hO.choose else ∅) := by
  apply exists_occurrence_equiv_of_map_eq
    (periodicOrbitTable N f).val (periodicOrbitTable NW fW).val
    (fun orbit => if hO : orbit.Nonempty then componentCode N f hO.choose else ∅)
    (fun orbit => if hO : orbit.Nonempty then componentCode NW fW hO.choose else ∅)
  simpa only [mapCode] using hcode.symm

/-- 写像符号が等しいとき、周期軌道の各出現を対応させたうえで、
    対応する各軌道から等しい基点語を持つ周期点の組を選べる。 -/
theorem exists_orbit_equiv_with_equal_baseWords
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              baseWord NW fW rW = baseWord N f r := by
  obtain ⟨e, he⟩ := exists_periodicOrbit_occurrence_equiv_of_mapCode_eq
    N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hON : (O : Finset (V → State)).Nonempty :=
    periodicOrbitTable_member_nonempty N f O hOmem
  have hOW : (e O : Finset (W → State)).Nonempty :=
    periodicOrbitTable_member_nonempty NW fW (e O) heOmem
  have hcomponent := he O
  rw [dif_pos hOW, dif_pos hON] at hcomponent
  have hperiodic : IsPeriodicPoint N f hON.choose :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem hON.choose hON.choose_spec
  obtain ⟨r, rW, hr, hrW, hbase⟩ := exists_baseWord_eq_of_componentCode_eq
    N f NW fW hON.choose hOW.choose hperiodic hcomponent
  have hOrbitW : periodicOrbit NW fW hOW.choose = (e O : Finset (W → State)) := by
    obtain ⟨qW, hqW, hqWO⟩ :=
      (mem_periodicOrbitTable_iff NW fW (e O)).1 heOmem
    rw [periodicOrbit_eq_of_mem NW fW qW hOW.choose hqW]
    · exact hqWO
    · rw [hqWO]
      exact hOW.choose_spec
  have hOrbitNSet : periodicOrbit N f hON.choose = (O : Finset (V → State)) := by
    obtain ⟨q, hq, hqO⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
    rw [periodicOrbit_eq_of_mem N f q hON.choose hq]
    · exact hqO
    · rw [hqO]
      exact hON.choose_spec
  exact ⟨r, rW, by rwa [← hOrbitNSet], by rwa [← hOrbitW], hbase⟩

end OrbitOccurrenceMatching

section OrbitTreeMatching

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

/-- 等しい基点語を持つ周期点の対応に、両舞台のセル数一致を仮定せず、
    二つの有限上界の最大値まで前像木対応を接着する。葉の空多重集合符号が
    追加の深さで変わらないことにより、異なる打ち切り深さを共通化できる。 -/
theorem hasTreeMatching_iterate_of_baseWord_eq_commonDepth
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : ℕ) (hn : n < minPeriod N f r) :
    HasTreeMatching N f NW fW
      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
      (iterate N f n r) (iterate NW fW n rW) := by
  have hrnMem : iterate N f n r ∈ periodicOrbit N f r :=
    (mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩
  have hrWnMem : iterate NW fW n rW ∈ periodicOrbit NW fW rW :=
    (mem_periodicOrbit_iff_exists NW fW rW _ hrW).2 ⟨n, rfl⟩
  have hrn : IsPeriodicPoint N f (iterate N f n r) :=
    isPeriodicPoint_of_mem_periodicOrbit N f r _ hr hrnMem
  have hrWn : IsPeriodicPoint NW fW (iterate NW fW n rW) :=
    isPeriodicPoint_of_mem_periodicOrbit NW fW rW _ hrW hrWnMem
  have hmu : minPreperiod N f (iterate N f n r) = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero N f _).1 hrn
  have hmuW : minPreperiod NW fW (iterate NW fW n rW) = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero NW fW _).1 hrWn
  let commonDepth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
  have hstableV :
      codeAtDepth N f commonDepth (iterate N f n r) =
        recursiveCode N f (iterate N f n r) := by
    apply codeAtDepth_eq_recursiveCode_of_remaining_le
    simpa [commonDepth, hmu] using
      (Nat.le_max_left (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
  have hstableW :
      codeAtDepth NW fW commonDepth (iterate NW fW n rW) =
        recursiveCode NW fW (iterate NW fW n rW) := by
    apply codeAtDepth_eq_recursiveCode_of_remaining_le
    simpa [commonDepth, hmuW] using
      (Nat.le_max_right (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
  have hrecursive := recursiveCode_iterate_eq_of_baseWord_eq
    N f NW fW r rW hbase n hn
  apply hasTreeMatching_of_codeAtDepth_eq N f NW fW
  exact hstableW.trans (hrecursive.trans hstableV.symm)

/-- 等しい基点語を持つ周期点の対応では、共通深さまでに流入する
    非周期前像木の節点数が周期上の各位置で一致する。 -/
theorem treeNodeCount_iterate_eq_of_baseWord_eq_commonDepth
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : ℕ) (hn : n < minPeriod N f r) :
    treeNodeCount NW fW
        (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
        (iterate NW fW n rW) =
      treeNodeCount N f
        (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
        (iterate N f n r) := by
  apply treeNodeCount_eq_of_hasTreeMatching N f NW fW
  exact hasTreeMatching_iterate_of_baseWord_eq_commonDepth
    N f NW fW r rW hr hrW hbase n hn

/-- 周期軌道の各位置に付く前像木の節点数を、一周期にわたって足した有限和。 -/
noncomputable def periodicOrbitTreeNodeCount
    (depth : ℕ) (q : V → State) : ℕ :=
  (Finset.range (minPeriod N f q)).sum fun n =>
    treeNodeCount N f depth (iterate N f n q)

/-- 各配位を、その最小前周期だけ進めて到達する周期点へ送る写像。 -/
noncomputable def eventualPeriodicRoot (y : V → State) : V → State :=
  iterate N f (minPreperiod N f y) y

/-- 最小前周期だけ進めた先は周期点である。 -/
theorem eventualPeriodicRoot_isPeriodicPoint (y : V → State) :
    IsPeriodicPoint N f (eventualPeriodicRoot N f y) := by
  refine ⟨minPeriod N f y, one_le_minPeriod N f y, ?_⟩
  have hcollision :=
    ((isPeriodicityPair_iff_collision N f y _ _).1 (minPeriod_spec N f y)).2
  rw [eventualPeriodicRoot, ← iterate_add, Nat.add_comm]
  exact hcollision

/-- 周期点 `q` に流入する前像木の全節点を、有限配位表のファイバーとして列挙する。 -/
noncomputable def preimageTreeNodeTable (q : V → State) : Finset (V → State) :=
  Finset.univ.filter fun y => eventualPeriodicRoot N f y = q

theorem mem_preimageTreeNodeTable_iff (q y : V → State) :
    y ∈ preimageTreeNodeTable N f q ↔ eventualPeriodicRoot N f y = q := by
  simp [preimageTreeNodeTable]

/-- 周期点 `q` へ流入する有限表は、根からの相対深さが
    `2^|V|-1` 以下である層へ重複なく分かれる。分類写像は各節点の
    最小前周期であり、その値は有限配位数から得た上界内にある。 -/
theorem sum_relativePreimageTreeLayer_card_eq_preimageTreeNodeTable_card
    (q : V → State) (hq : IsPeriodicPoint N f q) :
    ∑ k ∈ Finset.range (2 ^ Fintype.card V - 1 + 1),
        (relativePreimageTreeLayer N f q k).card =
      (preimageTreeNodeTable N f q).card := by
  let source := preimageTreeNodeTable N f q
  let target := Finset.range (2 ^ Fintype.card V - 1 + 1)
  let relativeDepth : (V → State) → ℕ := fun x => minPreperiod N f x
  have hmaps : ∀ x ∈ source, relativeDepth x ∈ target := by
    intro x _hx
    apply Finset.mem_range.mpr
    dsimp only [relativeDepth, target]
    have hbound := minPreperiod_le_configuration_card_sub_one N f x
    omega
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro k hk
  apply congrArg Finset.card
  ext x
  have hqmu : minPreperiod N f q = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero N f q).1 hq
  simp only [Finset.mem_filter]
  dsimp only [source, relativeDepth]
  rw [mem_relativePreimageTreeLayer_iff]
  constructor
  · rintro ⟨hxmu, hxiterate⟩
    have hxmu' : minPreperiod N f x = k := by omega
    refine ⟨(mem_preimageTreeNodeTable_iff N f q x).2 ?_, hxmu'⟩
    unfold eventualPeriodicRoot
    simpa [hxmu'] using hxiterate
  · rintro ⟨hxtable, hxmu⟩
    have hxroot := (mem_preimageTreeNodeTable_iff N f q x).1 hxtable
    unfold eventualPeriodicRoot at hxroot
    refine ⟨?_, ?_⟩
    · omega
    · simpa [hxmu] using hxroot

/-- 有限配位数から得た十分な打ち切り深さでは、再帰的前像木の
    節点数は、周期点 `q` へ流入する有限表の個数に一致する。 -/
theorem treeNodeCount_card_bound_eq_preimageTreeNodeTable_card
    (q : V → State) (hq : IsPeriodicPoint N f q) :
    treeNodeCount N f (2 ^ Fintype.card V - 1) q =
      (preimageTreeNodeTable N f q).card := by
  rw [treeNodeCount_eq_sum_relativePreimageTreeLayer_card]
  exact sum_relativePreimageTreeLayer_card_eq_preimageTreeNodeTable_card N f q hq

/-- 配位数から得た上界より深い相対層は空である。 -/
theorem relativePreimageTreeLayer_eq_empty_of_card_bound_lt
    (q : V → State) (hq : IsPeriodicPoint N f q) (k : ℕ)
    (hk : 2 ^ Fintype.card V - 1 < k) :
    relativePreimageTreeLayer N f q k = ∅ := by
  rw [Finset.eq_empty_iff_forall_notMem]
  intro x hx
  have hxdata := (mem_relativePreimageTreeLayer_iff N f q x k).1 hx
  have hqmu : minPreperiod N f q = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero N f q).1 hq
  have hxbound := minPreperiod_le_configuration_card_sub_one N f x
  omega

/-- 配位数から得た上界以上まで打ち切れば、前像木節点数は
    周期点へ流入する有限表の個数に一致する。 -/
theorem treeNodeCount_eq_preimageTreeNodeTable_card_of_card_bound_le
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth) :
    treeNodeCount N f depth q = (preimageTreeNodeTable N f q).card := by
  rw [treeNodeCount_eq_sum_relativePreimageTreeLayer_card]
  calc
    (∑ k ∈ Finset.range (depth + 1),
        (relativePreimageTreeLayer N f q k).card) =
        ∑ k ∈ Finset.range (2 ^ Fintype.card V - 1 + 1),
          (relativePreimageTreeLayer N f q k).card := by
      symm
      apply Finset.sum_subset (Finset.range_mono (Nat.succ_le_succ hdepth))
      intro k hkdepth hkbound
      have hk : 2 ^ Fintype.card V - 1 < k := by
        simp only [Finset.mem_range, Nat.not_lt] at hkbound
        omega
      rw [relativePreimageTreeLayer_eq_empty_of_card_bound_lt N f q hq k hk]
      rfl
    _ = (preimageTreeNodeTable N f q).card :=
      sum_relativePreimageTreeLayer_card_eq_preimageTreeNodeTable_card N f q hq

/-- 相異なる周期点に流入する二つの前像木節点表は交わらない。 -/
theorem preimageTreeNodeTable_disjoint
    (q r : V → State) (hqr : q ≠ r) :
    Disjoint (preimageTreeNodeTable N f q) (preimageTreeNodeTable N f r) := by
  rw [Finset.disjoint_left]
  intro y hyq hyr
  apply hqr
  exact ((mem_preimageTreeNodeTable_iff N f q y).1 hyq).symm.trans
    ((mem_preimageTreeNodeTable_iff N f r y).1 hyr)

/-- 周期点を添字とする前像木節点表は、全配位を重複なく被覆する。 -/
theorem preimageTreeNodeTables_cover :
    (Finset.univ.filter fun q => IsPeriodicPoint N f q).biUnion
        (preimageTreeNodeTable N f) = Finset.univ := by
  ext y
  simp only [Finset.mem_biUnion, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · rintro ⟨q, _hq, hy⟩
    trivial
  · intro _hy
    refine ⟨eventualPeriodicRoot N f y,
      eventualPeriodicRoot_isPeriodicPoint N f y, ?_⟩
    exact (mem_preimageTreeNodeTable_iff N f _ y).2 rfl

/-- 全周期点に付く前像木の節点数の和は、全配位数に等しい。
    `card_eq_sum_card_fiberwise` は一意な周期根による有限ファイバー分割を数える。 -/
theorem sum_preimageTreeNodeTable_card_eq_configurations :
    ∑ q ∈ (Finset.univ.filter fun q => IsPeriodicPoint N f q),
        (preimageTreeNodeTable N f q).card = 2 ^ Fintype.card V := by
  have hmaps : ∀ y ∈ (Finset.univ : Finset (V → State)),
      eventualPeriodicRoot N f y ∈
        (Finset.univ.filter fun q => IsPeriodicPoint N f q) := by
    intro y _hy
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    exact eventualPeriodicRoot_isPeriodicPoint N f y
  change ∑ q ∈ (Finset.univ.filter fun q => IsPeriodicPoint N f q),
      (Finset.univ.filter fun y => eventualPeriodicRoot N f y = q).card =
        2 ^ Fintype.card V
  rw [← Finset.card_eq_sum_card_fiberwise hmaps]
  exact card_config

/-- 周期軌道 `O` へ最終的に流入する全配位の有限表。 -/
noncomputable def periodicComponentNodeTable
    (O : Finset (V → State)) : Finset (V → State) :=
  Finset.univ.filter fun y => periodicOrbit N f (eventualPeriodicRoot N f y) = O

/-- 周期成分表への所属は、最終周期根の軌道が添字の周期軌道に等しいことと同値である。 -/
theorem mem_periodicComponentNodeTable_iff
    (O : Finset (V → State)) (y : V → State) :
    y ∈ periodicComponentNodeTable N f O ↔
      periodicOrbit N f (eventualPeriodicRoot N f y) = O := by
  simp [periodicComponentNodeTable]

/-- 相異なる周期軌道に流入する周期成分表は交わらない。 -/
theorem periodicComponentNodeTable_disjoint
    (O P : Finset (V → State)) (hOP : O ≠ P) :
    Disjoint (periodicComponentNodeTable N f O)
      (periodicComponentNodeTable N f P) := by
  rw [Finset.disjoint_left]
  intro y hyO hyP
  apply hOP
  exact ((mem_periodicComponentNodeTable_iff N f O y).1 hyO).symm.trans
    ((mem_periodicComponentNodeTable_iff N f P y).1 hyP)

/-- 周期軌道表で添字付けた周期成分表は全配位を被覆する。 -/
theorem periodicComponentNodeTables_cover :
    (periodicOrbitTable N f).biUnion (periodicComponentNodeTable N f) =
      Finset.univ := by
  ext y
  simp only [Finset.mem_biUnion, Finset.mem_univ, iff_true]
  let O := periodicOrbit N f (eventualPeriodicRoot N f y)
  have hO : O ∈ periodicOrbitTable N f := by
    apply (mem_periodicOrbitTable_iff N f O).2
    exact ⟨eventualPeriodicRoot N f y,
      eventualPeriodicRoot_isPeriodicPoint N f y, rfl⟩
  exact ⟨O, hO, (mem_periodicComponentNodeTable_iff N f O y).2 rfl⟩

/-- 各配位が属する周期成分表の添字は、周期軌道表の中でただ一つである。
    全成分の対応を一つの全配位対応へ接着するときの一意な成分選択に使う。 -/
theorem exists_unique_periodicComponent (y : V → State) :
    ∃! O : (periodicOrbitTable N f),
      y ∈ periodicComponentNodeTable N f O := by
  let O := periodicOrbit N f (eventualPeriodicRoot N f y)
  have hO : O ∈ periodicOrbitTable N f := by
    apply (mem_periodicOrbitTable_iff N f O).2
    exact ⟨eventualPeriodicRoot N f y,
      eventualPeriodicRoot_isPeriodicPoint N f y, rfl⟩
  refine ⟨⟨O, hO⟩, (mem_periodicComponentNodeTable_iff N f O y).2 rfl, ?_⟩
  intro P hyP
  apply Subtype.ext
  exact ((mem_periodicComponentNodeTable_iff N f P y).1 hyP).symm

/-- 周期点を基点とする一周期の前像木節点数は、十分な深さでは
    その周期成分へ流入する全配位の個数に一致する。 -/
theorem periodicOrbitTreeNodeCount_eq_periodicComponentNodeTable_card
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth) :
    periodicOrbitTreeNodeCount N f depth q =
      (periodicComponentNodeTable N f (periodicOrbit N f q)).card := by
  have hinj := iterate_injective_before_minPeriod N f q hq
  unfold periodicOrbitTreeNodeCount periodicComponentNodeTable periodicOrbit
  rw [← Finset.sum_image hinj]
  let source := Finset.univ.filter fun y =>
    periodicOrbit N f (eventualPeriodicRoot N f y) = periodicOrbit N f q
  let target := (Finset.range (minPeriod N f q)).image fun n => iterate N f n q
  let root : (V → State) → (V → State) := eventualPeriodicRoot N f
  have hmaps : ∀ y ∈ source, root y ∈ target := by
    intro y hy
    have hyorbit : periodicOrbit N f (root y) = periodicOrbit N f q := by
      simpa only [source, Finset.mem_filter, Finset.mem_univ, true_and] using hy
    have hyroot := eventualPeriodicRoot_isPeriodicPoint N f y
    have hyself := mem_periodicOrbit_self N f (root y) hyroot
    rw [hyorbit] at hyself
    exact hyself
  change (∑ r ∈ target, treeNodeCount N f depth r) = source.card
  rw [Finset.card_eq_sum_card_fiberwise hmaps]
  apply Finset.sum_congr rfl
  intro r hr
  have hrper := isPeriodicPoint_of_mem_periodicOrbit N f q r hq hr
  rw [treeNodeCount_eq_preimageTreeNodeTable_card_of_card_bound_le N f r hrper depth hdepth]
  apply congrArg Finset.card
  ext y
  simp only [Finset.mem_filter, Finset.mem_univ, true_and]
  have hrorbit := periodicOrbit_eq_of_mem N f q r hq hr
  rw [mem_preimageTreeNodeTable_iff]
  constructor
  · intro hyroot
    refine ⟨?_, hyroot⟩
    dsimp only [source]
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    rw [hyroot, hrorbit]
  · rintro ⟨_hycomponent, hyroot⟩
    exact hyroot

/-- 周期成分ごとの有限表は全配位を一意に分類するので、その個数和は全配位数である。 -/
theorem sum_periodicComponentNodeTable_card_eq_configurations :
    ∑ O ∈ periodicOrbitTable N f,
        (periodicComponentNodeTable N f O).card = 2 ^ Fintype.card V := by
  let source := (Finset.univ : Finset (V → State))
  let target := periodicOrbitTable N f
  let component : (V → State) → Finset (V → State) := fun y =>
    periodicOrbit N f (eventualPeriodicRoot N f y)
  have hmaps : ∀ y ∈ source, component y ∈ target := by
    intro y _hy
    apply (mem_periodicOrbitTable_iff N f _).2
    exact ⟨eventualPeriodicRoot N f y, eventualPeriodicRoot_isPeriodicPoint N f y, rfl⟩
  change ∑ O ∈ target, (source.filter fun y => component y = O).card = 2 ^ Fintype.card V
  rw [← Finset.card_eq_sum_card_fiberwise hmaps]
  exact card_config

/-- 等しい基点語を持つ周期成分では、共通深さまでの前像木節点数の
    一周期にわたる有限和が等しい。各位置の等式を有限和へ持ち上げるだけであり、
    前像木が全配位を尽くすことはまだ使わない。 -/
theorem periodicOrbitTreeNodeCount_eq_of_baseWord_eq_commonDepth
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r) :
    periodicOrbitTreeNodeCount NW fW
        (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)) rW =
      periodicOrbitTreeNodeCount N f
        (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)) r := by
  have hperiod := minPeriod_eq_of_baseWord_eq N f NW fW r rW hbase
  unfold periodicOrbitTreeNodeCount
  rw [hperiod]
  apply Finset.sum_congr rfl
  intro n hn
  exact treeNodeCount_iterate_eq_of_baseWord_eq_commonDepth
    N f NW fW r rW hr hrW hbase n (Finset.mem_range.mp hn)

/-- 写像符号が等しいとき、周期軌道を重複度つきで対応させ、
    対応する基点と周期上の全位置で共通深さの前像木節点数が一致する。 -/
theorem exists_orbit_equiv_with_treeNodeCounts
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              baseWord NW fW rW = baseWord N f r ∧
                ∀ n : ℕ, (hn : n < minPeriod N f r) →
                  treeNodeCount NW fW
                      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                      (iterate NW fW n rW) =
                    treeNodeCount N f
                      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                      (iterate N f n r) := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_equal_baseWords N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hbase⟩ := he O
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW (e O) heOmem rW hrWO
  exact ⟨r, rW, hrO, hrWO, hbase, fun n hn =>
    treeNodeCount_iterate_eq_of_baseWord_eq_commonDepth
      N f NW fW r rW hr hrW hbase n hn⟩

/-- 写像符号が等しいとき、対応する各周期成分について、周期上の全位置に
    付く前像木節点数の有限和が等しい。周期成分間の重複度も保つ。 -/
theorem exists_orbit_equiv_with_periodicOrbitTreeNodeCounts
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              periodicOrbitTreeNodeCount NW fW
                  (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)) rW =
                periodicOrbitTreeNodeCount N f
                  (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)) r := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_equal_baseWords N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hbase⟩ := he O
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW (e O) heOmem rW hrWO
  exact ⟨r, rW, hrO, hrWO,
    periodicOrbitTreeNodeCount_eq_of_baseWord_eq_commonDepth
      N f NW fW r rW hr hrW hbase⟩

/-- 写像符号が等しいとき、対応する周期成分へ流入する全配位の個数は等しい。 -/
theorem exists_orbit_equiv_with_periodicComponentNodeTable_cards
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        (periodicComponentNodeTable NW fW (e O)).card =
          (periodicComponentNodeTable N f O).card := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_periodicOrbitTreeNodeCounts
    N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hcount⟩ := he O
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW (e O) heOmem rW hrWO
  have hOrbitN : periodicOrbit N f r = (O : Finset (V → State)) := by
    obtain ⟨q, hq, hqO⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
    rw [periodicOrbit_eq_of_mem N f q r hq]
    · exact hqO
    · rwa [hqO]
  have hOrbitW : periodicOrbit NW fW rW = (e O : Finset (W → State)) := by
    obtain ⟨q, hq, hqO⟩ := (mem_periodicOrbitTable_iff NW fW (e O)).1 heOmem
    rw [periodicOrbit_eq_of_mem NW fW q rW hq]
    · exact hqO
    · rwa [hqO]
  let commonDepth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
  have hdepthV : 2 ^ Fintype.card V - 1 ≤ commonDepth := Nat.le_max_left _ _
  have hdepthW : 2 ^ Fintype.card W - 1 ≤ commonDepth := Nat.le_max_right _ _
  rw [← hOrbitW, ← hOrbitN]
  rw [← periodicOrbitTreeNodeCount_eq_periodicComponentNodeTable_card
        NW fW rW hrW commonDepth hdepthW,
      ← periodicOrbitTreeNodeCount_eq_periodicComponentNodeTable_card
        N f r hr commonDepth hdepthV]
  exact hcount

/-- 等しい写像符号は全配位数を一致させ、したがって 2 値舞台のセル数も一致させる。 -/
theorem configuration_card_and_cell_card_eq_of_mapCode_eq
    (hcode : mapCode NW fW = mapCode N f) :
    (2 ^ Fintype.card W = 2 ^ Fintype.card V) ∧
      Fintype.card W = Fintype.card V := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_periodicComponentNodeTable_cards
    N f NW fW hcode
  have hsum :
      (∑ OW : (periodicOrbitTable NW fW).val,
          (periodicComponentNodeTable NW fW OW).card) =
        ∑ O : (periodicOrbitTable N f).val,
          (periodicComponentNodeTable N f O).card := by
    rw [← e.sum_comp]
    exact Fintype.sum_congr _ _ fun O => he O
  have hconfig : 2 ^ Fintype.card W = 2 ^ Fintype.card V := by
    calc
      2 ^ Fintype.card W = ∑ OW ∈ periodicOrbitTable NW fW,
          (periodicComponentNodeTable NW fW OW).card :=
            (sum_periodicComponentNodeTable_card_eq_configurations NW fW).symm
      _ = ∑ OW : (periodicOrbitTable NW fW).val,
            (periodicComponentNodeTable NW fW OW).card :=
          (sum_occurrences_eq_finset_sum (periodicOrbitTable NW fW)
            (fun OW => (periodicComponentNodeTable NW fW OW).card)).symm
      _ = ∑ O : (periodicOrbitTable N f).val,
            (periodicComponentNodeTable N f O).card := hsum
      _ = ∑ O ∈ periodicOrbitTable N f,
            (periodicComponentNodeTable N f O).card :=
          sum_occurrences_eq_finset_sum (periodicOrbitTable N f)
            (fun O => (periodicComponentNodeTable N f O).card)
      _ = 2 ^ Fintype.card V :=
          sum_periodicComponentNodeTable_card_eq_configurations N f
  exact ⟨hconfig, Nat.pow_right_injective (le_refl 2) hconfig⟩

/-- 写像符号の等号から得られる全配位集合の全単射。
    この段では有限集合の個数一致だけを使って全単射を固定する。
    時間発展との可換性はまだ主張しない。 -/
noncomputable def configurationEquivOfMapCode
    (hcode : mapCode NW fW = mapCode N f) :
    (V → State) ≃ (W → State) :=
  Fintype.equivOfCardEq (by
    rw [card_config, card_config]
    exact (configuration_card_and_cell_card_eq_of_mapCode_eq N f NW fW hcode).1.symm)

/-- 上で固定した全配位対応写像は全単射である。 -/
theorem configurationEquivOfMapCode_bijective
    (hcode : mapCode NW fW = mapCode N f) :
    Function.Bijective (configurationEquivOfMapCode N f NW fW hcode) :=
  (configurationEquivOfMapCode N f NW fW hcode).bijective

/-- 写像符号が与える周期成分の重複度付き対応を一つ固定する。 -/
noncomputable def orbitEquivOfMapCode
    (hcode : mapCode NW fW = mapCode N f) :
    (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val :=
  Classical.choose
    (exists_orbit_equiv_with_periodicComponentNodeTable_cards N f NW fW hcode)

/-- 固定した周期成分対応は、対応する成分表の個数を保存する。 -/
theorem orbitEquivOfMapCode_component_card
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val) :
    (periodicComponentNodeTable NW fW (orbitEquivOfMapCode N f NW fW hcode O)).card =
      (periodicComponentNodeTable N f O).card := by
  exact Classical.choose_spec
    (exists_orbit_equiv_with_periodicComponentNodeTable_cards N f NW fW hcode) O

/-- 対応する二つの周期成分表の間に有限全単射を固定する。
    この段では成分表の個数一致だけを使い、時間発展との可換性はまだ要求しない。 -/
noncomputable def periodicComponentEquivOfMapCode
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val) :
    ↑(periodicComponentNodeTable N f O) ≃
      ↑(periodicComponentNodeTable NW fW (orbitEquivOfMapCode N f NW fW hcode O)) :=
  Fintype.equivOfCardEq (by
    simp only [Fintype.card_coe]
    exact (orbitEquivOfMapCode_component_card N f NW fW hcode O).symm)

/-- 各配位が属する一意な周期成分添字を固定する。 -/
noncomputable def periodicComponentIndex (y : V → State) :
    (periodicOrbitTable N f) :=
  Classical.choose (exists_unique_periodicComponent N f y)

theorem periodicComponentIndex_spec (y : V → State) :
    y ∈ periodicComponentNodeTable N f (periodicComponentIndex N f y) :=
  (Classical.choose_spec (exists_unique_periodicComponent N f y)).1

/-- 一意な周期成分添字を、重複度付き周期軌道表の出現型へ移す。 -/
noncomputable def periodicComponentOccurrenceIndex (y : V → State) :
    (periodicOrbitTable N f).val :=
  (periodicOrbitTable N f).val.mkToType (periodicComponentIndex N f y)
    ⟨0, Multiset.count_pos.mpr (periodicComponentIndex N f y).property⟩

/-- 一意な成分分割を使い、対応する成分表ごとの有限全単射を
    全配位上の一つの写像へ接着する。成分内の再帰的前像木対応を使う
    全単射性と時間発展との可換性は後続段で証明する。 -/
noncomputable def componentwiseConfigurationMap
    (hcode : mapCode NW fW = mapCode N f) (y : V → State) : W → State :=
  periodicComponentEquivOfMapCode N f NW fW hcode
    (periodicComponentOccurrenceIndex N f y)
    ⟨y, periodicComponentIndex_spec N f y⟩

/-- 接着した写像の値は、元の配位が属する周期成分に対応する成分表へ入る。 -/
theorem componentwiseConfigurationMap_mem_corresponding_component
    (hcode : mapCode NW fW = mapCode N f) (y : V → State) :
    componentwiseConfigurationMap N f NW fW hcode y ∈
      periodicComponentNodeTable NW fW
        (orbitEquivOfMapCode N f NW fW hcode
          (periodicComponentOccurrenceIndex N f y)) := by
  exact (periodicComponentEquivOfMapCode N f NW fW hcode
    (periodicComponentOccurrenceIndex N f y)
      ⟨y, periodicComponentIndex_spec N f y⟩).property

/-- 配位 `y` が周期成分 `O` の成分表に入るなら、
    一意性によって選んだ成分添字は `O` そのものである。 -/
theorem periodicComponentIndex_eq_of_mem
    (O : periodicOrbitTable N f) (y : V → State)
    (hy : y ∈ periodicComponentNodeTable N f O) :
    periodicComponentIndex N f y = O := by
  apply Subtype.ext
  exact ((mem_periodicComponentNodeTable_iff N f _ y).1
    (periodicComponentIndex_spec N f y)).symm.trans
      ((mem_periodicComponentNodeTable_iff N f _ y).1 hy)

/-- 周期軌道表は有限集合なので、その基礎多重集合で同じ周期成分を表す
    二つの出現は等しい。 -/
theorem periodicOrbitOccurrence_eq_of_coe_eq
    (O P : (periodicOrbitTable N f).val)
    (h : (O : Finset (V → State)) = (P : Finset (V → State))) :
    O = P := by
  rcases O with ⟨O, i⟩
  rcases P with ⟨P, j⟩
  simp only at h
  subst P
  congr 1
  apply Fin.ext
  have hcount : (periodicOrbitTable N f).val.count O = 1 := by
    exact Multiset.count_eq_one_of_mem (periodicOrbitTable N f).nodup
      (occurrence_mem (periodicOrbitTable N f).val ⟨O, i⟩)
  omega

/-- 配位が周期成分の一つの出現に属するなら、一意性から選んだ
    出現添字はその出現そのものである。 -/
theorem periodicComponentOccurrenceIndex_eq_of_mem
    (O : (periodicOrbitTable N f).val) (y : V → State)
    (hy : y ∈ periodicComponentNodeTable N f O) :
    periodicComponentOccurrenceIndex N f y = O := by
  apply periodicOrbitOccurrence_eq_of_coe_eq N f
  exact congrArg Subtype.val (periodicComponentIndex_eq_of_mem N f
    ⟨O, occurrence_mem (periodicOrbitTable N f).val O⟩ y hy)

/-- 全配位集合は、一意な周期成分出現とその成分内の配位の従属和に全単射である。 -/
noncomputable def configurationComponentSigmaEquiv :
    (Σ O : (periodicOrbitTable N f).val,
      ↑(periodicComponentNodeTable N f O)) ≃ (V → State) where
  toFun p := p.2
  invFun y := ⟨periodicComponentOccurrenceIndex N f y,
    ⟨y, periodicComponentIndex_spec N f y⟩⟩
  left_inv p := by
    have hp : periodicComponentOccurrenceIndex N f p.2 = p.1 :=
      periodicComponentOccurrenceIndex_eq_of_mem N f p.1 p.2 p.2.property
    refine Sigma.ext hp ?_
    exact (Subtype.heq_iff_coe_eq (fun y => by
      change y ∈ periodicComponentNodeTable N f
          (periodicComponentOccurrenceIndex N f p.2) ↔
        y ∈ periodicComponentNodeTable N f p.1
      rw [hp])).2 rfl
  right_inv y := rfl

/-- 周期成分出現の対応と各成分表の有限全単射を従属和上で接着した全単射。 -/
noncomputable def componentwiseConfigurationEquiv
    (hcode : mapCode NW fW = mapCode N f) :
    (V → State) ≃ (W → State) :=
  (configurationComponentSigmaEquiv N f).symm |>.trans
    (Equiv.sigmaCongr (orbitEquivOfMapCode N f NW fW hcode)
      (periodicComponentEquivOfMapCode N f NW fW hcode)) |>.trans
        (configurationComponentSigmaEquiv NW fW)

theorem componentwiseConfigurationEquiv_apply
    (hcode : mapCode NW fW = mapCode N f) (y : V → State) :
    componentwiseConfigurationEquiv N f NW fW hcode y =
      componentwiseConfigurationMap N f NW fW hcode y := by
  rfl

/-- 周期成分ごとの有限全単射を一意な成分分割に沿って接着した写像は単射である。 -/
theorem componentwiseConfigurationMap_injective
    (hcode : mapCode NW fW = mapCode N f) :
    Function.Injective (componentwiseConfigurationMap N f NW fW hcode) := by
  intro x y hxy
  apply (componentwiseConfigurationEquiv N f NW fW hcode).injective
  rw [componentwiseConfigurationEquiv_apply, componentwiseConfigurationEquiv_apply]
  exact hxy

/-- 周期成分ごとの有限全単射を一意な成分分割に沿って接着した写像は全射である。 -/
theorem componentwiseConfigurationMap_surjective
    (hcode : mapCode NW fW = mapCode N f) :
    Function.Surjective (componentwiseConfigurationMap N f NW fW hcode) := by
  intro z
  obtain ⟨y, hy⟩ := (componentwiseConfigurationEquiv N f NW fW hcode).surjective z
  refine ⟨y, ?_⟩
  rw [← componentwiseConfigurationEquiv_apply]
  exact hy

/-- 接着した全配位写像は全単射である。この段は成分表の一意な分割と、
    各対応成分表の有限全単射だけを使い、時間発展との可換性はまだ主張しない。 -/
theorem componentwiseConfigurationMap_bijective
    (hcode : mapCode NW fW = mapCode N f) :
    Function.Bijective (componentwiseConfigurationMap N f NW fW hcode) :=
  ⟨componentwiseConfigurationMap_injective N f NW fW hcode,
    componentwiseConfigurationMap_surjective N f NW fW hcode⟩

/-- 等しい基点語を持つ周期点の対応に、周期上の各位置へ
    非周期前像木の全深さ対応を接着する。共通の打ち切り深さを
    作るときにだけ、両舞台のセル数一致を使う。 -/
theorem hasTreeMatching_iterate_of_baseWord_eq
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (hcard : Fintype.card W = Fintype.card V)
    (n : ℕ) (hn : n < minPeriod N f r) :
    HasTreeMatching N f NW fW (2 ^ Fintype.card V - 1)
      (iterate N f n r) (iterate NW fW n rW) := by
  have hrnMem : iterate N f n r ∈ periodicOrbit N f r :=
    (mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩
  have hrWnMem : iterate NW fW n rW ∈ periodicOrbit NW fW rW :=
    (mem_periodicOrbit_iff_exists NW fW rW _ hrW).2 ⟨n, rfl⟩
  have hrn : IsPeriodicPoint N f (iterate N f n r) :=
    isPeriodicPoint_of_mem_periodicOrbit N f r _ hr hrnMem
  have hrWn : IsPeriodicPoint NW fW (iterate NW fW n rW) :=
    isPeriodicPoint_of_mem_periodicOrbit NW fW rW _ hrW hrWnMem
  have hmu : minPreperiod N f (iterate N f n r) = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero N f _).1 hrn
  have hmuW : minPreperiod NW fW (iterate NW fW n rW) = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero NW fW _).1 hrWn
  have hrecursive := recursiveCode_iterate_eq_of_baseWord_eq
    N f NW fW r rW hbase n hn
  have hdepth :
      codeAtDepth NW fW (2 ^ Fintype.card V - 1) (iterate NW fW n rW) =
        codeAtDepth N f (2 ^ Fintype.card V - 1) (iterate N f n r) := by
    simpa [recursiveCode, hcard, hmu, hmuW] using hrecursive
  exact hasTreeMatching_of_codeAtDepth_eq N f NW fW _ _ _ hdepth

/-- 写像符号が等しくセル数も等しいとき、周期軌道の出現の
    重複度付き対応と、対応する周期上の全ての位置に接着した
    前像木対応を同時に選べる。 -/
theorem exists_orbit_equiv_with_tree_matchings
    (hcode : mapCode NW fW = mapCode N f)
    (hcard : Fintype.card W = Fintype.card V) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              baseWord NW fW rW = baseWord N f r ∧
                ∀ n : ℕ, (hn : n < minPeriod N f r) →
                  HasTreeMatching N f NW fW (2 ^ Fintype.card V - 1)
                    (iterate N f n r) (iterate NW fW n rW) := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_equal_baseWords N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hbase⟩ := he O
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW (e O) heOmem rW hrWO
  exact ⟨r, rW, hrO, hrWO, hbase, fun n hn =>
    hasTreeMatching_iterate_of_baseWord_eq
      N f NW fW r rW hr hrW hbase hcard n hn⟩

/-- 写像符号が等しいとき、各対応周期成分を同じ有限周期添字で並べ、
    各位置の前像木対応と周期辺の可換性を同時に選べる。
    これは局所的な子対応を一つの周期成分へ接着した有限対応であり、
    相異なる周期成分どうしの全配位対応への接着はまだ行わない。 -/
theorem exists_orbit_equiv_with_component_matchings
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              baseWord NW fW rW = baseWord N f r ∧
                ∀ n : ℕ, (hn : n < minPeriod N f r) →
                  HasTreeMatching N f NW fW (2 ^ Fintype.card V - 1)
                      (iterate N f n r) (iterate NW fW n rW) ∧
                    globalMap N f (iterate N f n r) =
                        (if n + 1 < minPeriod N f r then
                          iterate N f (n + 1) r else r) ∧
                    globalMap NW fW (iterate NW fW n rW) =
                        (if n + 1 < minPeriod N f r then
                          iterate NW fW (n + 1) rW else rW) := by
  have hcard :=
    (configuration_card_and_cell_card_eq_of_mapCode_eq N f NW fW hcode).2
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_tree_matchings
    N f NW fW hcode hcard
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hbase, htrees⟩ := he O
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have heOmem : (e O : Finset (W → State)) ∈ periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val (e O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW (e O) heOmem rW hrWO
  refine ⟨r, rW, hrO, hrWO, hbase, fun n hn => ⟨htrees n hn, ?_⟩⟩
  exact periodic_index_matching_preserves_edges
    N f NW fW r rW hr hrW hbase n hn

end OrbitTreeMatching

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
