/-
節「二次形式」の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                        必要十分版との対応
  polarization・splitQuadraticForm              …_eq_necSuf（rfl）
  IsQuadraticForm・IsNondegenerateQuadraticForm・IsIsometry
                                                …_iff_necSuf
  各主張                                        …_of_necSuf

ℂ の性質は、加法の結合法則・交換法則に `add_assoc`・`add_comm`、a + (-a) = 0 に `add_neg_cancel`、0 + a = a に `zero_add`、
双対空間を線型空間にする性質に `complexDualSpaceVectorSpaceLaws` を渡す。
W ⊕ W^* の元 (w, f) は、具体版では f が具体版の双対空間の元、必要十分版では必要十分版の双対空間の元である。
二つの双対空間は値の写像が同じ元を持つ別の部分型なので、(w, f) を (w, f.toNecSuf) に写して必要十分版の主張を当てる
（`DualSpace.toNecSuf`。値の写像はそのままなので、両辺の値は定義により一致する）。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.QuadraticForm.QuadraticForm
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexVectorSpaceFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.QuadraticForm.QuadraticForm

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u}

/-! ### 定義の対応 -/

theorem polarization_eq_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) :
    polarization S q x y = NecSuf.VectorSpace.polarization S.toNecSuf q x y := rfl

theorem isQuadraticForm_iff_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) :
    IsQuadraticForm S q ↔ NecSuf.VectorSpace.IsQuadraticForm S.toNecSuf q :=
  ⟨fun h => ⟨h.map_smul, fun y => (isComplexLinearForm_iff_necSuf S _).1 (h.polarization_isLinearForm y)⟩,
    fun h => ⟨h.map_smul, fun y => (isComplexLinearForm_iff_necSuf S _).2 (h.polarization_isLinearForm y)⟩⟩

theorem isNondegenerateQuadraticForm_iff_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) :
    IsNondegenerateQuadraticForm S q ↔ NecSuf.VectorSpace.IsNondegenerateQuadraticForm S.toNecSuf q :=
  ⟨fun h => ⟨(isQuadraticForm_iff_necSuf S q).1 h.isQuadraticForm, h.nondegenerate⟩,
    fun h => ⟨(isQuadraticForm_iff_necSuf S q).2 h.isQuadraticForm, h.nondegenerate⟩⟩

theorem isIsometry_iff_necSuf {V' : Type v} (S : ComplexVectorSpace V) (S' : ComplexVectorSpace V')
    (q : V → ℂ) (q' : V' → ℂ) (θ : V → V') :
    IsIsometry S S' q q' θ ↔ NecSuf.VectorSpace.IsIsometry S.toNecSuf S'.toNecSuf q q' θ :=
  ⟨fun h => ⟨(isQuadraticForm_iff_necSuf S q).1 h.isQuadraticForm, (isQuadraticForm_iff_necSuf S' q').1 h.isQuadraticForm',
      (isComplexLinearMap_iff_necSuf S S' θ).1 h.isLinearMap, h.map_form⟩,
    fun h => ⟨(isQuadraticForm_iff_necSuf S q).2 h.isQuadraticForm, (isQuadraticForm_iff_necSuf S' q').2 h.isQuadraticForm',
      (isComplexLinearMap_iff_necSuf S S' θ).2 h.isLinearMap, h.map_form⟩⟩

/-! ### 偏極の主張 -/

/-- 本文 `claim_polarization_identity` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_identity_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) :
    (q x + q y) + polarization S q x y = q (S.add x y) :=
  NecSuf.VectorSpace.polarization_identity _root_.add_assoc _root_.add_comm add_neg_cancel _root_.zero_add
    S.toNecSuf q x y

/-- 本文 `claim_polarization_is_symmetric` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_symm_of_necSuf (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) :
    polarization S q x y = polarization S q y x :=
  NecSuf.VectorSpace.polarization_symm _root_.add_assoc _root_.add_comm S.toNecSuf q x y

/-! ### 対による二次の写像 -/

section Split

variable {W : Type u} (SW : ComplexVectorSpace W)

/-- W ⊕ W^* の元 (w, f) を、必要十分版の W ⊕ W^* の元 (w, f.toNecSuf) に写す。 -/
def splitPointToNecSuf (p : W × DualSpace SW) : W × NecSuf.VectorSpace.DualSpace SW.toNecSuf :=
  (p.1, p.2.toNecSuf)

theorem splitQuadraticForm_eq_necSuf (p : W × DualSpace SW) :
    splitQuadraticForm SW p = NecSuf.VectorSpace.splitQuadraticForm SW.toNecSuf (splitPointToNecSuf SW p) := rfl

/-- 本文 `claim_value_of_polarization_of_split_quadratic_form` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem polarization_splitQuadraticForm_of_necSuf (w w' : W) (f f' : DualSpace SW) :
    polarization (splitSpace SW) (splitQuadraticForm SW) (w, f) (w', f') = f.1 w' + f'.1 w :=
  NecSuf.VectorSpace.polarization_splitQuadraticForm complexDualSpaceVectorSpaceLaws SW.toNecSuf add_neg_cancel
    w w' f.toNecSuf f'.toNecSuf

/-- 本文 `claim_split_quadratic_form_is_quadratic_form` を、必要十分版に ℂ の性質を渡して得たもの。
二つの条件を、写した点で必要十分版の二つの条件に当てる。 -/
theorem splitQuadraticForm_isQuadraticForm_of_necSuf :
    IsQuadraticForm (splitSpace SW) (splitQuadraticForm SW) := by
  have h := NecSuf.VectorSpace.splitQuadraticForm_isQuadraticForm complexDualSpaceVectorSpaceLaws SW.toNecSuf
    add_neg_cancel
  exact {
    map_smul := fun l p => h.map_smul l (splitPointToNecSuf SW p)
    polarization_isLinearForm := fun y => {
      map_add := fun p₁ p₂ => (h.polarization_isLinearForm (splitPointToNecSuf SW y)).map_add
        (splitPointToNecSuf SW p₁) (splitPointToNecSuf SW p₂)
      map_smul := fun l p => (h.polarization_isLinearForm (splitPointToNecSuf SW y)).map_smul l
        (splitPointToNecSuf SW p) } }

/-- 本文 `claim_split_quadratic_form_vanishes_on_first_component` を、必要十分版から得たもの。 -/
theorem splitQuadraticForm_embedFirst_of_necSuf (w : W) :
    splitQuadraticForm SW (embedFirst (dualSpaceVectorSpace SW) w) = 0 :=
  NecSuf.VectorSpace.splitQuadraticForm_embedFirst complexDualSpaceVectorSpaceLaws SW.toNecSuf w

/-- 本文 `claim_split_quadratic_form_vanishes_on_second_component` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem splitQuadraticForm_embedSecond_of_necSuf (g : DualSpace SW) :
    splitQuadraticForm SW (embedSecond SW g) = 0 :=
  NecSuf.VectorSpace.splitQuadraticForm_embedSecond SW.toNecSuf (_root_.add_zero 0) zero_mul g.toNecSuf

end Split

end CliffordMatrixIsomorphism.ComplexVectorSpace
