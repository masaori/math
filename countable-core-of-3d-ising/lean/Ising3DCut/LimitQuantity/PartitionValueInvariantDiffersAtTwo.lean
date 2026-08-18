/-
「ずらした自由族は有限箱の分配多項式値が極限量に必要でないことの反例である」の
Lean 具体版・先頭の段。

$q$ に依らない不変量 $\iota_L(P) = P(1)$ が $L = 2$ で二つの族の間で異なること：
$\iota_2(Z_2) = Z_2(1) = 2^8$、$\iota_2(Z'_2) = Z_3(1) = 2^{27}$、$2^8 \ne 2^{27}$。
既形式化の `partitionPolynomial_value_at_one`（$Z_L(1) = 2^{\#V_L}$）と
`card_site`（$\#V_L = L^3$）に帰着し、あとは整数の決定計算だけである。
ℝ への脱出は無い。
-/
import Ising3DCut.NullModel.PartitionValueAtOne
import Ising3DCut.LimitQuantity.SiteCountIndependentOfQ
import Ising3DCut.LimitQuantity.TailShiftLimit

namespace Ising3DCut.LimitQuantity

open Filter Topology

/-- 自由境界の `Z₂` の 1 での値は `2^8`。
`partitionPolynomial_value_at_one` と `card_site` の特殊化。 -/
lemma partitionPolynomial_two_eval_one :
    (NullModel.partitionPolynomial 2).eval 1 = (2 ^ 8 : ℤ) := by
  rw [NullModel.partitionPolynomial_value_at_one, card_site]
  norm_num

/-- ずらした自由族の `Z'₂ = Z₃` の 1 での値は `2^27`。
`partitionPolynomial_value_at_one` と `card_site` の特殊化。 -/
lemma partitionPolynomial_three_eval_one :
    (NullModel.partitionPolynomial 3).eval 1 = (2 ^ 27 : ℤ) := by
  rw [NullModel.partitionPolynomial_value_at_one, card_site]
  norm_num

/-- 不変量 $\iota_L(P) = P(1)$ は $L = 2$ で元の族とずらした自由族の間で異なる：
$Z_2(1) = 2^8 \ne 2^{27} = Z_3(1) = Z'_2(1)$。 -/
theorem partitionValue_invariant_differs_at_two :
    (NullModel.partitionPolynomial 2).eval 1 ≠
      (NullModel.partitionPolynomial 3).eval 1 := by
  rw [partitionPolynomial_two_eval_one, partitionPolynomial_three_eval_one]
  decide

/-- ずらした自由族の判定枠で、分配多項式の `1` での値は極限量を決めない。
`L = 2` で有限不変量は異なる一方、有限箱量の列は元の列の末尾と項ごとに一致し、
両列が極限を持てばその値は一致する。 -/
theorem partition_value_does_not_determine_limit_quantity
    (q : ℚ) (N : ℕ → ℕ) (α α' : ℝ)
    (h : Tendsto (rootSeq (finiteBoxValueSeq q) N) atTop (𝓝 α))
    (h' : Tendsto (shiftedFreeFiniteBoxQuantitySeq q N) atTop (𝓝 α')) :
    (NullModel.partitionPolynomial 2).eval 1 ≠
        (NullModel.partitionPolynomial 3).eval 1 ∧
      (∀ n, shiftedFreeFiniteBoxQuantitySeq q N n =
        rootSeq (finiteBoxValueSeq q) N (n + 1)) ∧
      α' = α := by
  refine ⟨partitionValue_invariant_differs_at_two,
    shiftedFreeFiniteBoxQuantitySeq_eq_tail q N, ?_⟩
  exact shiftedFreeFiniteBoxQuantitySeq_limit_eq q N α α' h h'

end Ising3DCut.LimitQuantity
