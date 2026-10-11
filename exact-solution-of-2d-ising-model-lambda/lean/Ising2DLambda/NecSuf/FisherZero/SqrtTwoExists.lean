/-
「二の平方根の存在」の必要十分版。

係数の加法則・不定元の冪の係数・定数の正次数係数と、正次数に非零係数を持つ
多項式の根の存在を使い、本文の係数の五段と評価の十二段を再現する。
評価には加法・乗法・不定元・定数の保存と、冪の一乗・後続則だけを使う。

値の加法には結合律と左右の零元を使う。対象の値 a に対して b + a = 0 となる
一つの b があればよく、全要素の加法逆元は不要である。乗法には演算だけを要求し、
結合律・可換律・分配律・除法は要求しない。係数の非零性には 1 ≠ 0 が必要である。
二という値・標数零・代数的数であることは、この証明手順には不要である。

住処: 値と多項式は任意の型であり、ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Group.Basic

namespace Ising2DLambda.NecSuf.FisherZero

universe u v

/-- 係数と評価の法則から、加法逆元を持つ値の平方根を構成する。 -/
theorem sqrt_two_exists_necSuf
    {Value : Type u} {Poly : Type v}
    [AddMonoid Value] [Mul Value] [One Value]
    [Add Poly] [Mul Poly] [Pow Poly ℕ]
    (constant : Value → Poly) (X : Poly)
    (coeff : Poly → ℕ → Value) (eval : Value → Poly → Value)
    (a b : Value) (hInverse : b + a = 0)
    (hCoeffAdd : ∀ p q n, coeff (p + q) n = coeff p n + coeff q n)
    (hCoeffPower : ∀ n, coeff (X ^ n) n = 1)
    (hCoeffConst : ∀ c n, n ≠ 0 → coeff (constant c) n = 0)
    (hOneNonzero : (1 : Value) ≠ 0)
    (hRootExists : ∀ p n, n ≠ 0 → coeff p n ≠ 0 → ∃ s, eval s p = 0)
    (hEvalX : ∀ s, eval s X = s)
    (hEvalMul : ∀ s p q, eval s (p * q) = eval s p * eval s q)
    (hPowOne : ∀ p : Poly, p ^ (1 : ℕ) = p)
    (hPowSucc : ∀ (p : Poly) (n : ℕ), p ^ (n + 1) = p ^ n * p)
    (hEvalConst : ∀ s c, eval s (constant c) = c)
    (hEvalAdd : ∀ s p q, eval s (p + q) = eval s p + eval s q) :
    ∃ s : Value, s * s = a := by
  let g : Poly := X ^ (2 : ℕ) + constant b
  have hCoeff : coeff g 2 = 1 := by
    calc
      coeff g 2 = coeff (X ^ (2 : ℕ) + constant b) 2 := rfl
      _ = coeff (X ^ (2 : ℕ)) 2 + coeff (constant b) 2 := hCoeffAdd _ _ _
      _ = 1 + coeff (constant b) 2 := by rw [hCoeffPower]
      _ = 1 + 0 := by rw [hCoeffConst b 2 (by decide)]
      _ = 1 := add_zero _
  have hCoeffNe : coeff g 2 ≠ 0 := by
    rw [hCoeff]
    exact hOneNonzero
  obtain ⟨s, hsRoot⟩ := hRootExists g 2 (by decide) hCoeffNe
  refine ⟨s, ?_⟩
  calc
    s * s = eval s X * eval s X := by rw [hEvalX]
    _ = eval s (X * X) := (hEvalMul s X X).symm
    _ = eval s (X ^ (1 : ℕ) * X) := by rw [hPowOne]
    _ = eval s (X ^ (2 : ℕ)) := by rw [hPowSucc X 1]
    _ = eval s (X ^ (2 : ℕ)) + 0 := (add_zero _).symm
    _ = eval s (X ^ (2 : ℕ)) + (b + a) := by rw [hInverse]
    _ = eval s (X ^ (2 : ℕ)) + (eval s (constant b) + a) := by rw [hEvalConst]
    _ = (eval s (X ^ (2 : ℕ)) + eval s (constant b)) + a := (add_assoc _ _ _).symm
    _ = eval s (X ^ (2 : ℕ) + constant b) + a := by rw [hEvalAdd]
    _ = eval s g + a := rfl
    _ = 0 + a := by rw [hsRoot]
    _ = a := zero_add _

end Ising2DLambda.NecSuf.FisherZero
