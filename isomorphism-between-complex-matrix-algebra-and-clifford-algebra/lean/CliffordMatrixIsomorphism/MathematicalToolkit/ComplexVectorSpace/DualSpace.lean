/-
節「ℂ-線型空間」のうち双対空間の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                  このファイル
  claim_pointwise_sum_of_linear_forms_is_linear_form            pointwiseSum（s_{f,g}）・pointwiseSum_isLinearForm
  claim_pointwise_scalar_multiple_of_linear_form_is_linear_form pointwiseScalarMultiple（m_{μ,f}）・pointwiseScalarMultiple_isLinearForm
  claim_zero_map_is_linear_form                                 zeroMap（z_V）・zeroMap_isLinearForm
  def_dual_space                                                DualSpace・DualSpace.add・DualSpace.smul・DualSpace.zero
  claim_dual_space_is_complex_vector_space                      dualSpaceVectorSpace

本文の「定義によって等しい」行は `rfl`、ℂ の公理を一つ当てる行は、その公理の mathlib の補題を
引数を明示して `rw` で一回当てる。

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/DualSpace.lean`、導出版は `ComplexVectorSpaceFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {V : Type u}

/-- 本文 `claim_pointwise_sum_of_linear_forms_is_linear_form` の s_{f,g}(x) := f(x) +_ℂ g(x)。 -/
def pointwiseSum (f g : V → ℂ) : V → ℂ := fun x => f x + g x

/-- 本文 `claim_pointwise_sum_of_linear_forms_is_linear_form`。 -/
theorem pointwiseSum_isLinearForm (S : ComplexVectorSpace V) {f g : V → ℂ}
    (hf : IsComplexLinearForm S f) (hg : IsComplexLinearForm S g) :
    IsComplexLinearForm S (pointwiseSum f g) where
  map_add x y := calc
    pointwiseSum f g (S.add x y) = f (S.add x y) + g (S.add x y) := rfl
    _ = (f x + f y) + g (S.add x y) := by rw [hf.map_add x y]
    _ = (f x + f y) + (g x + g y) := by rw [hg.map_add x y]
    _ = f x + (f y + (g x + g y)) := by rw [_root_.add_assoc (f x) (f y) (g x + g y)]
    _ = f x + ((f y + g x) + g y) := by rw [_root_.add_assoc (f y) (g x) (g y)]
    _ = f x + ((g x + f y) + g y) := by rw [_root_.add_comm (f y) (g x)]
    _ = f x + (g x + (f y + g y)) := by rw [_root_.add_assoc (g x) (f y) (g y)]
    _ = (f x + g x) + (f y + g y) := by rw [_root_.add_assoc (f x) (g x) (f y + g y)]
    _ = pointwiseSum f g x + pointwiseSum f g y := rfl
  map_smul l x := calc
    pointwiseSum f g (S.smul l x) = f (S.smul l x) + g (S.smul l x) := rfl
    _ = l * f x + g (S.smul l x) := by rw [hf.map_smul l x]
    _ = l * f x + l * g x := by rw [hg.map_smul l x]
    _ = l * (f x + g x) := by rw [mul_add l (f x) (g x)]
    _ = l * pointwiseSum f g x := rfl

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_form_is_linear_form` の m_{μ,f}(x) := μ ·_ℂ f(x)。 -/
def pointwiseScalarMultiple (μ : ℂ) (f : V → ℂ) : V → ℂ := fun x => μ * f x

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_form_is_linear_form`。 -/
theorem pointwiseScalarMultiple_isLinearForm (S : ComplexVectorSpace V) (μ : ℂ) {f : V → ℂ}
    (hf : IsComplexLinearForm S f) : IsComplexLinearForm S (pointwiseScalarMultiple μ f) where
  map_add x y := calc
    pointwiseScalarMultiple μ f (S.add x y) = μ * f (S.add x y) := rfl
    _ = μ * (f x + f y) := by rw [hf.map_add x y]
    _ = μ * f x + μ * f y := by rw [mul_add μ (f x) (f y)]
    _ = pointwiseScalarMultiple μ f x + pointwiseScalarMultiple μ f y := rfl
  map_smul l x := calc
    pointwiseScalarMultiple μ f (S.smul l x) = μ * f (S.smul l x) := rfl
    _ = μ * (l * f x) := by rw [hf.map_smul l x]
    _ = (μ * l) * f x := by rw [mul_assoc μ l (f x)]
    _ = (l * μ) * f x := by rw [mul_comm μ l]
    _ = l * (μ * f x) := by rw [mul_assoc l μ (f x)]
    _ = l * pointwiseScalarMultiple μ f x := rfl

/-- 本文 `claim_zero_map_is_linear_form` の z_V(x) := 0_ℂ。 -/
def zeroMap : V → ℂ := fun _ => 0

/-- 本文 `claim_zero_map_is_linear_form`。 -/
theorem zeroMap_isLinearForm (S : ComplexVectorSpace V) : IsComplexLinearForm S (zeroMap (V := V)) where
  map_add x y := calc
    zeroMap (S.add x y) = (0 : ℂ) := rfl
    _ = 0 + 0 := by rw [_root_.add_zero (0 : ℂ)]
    _ = zeroMap x + zeroMap y := rfl
  map_smul l x := calc
    zeroMap (S.smul l x) = (0 : ℂ) := rfl
    _ = l * 0 := by rw [mul_zero l]
    _ = l * zeroMap x := rfl

/-- 本文 `def_dual_space` の V^*：V 上の線型形式全体。二つの元が等しいとは写像として等しいこと。 -/
abbrev DualSpace (S : ComplexVectorSpace V) : Type u := {f : V → ℂ // IsComplexLinearForm S f}

namespace DualSpace

variable (S : ComplexVectorSpace V)

/-- 本文 `def_dual_space` の f +_{V^*} g := s_{f,g}。値が V^* に入る根拠は `pointwiseSum_isLinearForm`。 -/
def add (f g : DualSpace S) : DualSpace S :=
  ⟨pointwiseSum f.1 g.1, pointwiseSum_isLinearForm S f.2 g.2⟩

/-- 本文 `def_dual_space` の μ ·_{V^*} f := m_{μ,f}。 -/
def smul (μ : ℂ) (f : DualSpace S) : DualSpace S :=
  ⟨pointwiseScalarMultiple μ f.1, pointwiseScalarMultiple_isLinearForm S μ f.2⟩

/-- 本文 `def_dual_space` の 0_{V^*} := z_V。 -/
def zero : DualSpace S := ⟨zeroMap, zeroMap_isLinearForm S⟩

variable {S}

/-- 本文 `def_dual_space` の「V^* の二つの元が等しいとは、すべての x ∈ V での値が等しいこと」。 -/
theorem ext {f g : DualSpace S} (h : ∀ x : V, f.1 x = g.1 x) : f = g :=
  Subtype.ext (funext h)

end DualSpace

/-- 本文 `claim_dual_space_is_complex_vector_space`：組 (V^*, +_{V^*}, ·_{V^*}, 0_{V^*}) は ℂ-線型空間である。
八つの条件を、各点 x での値の等式で確かめる。加法の逆元は f' := (-1_ℂ) ·_{V^*} f。 -/
def dualSpaceVectorSpace (S : ComplexVectorSpace V) : ComplexVectorSpace (DualSpace S) where
  add := DualSpace.add S
  smul := DualSpace.smul S
  zero := DualSpace.zero S
  add_assoc f g h := DualSpace.ext fun x => calc
    (DualSpace.add S (DualSpace.add S f g) h).1 x
        = pointwiseSum (DualSpace.add S f g).1 h.1 x := rfl
    _ = (DualSpace.add S f g).1 x + h.1 x := rfl
    _ = pointwiseSum f.1 g.1 x + h.1 x := rfl
    _ = (f.1 x + g.1 x) + h.1 x := rfl
    _ = f.1 x + (g.1 x + h.1 x) := by rw [_root_.add_assoc (f.1 x) (g.1 x) (h.1 x)]
    _ = f.1 x + pointwiseSum g.1 h.1 x := rfl
    _ = f.1 x + (DualSpace.add S g h).1 x := rfl
    _ = pointwiseSum f.1 (DualSpace.add S g h).1 x := rfl
    _ = (DualSpace.add S f (DualSpace.add S g h)).1 x := rfl
  add_comm f g := DualSpace.ext fun x => calc
    (DualSpace.add S f g).1 x = pointwiseSum f.1 g.1 x := rfl
    _ = f.1 x + g.1 x := rfl
    _ = g.1 x + f.1 x := by rw [_root_.add_comm (f.1 x) (g.1 x)]
    _ = pointwiseSum g.1 f.1 x := rfl
    _ = (DualSpace.add S g f).1 x := rfl
  add_zero f := DualSpace.ext fun x => calc
    (DualSpace.add S f (DualSpace.zero S)).1 x = pointwiseSum f.1 (DualSpace.zero S).1 x := rfl
    _ = f.1 x + (DualSpace.zero S).1 x := rfl
    _ = f.1 x + zeroMap x := rfl
    _ = f.1 x + 0 := rfl
    _ = f.1 x := by rw [_root_.add_zero (f.1 x)]
  exists_add_inverse f := ⟨DualSpace.smul S (-1) f, DualSpace.ext fun x => calc
    (DualSpace.add S f (DualSpace.smul S (-1) f)).1 x
        = pointwiseSum f.1 (DualSpace.smul S (-1) f).1 x := rfl
    _ = f.1 x + (DualSpace.smul S (-1) f).1 x := rfl
    _ = f.1 x + pointwiseScalarMultiple (-1) f.1 x := rfl
    _ = f.1 x + (-1) * f.1 x := rfl
    _ = 1 * f.1 x + (-1) * f.1 x := by rw [one_mul (f.1 x)]
    _ = (1 + (-1)) * f.1 x := by rw [add_mul (1 : ℂ) (-1) (f.1 x)]
    _ = 0 * f.1 x := by rw [add_neg_cancel (1 : ℂ)]
    _ = 0 := by rw [zero_mul (f.1 x)]
    _ = zeroMap x := rfl
    _ = (DualSpace.zero S).1 x := rfl⟩
  smul_assoc l μ f := DualSpace.ext fun x => calc
    (DualSpace.smul S (l * μ) f).1 x = pointwiseScalarMultiple (l * μ) f.1 x := rfl
    _ = (l * μ) * f.1 x := rfl
    _ = l * (μ * f.1 x) := by rw [mul_assoc l μ (f.1 x)]
    _ = l * pointwiseScalarMultiple μ f.1 x := rfl
    _ = l * (DualSpace.smul S μ f).1 x := rfl
    _ = pointwiseScalarMultiple l (DualSpace.smul S μ f).1 x := rfl
    _ = (DualSpace.smul S l (DualSpace.smul S μ f)).1 x := rfl
  one_smul f := DualSpace.ext fun x => calc
    (DualSpace.smul S 1 f).1 x = pointwiseScalarMultiple 1 f.1 x := rfl
    _ = 1 * f.1 x := rfl
    _ = f.1 x := by rw [one_mul (f.1 x)]
  smul_add l f g := DualSpace.ext fun x => calc
    (DualSpace.smul S l (DualSpace.add S f g)).1 x
        = pointwiseScalarMultiple l (DualSpace.add S f g).1 x := rfl
    _ = l * (DualSpace.add S f g).1 x := rfl
    _ = l * pointwiseSum f.1 g.1 x := rfl
    _ = l * (f.1 x + g.1 x) := rfl
    _ = l * f.1 x + l * g.1 x := by rw [mul_add l (f.1 x) (g.1 x)]
    _ = pointwiseScalarMultiple l f.1 x + pointwiseScalarMultiple l g.1 x := rfl
    _ = (DualSpace.smul S l f).1 x + (DualSpace.smul S l g).1 x := rfl
    _ = pointwiseSum (DualSpace.smul S l f).1 (DualSpace.smul S l g).1 x := rfl
    _ = (DualSpace.add S (DualSpace.smul S l f) (DualSpace.smul S l g)).1 x := rfl
  add_smul l μ f := DualSpace.ext fun x => calc
    (DualSpace.smul S (l + μ) f).1 x = pointwiseScalarMultiple (l + μ) f.1 x := rfl
    _ = (l + μ) * f.1 x := rfl
    _ = l * f.1 x + μ * f.1 x := by rw [add_mul l μ (f.1 x)]
    _ = pointwiseScalarMultiple l f.1 x + pointwiseScalarMultiple μ f.1 x := rfl
    _ = (DualSpace.smul S l f).1 x + (DualSpace.smul S μ f).1 x := rfl
    _ = pointwiseSum (DualSpace.smul S l f).1 (DualSpace.smul S μ f).1 x := rfl
    _ = (DualSpace.add S (DualSpace.smul S l f) (DualSpace.smul S μ f)).1 x := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
