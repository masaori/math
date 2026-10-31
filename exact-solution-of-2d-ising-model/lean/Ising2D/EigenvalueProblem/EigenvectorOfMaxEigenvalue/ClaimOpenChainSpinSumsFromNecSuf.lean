/-
# 1 次元開鎖の二つのスピン和を必要十分版の系として導出する

具体版（人手と 1 対 1）: `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSums.lean`。
必要十分版: `Ising2D/NecSuf/OpenChainSpinSum.lean`。

| 人手 | 具体版 | 必要十分版からの導出 | 特殊化 |
| --- | --- | --- | --- |
| `open_chain_endpoint_product_sum` の Step 2 | `prod_openChainBondSpin` | `prod_openChainBondSpin_of_necSuf` | `G = ℝ`、`x(m) = s(m)` |
| `open_chain_partition_sum` | `open_chain_partition_sum` | `open_chain_partition_sum_of_necSuf` | `R = ℝ`、`g(t) = exp(Kt)` |
| `open_chain_endpoint_product_sum` | `open_chain_endpoint_product_sum` | `open_chain_endpoint_product_sum_of_necSuf` | `R = ℝ`、`g(t) = t·exp(Kt)` |

導出した主張は具体版と同じ型である。
-/
import Ising2D.NecSuf.OpenChainSpinSum

namespace Ising2D

open Finset

variable {M : ℕ}

/-- `prod_openChainBondSpin` を `NecSuf.prod_mul_nextSite_eq_first_mul_last`（`G = ℝ`、`x(m) = s(m)`）から得る。 -/
theorem prod_openChainBondSpin_of_necSuf (hM : 2 ≤ M) (s : SpinConf M) :
    ∏ b : OpenChainBond M, (openChainBondSpin s b : ℝ)
      = (s (firstSite M (by omega)) : ℝ) * (s (lastSite M (by omega)) : ℝ) := by
  rw [← NecSuf.prod_mul_nextSite_eq_first_mul_last hM (fun m => (s m : ℝ))
    (fun m _ _ => spinVal_mul_self (s m)),
    Finset.prod_subtype (p := fun m : Fin M => (m : ℕ) + 1 ≠ M) _ (fun m => by simp)]
  rfl

/-- `open_chain_partition_sum` を `NecSuf.open_chain_weighted_sum`（`R = ℝ`、`g(t) = exp(Kt)`）から得る。 -/
theorem open_chain_partition_sum_of_necSuf (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, Real.exp (K * openChainEnergy s) = 2 * (2 * Real.cosh K) ^ (M - 1) := by
  have hM0 : M ≠ 0 := by omega
  rw [Finset.sum_congr rfl fun s _ => exp_openChainEnergy K s,
    NecSuf.open_chain_weighted_sum hM0 (fun t : SpinVal => Real.exp (K * (t : ℝ))), Real.cosh_eq]
  congr 2
  simp only [mul_one, mul_neg]
  ring

/-- `open_chain_endpoint_product_sum` を `NecSuf.open_chain_weighted_sum`（`R = ℝ`、`g(t) = t·exp(Kt)`）と
`prod_openChainBondSpin_of_necSuf` から得る。 -/
theorem open_chain_endpoint_product_sum_of_necSuf (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = 2 * (2 * Real.sinh K) ^ (M - 1) := by
  have hM0 : M ≠ 0 := by omega
  have h : ∀ s : SpinConf M,
      (s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ) * Real.exp (K * openChainEnergy s)
        = ∏ b : OpenChainBond M, (openChainBondSpin s b : ℝ)
            * Real.exp (K * (openChainBondSpin s b : ℝ)) := fun s => by
    rw [Finset.prod_mul_distrib, prod_openChainBondSpin_of_necSuf hM s, exp_openChainEnergy K s,
      mul_comm (s (lastSite M _) : ℝ)]
  rw [Finset.sum_congr rfl fun s _ => h s,
    NecSuf.open_chain_weighted_sum hM0 (fun t : SpinVal => (t : ℝ) * Real.exp (K * (t : ℝ))),
    Real.sinh_eq]
  congr 2
  simp only [one_mul, mul_one, mul_neg, neg_mul]
  ring

end Ising2D
