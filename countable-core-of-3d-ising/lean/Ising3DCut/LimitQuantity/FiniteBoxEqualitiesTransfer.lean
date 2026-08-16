/-
「有限箱の等式の族は極限量の等式へ渡る」の Lean 具体版・可算側の段。

仮定は各 $L\ge1$ での正の有理数の等式 $Z_L(q)=Z_L(q')$ だけである。素指数データ $\lambda$ は
正の有理数の上の写像なので、等式から各素数 $p$ について $p$ 進付値が一致し、列 $S_q$ と $S_{q'}$ の
第二成分が一致する（第一成分 $\#V_L$ は $q$ に依らない）。ここまでが可算側で、以降の極限の段は
「極限量が有限箱の列だけの関数であること」の束ね（`limitQuantity_tendsto_of_pointwise_eq`）へ帰着する。
-/
import Ising3DCut.LimitQuantity.PartitionValuesAgreeFromSequence

namespace Ising3DCut.LimitQuantity

open NullModel

/-- 各 `L ≥ 1` で `Z_L(q) = Z_L(q')` なら、各 `L ≥ 1`・各素数 `p` で `p` 進付値が一致する
（素指数データは値の上の写像であるから）。 -/
theorem prime_exponent_sequence_eq_of_partitionPolynomial_evalAtRational_eq
    {q q' : ℚ}
    (h : ∀ L : ℕ, 0 < L →
      evalAtRational q (partitionPolynomial L) = evalAtRational q' (partitionPolynomial L)) :
    ∀ L : ℕ, 0 < L → ∀ p : ℕ, p.Prime →
      padicValRat p (evalAtRational q (partitionPolynomial L)) =
        padicValRat p (evalAtRational q' (partitionPolynomial L)) := by
  intro L hL p _
  rw [h L hL]

end Ising3DCut.LimitQuantity
