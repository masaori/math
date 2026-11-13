/-
節「ℂ-線型空間」のうち ℂ に ℂ-線型空間の構造を与える組の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                  このファイル
  def_complex_numbers_as_complex_vector_space                   ComplexVec.add・ComplexVec.smul・ComplexVec.zero
  claim_complex_numbers_as_vector_space_is_complex_vector_space complexNumbersVectorSpace

ℂ の乗法 ·_ℂ とスカラー倍 ·_{ℂ^vec} は値の等しい写像だが、本文と同じく別の名前で書き、
行き来には三つの定義（`rfl` の行）だけを通す。

必要十分版は `NecSuf/MathematicalToolkit/ComplexVectorSpace/ComplexNumbersAsVectorSpace.lean`、導出版は `ComplexVectorSpaceFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

namespace ComplexVec

/-- 本文 `def_complex_numbers_as_complex_vector_space` の x +_{ℂ^vec} y := x +_ℂ y。 -/
def add (x y : ℂ) : ℂ := x + y

/-- 本文 `def_complex_numbers_as_complex_vector_space` の λ ·_{ℂ^vec} x := λ ·_ℂ x。 -/
def smul (l x : ℂ) : ℂ := l * x

/-- 本文 `def_complex_numbers_as_complex_vector_space` の 0_{ℂ^vec} := 0_ℂ。 -/
def zero : ℂ := 0

end ComplexVec

/-- 本文 `claim_complex_numbers_as_vector_space_is_complex_vector_space`。 -/
def complexNumbersVectorSpace : ComplexVectorSpace ℂ where
  add := ComplexVec.add
  smul := ComplexVec.smul
  zero := ComplexVec.zero
  add_assoc x y z := calc
    ComplexVec.add (ComplexVec.add x y) z = ComplexVec.add x y + z := rfl
    _ = (x + y) + z := rfl
    _ = x + (y + z) := by rw [_root_.add_assoc x y z]
    _ = x + ComplexVec.add y z := rfl
    _ = ComplexVec.add x (ComplexVec.add y z) := rfl
  add_comm x y := calc
    ComplexVec.add x y = x + y := rfl
    _ = y + x := by rw [_root_.add_comm x y]
    _ = ComplexVec.add y x := rfl
  add_zero x := calc
    ComplexVec.add x ComplexVec.zero = x + ComplexVec.zero := rfl
    _ = x + 0 := rfl
    _ = x := by rw [_root_.add_zero x]
  exists_add_inverse x := ⟨-x, calc
    ComplexVec.add x (-x) = x + (-x) := rfl
    _ = 0 := by rw [add_neg_cancel x]
    _ = ComplexVec.zero := rfl⟩
  smul_assoc l μ x := calc
    ComplexVec.smul (l * μ) x = (l * μ) * x := rfl
    _ = l * (μ * x) := by rw [mul_assoc l μ x]
    _ = l * ComplexVec.smul μ x := rfl
    _ = ComplexVec.smul l (ComplexVec.smul μ x) := rfl
  one_smul x := calc
    ComplexVec.smul 1 x = 1 * x := rfl
    _ = x := by rw [one_mul x]
  smul_add l x y := calc
    ComplexVec.smul l (ComplexVec.add x y) = l * ComplexVec.add x y := rfl
    _ = l * (x + y) := rfl
    _ = l * x + l * y := by rw [mul_add l x y]
    _ = ComplexVec.smul l x + ComplexVec.smul l y := rfl
    _ = ComplexVec.add (ComplexVec.smul l x) (ComplexVec.smul l y) := rfl
  add_smul l μ x := calc
    ComplexVec.smul (l + μ) x = (l + μ) * x := rfl
    _ = l * x + μ * x := by rw [add_mul l μ x]
    _ = ComplexVec.smul l x + ComplexVec.smul μ x := rfl
    _ = ComplexVec.add (ComplexVec.smul l x) (ComplexVec.smul μ x) := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
