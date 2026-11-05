/-
# 偶数番目と奇数番目が数の冪のスカラー倍である行列の列の指数級数: ノルムの評価と `ε` の鎖（具体版を必要十分版から導く）

具体版 `ClaimExponentialSeriesOfEvenOddPowerTerms.lean`（人手 `exponential_series_of_even_odd_power_terms`）の
`evenOddPartialSum_sub_limit_norm_le`・`evenOddPartialSum_sub_limit_norm_tendsto` を、必要十分版
`Ising2D/NecSuf/EvenOddSeriesNormEstimate.lean` の、元の集合 `Matrix (Fin d) (Fin d) ℂ` と Frobenius ノルム
（`def_matrix_norm` の行列ノルムと値が一致する）、係数の集合 ℂ、`ι := ι_{ℝ→ℂ}`（`inclusion_rr_to_cc`）の特殊化として得る。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExponentialSeriesOfEvenOddPowerTerms
import Ising2D.NecSuf.EvenOddSeriesNormEstimate

namespace Ising2D

open Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup Matrix.frobeniusNormSMulClass

variable {d : ℕ}

/-- `evenOddPartialSum_sub_limit_norm_le` を `NecSuf.evenOdd_norm_le'`（`hD` は差の中間目標 `evenOddPartialSum_sub_limit`、
`|a| ≤ w`・`|b| ≤ w` は実数の評価の中間目標）の特殊化として得る。 -/
theorem evenOddPartialSum_sub_limit_norm_le_of_necSuf (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B) (N : ℕ) :
    ‖evenOddPartialSum T N - evenOddLimit A B x c‖
      ≤ (evenOddErrPlus x N + evenOddErrMinus x N) / 2 * evenOddKappa A B c :=
  NecSuf.evenOdd_norm_le' (fun r : ℝ => (r : ℂ)) (fun y z => norm_add_le y z) (fun k y => norm_smul k y)
    (fun k l => norm_mul k l) (fun r => by rw [Complex.norm_real, Real.norm_eq_abs])
    A B _ c (norm_nonneg _) (norm_nonneg _) (norm_nonneg _) _ _ _ _
    (evenOddPartialSum_sub_limit A B x c T hTe hTo N)
    (evenOddAlpha_sub_cosh_abs_le x N) (evenOddBeta_sub_sinh_abs_le x N) rfl

/-- `evenOddPartialSum_sub_limit_norm_tendsto` を `NecSuf.evenOdd_err_tendsto'`（`hle` はノルムの評価、`hsmall` は
`evenOddErr_eventually_lt`）の特殊化として得る。 -/
theorem evenOddPartialSum_sub_limit_norm_tendsto_of_necSuf (A B : Matrix (Fin d) (Fin d) ℂ) (x : ℝ) (c : ℂ)
    (T : ℕ → Matrix (Fin d) (Fin d) ℂ)
    (hTe : ∀ n, Even n → T n = (x : ℂ) ^ n • A) (hTo : ∀ n, Odd n → T n = (c * (x : ℂ) ^ n) • B) :
    Tendsto (fun N => ‖evenOddPartialSum T N - evenOddLimit A B x c‖) atTop (𝓝 0) :=
  NecSuf.evenOdd_err_tendsto' _ (evenOddErrPlus x) (evenOddErrMinus x) (evenOddKappa A B c)
    (by rw [evenOddKappa]; positivity) (fun _ => norm_nonneg _)
    (evenOddPartialSum_sub_limit_norm_le_of_necSuf A B x c T hTe hTo)
    (fun _ hδ => evenOddErr_eventually_lt x hδ)

end Ising2D
