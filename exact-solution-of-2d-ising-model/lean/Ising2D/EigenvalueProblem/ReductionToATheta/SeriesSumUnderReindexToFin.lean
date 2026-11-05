/-
# `TensorPow M` の級数の和を、添字を `Fin (2^M)` へ付け替えて `evenOddSeriesSum` で読む

人手の項目を持たない補助のファイルである。人手 `exponential_series_of_even_odd_power_terms` の具体版
（`ClaimExponentialSeriesOfEvenOddPowerTerms.lean`）は行列の添字を `Fin d` に取り、級数の和を部分和
`Σ_{n=0}^{N}(1/n!)_ℂ T_n`（添字 `Fin (N + 1)`）の極限 `evenOddSeriesSum` で書く。一方 `TensorPow M` の行列は
添字が `Conf M` で、級数は mathlib の `HasSum`（係数 `(n! : ℂ)⁻¹`）で書かれている。

そこで添字を付け替える写像 `Φ := toFinPowAlgEquiv M : TensorPow M → Matrix (Fin (2^M)) (Fin (2^M)) ℂ`
（`Representation.lean`）に名前を付け、`HasSum` の和 `S` について `Φ(S)` が `Φ` で移した列の `evenOddSeriesSum` に
等しいことを述べる。使うのは、`Φ` が連続であること（`Continuous.matrix_reindex`）、和とスカラー倍を保つこと
（`map_sum`・`map_smul`）、部分和の添字 `Finset.range (N + 1)` と `Fin (N + 1)` の読み替え、係数 `(n! : ℂ)⁻¹` と
`(1/n!)_ℂ` の読み替え、極限の一意性（`Filter.Tendsto.limUnder_eq`）だけである。いずれも人手の行ではない。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExponentialSeriesOfEvenOddPowerTerms
import Ising2D.Representation

namespace Ising2D

open Nat Filter Topology

variable {M : ℕ}

attribute [local instance] Matrix.frobeniusNormedAddCommGroup Matrix.frobeniusNormSMulClass

/-- `Σ_n (n!)^{-1} T_n` が `S` に収束する（`HasSum`）とき、`Φ(S)` は `Φ` で移した列の級数の和
（部分和 `Σ_{n=0}^{N}(1/n!)_ℂΦ(T_n)` の極限 `evenOddSeriesSum`）に等しい。 -/
theorem toFinPow_eq_evenOddSeriesSum_of_hasSum {T : ℕ → TensorPow M} {S : TensorPow M}
    (h : HasSum (fun n => ((n ! : ℂ))⁻¹ • T n) S) :
    toFinPowAlgEquiv M S = evenOddSeriesSum (fun n => toFinPowAlgEquiv M (T n)) := by
  have hΦ : Continuous (toFinPowAlgEquiv M) := continuous_id.matrix_reindex _ _
  have h' : Tendsto (fun N => evenOddPartialSum (fun n => toFinPowAlgEquiv M (T n)) N) atTop
      (𝓝 (toFinPowAlgEquiv M S)) := by
    refine ((tendsto_add_atTop_iff_nat 1).2
      ((hΦ.tendsto _).comp h.tendsto_sum_nat)).congr fun N => ?_
    rw [Function.comp_apply, map_sum, evenOddPartialSum,
      ← Fin.sum_univ_eq_sum_range (fun n => toFinPowAlgEquiv M (((n.factorial : ℂ))⁻¹ • T n))]
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [map_smul, one_div, Complex.ofReal_inv, Complex.ofReal_natCast]
  exact h'.limUnder_eq.symm

end Ising2D
