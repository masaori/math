/-
# セクター上での置き換えと対称形の解消を必要十分版の特殊化として導く（形式化の記録）

対応する人手の主張は、本文から参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ
退避した `sector_replacement_pow` と `partition_function_sector_decomposition` の Step 3 である。

具体版は `ClaimSectorReplacementOfV1.lean` の `sector_replacement_pow` と
`ClaimPartitionFunctionSectorDecomposition.lean` の `trace_epsProj_sym_pow` の中の帰納法である。
ここでは同じ主張を、必要十分版 `NecSuf.pow_mul_proj`・`NecSuf.mul_pow_conj_left`
（`NecSuf/Projector.lean`）を `Mat(2^{M_col}, ℂ)` の転送行列へ特殊化して導く。
-/
import Ising2D.RoutesNotAdopted.MinusSector.ClaimPartitionFunctionSectorDecomposition
import Ising2D.NecSuf.Projector

namespace Ising2D

variable {M : ℕ}

/-- 具体版 `sector_replacement_pow` の必要十分版 `NecSuf.pow_mul_proj` からの導出。 -/
theorem sector_replacement_pow_of_necSuf {K1 K2 : ℝ} {η : ℂ} (hM : 2 ≤ M) (hK2 : 0 < K2)
    (hη : η * η = 1) (n : ℕ) :
    (V1 M K1 * V2 M K2) ^ n * epsProj M η
      = (V1pm M K1 (-η) * V2 M K2) ^ n * epsProj M η :=
  NecSuf.pow_mul_proj (epsProj_sq hη) (commute_V1_epsProj K1 η)
    (commute_V2_epsProj hK2 η) (commute_V1pm_epsProj K1 (-η) η)
    (sector_replacement_of_V1 hM hη) n

/-- `trace_epsProj_sym_pow` の中の対称形の解消 `B (BV_2B)^n = (BBV_2)^n B` の、
必要十分版 `NecSuf.mul_pow_conj_left` からの導出（`B = (V_1^{(±)})^{1/2}`）。 -/
theorem V1pmHalf_mul_sym_pow_of_necSuf (K1 K2 : ℝ) (ηsign : ℂ) (n : ℕ) :
    V1pmHalf M K1 ηsign * (V1pmHalf M K1 ηsign * V2 M K2 * V1pmHalf M K1 ηsign) ^ n
      = (V1pmHalf M K1 ηsign * V1pmHalf M K1 ηsign * V2 M K2) ^ n * V1pmHalf M K1 ηsign :=
  NecSuf.mul_pow_conj_left _ _ n

end Ising2D
