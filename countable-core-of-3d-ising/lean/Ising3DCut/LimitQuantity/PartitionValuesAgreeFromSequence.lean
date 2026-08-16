/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の後半（可算側の段）。

列 $S_q=(L\mapsto(\#V_L,\lambda(Z_L(q))))$ と $S_{q'}$ が写像として一致すれば、各 $L\ge1$ で
素指数データ $\lambda(Z_L(q))=\lambda(Z_L(q'))$ である。$Z_L(q)>0$・$Z_L(q')>0$（第三歩の前半）
なので第二歩を当てて $Z_L(q)=Z_L(q')$ を得る。ここでは列の第二成分の一致（すべての素数 $p$ で
`padicValRat p (Z_L q) = padicValRat p (Z_L q')`）を仮定として受け取り、全 $L\ge1$ での値の一致を返す。
第一成分 $\#V_L$ は $q$ に依らないので、その一致は仮定に含める必要がない。
-/
import Ising3DCut.LimitQuantity.PrimeExponentDataDeterminesRat
import Ising3DCut.LimitQuantity.PartitionValuePositive

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 正の有理数 `q q'` について、各 `L ≥ 1` と各素数 `p` で `Z_L(q)` と `Z_L(q')` の `p` 進付値が
一致すれば、各 `L ≥ 1` で `Z_L(q) = Z_L(q')`。 -/
theorem partitionPolynomial_evalAtRational_eq_of_prime_exponent_sequence_eq
    {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q')
    (h : ∀ L : ℕ, 0 < L → ∀ p : ℕ, p.Prime →
      padicValRat p (evalAtRational q (partitionPolynomial L)) =
        padicValRat p (evalAtRational q' (partitionPolynomial L))) :
    ∀ L : ℕ, 0 < L →
      evalAtRational q (partitionPolynomial L) = evalAtRational q' (partitionPolynomial L) := by
  intro L hL
  exact rat_eq_of_prime_exponents_eq
    (partitionPolynomial_evalAtRational_pos hL hq)
    (partitionPolynomial_evalAtRational_pos hL hq')
    (h L hL)

end Ising3DCut.LimitQuantity
