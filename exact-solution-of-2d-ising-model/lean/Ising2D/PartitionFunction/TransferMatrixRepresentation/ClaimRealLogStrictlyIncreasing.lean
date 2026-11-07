/-
# 正の実数上の実対数は狭義単調増加（具体版）

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `transfer_matrix_claim_real_log_strictly_increasing`（ラベル **`real_log_strictly_increasing`**）

原文の主張: `u, v ∈ ℝ_{>0}`、`u < v` なら `log u < log v`。

| 人手の段 | Lean |
| --- | --- |
| `log u < log v` でないと仮定し、ℝ の順序の三分律で `log v < log u` か `log v = log u` に分ける | `by_contra` と、`¬(log u < log v)` から `log v ≤ log u` を `log v < log u` か `log v = log u` に分ける `lt_or_eq_of_le` |
| `log v < log u` の場合: `v = exp(log v) < exp(log u) = u`。`u < v` と両立しない（非対称性） | 3 段の `calc` と `lt_asymm` |
| `log v = log u` の場合: `v = exp(log v) = exp(log u) = u`。`u < v` と両立しない（非反射性） | 3 段の `calc` と `lt_irrefl` |

人手の `log` は `def_real_logarithm_positive`（`exp : ℝ → ℝ_{>0}` の逆写像）で、Lean はこれを mathlib の `Real.log` で表す
（`def_real_logarithm_positive` の Lean の具体版は無い）。その定義の `exp(log y) = y`（`y > 0`）は mathlib の `Real.exp_log`、
人手が引く `real_exp_strictly_increasing` は mathlib の `Real.exp_lt_exp`（Lean の具体版は無い）で表す。

必要十分版は `Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_strictMono`、
具体版をその系として導くのは `ClaimRealLogStrictlyIncreasingFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace Ising2D

/-- **人手 `real_log_strictly_increasing`**: `u, v ∈ ℝ_{>0}`、`u < v` なら `log u < log v`。 -/
theorem real_log_strictly_increasing {u v : ℝ} (hu : 0 < u) (hv : 0 < v) (huv : u < v) :
    Real.log u < Real.log v := by
  by_contra hne                         -- `log u < log v` でないと仮定する
  rcases lt_or_eq_of_le (not_lt.1 hne) with h | h
                                        -- ℝ の順序の三分律: `log v < log u` または `log v = log u`
  · -- `log v < log u` の場合
    have hvu : v < u :=
      calc v = Real.exp (Real.log v) := (Real.exp_log hv).symm
                                        -- `def_real_logarithm_positive` の `exp(log y) = y`
        _ < Real.exp (Real.log u) := Real.exp_lt_exp.2 h
                                        -- `log v < log u` と `real_exp_strictly_increasing`
        _ = u := Real.exp_log hu
                                        -- `def_real_logarithm_positive` の `exp(log y) = y`
    exact lt_asymm huv hvu
                                        -- `u < v` と両立しない（ℝ の順序の非対称性）
  · -- `log v = log u` の場合
    have hvu : v = u :=
      calc v = Real.exp (Real.log v) := (Real.exp_log hv).symm
                                        -- `def_real_logarithm_positive` の `exp(log y) = y`
        _ = Real.exp (Real.log u) := by rw [h]
                                        -- `log v = log u`
        _ = u := Real.exp_log hu
                                        -- `def_real_logarithm_positive` の `exp(log y) = y`
    exact lt_irrefl u (hvu ▸ huv)
                                        -- `u < v` と両立しない（ℝ の順序の非反射性）

end Ising2D
