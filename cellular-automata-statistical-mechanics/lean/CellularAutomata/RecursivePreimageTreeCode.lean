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
各周期成分表を、周期上の一意な根とその根へ流入する有限配位表との従属和へ分解する。
周期位置ごとの再帰的前像木対応をその従属和上で接着し、対応する周期成分表の全単射も構成する。
この全単射の共役条件・完全性・有限決定も形式化する。
有限集合、自然数、写像の等号だけを使い、R / C は使わない。
-/
import CellularAutomata.NecSuf.RecursivePreimageTreeCode
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
  := NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.codeAtDepth
    (nonperiodicChildren N f)

/-- 人手証明の上界 `2^|V|-1-μ(y)` を使った再帰的前像木符号。 -/
noncomputable def recursiveCode (y : V → State) : ℕ :=
  codeAtDepth N f (2 ^ Fintype.card V - 1 - minPreperiod N f y) y

/-- 具体版の再帰的前像木符号は、必要十分版の完成符号の特殊化である
    （子表は非周期一段前像、`level` は最小前周期、`bound` は `2^|V|-1`）。 -/
theorem recursiveCode_eq_completedCode (y : V → State) :
    recursiveCode N f y =
      NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.completedCode
        (nonperiodicChildren N f) (2 ^ Fintype.card V - 1) (minPreperiod N f) y := rfl

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
  rw [recursiveCode_eq_completedCode]
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.codeAtDepth_eq_completedCode_of_remaining_le
    (nonperiodicChildren N f) (2 ^ Fintype.card V - 1) (minPreperiod N f)
    (fun y z hz => child_minPreperiod_eq_add_one N f y z hz)
    (fun y => minPreperiod_le_configuration_card_sub_one N f y)
    y depth hdepth

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

/-! 打ち切り前像木の節点は、根または非周期一段前像を根とする子部分木の節点である。
    子の出現を型に残すことで、個数一致だけでなく選んだ再帰分岐そのものを記録する。 -/
def TruncatedTreeNode : (depth : ℕ) → (V → State) → Type
  | 0, _ => PUnit
  | depth + 1, y =>
      PUnit ⊕ (Σ z : (nonperiodicChildren N f y).val,
        TruncatedTreeNode depth z)

/-- 打ち切り前像木の抽象節点が表す実際の配位。
    根は基点そのものを表し、子部分木では子の出現を一段降りて再帰する。 -/
def truncatedTreeNodeConfiguration :
    (depth : ℕ) → (y : V → State) → TruncatedTreeNode N f depth y → (V → State)
  | 0, y, _ => y
  | _ + 1, y, Sum.inl _ => y
  | depth + 1, _, Sum.inr p =>
      truncatedTreeNodeConfiguration depth p.1 p.2

/-- 打ち切り前像木の抽象節点の、基点から測った深さ。 -/
def truncatedTreeNodeLevel :
    (depth : ℕ) → (y : V → State) → TruncatedTreeNode N f depth y → ℕ
  | 0, _, _ => 0
  | _ + 1, _, Sum.inl _ => 0
  | depth + 1, _, Sum.inr p =>
      truncatedTreeNodeLevel depth p.1 p.2 + 1

/-- 打ち切り前像木の根節点。深さにかかわらず基点そのものを表す。 -/
def truncatedTreeNodeRoot :
    (depth : ℕ) → (y : V → State) → TruncatedTreeNode N f depth y
  | 0, _ => PUnit.unit
  | _ + 1, _ => Sum.inl PUnit.unit

/-- 根節点が表す配位は基点である。 -/
theorem truncatedTreeNodeConfiguration_root
    (depth : ℕ) (y : V → State) :
    truncatedTreeNodeConfiguration N f depth y
      (truncatedTreeNodeRoot N f depth y) = y := by
  cases depth <;> rfl

/-- 抽象節点が表す配位を、その節点の深さだけ一段発展すると基点へ戻る。
    これは節点型と有限配位表を個数だけで対応させず、実際の親子辺を保存する
    全単射へ置き換えるための基礎となる。 -/
theorem iterate_truncatedTreeNodeConfiguration_eq_root :
    (depth : ℕ) → (y : V → State) → (u : TruncatedTreeNode N f depth y) →
      iterate N f (truncatedTreeNodeLevel N f depth y u)
          (truncatedTreeNodeConfiguration N f depth y u) = y
  | 0, _, _ => rfl
  | _ + 1, _, Sum.inl _ => rfl
  | depth + 1, y, Sum.inr p => by
      have ih := iterate_truncatedTreeNodeConfiguration_eq_root depth p.1 p.2
      have hp : globalMap N f p.1 = y :=
        (mem_nonperiodicChildren_iff N f y p.1).1
          (occurrence_mem (nonperiodicChildren N f y).val p.1) |>.1
      rw [truncatedTreeNodeLevel, truncatedTreeNodeConfiguration, iterate_succ, ih, hp]

/-- 抽象節点が表す配位の最小前周期は、基点の最小前周期に
    節点の深さを足した値である。各子で最小前周期が一つ増えることを
    再帰的に適用する。 -/
theorem minPreperiod_truncatedTreeNodeConfiguration_eq_add_level :
    (depth : ℕ) → (y : V → State) → (u : TruncatedTreeNode N f depth y) →
      minPreperiod N f (truncatedTreeNodeConfiguration N f depth y u) =
        minPreperiod N f y + truncatedTreeNodeLevel N f depth y u
  | 0, _, _ => by simp [truncatedTreeNodeConfiguration, truncatedTreeNodeLevel]
  | _ + 1, _, Sum.inl _ => by
      simp [truncatedTreeNodeConfiguration, truncatedTreeNodeLevel]
  | depth + 1, y, Sum.inr p => by
      have ih := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
        depth p.1 p.2
      have hp : minPreperiod N f p.1 = minPreperiod N f y + 1 :=
        child_minPreperiod_eq_add_one N f y p.1
          (occurrence_mem (nonperiodicChildren N f y).val p.1)
      rw [truncatedTreeNodeConfiguration, truncatedTreeNodeLevel, ih, hp]
      omega

/-- 抽象節点から実配位への再帰写像は単射である。根と非根は
    最小前周期で区別し、二つの非根は同じ深さだけ進めて直下の子を
    回復した後、子部分木で帰納法を適用する。 -/
theorem truncatedTreeNodeConfiguration_injective :
    (depth : ℕ) → (y : V → State) →
      Function.Injective (truncatedTreeNodeConfiguration N f depth y)
  | 0, _ => by
      intro u v _
      cases u
      cases v
      rfl
  | depth + 1, y => by
      intro u v huv
      cases u with
      | inl uRoot =>
          cases v with
          | inl vRoot =>
              exact congrArg Sum.inl (Subsingleton.elim uRoot vRoot)
          | inr vChild =>
              exfalso
              have huMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inl uRoot)
              have hvMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inr vChild)
              rw [huv] at huMu
              simp only [truncatedTreeNodeLevel] at huMu hvMu
              omega
      | inr uChild =>
          cases v with
          | inl vRoot =>
              exfalso
              have huMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inr uChild)
              have hvMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inl vRoot)
              rw [huv] at huMu
              simp only [truncatedTreeNodeLevel] at huMu hvMu
              omega
          | inr vChild =>
              have huMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inr uChild)
              have hvMu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
                N f (depth + 1) y (Sum.inr vChild)
              rw [huv] at huMu
              have hlevel :
                  truncatedTreeNodeLevel N f depth uChild.1 uChild.2 =
                    truncatedTreeNodeLevel N f depth vChild.1 vChild.2 := by
                simp only [truncatedTreeNodeLevel] at huMu hvMu
                omega
              have huRoot := iterate_truncatedTreeNodeConfiguration_eq_root
                N f depth uChild.1 uChild.2
              have hvRoot := iterate_truncatedTreeNodeConfiguration_eq_root
                N f depth vChild.1 vChild.2
              have hchildValue : (uChild.1 : V → State) = vChild.1 := by
                calc
                  (uChild.1 : V → State) =
                      iterate N f (truncatedTreeNodeLevel N f depth uChild.1 uChild.2)
                        (truncatedTreeNodeConfiguration N f depth uChild.1 uChild.2) :=
                    huRoot.symm
                  _ = iterate N f (truncatedTreeNodeLevel N f depth vChild.1 vChild.2)
                        (truncatedTreeNodeConfiguration N f depth vChild.1 vChild.2) := by
                    rw [hlevel]
                    exact congrArg (iterate N f _ ) huv
                  _ = (vChild.1 : V → State) := hvRoot
              have hchild : uChild.1 = vChild.1 := by
                cases hU : uChild.1 with
                | mk uValue uOccurrence =>
                    cases hV : vChild.1 with
                    | mk vValue vOccurrence =>
                        rw [hU, hV] at hchildValue
                        dsimp only at hchildValue
                        subst vValue
                        have hcount :
                            Multiset.count uValue (nonperiodicChildren N f y).val = 1 :=
                          Multiset.count_eq_one_of_mem
                            (nonperiodicChildren N f y).nodup
                            (occurrence_mem (nonperiodicChildren N f y).val
                              ⟨uValue, uOccurrence⟩)
                        have hOccurrence : uOccurrence = vOccurrence := by
                          apply Fin.ext
                          omega
                        exact congrArg
                          (fun occurrence =>
                            (nonperiodicChildren N f y).val.mkToType uValue occurrence)
                          hOccurrence
              cases uChild with
              | mk uIndex uNode =>
                  cases vChild with
                  | mk vIndex vNode =>
                      simp only at hchild
                      subst vIndex
                      have hnode : uNode = vNode :=
                        truncatedTreeNodeConfiguration_injective depth uIndex huv
                      subst vNode
                      rfl

/-- 打ち切り前像木の節点型は有限である。後続深さでは根一つと、
    有限個の非周期子に付く一つ浅い有限節点型の従属和に分ける。 -/
@[reducible] noncomputable def truncatedTreeNodeFintype :
    (depth : ℕ) → (y : V → State) → Fintype (TruncatedTreeNode N f depth y)
  | 0, _ => inferInstanceAs (Fintype PUnit)
  | depth + 1, y => by
      letI (z : (nonperiodicChildren N f y).val) :=
        truncatedTreeNodeFintype depth z
      exact inferInstanceAs (Fintype
        (PUnit ⊕ (Σ z : (nonperiodicChildren N f y).val,
          TruncatedTreeNode N f depth z)))

/-- 再帰的前像木対応から、打ち切り節点型の実際の全単射を構成する。
    後続深さでは根を根へ固定し、子出現の全単射を適用してから、
    対応する各子部分木の内部で独立に再帰する。 -/
noncomputable def treeNodeEquivOfMatching :
    (depth : ℕ) → (y : V → State) → (yW : W → State) →
      HasTreeMatching N f NW fW depth y yW →
        TruncatedTreeNode N f depth y ≃ TruncatedTreeNode NW fW depth yW
  | 0, _, _, _ => Equiv.refl PUnit
  | depth + 1, y, yW, hmatch =>
      Equiv.sumCongr (Equiv.refl PUnit)
        (Equiv.sigmaCongr (Classical.choose hmatch) fun z =>
          treeNodeEquivOfMatching depth z (Classical.choose hmatch z)
            (Classical.choose_spec hmatch z))

/-- 再帰的前像木対応から構成した全単射は根を根へ送る。 -/
theorem treeNodeEquivOfMatching_root
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hmatch : HasTreeMatching N f NW fW (depth + 1) y yW) :
    treeNodeEquivOfMatching N f NW fW (depth + 1) y yW hmatch (Sum.inl PUnit.unit) =
      Sum.inl PUnit.unit := by
  rfl

/-- 再帰的前像木対応は、深さ零を含む全ての打ち切り深さで根を根へ送る。 -/
theorem treeNodeEquivOfMatching_root_all
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hmatch : HasTreeMatching N f NW fW depth y yW) :
    treeNodeEquivOfMatching N f NW fW depth y yW hmatch
        (truncatedTreeNodeRoot N f depth y) =
      truncatedTreeNodeRoot NW fW depth yW := by
  cases depth <;> rfl

/-- 子分岐では、選択した子出現対応を先に適用し、その下の部分木対応へ再帰する。 -/
theorem treeNodeEquivOfMatching_child
    (depth : ℕ) (y : V → State) (yW : W → State)
    (hmatch : HasTreeMatching N f NW fW (depth + 1) y yW)
    (z : (nonperiodicChildren N f y).val)
    (u : TruncatedTreeNode N f depth z) :
    treeNodeEquivOfMatching N f NW fW (depth + 1) y yW hmatch
        (Sum.inr ⟨z, u⟩) =
      Sum.inr ⟨Classical.choose hmatch z,
        treeNodeEquivOfMatching N f NW fW depth z
          (Classical.choose hmatch z) (Classical.choose_spec hmatch z) u⟩ := by
  rfl

/-- 打ち切り前像木の非周期な親子辺。直下の子から根への辺と、
    各子部分木の内部辺を再帰的に区別して記録する。 -/
inductive TruncatedTreeParentEdge :
    (depth : ℕ) → (y : V → State) →
      TruncatedTreeNode N f depth y → TruncatedTreeNode N f depth y → Prop
  | rootChild (depth : ℕ) (y : V → State)
      (z : (nonperiodicChildren N f y).val) :
      TruncatedTreeParentEdge (depth + 1) y
        (Sum.inr ⟨z, truncatedTreeNodeRoot N f depth z⟩)
        (truncatedTreeNodeRoot N f (depth + 1) y)
  | inChild (depth : ℕ) (y : V → State)
      (z : (nonperiodicChildren N f y).val)
      {u v : TruncatedTreeNode N f depth z}
      (huv : TruncatedTreeParentEdge depth z u v) :
      TruncatedTreeParentEdge (depth + 1) y
        (Sum.inr ⟨z, u⟩) (Sum.inr ⟨z, v⟩)

/-- 抽象前像木の親子辺が表す二配位は、実際に一段発展で結ばれる。 -/
theorem truncatedTreeParentEdge_configuration :
    {depth : ℕ} → {y : V → State} →
      {u v : TruncatedTreeNode N f depth y} →
      TruncatedTreeParentEdge N f depth y u v →
        globalMap N f (truncatedTreeNodeConfiguration N f depth y u) =
          truncatedTreeNodeConfiguration N f depth y v
  | _, _, _, _, .rootChild depth y z => by
      rw [truncatedTreeNodeConfiguration, truncatedTreeNodeConfiguration_root,
        truncatedTreeNodeConfiguration_root]
      exact (mem_nonperiodicChildren_iff N f y z).1
        (occurrence_mem (nonperiodicChildren N f y).val z) |>.1
  | _, _, _, _, .inChild depth _ z huv => by
      rw [truncatedTreeNodeConfiguration, truncatedTreeNodeConfiguration]
      exact truncatedTreeParentEdge_configuration huv

/-- 再帰的な節点全単射は、根直下だけでなく全ての子部分木内部でも
    親子辺を親子辺へ送る。証明は辺の深さに関する帰納法である。 -/
theorem treeNodeEquivOfMatching_preserves_parent_edge
    {depth : ℕ} {y : V → State} {yW : W → State}
    (hmatch : HasTreeMatching N f NW fW depth y yW)
    {u v : TruncatedTreeNode N f depth y}
    (huv : TruncatedTreeParentEdge N f depth y u v) :
    TruncatedTreeParentEdge NW fW depth yW
      (treeNodeEquivOfMatching N f NW fW depth y yW hmatch u)
      (treeNodeEquivOfMatching N f NW fW depth y yW hmatch v) := by
  induction huv generalizing yW with
  | rootChild depth y z =>
      rw [treeNodeEquivOfMatching_child, treeNodeEquivOfMatching_root_all,
        treeNodeEquivOfMatching_root_all]
      exact TruncatedTreeParentEdge.rootChild (N := NW) (f := fW)
        depth _ (Classical.choose hmatch z)
  | inChild depth y z huv ih =>
      rw [treeNodeEquivOfMatching_child, treeNodeEquivOfMatching_child]
      exact TruncatedTreeParentEdge.inChild (N := NW) (f := fW)
        depth _ (Classical.choose hmatch z) (ih (Classical.choose_spec hmatch z))

/-- 打ち切り前像木の各節点は根そのものか、一意な一段発展先を表す
    親節点を持つ。後続深さでは、根直下と子部分木内部を分けて示す。 -/
theorem truncatedTreeNode_eq_root_or_exists_parent :
    (depth : ℕ) → (y : V → State) → (u : TruncatedTreeNode N f depth y) →
      u = truncatedTreeNodeRoot N f depth y ∨
        ∃ v : TruncatedTreeNode N f depth y,
          TruncatedTreeParentEdge N f depth y u v
  | 0, _, u => by
      left
      cases u
      rfl
  | depth + 1, y, Sum.inl u => by
      left
      exact congrArg Sum.inl (Subsingleton.elim u PUnit.unit)
  | depth + 1, y, Sum.inr ⟨z, u⟩ => by
      rcases truncatedTreeNode_eq_root_or_exists_parent depth z u with hu | ⟨v, huv⟩
      · right
        subst u
        exact ⟨truncatedTreeNodeRoot N f (depth + 1) y,
          TruncatedTreeParentEdge.rootChild (N := N) (f := f) depth y z⟩
      · right
        exact ⟨Sum.inr ⟨z, v⟩,
          TruncatedTreeParentEdge.inChild (N := N) (f := f) depth y z huv⟩

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

/-- 打ち切り節点型の元数は、根一つと各子部分木の元数を再帰的に足す
    `treeNodeCount` に一致する。 -/
theorem card_truncatedTreeNode_eq_treeNodeCount
    (depth : ℕ) (y : V → State) :
    @Fintype.card (TruncatedTreeNode N f depth y)
        (truncatedTreeNodeFintype N f depth y) = treeNodeCount N f depth y := by
  letI := truncatedTreeNodeFintype N f depth y
  rw [← Nat.card_eq_fintype_card]
  induction depth generalizing y with
  | zero => simp [TruncatedTreeNode, treeNodeCount]
  | succ depth ih =>
      letI (z : (nonperiodicChildren N f y).val) :=
        truncatedTreeNodeFintype N f depth z
      simp only [TruncatedTreeNode, treeNodeCount, Nat.card_eq_fintype_card,
        Fintype.card_sum, Fintype.card_punit, Fintype.card_sigma]
      congr 1
      apply Fintype.sum_congr
      intro z
      simpa only [Nat.card_eq_fintype_card] using ih z

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

/-- 具体版の一周期表は、必要十分版の周期長を最小周期、反復列を大域写像の反復と
する特殊化である。 -/
theorem periodicOrbit_eq_necessary_sufficient (q : V → State) :
    periodicOrbit N f q =
      NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.periodicOrbit
        (minPeriod N f) (iterate N f) q := rfl

/-- 周期点の基点語。 -/
noncomputable def baseWord (q : V → State) : List ℕ :=
  List.ofFn fun n : Fin (minPeriod N f q) => recursiveCode N f (iterate N f n q)

/-- 具体版の基点語は、必要十分版の周期長を最小周期、反復列を大域写像の反復、
点符号を完成した再帰的前像木符号とする特殊化である。 -/
theorem baseWord_eq_necessary_sufficient (q : V → State) :
    baseWord N f q =
      NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.baseWord
        (minPeriod N f) (iterate N f) (recursiveCode N f) q := rfl

/-- 一つの周期軌道を、全基点語の有限集合で表した成分符号。 -/
noncomputable def componentCode (q : V → State) : Finset (List ℕ) :=
  (periodicOrbit N f q).image (baseWord N f)

/-- 具体版の成分符号は、必要十分版の有限表を一周期表、付値を基点語とする
特殊化である。 -/
theorem componentCode_eq_necessary_sufficient (q : V → State) :
    componentCode N f q =
      NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.componentCode
        (periodicOrbit N f) (baseWord N f) q := rfl

/-- 全ての周期軌道を重複なく列挙する有限表。 -/
noncomputable def periodicOrbitTable : Finset (Finset (V → State)) :=
  ((Finset.univ.filter fun q => IsPeriodicPoint N f q).image (periodicOrbit N f))

/-- 写像全体の符号。異なる軌道の同じ成分符号は多重度を保つ。 -/
noncomputable def mapCode : Multiset (Finset (List ℕ)) :=
  (periodicOrbitTable N f).val.map fun orbit =>
    if h : orbit.Nonempty then componentCode N f h.choose else ∅

/-- 具体版の写像符号は、必要十分版の有限表上の符号集約を、周期軌道表と
各軌道の成分符号へ特殊化したものである。 -/
theorem mapCode_eq_necessary_sufficient :
    mapCode N f =
      NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.aggregateCode
        (periodicOrbitTable N f)
        (fun orbit => if h : orbit.Nonempty then componentCode N f h.choose else ∅) := rfl

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

/-- 周期点を根とする抽象節点が表す配位は、その周期点へ流入する
    有限配位表に属する。最小前周期が節点深さに一致し、その回数の
    反復で根へ戻ることを使う。 -/
theorem truncatedTreeNodeConfiguration_mem_preimageTreeNodeTable
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (u : TruncatedTreeNode N f depth q) :
    truncatedTreeNodeConfiguration N f depth q u ∈ preimageTreeNodeTable N f q := by
  rw [mem_preimageTreeNodeTable_iff]
  unfold eventualPeriodicRoot
  have hmu := minPreperiod_truncatedTreeNodeConfiguration_eq_add_level
    N f depth q u
  have hqmu : minPreperiod N f q = 0 :=
    (isPeriodicPoint_iff_minPreperiod_zero N f q).1 hq
  rw [hmu, hqmu, Nat.zero_add]
  exact iterate_truncatedTreeNodeConfiguration_eq_root N f depth q u

/-- 配位数から得た上界以上の深さでは、打ち切り前像木の有限節点型と、
    周期点 `q` へ流入する配位の有限表の間に全単射がある。
    節点型の再帰的分解と既証明の重複なしの層別個数一致を合成する。 -/
noncomputable def truncatedTreeNodeEquivPreimageTreeNodeTable
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth) :
    TruncatedTreeNode N f depth q ≃ ↑(preimageTreeNodeTable N f q) := by
  letI := truncatedTreeNodeFintype N f depth q
  let configurationMap : TruncatedTreeNode N f depth q →
      ↑(preimageTreeNodeTable N f q) := fun u =>
    ⟨truncatedTreeNodeConfiguration N f depth q u,
      truncatedTreeNodeConfiguration_mem_preimageTreeNodeTable N f q hq depth u⟩
  have hinjective : Function.Injective configurationMap := by
    intro u v huv
    apply truncatedTreeNodeConfiguration_injective N f depth q
    exact congrArg Subtype.val huv
  have hcard :
      Fintype.card (TruncatedTreeNode N f depth q) =
        Fintype.card ↑(preimageTreeNodeTable N f q) := by
    rw [card_truncatedTreeNode_eq_treeNodeCount N f]
    rw [treeNodeCount_eq_preimageTreeNodeTable_card_of_card_bound_le
      N f q hq depth hdepth]
    exact (Fintype.card_coe _).symm
  exact Equiv.ofBijective configurationMap
    ((Fintype.bijective_iff_injective_and_card configurationMap).2
      ⟨hinjective, hcard⟩)

/-- 十分深い節点型と有限配位表の全単射は、抽象節点が表す
    実配位そのものを返す。個数一致から任意に選ぶ全単射ではない。 -/
theorem truncatedTreeNodeEquivPreimageTreeNodeTable_apply
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth)
    (u : TruncatedTreeNode N f depth q) :
    (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth u : V → State) =
      truncatedTreeNodeConfiguration N f depth q u := by
  rfl

theorem truncatedTreeNodeEquivPreimageTreeNodeTable_bijective
    (q : V → State) (hq : IsPeriodicPoint N f q) (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth) :
    Function.Bijective
      (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth) :=
  (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth).bijective

/-- 対応する二つの十分深い前像木では、再帰的な子対応から構成した
    節点全単射を、周期点へ流入する二つの有限配位表の全単射へ移せる。 -/
noncomputable def preimageTreeNodeTableEquivOfMatching
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth)
    (hmatch : HasTreeMatching N f NW fW depth q qW) :
    ↑(preimageTreeNodeTable N f q) ≃ ↑(preimageTreeNodeTable NW fW qW) :=
  (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth).symm |>.trans
    (treeNodeEquivOfMatching N f NW fW depth q qW hmatch) |>.trans
      (truncatedTreeNodeEquivPreimageTreeNodeTable NW fW qW hqW depth hdepthW)

theorem preimageTreeNodeTableEquivOfMatching_bijective
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth)
    (hmatch : HasTreeMatching N f NW fW depth q qW) :
    Function.Bijective
      (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW depth
        hdepth hdepthW hmatch) :=
  (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW depth
    hdepth hdepthW hmatch).bijective

/-- 再帰的対応から作った有限配位表全単射は、根を対応先の根へ送る。 -/
theorem preimageTreeNodeTableEquivOfMatching_maps_root
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth)
    (hmatch : HasTreeMatching N f NW fW depth q qW) :
    let sourceRoot :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth
        (truncatedTreeNodeRoot N f depth q)
    (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW depth
        hdepth hdepthW hmatch sourceRoot : W → State) = qW := by
  dsimp only
  change
    ((truncatedTreeNodeEquivPreimageTreeNodeTable NW fW qW hqW depth hdepthW)
      (treeNodeEquivOfMatching N f NW fW depth q qW hmatch
        ((truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth).symm
          (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth
            (truncatedTreeNodeRoot N f depth q)))) : W → State) = qW
  rw [Equiv.symm_apply_apply]
  rw [treeNodeEquivOfMatching_root_all]
  rw [truncatedTreeNodeEquivPreimageTreeNodeTable_apply]
  rw [truncatedTreeNodeConfiguration_root]

/-- 再帰対応で選ばれた非周期子は、構造保存された有限配位表の
    全単射によって対応先の非周期子そのものへ移る。 -/
theorem preimageTreeNodeTableEquivOfMatching_maps_child
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth + 1)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth + 1)
    (hmatch : HasTreeMatching N f NW fW (depth + 1) q qW)
    (z : (nonperiodicChildren N f q).val) :
    let sourceNode : TruncatedTreeNode N f (depth + 1) q :=
      Sum.inr ⟨z, truncatedTreeNodeRoot N f depth z⟩
    let sourceConfiguration :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq (depth + 1) hdepth
        sourceNode
    (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW
        (depth + 1) hdepth hdepthW hmatch sourceConfiguration : W → State) =
      Classical.choose hmatch z := by
  dsimp only
  change
    ((truncatedTreeNodeEquivPreimageTreeNodeTable NW fW qW hqW
        (depth + 1) hdepthW)
      (treeNodeEquivOfMatching N f NW fW (depth + 1) q qW hmatch
        ((truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq
          (depth + 1) hdepth).symm
          (truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq
            (depth + 1) hdepth
            (Sum.inr ⟨z, truncatedTreeNodeRoot N f depth z⟩)))) : W → State) =
      Classical.choose hmatch z
  rw [Equiv.symm_apply_apply]
  rw [treeNodeEquivOfMatching_child]
  rw [treeNodeEquivOfMatching_root_all]
  rw [truncatedTreeNodeEquivPreimageTreeNodeTable_apply]
  rw [truncatedTreeNodeConfiguration]
  rw [truncatedTreeNodeConfiguration_root]

/-- 上の有限配位表全単射は、選ばれた非周期子から周期根への
    一段発展を両側で保存する。 -/
theorem preimageTreeNodeTableEquivOfMatching_preserves_child_parent_edge
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth + 1)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth + 1)
    (hmatch : HasTreeMatching N f NW fW (depth + 1) q qW)
    (z : (nonperiodicChildren N f q).val) :
    let sourceNode : TruncatedTreeNode N f (depth + 1) q :=
      Sum.inr ⟨z, truncatedTreeNodeRoot N f depth z⟩
    let sourceConfiguration :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq (depth + 1) hdepth
        sourceNode
    globalMap N f sourceConfiguration = q ∧
      globalMap NW fW
        (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW
          (depth + 1) hdepth hdepthW hmatch sourceConfiguration) = qW := by
  dsimp only
  constructor
  · rw [truncatedTreeNodeEquivPreimageTreeNodeTable_apply]
    rw [truncatedTreeNodeConfiguration]
    rw [truncatedTreeNodeConfiguration_root]
    exact (mem_nonperiodicChildren_iff N f q z).1
      (occurrence_mem (nonperiodicChildren N f q).val z) |>.1
  · rw [preimageTreeNodeTableEquivOfMatching_maps_child]
    exact (mem_nonperiodicChildren_iff NW fW qW (Classical.choose hmatch z)).1
      (occurrence_mem (nonperiodicChildren NW fW qW).val
        (Classical.choose hmatch z)) |>.1

/-- 構造保存された有限配位表全単射は、再帰的前像木の全ての
    非周期親子辺で一段発展と可換する。根直下だけでなく、任意の
    子部分木内部の辺を深さ帰納法で含む。 -/
theorem preimageTreeNodeTableEquivOfMatching_preserves_parent_edge
    {W : Type} [Fintype W] [DecidableEq W]
    (NW : W → Finset W)
    (fW : (w : W) → (↥(NW w) → State) → State)
    (q : V → State) (qW : W → State)
    (hq : IsPeriodicPoint N f q) (hqW : IsPeriodicPoint NW fW qW)
    (depth : ℕ)
    (hdepth : 2 ^ Fintype.card V - 1 ≤ depth)
    (hdepthW : 2 ^ Fintype.card W - 1 ≤ depth)
    (hmatch : HasTreeMatching N f NW fW depth q qW)
    (u v : TruncatedTreeNode N f depth q)
    (huv : TruncatedTreeParentEdge N f depth q u v) :
    let sourceChild :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth u
    let sourceParent :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f q hq depth hdepth v
    globalMap N f sourceChild = sourceParent ∧
      globalMap NW fW
          (preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW depth
            hdepth hdepthW hmatch sourceChild) =
        preimageTreeNodeTableEquivOfMatching N f NW fW q qW hq hqW depth
          hdepth hdepthW hmatch sourceParent := by
  dsimp only
  constructor
  · simp only [truncatedTreeNodeEquivPreimageTreeNodeTable_apply]
    exact truncatedTreeParentEdge_configuration N f huv
  · simp only [preimageTreeNodeTableEquivOfMatching, Equiv.trans_apply,
      Equiv.symm_apply_apply]
    simp only [truncatedTreeNodeEquivPreimageTreeNodeTable_apply]
    exact truncatedTreeParentEdge_configuration NW fW
      (treeNodeEquivOfMatching_preserves_parent_edge N f NW fW hmatch huv)

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

/-- 一段発展は、各配位が最終的に流入する周期成分を変えない。 -/
theorem globalMap_mem_periodicComponentNodeTable
    (O : Finset (V → State)) (y : V → State)
    (hy : y ∈ periodicComponentNodeTable N f O) :
    globalMap N f y ∈ periodicComponentNodeTable N f O := by
  rw [mem_periodicComponentNodeTable_iff] at hy ⊢
  by_cases hzero : minPreperiod N f y = 0
  · have hyper : IsPeriodicPoint N f y :=
      (isPeriodicPoint_iff_minPreperiod_zero N f y).2 hzero
    have hFper : IsPeriodicPoint N f (globalMap N f y) := by
      obtain ⟨p, hp, hperiod⟩ := hyper
      refine ⟨p, hp, ?_⟩
      calc
        iterate N f p (globalMap N f y) = iterate N f p (iterate N f 1 y) := by
          rw [iterate_succ, iterate_zero]
        _ = iterate N f (p + 1) y := (iterate_add N f p 1 y).symm
        _ = globalMap N f (iterate N f p y) := (iterate_succ N f p y).symm
        _ = globalMap N f y := congrArg (globalMap N f) hperiod
    have hrootY : eventualPeriodicRoot N f y = y := by
      unfold eventualPeriodicRoot
      rw [hzero, iterate_zero]
    have hrootF : eventualPeriodicRoot N f (globalMap N f y) = globalMap N f y := by
      unfold eventualPeriodicRoot
      rw [(isPeriodicPoint_iff_minPreperiod_zero N f _).1 hFper, iterate_zero]
    rw [hrootY] at hy
    rw [hrootF]
    rw [periodicOrbit_eq_of_mem N f y (globalMap N f y) hyper]
    · exact hy
    · exact (mem_periodicOrbit_iff_exists N f y _ hyper).2 ⟨1, by
        rw [iterate_succ, iterate_zero]⟩
  · have hpos : 0 < minPreperiod N f y := Nat.pos_of_ne_zero hzero
    have hdec := minPreperiod_globalMap_eq_sub_one N f y hpos
    have hroot : eventualPeriodicRoot N f (globalMap N f y) =
        eventualPeriodicRoot N f y := by
      unfold eventualPeriodicRoot
      rw [hdec]
      calc
        iterate N f (minPreperiod N f y - 1) (globalMap N f y) =
            iterate N f (minPreperiod N f y - 1) (iterate N f 1 y) := by
          rw [iterate_succ, iterate_zero]
        _ = iterate N f (minPreperiod N f y - 1 + 1) y :=
          (iterate_add N f (minPreperiod N f y - 1) 1 y).symm
        _ = iterate N f (minPreperiod N f y) y := by congr 1 <;> omega
    rw [hroot]
    exact hy

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

/-- 一つの周期軌道へ流入する周期成分表は、周期上の一意な根と、
    その根へ流入する前像木節点表との従属和に全単射である。
    周期位置ごとの前像木対応を周期成分対応へ接着するための分割である。 -/
noncomputable def periodicComponentRootSigmaEquiv
    (q : V → State) (hq : IsPeriodicPoint N f q) :
    (Σ n : Fin (minPeriod N f q),
      ↑(preimageTreeNodeTable N f (iterate N f n q))) ≃
        ↑(periodicComponentNodeTable N f (periodicOrbit N f q)) :=
  Equiv.ofBijective
    (fun p => ⟨p.2, by
      rw [mem_periodicComponentNodeTable_iff]
      have hroot := (mem_preimageTreeNodeTable_iff N f _ p.2).1 p.2.property
      rw [hroot]
      exact periodicOrbit_eq_of_mem N f q (iterate N f p.1 q) hq
        ((mem_periodicOrbit_iff_exists N f q _ hq).2 ⟨p.1, rfl⟩)⟩)
    ⟨by
      intro a b hab
      have hroota := (mem_preimageTreeNodeTable_iff N f _ a.2).1 a.2.property
      have hrootb := (mem_preimageTreeNodeTable_iff N f _ b.2).1 b.2.property
      have habValue : (a.2 : V → State) = (b.2 : V → State) :=
        congrArg Subtype.val hab
      have hiter : iterate N f a.1 q = iterate N f b.1 q := by
        exact hroota.symm.trans
          ((congrArg (eventualPeriodicRoot N f) habValue).trans hrootb)
      have hn : (a.1 : ℕ) = (b.1 : ℕ) :=
        iterate_injective_before_minPeriod N f q hq
          (by simp [a.1.isLt]) (by simp [b.1.isLt]) hiter
      have habIndex : a.1 = b.1 := Fin.ext hn
      cases a with
      | mk ai av =>
          cases b with
          | mk bi bv =>
              cases habIndex
              have hav : av = bv := Subtype.ext habValue
              cases hav
              rfl,
    by
      intro y
      have hyorbit := (mem_periodicComponentNodeTable_iff N f _ y).1 y.property
      have hyroot := eventualPeriodicRoot_isPeriodicPoint N f y
      have hrootmem : eventualPeriodicRoot N f y ∈ periodicOrbit N f q := by
        have hself := mem_periodicOrbit_self N f _ hyroot
        rw [hyorbit] at hself
        exact hself
      obtain ⟨n, hn, hiterate⟩ := Finset.mem_image.mp hrootmem
      let p : Σ n : Fin (minPeriod N f q),
          ↑(preimageTreeNodeTable N f (iterate N f n q)) :=
        ⟨⟨n, Finset.mem_range.mp hn⟩, ⟨y, by
          rw [mem_preimageTreeNodeTable_iff]
          exact hiterate.symm⟩⟩
      exact ⟨p, Subtype.ext rfl⟩⟩

theorem periodicComponentRootSigmaEquiv_bijective
    (q : V → State) (hq : IsPeriodicPoint N f q) :
    Function.Bijective (periodicComponentRootSigmaEquiv N f q hq) :=
  (periodicComponentRootSigmaEquiv N f q hq).bijective

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

/-- 等しい基点語を持つ二つの周期点について、周期位置ごとの再帰的前像木対応を
    一意な周期根による従属和分割に沿って接着し、対応する周期成分表の全単射を得る。
    この段では全単射性だけを固定し、一段発展との可換性はまだ主張しない。 -/
noncomputable def periodicComponentEquivOfBaseWordEq
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r) :
    ↑(periodicComponentNodeTable N f (periodicOrbit N f r)) ≃
      ↑(periodicComponentNodeTable NW fW (periodicOrbit NW fW rW)) := by
  let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
  have hperiod : minPeriod NW fW rW = minPeriod N f r :=
    minPeriod_eq_of_baseWord_eq N f NW fW r rW hbase
  let eIndex : Fin (minPeriod N f r) ≃ Fin (minPeriod NW fW rW) :=
    finCongr hperiod.symm
  let eTrees :
      (Σ n : Fin (minPeriod N f r),
        ↑(preimageTreeNodeTable N f (iterate N f n r))) ≃
        (Σ nW : Fin (minPeriod NW fW rW),
          ↑(preimageTreeNodeTable NW fW (iterate NW fW nW rW))) :=
    Equiv.sigmaCongr eIndex fun n => by
      have hn : (n : ℕ) < minPeriod N f r := n.isLt
      have hrn : IsPeriodicPoint N f (iterate N f n r) :=
        isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
          ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
      have hrWn : IsPeriodicPoint NW fW (iterate NW fW n rW) :=
        isPeriodicPoint_of_mem_periodicOrbit NW fW rW _ hrW
          ((mem_periodicOrbit_iff_exists NW fW rW _ hrW).2 ⟨n, rfl⟩)
      have hmatch := hasTreeMatching_iterate_of_baseWord_eq_commonDepth
        N f NW fW r rW hr hrW hbase n hn
      have hdepth : 2 ^ Fintype.card V - 1 ≤ depth := by
        exact Nat.le_max_left _ _
      have hdepthW : 2 ^ Fintype.card W - 1 ≤ depth := by
        exact Nat.le_max_right _ _
      simpa [eIndex, depth, hperiod] using
        preimageTreeNodeTableEquivOfMatching N f NW fW
          (iterate N f n r) (iterate NW fW n rW) hrn hrWn depth
          hdepth hdepthW hmatch
  exact (periodicComponentRootSigmaEquiv N f r hr).symm |>.trans
    eTrees |>.trans (periodicComponentRootSigmaEquiv NW fW rW hrW)

theorem periodicComponentEquivOfBaseWordEq_bijective
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r) :
    Function.Bijective
      (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase) :=
  (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase).bijective

/-- 周期成分全単射は、同じ有限添字の周期根を対応先の周期根へ送る。 -/
theorem periodicComponentEquivOfBaseWordEq_maps_periodic_root
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : Fin (minPeriod N f r)) :
    let hrn : IsPeriodicPoint N f (iterate N f n r) :=
      isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
        ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
    let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
    let sourceRootTree :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
        depth (Nat.le_max_left _ _) (truncatedTreeNodeRoot N f depth (iterate N f n r))
    let sourceRoot := periodicComponentRootSigmaEquiv N f r hr ⟨n, sourceRootTree⟩
    (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase sourceRoot :
      W → State) = iterate NW fW n rW := by
  dsimp only
  let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
  have hrn : IsPeriodicPoint N f (iterate N f n r) :=
    isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
      ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
  have hrWn : IsPeriodicPoint NW fW (iterate NW fW n rW) :=
    isPeriodicPoint_of_mem_periodicOrbit NW fW rW _ hrW
      ((mem_periodicOrbit_iff_exists NW fW rW _ hrW).2 ⟨n, rfl⟩)
  have hmatch := hasTreeMatching_iterate_of_baseWord_eq_commonDepth
    N f NW fW r rW hr hrW hbase n n.isLt
  change
    ((periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase)
      (periodicComponentRootSigmaEquiv N f r hr ⟨n,
        truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
          depth (Nat.le_max_left _ _)
          (truncatedTreeNodeRoot N f depth (iterate N f n r))⟩) :
      W → State) = iterate NW fW n rW
  unfold periodicComponentEquivOfBaseWordEq
  simp only [Equiv.trans_apply, Equiv.symm_apply_apply]
  simp only [Equiv.sigmaCongr, Equiv.sigmaCongrRight, Equiv.sigmaCongrLeft]
  simp only [periodicComponentRootSigmaEquiv]
  convert preimageTreeNodeTableEquivOfMatching_maps_root
    N f NW fW (iterate N f n r) (iterate NW fW n rW) hrn hrWn depth
      (Nat.le_max_left _ _) (Nat.le_max_right _ _) hmatch using 1 <;> simp [depth]
  all_goals congr 1

/-- 周期位置ごとの前像木対応を従属和上で接着した周期成分全単射は、
    各位置へ流入する全ての非周期親子辺で一段発展と可換する。 -/
theorem periodicComponentEquivOfBaseWordEq_preserves_parent_edge
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (n : Fin (minPeriod N f r))
    (u v : TruncatedTreeNode N f
      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
      (iterate N f n r))
    (huv : TruncatedTreeParentEdge N f
      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
      (iterate N f n r) u v) :
    let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
    let hrn : IsPeriodicPoint N f (iterate N f n r) :=
      isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
        ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
    let sourceChildTree :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
        depth (Nat.le_max_left _ _) u
    let sourceParentTree :=
      truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
        depth (Nat.le_max_left _ _) v
    let sourceChild := periodicComponentRootSigmaEquiv N f r hr ⟨n, sourceChildTree⟩
    let sourceParent := periodicComponentRootSigmaEquiv N f r hr ⟨n, sourceParentTree⟩
    globalMap N f sourceChild = sourceParent ∧
      globalMap NW fW
          (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase
            sourceChild) =
        periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase
          sourceParent := by
  dsimp only
  let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
  have hperiod : minPeriod NW fW rW = minPeriod N f r :=
    minPeriod_eq_of_baseWord_eq N f NW fW r rW hbase
  have hrn : IsPeriodicPoint N f (iterate N f n r) :=
    isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
      ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
  have hrWn : IsPeriodicPoint NW fW (iterate NW fW n rW) :=
    isPeriodicPoint_of_mem_periodicOrbit NW fW rW _ hrW
      ((mem_periodicOrbit_iff_exists NW fW rW _ hrW).2 ⟨n, rfl⟩)
  have hmatch := hasTreeMatching_iterate_of_baseWord_eq_commonDepth
    N f NW fW r rW hr hrW hbase n n.isLt
  have hedge := preimageTreeNodeTableEquivOfMatching_preserves_parent_edge
    N f NW fW (iterate N f n r) (iterate NW fW n rW) hrn hrWn depth
      (Nat.le_max_left _ _) (Nat.le_max_right _ _) hmatch u v huv
  constructor
  · simpa [periodicComponentRootSigmaEquiv] using hedge.1
  · change globalMap NW fW
        (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase
          (periodicComponentRootSigmaEquiv N f r hr ⟨n,
            truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
              depth (Nat.le_max_left _ _) u⟩)) =
      periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase
        (periodicComponentRootSigmaEquiv N f r hr ⟨n,
          truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
            depth (Nat.le_max_left _ _) v⟩)
    unfold periodicComponentEquivOfBaseWordEq
    simp only [Equiv.trans_apply, Equiv.symm_apply_apply]
    simp only [periodicComponentRootSigmaEquiv]
    simp only [Equiv.sigmaCongr, Equiv.sigmaCongrRight, Equiv.sigmaCongrLeft]
    convert hedge.2 using 1 <;> simp [depth]
    all_goals congr 1

/-- 対応する一つの周期成分では、同じ有限添字で対応させた周期辺と、
    周期成分全単射で対応させた非周期前像木の全親子辺の双方で
    一段発展が保存される。 -/
theorem periodicComponentEquivOfBaseWordEq_preserves_all_component_edges
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r) :
    let depth := max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
    (∀ n : Fin (minPeriod N f r),
      globalMap N f (iterate N f n r) =
          (if (n : ℕ) + 1 < minPeriod N f r then iterate N f (n + 1) r else r) ∧
        globalMap NW fW (iterate NW fW n rW) =
          (if (n : ℕ) + 1 < minPeriod N f r then iterate NW fW (n + 1) rW else rW)) ∧
    (∀ (n : Fin (minPeriod N f r))
        (u v : TruncatedTreeNode N f depth (iterate N f n r)),
      TruncatedTreeParentEdge N f depth (iterate N f n r) u v →
      let hrn : IsPeriodicPoint N f (iterate N f n r) :=
        isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
          ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
      let sourceChildTree :=
        truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
          depth (Nat.le_max_left _ _) u
      let sourceParentTree :=
        truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
          depth (Nat.le_max_left _ _) v
      let sourceChild := periodicComponentRootSigmaEquiv N f r hr ⟨n, sourceChildTree⟩
      let sourceParent := periodicComponentRootSigmaEquiv N f r hr ⟨n, sourceParentTree⟩
      globalMap N f sourceChild = sourceParent ∧
        globalMap NW fW
            (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase sourceChild) =
          periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase sourceParent) := by
  dsimp only
  constructor
  · intro n
    exact periodic_index_matching_preserves_edges
      N f NW fW r rW hr hrW hbase n n.isLt
  · intro n u v huv
    exact periodicComponentEquivOfBaseWordEq_preserves_parent_edge
      N f NW fW r rW hr hrW hbase n u v huv

/-- 周期成分全単射は、成分表の全ての配位で一段発展と可換する。
    節点が根であるか親を持つかで場合分けし、周期辺の保存と
    非周期親子辺の保存をそれぞれ適用する。 -/
theorem periodicComponentEquivOfBaseWordEq_commutes_globalMap
    (r : V → State) (rW : W → State)
    (hr : IsPeriodicPoint N f r) (hrW : IsPeriodicPoint NW fW rW)
    (hbase : baseWord NW fW rW = baseWord N f r)
    (y : ↑(periodicComponentNodeTable N f (periodicOrbit N f r))) :
    globalMap NW fW
        (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase y :
          W → State) =
      (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase
        ⟨globalMap N f (y : V → State),
          globalMap_mem_periodicComponentNodeTable N f
            (periodicOrbit N f r) (y : V → State) y.property⟩ : W → State) := by
  classical
  obtain ⟨p, hp⟩ := (periodicComponentRootSigmaEquiv N f r hr).surjective y
  obtain ⟨n, w⟩ := p
  have hrn : IsPeriodicPoint N f (iterate N f n r) :=
    isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
      ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨n, rfl⟩)
  obtain ⟨u, hu⟩ := (truncatedTreeNodeEquivPreimageTreeNodeTable N f
      (iterate N f n r) hrn
      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
      (Nat.le_max_left _ _)).surjective w
  rcases truncatedTreeNode_eq_root_or_exists_parent N f
      (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
      (iterate N f n r) u with hroot | ⟨v, huv⟩
  · -- 節点が根の場合。周期辺の保存を使う。
    subst hroot
    have hyval : (y : V → State) = iterate N f n r := by
      rw [← hp, ← hu]
      exact truncatedTreeNodeConfiguration_root N f _ _
    have hpos : 0 < minPeriod N f r := lt_of_le_of_lt (Nat.zero_le _) n.isLt
    have hedge := periodic_index_matching_preserves_edges N f NW fW r rW hr hrW
      hbase (n : ℕ) n.isLt
    have hEy : (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase y :
        W → State) = iterate NW fW n rW := by
      rw [show y = periodicComponentRootSigmaEquiv N f r hr
          ⟨n, truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
            (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
            (Nat.le_max_left _ _)
            (truncatedTreeNodeRoot N f
              (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
              (iterate N f n r))⟩ from by rw [hu]; exact hp.symm]
      exact periodicComponentEquivOfBaseWordEq_maps_periodic_root
        N f NW fW r rW hr hrW hbase n
    by_cases hnext : (n : ℕ) + 1 < minPeriod N f r
    · have hm : ((⟨(n : ℕ) + 1, hnext⟩ : Fin (minPeriod N f r)) : ℕ) = (n : ℕ) + 1 := rfl
      have hgoalSource : globalMap N f (y : V → State) =
          iterate N f (⟨(n : ℕ) + 1, hnext⟩ : Fin (minPeriod N f r)) r := by
        rw [hyval, hedge.1, if_pos hnext, hm]
      have hsub : (⟨globalMap N f (y : V → State),
            globalMap_mem_periodicComponentNodeTable N f
              (periodicOrbit N f r) (y : V → State) y.property⟩ :
          ↑(periodicComponentNodeTable N f (periodicOrbit N f r))) =
          periodicComponentRootSigmaEquiv N f r hr
            ⟨⟨(n : ℕ) + 1, hnext⟩,
              truncatedTreeNodeEquivPreimageTreeNodeTable N f
                (iterate N f (⟨(n : ℕ) + 1, hnext⟩ : Fin (minPeriod N f r)) r)
                (isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
                  ((mem_periodicOrbit_iff_exists N f r _ hr).2
                    ⟨(n : ℕ) + 1, rfl⟩))
                (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                (Nat.le_max_left _ _)
                (truncatedTreeNodeRoot N f
                  (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                  (iterate N f (⟨(n : ℕ) + 1, hnext⟩ : Fin (minPeriod N f r)) r))⟩ := by
        apply Subtype.ext
        change globalMap N f (y : V → State) = _
        rw [hgoalSource]
        exact (truncatedTreeNodeConfiguration_root N f _ _).symm
      rw [hEy, hsub, hedge.2, if_pos hnext,
        periodicComponentEquivOfBaseWordEq_maps_periodic_root
          N f NW fW r rW hr hrW hbase ⟨(n : ℕ) + 1, hnext⟩]
    · have hm : ((⟨0, hpos⟩ : Fin (minPeriod N f r)) : ℕ) = 0 := rfl
      have hgoalSource : globalMap N f (y : V → State) =
          iterate N f (⟨0, hpos⟩ : Fin (minPeriod N f r)) r := by
        rw [hyval, hedge.1, if_neg hnext, hm, iterate_zero]
      have hsub : (⟨globalMap N f (y : V → State),
            globalMap_mem_periodicComponentNodeTable N f
              (periodicOrbit N f r) (y : V → State) y.property⟩ :
          ↑(periodicComponentNodeTable N f (periodicOrbit N f r))) =
          periodicComponentRootSigmaEquiv N f r hr
            ⟨⟨0, hpos⟩,
              truncatedTreeNodeEquivPreimageTreeNodeTable N f
                (iterate N f (⟨0, hpos⟩ : Fin (minPeriod N f r)) r)
                (isPeriodicPoint_of_mem_periodicOrbit N f r _ hr
                  ((mem_periodicOrbit_iff_exists N f r _ hr).2 ⟨0, rfl⟩))
                (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                (Nat.le_max_left _ _)
                (truncatedTreeNodeRoot N f
                  (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
                  (iterate N f (⟨0, hpos⟩ : Fin (minPeriod N f r)) r))⟩ := by
        apply Subtype.ext
        change globalMap N f (y : V → State) = _
        rw [hgoalSource]
        exact (truncatedTreeNodeConfiguration_root N f _ _).symm
      rw [hEy, hsub, hedge.2, if_neg hnext,
        periodicComponentEquivOfBaseWordEq_maps_periodic_root
          N f NW fW r rW hr hrW hbase ⟨0, hpos⟩, hm, iterate_zero]
  · -- 節点が親を持つ場合。非周期親子辺の保存を使う。
    have hedge := periodicComponentEquivOfBaseWordEq_preserves_parent_edge
      N f NW fW r rW hr hrW hbase n u v huv
    dsimp only at hedge
    obtain ⟨hsrc, hcomm⟩ := hedge
    have hchild : periodicComponentRootSigmaEquiv N f r hr
        ⟨n, truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
          (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
          (Nat.le_max_left _ _) u⟩ = y := by
      rw [hu]; exact hp
    rw [hchild] at hsrc hcomm
    have hsub : (⟨globalMap N f (y : V → State),
          globalMap_mem_periodicComponentNodeTable N f
            (periodicOrbit N f r) (y : V → State) y.property⟩ :
        ↑(periodicComponentNodeTable N f (periodicOrbit N f r))) =
        periodicComponentRootSigmaEquiv N f r hr
          ⟨n, truncatedTreeNodeEquivPreimageTreeNodeTable N f (iterate N f n r) hrn
            (max (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1))
            (Nat.le_max_left _ _) v⟩ := Subtype.ext hsrc
    rw [hsub]
    exact hcomm

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

/-- 写像符号が等しいとき、全ての周期成分について再帰的前像木対応を
    同時に選べ、両側の一段発展が対応する各周期成分を保存する。 -/
theorem exists_orbit_equiv_with_component_matchings_and_stability
    (hcode : mapCode NW fW = mapCode N f) :
    ∃ e : (periodicOrbitTable N f).val ≃ (periodicOrbitTable NW fW).val,
      ∀ O : (periodicOrbitTable N f).val,
        ∃ r : V → State, ∃ rW : W → State,
          r ∈ (O : Finset (V → State)) ∧
            rW ∈ (e O : Finset (W → State)) ∧
              baseWord NW fW rW = baseWord N f r ∧
                (∀ y ∈ periodicComponentNodeTable N f O,
                  globalMap N f y ∈ periodicComponentNodeTable N f O) ∧
                (∀ yW ∈ periodicComponentNodeTable NW fW (e O),
                  globalMap NW fW yW ∈ periodicComponentNodeTable NW fW (e O)) := by
  obtain ⟨e, he⟩ := exists_orbit_equiv_with_component_matchings
    N f NW fW hcode
  refine ⟨e, fun O => ?_⟩
  obtain ⟨r, rW, hrO, hrWO, hbase, _⟩ := he O
  exact ⟨r, rW, hrO, hrWO, hbase,
    fun y hy => globalMap_mem_periodicComponentNodeTable N f O y hy,
    fun yW hyW => globalMap_mem_periodicComponentNodeTable NW fW (e O) yW hyW⟩

/-- 写像符号の等号から、全周期成分の構造保存対応を同時に与える
    重複度付き周期成分対応を一つ固定する。 -/
noncomputable def structurePreservingOrbitEquiv
    (hcode : mapCode NW fW = mapCode N f) :
    Equiv (periodicOrbitTable N f).val (periodicOrbitTable NW fW).val :=
  Classical.choose
    (exists_orbit_equiv_with_component_matchings_and_stability N f NW fW hcode)

/-- 固定した周期成分対応の各成分には、等しい基点語を持つ周期根と
    両成分の一段発展安定性を同時に選べる。 -/
theorem structurePreservingOrbitEquiv_spec
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val) :
    ∃ r : V → State, ∃ rW : W → State,
      r ∈ (O : Finset (V → State)) ∧
        rW ∈ (structurePreservingOrbitEquiv N f NW fW hcode O :
          Finset (W → State)) ∧
          baseWord NW fW rW = baseWord N f r ∧
            (∀ y ∈ periodicComponentNodeTable N f O,
              globalMap N f y ∈ periodicComponentNodeTable N f O) ∧
            (∀ yW ∈ periodicComponentNodeTable NW fW
                (structurePreservingOrbitEquiv N f NW fW hcode O),
              globalMap NW fW yW ∈ periodicComponentNodeTable NW fW
                (structurePreservingOrbitEquiv N f NW fW hcode O)) := by
  exact Classical.choose_spec
    (exists_orbit_equiv_with_component_matchings_and_stability N f NW fW hcode) O

/-- 有限集合の等号に沿って、部分型の間の全単射を移す。 -/
noncomputable def transferEquiv {X Y : Type} {P P' : Finset X} {Q Q' : Finset Y}
    (hP : P = P') (hQ : Q = Q') (e : ↑P ≃ ↑Q) : ↑P' ≃ ↑Q' := by
  subst hP
  subst hQ
  exact e

/-- 移した全単射の値は、元の全単射の値と同じ元である。 -/
theorem transferEquiv_coe {X Y : Type} {P P' : Finset X} {Q Q' : Finset Y}
    (hP : P = P') (hQ : Q = Q') (e : ↑P ≃ ↑Q) (y : ↑P') :
    ((transferEquiv hP hQ e y : Y))
      = (e ⟨(y : X), by rw [hP]; exact y.property⟩ : Y) := by
  subst hP
  subst hQ
  rfl

/-- 同時に選んだ対応成分ごとに、再帰的前像木対応から作った
    構造保存全単射を固定する。 -/
noncomputable def structurePreservingPeriodicComponentEquiv
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val) :
    Equiv ↑(periodicComponentNodeTable N f O)
      ↑(periodicComponentNodeTable NW fW
        (structurePreservingOrbitEquiv N f NW fW hcode O)) := by
  let hex := structurePreservingOrbitEquiv_spec N f NW fW hcode O
  let r := Classical.choose hex
  let hexW := Classical.choose_spec hex
  let rW := Classical.choose hexW
  have hspec := Classical.choose_spec hexW
  have hrO := hspec.1
  have hrWO := hspec.2.1
  have hbase := hspec.2.2.1
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have hOWmem :
      (structurePreservingOrbitEquiv N f NW fW hcode O : Finset (W → State)) ∈
        periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val
      (structurePreservingOrbitEquiv N f NW fW hcode O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW
      (structurePreservingOrbitEquiv N f NW fW hcode O) hOWmem rW hrWO
  have hOrbit : periodicOrbit N f r = (O : Finset (V → State)) := by
    obtain ⟨q, hq, hqO⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
    rw [periodicOrbit_eq_of_mem N f q r hq]
    · exact hqO
    · rwa [hqO]
  have hOrbitW : periodicOrbit NW fW rW =
      (structurePreservingOrbitEquiv N f NW fW hcode O : Finset (W → State)) := by
    obtain ⟨qW, hqW, hqWO⟩ :=
      (mem_periodicOrbitTable_iff NW fW
        (structurePreservingOrbitEquiv N f NW fW hcode O)).1 hOWmem
    rw [periodicOrbit_eq_of_mem NW fW qW rW hqW]
    · exact hqWO
    · rwa [hqWO]
  exact transferEquiv (congrArg (periodicComponentNodeTable N f) hOrbit)
    (congrArg (periodicComponentNodeTable NW fW) hOrbitW)
    (periodicComponentEquivOfBaseWordEq N f NW fW r rW hr hrW hbase)

/-- 同時に選んだ周期成分対応と成分内の構造保存全単射を、
    一意な周期成分分割に沿って全配位の全単射へ接着する。 -/
noncomputable def structurePreservingConfigurationEquiv
    (hcode : mapCode NW fW = mapCode N f) :
    Equiv (V → State) (W → State) :=
  (configurationComponentSigmaEquiv N f).symm |>.trans
    (Equiv.sigmaCongr (structurePreservingOrbitEquiv N f NW fW hcode)
      (structurePreservingPeriodicComponentEquiv N f NW fW hcode)) |>.trans
        (configurationComponentSigmaEquiv NW fW)

/-- 周期成分ごとの再帰的前像木対応を接着した全配位対応は全単射である。 -/
theorem structurePreservingConfigurationEquiv_bijective
    (hcode : mapCode NW fW = mapCode N f) :
    Function.Bijective (structurePreservingConfigurationEquiv N f NW fW hcode) :=
  (structurePreservingConfigurationEquiv N f NW fW hcode).bijective

theorem structurePreservingConfigurationEquiv_apply
    (hcode : mapCode NW fW = mapCode N f) (y : V → State) :
    structurePreservingConfigurationEquiv N f NW fW hcode y =
      structurePreservingPeriodicComponentEquiv N f NW fW hcode
        (periodicComponentOccurrenceIndex N f y)
        ⟨y, periodicComponentIndex_spec N f y⟩ := by
  rfl

/-- 同時に選んだ各周期成分の構造保存全単射は、
    その成分内の全配位で一段発展と可換する。 -/
theorem structurePreservingPeriodicComponentEquiv_commutes_globalMap
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val)
    (y : ↑(periodicComponentNodeTable N f O)) :
    globalMap NW fW
        (structurePreservingPeriodicComponentEquiv N f NW fW hcode O y : W → State) =
      (structurePreservingPeriodicComponentEquiv N f NW fW hcode O
        ⟨globalMap N f (y : V → State),
          globalMap_mem_periodicComponentNodeTable N f O
            (y : V → State) y.property⟩ : W → State) := by
  let hex := structurePreservingOrbitEquiv_spec N f NW fW hcode O
  let r := Classical.choose hex
  let hexW := Classical.choose_spec hex
  let rW := Classical.choose hexW
  have hspec := Classical.choose_spec hexW
  have hrO := hspec.1
  have hrWO := hspec.2.1
  have hbase := hspec.2.2.1
  have hOmem : (O : Finset (V → State)) ∈ periodicOrbitTable N f :=
    occurrence_mem (periodicOrbitTable N f).val O
  have hOWmem :
      (structurePreservingOrbitEquiv N f NW fW hcode O : Finset (W → State)) ∈
        periodicOrbitTable NW fW :=
    occurrence_mem (periodicOrbitTable NW fW).val
      (structurePreservingOrbitEquiv N f NW fW hcode O)
  have hr : IsPeriodicPoint N f r :=
    isPeriodicPoint_of_mem_periodicOrbitTable N f O hOmem r hrO
  have hrW : IsPeriodicPoint NW fW rW :=
    isPeriodicPoint_of_mem_periodicOrbitTable NW fW
      (structurePreservingOrbitEquiv N f NW fW hcode O) hOWmem rW hrWO
  have hOrbit : periodicOrbit N f r = (O : Finset (V → State)) := by
    obtain ⟨q, hq, hqO⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
    rw [periodicOrbit_eq_of_mem N f q r hq]
    · exact hqO
    · rwa [hqO]
  simp only [structurePreservingPeriodicComponentEquiv, transferEquiv_coe]
  exact periodicComponentEquivOfBaseWordEq_commutes_globalMap
    N f NW fW r rW hr hrW hbase ⟨(y : V → State), by rw [hOrbit]; exact y.property⟩

/-- 配位が属する周期成分表を一つ指定すれば、接着した全配位対応の値は
    その成分の構造保存全単射の値に一致する。 -/
theorem structurePreservingConfigurationEquiv_apply_of_mem
    (hcode : mapCode NW fW = mapCode N f)
    (O : (periodicOrbitTable N f).val) (y : V → State)
    (hy : y ∈ periodicComponentNodeTable N f O) :
    structurePreservingConfigurationEquiv N f NW fW hcode y =
      (structurePreservingPeriodicComponentEquiv N f NW fW hcode O ⟨y, hy⟩ : W → State) := by
  have hidx : periodicComponentOccurrenceIndex N f y = O :=
    periodicComponentOccurrenceIndex_eq_of_mem N f O y hy
  subst hidx
  rw [structurePreservingConfigurationEquiv_apply]

/-- 写像符号の等号から接着した全配位全単射は一段発展と可換する。 -/
theorem structurePreservingConfigurationEquiv_commutes_globalMap
    (hcode : mapCode NW fW = mapCode N f) (y : V → State) :
    structurePreservingConfigurationEquiv N f NW fW hcode (globalMap N f y) =
      globalMap NW fW (structurePreservingConfigurationEquiv N f NW fW hcode y) := by
  have hy : y ∈ periodicComponentNodeTable N f (periodicComponentOccurrenceIndex N f y) :=
    periodicComponentIndex_spec N f y
  have hFy : globalMap N f y ∈
      periodicComponentNodeTable N f (periodicComponentOccurrenceIndex N f y) :=
    globalMap_mem_periodicComponentNodeTable N f _ y hy
  have hindex : periodicComponentOccurrenceIndex N f (globalMap N f y)
      = periodicComponentOccurrenceIndex N f y :=
    periodicComponentOccurrenceIndex_eq_of_mem N f _ (globalMap N f y) hFy
  rw [structurePreservingConfigurationEquiv_apply_of_mem N f NW fW hcode
      (periodicComponentOccurrenceIndex N f y) (globalMap N f y) hFy,
    structurePreservingConfigurationEquiv_apply_of_mem N f NW fW hcode
      (periodicComponentOccurrenceIndex N f y) y hy]
  exact (structurePreservingPeriodicComponentEquiv_commutes_globalMap
    N f NW fW hcode (periodicComponentOccurrenceIndex N f y) ⟨y, hy⟩).symm

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
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.codeAtDepth_transport
    (nonperiodicChildren N f) (nonperiodicChildren NW fW) h
    (image_nonperiodicChildren N f NW fW h hconj) depth y

/-- 共役全単射は再帰的前像木符号を点ごとに保存する。 -/
theorem recursiveCode_transport (y : V → State) :
    recursiveCode NW fW (h y) = recursiveCode N f y := by
  rw [recursiveCode_eq_completedCode, recursiveCode_eq_completedCode]
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.completedCode_transport
    (nonperiodicChildren N f) (nonperiodicChildren NW fW) h
    (image_nonperiodicChildren N f NW fW h hconj)
    (2 ^ Fintype.card V - 1) (2 ^ Fintype.card W - 1)
    (by rw [card_cells_eq h])
    (minPreperiod N f) (minPreperiod NW fW)
    (minPreperiod_transport N f NW fW h hconj) y

/-- 共役全単射は周期点の基点語を保存する。 -/
theorem baseWord_transport (q : V → State) :
    baseWord NW fW (h q) = baseWord N f q := by
  rw [baseWord_eq_necessary_sufficient, baseWord_eq_necessary_sufficient]
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.baseWord_transport
    (minPeriod N f) (minPeriod NW fW) (iterate N f) (iterate NW fW)
    (recursiveCode N f) (recursiveCode NW fW) h
    (minPeriod_transport N f NW fW h hconj)
    (fun n y => IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj n y)
    (recursiveCode_transport N f NW fW h hconj) q

/-- 共役全単射は周期軌道の有限表を全単射に移す。 -/
theorem image_periodicOrbit (q : V → State) :
    (periodicOrbit N f q).image h = periodicOrbit NW fW (h q) := by
  rw [periodicOrbit_eq_necessary_sufficient, periodicOrbit_eq_necessary_sufficient]
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.image_periodicOrbit
    (minPeriod N f) (minPeriod NW fW) (iterate N f) (iterate NW fW) h
    (minPeriod_transport N f NW fW h hconj)
    (fun n y => IterateMonoidConjugacyInvariance.conjugate_iterate N f NW fW h hconj n y) q

/-- 共役全単射は周期軌道の成分符号を保存する。 -/
theorem componentCode_transport (q : V → State) :
    componentCode NW fW (h q) = componentCode N f q := by
  rw [componentCode_eq_necessary_sufficient, componentCode_eq_necessary_sufficient]
  exact NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.componentCode_transport
    (periodicOrbit N f) (periodicOrbit NW fW) (baseWord N f) (baseWord NW fW) h
    (image_periodicOrbit N f NW fW h hconj)
    (baseWord_transport N f NW fW h hconj) q

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
  rw [mapCode_eq_necessary_sufficient, mapCode_eq_necessary_sufficient]
  apply NecSuf.RecursivePreimageTreeCode.ConjugacyInvariance.aggregateCode_transport
    (periodicOrbitTable N f) (periodicOrbitTable NW fW) (Finset.image h)
    (Finset.image_injective h.injective)
    (image_periodicOrbitTable N f NW fW h hconj)
  intro O hO
  have hOmem : O ∈ periodicOrbitTable N f := hO
  obtain ⟨q, hq, rfl⟩ := (mem_periodicOrbitTable_iff N f O).1 hOmem
  have hne : (periodicOrbit N f q).Nonempty := ⟨q, mem_periodicOrbit_self N f q hq⟩
  have hneW : ((periodicOrbit N f q).image h).Nonempty := hne.image h
  rw [dif_pos hneW, dif_pos hne]
  obtain ⟨z, hzmem, hzeq⟩ := Finset.mem_image.mp hneW.choose_spec
  rw [← hzeq, componentCode_transport N f NW fW h hconj z,
    componentCode_eq_of_mem N f q z hq hzmem,
    componentCode_eq_of_mem N f q hne.choose hq hne.choose_spec]

end ConjugacyTransport

section CompleteInvariant

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

/-- 写像符号が等しければ共役全単射を構成できる
    （`claim_recursive_preimage_tree_code_completeness` の結論）。 -/
theorem exists_conjugacy_of_mapCode_eq (hcode : mapCode NW fW = mapCode N f) :
    ∃ h : (V → State) ≃ (W → State),
      ∀ y, h (globalMap N f y) = globalMap NW fW (h y) :=
  ⟨structurePreservingConfigurationEquiv N f NW fW hcode,
    structurePreservingConfigurationEquiv_commutes_globalMap N f NW fW hcode⟩

/-- 再帰的前像木符号は共役の完全不変量である
    （`claim_recursive_preimage_tree_code_complete_invariant` の結論）。 -/
theorem mapCode_eq_iff_exists_conjugacy :
    mapCode NW fW = mapCode N f ↔
      ∃ h : (V → State) ≃ (W → State),
        ∀ y, h (globalMap N f y) = globalMap NW fW (h y) := by
  constructor
  · exact exists_conjugacy_of_mapCode_eq N f NW fW
  · rintro ⟨h, hconj⟩
    exact mapCode_transport N f NW fW h hconj

/-! ## 有限決定（`claim_recursive_preimage_tree_code_finite_decidability`） -/

/-- 二つの有限な写像符号の等号は決定可能である。写像符号は、有限配位表から
    最小前周期の有限上界まで再帰して作った自然数の有限多重集合である。 -/
noncomputable instance mapCodeEqualityDecidable : Decidable (mapCode NW fW = mapCode N f) :=
  @CellularAutomata.NecSuf.RecursivePreimageTreeCode.codeEqualityDecidable
    (Multiset (Finset (List ℕ)))
    CellularAutomata.NecSuf.RecursivePreimageTreeCode.mapCodeTypeDecidableEq
    (mapCode N f) (mapCode NW fW)

/-- 共役全単射の存在は、完全不変量である写像符号の等号を有限比較することで
    決定できる。全単射を先に全数走査する必要はない。 -/
noncomputable instance conjugacyExistenceDecidable :
    Decidable
      (∃ h : (V → State) ≃ (W → State),
        ∀ y, h (globalMap N f y) = globalMap NW fW (h y)) :=
  decidable_of_iff (mapCode NW fW = mapCode N f)
    (mapCode_eq_iff_exists_conjugacy N f NW fW)

/-- 符号の有限比較が一致を返した場合に固定する共役全単射。
    不一致の場合は `none` を返す。 -/
noncomputable def conjugacyFromMapCodeDecision : Option ((V → State) ≃ (W → State)) :=
  if hcode : mapCode NW fW = mapCode N f then
    some (structurePreservingConfigurationEquiv N f NW fW hcode)
  else
    none

/-- 符号が等しい場合、有限決定から得る値は、再帰的前像木対応を接着して
    構成した共役全単射そのものである。 -/
theorem conjugacyFromMapCodeDecision_eq_some
    (hcode : mapCode NW fW = mapCode N f) :
    conjugacyFromMapCodeDecision N f NW fW =
      some (structurePreservingConfigurationEquiv N f NW fW hcode) := by
  simp [conjugacyFromMapCodeDecision, hcode]

/-- 有限決定が返す `Option` に値があることと、共役全単射が存在することは同値である。 -/
theorem conjugacyFromMapCodeDecision_isSome_iff :
    (conjugacyFromMapCodeDecision N f NW fW).isSome ↔
      ∃ h : (V → State) ≃ (W → State),
        ∀ y, h (globalMap N f y) = globalMap NW fW (h y) := by
  rw [← mapCode_eq_iff_exists_conjugacy N f NW fW]
  by_cases hcode : mapCode NW fW = mapCode N f
  · simp [conjugacyFromMapCodeDecision, hcode]
  · simp [conjugacyFromMapCodeDecision, hcode]

end CompleteInvariant

/-! ## 必要十分版からの導出 -/

section NecSufDerivation

variable {W : Type} [Fintype W] [DecidableEq W]
variable (NW : W → Finset W)
variable (fW : (w : W) → (↥(NW w) → State) → State)

open CellularAutomata.NecSuf.RecursivePreimageTreeCode

/-- 具体版の共役全単射の存在は、必要十分版の `HasConjugacy` の特殊化である。 -/
theorem hasConjugacy_eq :
    HasConjugacy (globalMap N f) (globalMap NW fW) =
      ∃ h : (V → State) ≃ (W → State),
        ∀ y, h (globalMap N f y) = globalMap NW fW (h y) := rfl

/-- 具体版の完全不変量は、必要十分版の同値の特殊化として得られる
    （完全性と共役不変性の二つの含意だけを渡す）。 -/
theorem mapCode_eq_iff_exists_conjugacy_of_necSuf :
    mapCode NW fW = mapCode N f ↔
      ∃ h : (V → State) ≃ (W → State),
        ∀ y, h (globalMap N f y) = globalMap NW fW (h y) :=
  code_eq_iff_hasConjugacy (globalMap N f) (globalMap NW fW)
    (mapCode N f) (mapCode NW fW)
    (exists_conjugacy_of_mapCode_eq N f NW fW)
    (fun hconj => mapCode_transport N f NW fW hconj.choose hconj.choose_spec)

/-- 具体版の有限決定が返す `Option` は、必要十分版の選択に
    符号型 `Multiset (Finset (List ℕ))` の等号判定と、符号の等号から
    共役全単射を作る具体版の構成を渡した特殊化である。 -/
theorem conjugacyFromMapCodeDecision_of_necSuf :
    conjugacyFromMapCodeDecision N f NW fW =
      @conjugacyFromDecision (V → State) (W → State) (Multiset (Finset (List ℕ)))
        mapCodeTypeDecidableEq (mapCode N f) (mapCode NW fW)
        (fun hcode => structurePreservingConfigurationEquiv N f NW fW hcode) := by
  by_cases hcode : mapCode NW fW = mapCode N f
  · simp [conjugacyFromMapCodeDecision, conjugacyFromDecision, hcode]
  · simp [conjugacyFromMapCodeDecision, conjugacyFromDecision, hcode]

end NecSufDerivation

end CellularAutomata.RecursivePreimageTreeCode
