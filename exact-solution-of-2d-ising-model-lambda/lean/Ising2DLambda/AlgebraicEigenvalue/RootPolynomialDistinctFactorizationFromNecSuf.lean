/-
具体版が必要十分版の特殊化として得られることの導出。
値の型を Qbar[t]（積の可換モノイド）、根の型を Qbar、因子を t - x̂、
上界の述語を「その番号より上の係数が零」、先頭の係数の述語を「その番号の係数が 1」とし、
- hbase を f = t^n - 1 の係数の計算（`rootPolynomialCoeffBound`・`rootPolynomial_coeff_top`）、
- hroot を代数閉性（`rootPolynomialDistinctFactorizationRootExists`）、
- hfactor を因数定理の商の 3 条件（`rootPolynomialDistinctFactorizationQuotient`）、
- hmem を分解の評価（`rootPolynomialLinearFactorRootMem`）、
- hextract を因子の取り出し r3（`qbarPolyLinearFactorProductExtract`）、
- hmul を積の係数上界 r1（`qbarPolyProductCoeffBound`）、
- hdistinct を取り出した根との相異性 d4b2c3（`qbarPolyExtractedRootDistinct`）
で埋める。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialDistinctFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootPolynomialDistinctFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

theorem rootPolynomialDistinctFactorization_from_necSuf (n : ℕ) (hn : 1 ≤ n)
    (j : ℕ) (hj : j ≤ n) :
    ∃ (w : ℕ → Qbar) (g : QbarPoly),
      (∀ i : ℕ, i < j → w i ∈ RootOfUnity n) ∧
      (∀ i i' : ℕ, i < j → i' < j → i ≠ i' → w i ≠ w i') ∧
      rootPolynomial n
        = (∏ i ∈ Finset.range j, (Polynomial.X - qbarConst (w i))) * g ∧
      (∀ k : ℕ, n - j < k → g.coeff k = 0) ∧
      g.coeff (n - j) = 1 := by
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.root_polynomial_distinct_factorization_necSuf
    (fun x => Polynomial.X - qbarConst x)
    (rootPolynomial n) n hn
    (fun C m => ∀ k : ℕ, m < k → C.coeff k = 0)
    (fun C m => C.coeff m = 1)
    (fun x g => qbarPolyEval x g = 0)
    (fun x => x ∈ RootOfUnity n)
    ⟨rootPolynomialCoeffBound n, rootPolynomial_coeff_top n (by omega)⟩
    (fun g m hm hlead => rootPolynomialDistinctFactorizationRootExists g m hm hlead)
    (fun g x m hm hbound hlead hroot =>
      rootPolynomialDistinctFactorizationQuotient g x m hm hbound hlead hroot)
    (fun x C hf => rootPolynomialLinearFactorRootMem n x C hf)
    (fun a j i hi => qbarPolyLinearFactorProductExtract a j i hi)
    (fun B C p q hB hC => qbarPolyProductCoeffBound B C p q hB hC)
    (fun C p q hpq hC k hk => hC k (by omega))
    (fun x hx h B g hb hf hBg x' hx' =>
      qbarPolyExtractedRootDistinct n hn x hx h B g hb hf hBg x' hx')
    j hj

end Ising2DLambda.AlgebraicEigenvalue
