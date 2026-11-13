/-
節「ℂ-線型空間」のうち ℂ に ℂ-線型空間の構造を与える組の必要十分版。具体版
`MathematicalToolkit/ComplexVectorSpace/ComplexNumbersAsVectorSpace.lean` と同じ行で書く。
係数 K を自分自身の上の線型空間にする。

実際に使う K の性質: 加法の結合法則・交換法則、a + 0 = a、加法の逆元の存在、乗法の結合法則、
1 · a = a、左右の分配法則。乗法の交換法則・a · 1 = a は使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u

variable {K : Type u} [Add K] [Mul K] [One K]

namespace CoefficientsVec

/-- 本文 `def_complex_numbers_as_complex_vector_space` の x +_{ℂ^vec} y := x +_ℂ y。 -/
def add (x y : K) : K := x + y

/-- 本文 `def_complex_numbers_as_complex_vector_space` の λ ·_{ℂ^vec} x := λ ·_ℂ x。 -/
def smul (l x : K) : K := l * x

/-- 本文 `def_complex_numbers_as_complex_vector_space` の 0_{ℂ^vec} := 0_ℂ。 -/
def zero [Zero K] : K := 0

end CoefficientsVec

/-- 本文 `claim_complex_numbers_as_vector_space_is_complex_vector_space`。 -/
def coefficientsVectorSpace [Zero K]
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c)) (hcomm : ∀ a b : K, a + b = b + a)
    (hadd_zero : ∀ a : K, a + 0 = a) (hneg : ∀ a : K, ∃ a' : K, a + a' = 0)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c)) (hone_mul : ∀ a : K, 1 * a = a)
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    (hrdistrib : ∀ a b c : K, (a + b) * c = a * c + b * c) : VectorSpace K K where
  add := CoefficientsVec.add
  smul := CoefficientsVec.smul
  zero := CoefficientsVec.zero
  add_assoc x y z := calc
    CoefficientsVec.add (CoefficientsVec.add x y) z = CoefficientsVec.add x y + z := rfl
    _ = (x + y) + z := rfl
    _ = x + (y + z) := by rw [hassoc x y z]
    _ = x + CoefficientsVec.add y z := rfl
    _ = CoefficientsVec.add x (CoefficientsVec.add y z) := rfl
  add_comm x y := calc
    CoefficientsVec.add x y = x + y := rfl
    _ = y + x := by rw [hcomm x y]
    _ = CoefficientsVec.add y x := rfl
  add_zero x := calc
    CoefficientsVec.add x CoefficientsVec.zero = x + CoefficientsVec.zero := rfl
    _ = x + 0 := rfl
    _ = x := by rw [hadd_zero x]
  exists_add_inverse x := by
    obtain ⟨x', hx'⟩ := hneg x
    exact ⟨x', calc
      CoefficientsVec.add x x' = x + x' := rfl
      _ = 0 := by rw [hx']
      _ = CoefficientsVec.zero := rfl⟩
  smul_assoc l μ x := calc
    CoefficientsVec.smul (l * μ) x = (l * μ) * x := rfl
    _ = l * (μ * x) := by rw [hmassoc l μ x]
    _ = l * CoefficientsVec.smul μ x := rfl
    _ = CoefficientsVec.smul l (CoefficientsVec.smul μ x) := rfl
  one_smul x := calc
    CoefficientsVec.smul 1 x = 1 * x := rfl
    _ = x := by rw [hone_mul x]
  smul_add l x y := calc
    CoefficientsVec.smul l (CoefficientsVec.add x y) = l * CoefficientsVec.add x y := rfl
    _ = l * (x + y) := rfl
    _ = l * x + l * y := by rw [hldistrib l x y]
    _ = CoefficientsVec.smul l x + CoefficientsVec.smul l y := rfl
    _ = CoefficientsVec.add (CoefficientsVec.smul l x) (CoefficientsVec.smul l y) := rfl
  add_smul l μ x := calc
    CoefficientsVec.smul (l + μ) x = (l + μ) * x := rfl
    _ = l * x + μ * x := by rw [hrdistrib l μ x]
    _ = CoefficientsVec.smul l x + CoefficientsVec.smul μ x := rfl
    _ = CoefficientsVec.add (CoefficientsVec.smul l x) (CoefficientsVec.smul μ x) := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
