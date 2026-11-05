/-
# 1 次元開鎖の二つのスピン和を必要十分版の系として導出する

具体版（人手と 1 対 1）: `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimOpenChainSpinSums.lean`。
必要十分版: `Ising2D/NecSuf/OpenChainSpinSum.lean`。

| 人手 | 具体版 | 必要十分版からの導出 | 特殊化 |
| --- | --- | --- | --- |
| `open_chain_endpoint_product_sum` の Step 2 の `M_col = 2`・`M_col ≥ 3` の鎖 | `prod_bondSpin_eq_first_mul_last` | `prod_bondSpin_eq_first_mul_last_of_necSuf` | `G = ℝ`、`x(m) = s(m)` |
| 同 Step 2 の `s(M_col)s(1)exp(KE(s))` の鎖 | `endpoint_mul_exp_openChainEnergy_eq_prod` | `endpoint_mul_exp_openChainEnergy_eq_prod_of_necSuf`（同じ 4 段。2 段目だけを上の導出に替える） | — |
| `open_chain_partition_sum` | `open_chain_partition_sum` | `open_chain_partition_sum_of_necSuf`（具体版と同じ行の順） | `R = ℝ`、`g(t) = exp(Kt)` |
| `open_chain_endpoint_product_sum` | `open_chain_endpoint_product_sum` | `open_chain_endpoint_product_sum_of_necSuf`（具体版と同じ行の順） | `R = ℝ`、`g(t) = t·exp(Kt)` |

導出した主張は具体版と同じ型である。二つの主張の導出は、具体版の鎖と同じ行の順に、重みに依らない行を必要十分版
（`人手 2`〜`人手 5` は `NecSuf.open_chain_weighted_sum_eq_sum_prod`、`{-1,1}` の上の和は `NecSuf.sum_spinVal_const`）で、
重みに固有の行（`open_chain_partition_sum` の `人手 1`・`人手 6`・`人手 7`・`人手 9`、`open_chain_endpoint_product_sum` の
`人手 1`・`人手 6`〜`人手 9`・`人手 11`）と冪の行を具体版と同じ根拠で置く。
-/
import Ising2D.NecSuf.OpenChainSpinSum

namespace Ising2D

open Finset

variable {M : ℕ}

/-- `prod_bondSpin_eq_first_mul_last` を `NecSuf.prod_mul_succ_eq_first_mul_last`（`G = ℝ`、`x(m) = s(m)`、
中間のサイトの `s(m)s(m) = 1` は `spinVal_mul_self`）から得る。 -/
theorem prod_bondSpin_eq_first_mul_last_of_necSuf {n : ℕ} (s : SpinConf (n + 2)) :
    ∏ m : Fin (n + 1), (bondSpin s m : ℝ) = (s 0 : ℝ) * (s (Fin.last (n + 1)) : ℝ) :=
  NecSuf.prod_mul_succ_eq_first_mul_last (fun k => (s k : ℝ)) (fun j => spinVal_mul_self (s j.succ.castSucc))

/-- `endpoint_mul_exp_openChainEnergy_eq_prod` を、2 段目の `Π_m t_m(s) = s(1)s(M_col)` を
`prod_bondSpin_eq_first_mul_last_of_necSuf` に替えて得る（ほかの段は具体版と同じ）。 -/
theorem endpoint_mul_exp_openChainEnergy_eq_prod_of_necSuf {n : ℕ} (K : ℝ) (s : SpinConf (n + 2)) :
    (s (Fin.last (n + 1)) : ℝ) * (s 0 : ℝ) * Real.exp (K * openChainEnergy s)
      = ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
  calc (s (Fin.last (n + 1)) : ℝ) * (s 0 : ℝ) * Real.exp (K * openChainEnergy s)
      = (s 0 : ℝ) * (s (Fin.last (n + 1)) : ℝ) * Real.exp (K * openChainEnergy s) := by
        rw [mul_comm (s (Fin.last (n + 1)) : ℝ)]        -- ℝ の乗法の可換性
    _ = (∏ m : Fin (n + 1), (bondSpin s m : ℝ)) * Real.exp (K * openChainEnergy s) := by
        rw [prod_bondSpin_eq_first_mul_last_of_necSuf]  -- 必要十分版から得た等式を右辺から左辺へ
    _ = (∏ m : Fin (n + 1), (bondSpin s m : ℝ)) * ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) := by
        rw [exp_openChainEnergy_eq_prod_bondSpin]       -- `exp(KE(s))` の鎖
    _ = ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
        (finite_product_of_real_products n _ _).symm   -- `finite_product_of_real_products` を右辺から左辺へ

/-- `open_chain_partition_sum` を、`NecSuf.open_chain_weighted_sum_eq_sum_prod`・`NecSuf.sum_spinVal_const`
（`R = ℝ`、`g(t) = exp(Kt)`）を具体版と同じ行の順に挟んで得る。 -/
theorem open_chain_partition_sum_of_necSuf (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, Real.exp (K * openChainEnergy s) = 2 * (2 * Real.cosh K) ^ (M - 1) := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 2 := ⟨M - 2, by omega⟩
  calc ∑ s : SpinConf (n + 2), Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), Real.exp (K * (bondSpin s m : ℝ)) :=
        Finset.sum_congr rfl fun s _ => exp_openChainEnergy_eq_prod_bondSpin K s
                                                        -- 人手 1: 準備の等式を各項へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp (K * 1) + Real.exp (K * (-1))) :=
        NecSuf.open_chain_weighted_sum_eq_sum_prod (fun t : SpinVal => Real.exp (K * (t : ℝ)))
                                                        -- 人手 2〜人手 5: 必要十分版の前半（`g(t) = exp(Kt)`）
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp K + Real.exp (K * (-1))) := by
        rw [mul_one]                                    -- 人手 6: ℝ で `a·1 = a` を各因子へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp K + Real.exp (-K)) := by
        rw [mul_neg_one]                                -- 人手 7: ℝ で `a·(-1) = -a` を各因子へ
    _ = 2 * ∏ _m : Fin (n + 1), (Real.exp K + Real.exp (-K)) :=
        NecSuf.sum_spinVal_const _                      -- 人手 8: `u` に依らない `c` の `{-1,1}` 上の和は `2c`（必要十分版）
    _ = 2 * ∏ _m : Fin (n + 1), (2 * Real.cosh K) := by
        rw [Real.cosh_eq, mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- 人手 9: `def_cosh_sinh`（`x → K`。具体版と同じく mathlib の `Real.cosh_eq`）
    _ = 2 * (2 * Real.cosh K) ^ (n + 2 - 1) := by
        rw [Fin.prod_const]; rfl                        -- 人手 10: `x^n := Π_{j=1}^{n} x`（`n + 2 - 1` は `n + 1` と同じ数）

/-- `open_chain_endpoint_product_sum` を、`endpoint_mul_exp_openChainEnergy_eq_prod_of_necSuf` と
`NecSuf.open_chain_weighted_sum_eq_sum_prod`・`NecSuf.sum_spinVal_const`（`R = ℝ`、`g(t) = t·exp(Kt)`）を
具体版と同じ行の順に挟んで得る。 -/
theorem open_chain_endpoint_product_sum_of_necSuf (hM : 2 ≤ M) (K : ℝ) :
    ∑ s : SpinConf M, (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = 2 * (2 * Real.sinh K) ^ (M - 1) := by
  obtain ⟨n, rfl⟩ : ∃ n, M = n + 2 := ⟨M - 2, by omega⟩
  calc ∑ s : SpinConf (n + 2), (s (lastSite (n + 2) (by omega)) : ℝ) * (s (firstSite (n + 2) (by omega)) : ℝ)
        * Real.exp (K * openChainEnergy s)
      = ∑ s : SpinConf (n + 2), ∏ m : Fin (n + 1), (bondSpin s m : ℝ) * Real.exp (K * (bondSpin s m : ℝ)) :=
        Finset.sum_congr rfl fun s _ => endpoint_mul_exp_openChainEnergy_eq_prod_of_necSuf K s
                                                        -- 人手 1: 直前の等式を各項へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), ((1 : ℝ) * Real.exp (K * 1) + (-1) * Real.exp (K * (-1))) :=
        NecSuf.open_chain_weighted_sum_eq_sum_prod (fun t : SpinVal => (t : ℝ) * Real.exp (K * (t : ℝ)))
                                                        -- 人手 2〜人手 5: 必要十分版の前半（`g(t) = t·exp(Kt)`）
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp (K * 1) + (-1) * Real.exp (K * (-1))) := by
        rw [one_mul]                                    -- 人手 6: ℝ で `1·b = b` を各因子へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp K + (-1) * Real.exp (K * (-1))) := by
        rw [mul_one]                                    -- 人手 7: ℝ で `a·1 = a` を各因子へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp K + (-1) * Real.exp (-K)) := by
        rw [mul_neg_one K]                              -- 人手 8: ℝ で `a·(-1) = -a` を各因子へ
    _ = ∑ _u : SpinVal, ∏ _m : Fin (n + 1), (Real.exp K - Real.exp (-K)) := by
        rw [neg_one_mul, ← sub_eq_add_neg]              -- 人手 9: ℝ で `a + (-1)b = a - b` を各因子へ
    _ = 2 * ∏ _m : Fin (n + 1), (Real.exp K - Real.exp (-K)) :=
        NecSuf.sum_spinVal_const _                      -- 人手 10: `u` に依らない `c` の `{-1,1}` 上の和は `2c`（必要十分版）
    _ = 2 * ∏ _m : Fin (n + 1), (2 * Real.sinh K) := by
        rw [Real.sinh_eq, mul_div_cancel₀ _ (two_ne_zero : (2 : ℝ) ≠ 0)]
                                                        -- 人手 11: `def_cosh_sinh`（`x → K`。具体版と同じく mathlib の `Real.sinh_eq`）
    _ = 2 * (2 * Real.sinh K) ^ (n + 2 - 1) := by
        rw [Fin.prod_const]; rfl                        -- 人手 12: `x^n := Π_{j=1}^{n} x`（`n + 2 - 1` は `n + 1` と同じ数）

end Ising2D
