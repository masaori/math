/-
節「テンソル積」のうち、集合上の ℂ 値写像の集合と各点ごとの演算の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  def_complex_valued_maps_on_set                                ComplexValuedMaps.add・smul・zero
  claim_complex_valued_maps_on_set_form_complex_vector_space    complexValuedMapsVectorSpace

ℂ^X の元は写像 X → ℂ で、二元の等しさは写像としての等しさ（`funext`）である。
本文の各式変形は x ∈ X を固定した ℂ の中の等式の連なりなので、`funext x` の後の `calc` の一行を本文の一行に当てる。

必要十分版は `NecSuf/MathematicalToolkit/TensorProduct/ComplexValuedMaps.lean`、導出版は `TensorProductFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

namespace ComplexValuedMaps

variable {X : Type u}

/-- 本文 `def_complex_valued_maps_on_set`：(A +_{ℂ^X} B)(x) := A(x) +_ℂ B(x)。 -/
def add (A B : X → ℂ) : X → ℂ := fun x => A x + B x

/-- 本文 `def_complex_valued_maps_on_set`：(λ ·_{ℂ^X} A)(x) := λ ·_ℂ A(x)。 -/
def smul (l : ℂ) (A : X → ℂ) : X → ℂ := fun x => l * A x

/-- 本文 `def_complex_valued_maps_on_set`：0_{ℂ^X}(x) := 0_ℂ。 -/
def zero : X → ℂ := fun _ => 0

end ComplexValuedMaps

/-- 本文 `claim_complex_valued_maps_on_set_form_complex_vector_space`：(ℂ^X, +_{ℂ^X}, ·_{ℂ^X}, 0_{ℂ^X}) は ℂ-線型空間である。 -/
def complexValuedMapsVectorSpace (X : Type u) : ComplexVectorSpace (X → ℂ) where
  add := ComplexValuedMaps.add
  smul := ComplexValuedMaps.smul
  zero := ComplexValuedMaps.zero
  add_assoc A B C := funext fun x => calc
    ComplexValuedMaps.add (ComplexValuedMaps.add A B) C x
        = ComplexValuedMaps.add A B x + C x := rfl
    _ = (A x + B x) + C x := rfl
    _ = A x + (B x + C x) := by rw [_root_.add_assoc (A x) (B x) (C x)]
    _ = A x + ComplexValuedMaps.add B C x := rfl
    _ = ComplexValuedMaps.add A (ComplexValuedMaps.add B C) x := rfl
  add_comm A B := funext fun x => calc
    ComplexValuedMaps.add A B x = A x + B x := rfl
    _ = B x + A x := by rw [_root_.add_comm (A x) (B x)]
    _ = ComplexValuedMaps.add B A x := rfl
  add_zero A := funext fun x => calc
    ComplexValuedMaps.add A ComplexValuedMaps.zero x = A x + ComplexValuedMaps.zero x := rfl
    _ = A x + 0 := rfl
    _ = A x := by rw [_root_.add_zero (A x)]
  exists_add_inverse A := ⟨fun x => -A x, funext fun x => calc
    ComplexValuedMaps.add A (fun x => -A x) x = A x + (fun x => -A x) x := rfl
    _ = A x + (-A x) := rfl
    _ = 0 := by rw [add_neg_cancel (A x)]
    _ = ComplexValuedMaps.zero x := rfl⟩
  smul_assoc l μ A := funext fun x => calc
    ComplexValuedMaps.smul (l * μ) A x = (l * μ) * A x := rfl
    _ = l * (μ * A x) := by rw [mul_assoc l μ (A x)]
    _ = l * ComplexValuedMaps.smul μ A x := rfl
    _ = ComplexValuedMaps.smul l (ComplexValuedMaps.smul μ A) x := rfl
  one_smul A := funext fun x => calc
    ComplexValuedMaps.smul 1 A x = 1 * A x := rfl
    _ = A x := by rw [one_mul (A x)]
  smul_add l A B := funext fun x => calc
    ComplexValuedMaps.smul l (ComplexValuedMaps.add A B) x = l * ComplexValuedMaps.add A B x := rfl
    _ = l * (A x + B x) := rfl
    _ = l * A x + l * B x := by rw [mul_add l (A x) (B x)]
    _ = ComplexValuedMaps.smul l A x + ComplexValuedMaps.smul l B x := rfl
    _ = ComplexValuedMaps.add (ComplexValuedMaps.smul l A) (ComplexValuedMaps.smul l B) x := rfl
  add_smul l μ A := funext fun x => calc
    ComplexValuedMaps.smul (l + μ) A x = (l + μ) * A x := rfl
    _ = l * A x + μ * A x := by rw [add_mul l μ (A x)]
    _ = ComplexValuedMaps.smul l A x + ComplexValuedMaps.smul μ A x := rfl
    _ = ComplexValuedMaps.add (ComplexValuedMaps.smul l A) (ComplexValuedMaps.smul μ A) x := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
