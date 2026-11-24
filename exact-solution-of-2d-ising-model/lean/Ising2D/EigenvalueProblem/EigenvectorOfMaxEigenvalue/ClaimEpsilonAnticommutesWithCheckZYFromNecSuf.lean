/-
# `ε` は `Ž, Y̌, ψ̌` と反可換（必要十分版からの導出）

具体版 `ClaimEpsilonAnticommutesWithCheckZY.lean` の (2) `epsilon_anticomm_checkZ`・`epsilon_anticomm_checkY` を
必要十分版 `Ising2D/NecSuf/ParityFermion.lean` の `NecSuf.anticomm_sum_smul` の特殊化として、
(3) `epsilon_anticomm_checkPsiDag`・`epsilon_anticomm_checkPsi` を `NecSuf.anticomm_add_smul` の特殊化として得る。
人手のラベルは `epsilon_anticommutes_with_check_Z_Y`。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimEpsilonAnticommutesWithCheckZY
import Ising2D.NecSuf.ParityFermion

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 人手 (2) が必要十分版 `Ising2D.NecSuf.anticomm_sum_smul` の特殊化として得られること
（`Ž_μ` は `Z_j` の ℂ 係数有限和である）。 -/
theorem epsilon_anticomm_checkZ_of_necSuf (M : ℕ) (μ : ℤ) :
    epsilon M * checkZ M μ = -(checkZ M μ * epsilon M) := by
  rw [checkZ]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Z j) Finset.univ _

/-- 人手 (2) の `Y̌_μ` の側が必要十分版の特殊化として得られること。 -/
theorem epsilon_anticomm_checkY_of_necSuf (M : ℕ) (μ : ℤ) :
    epsilon M * checkY M μ = -(checkY M μ * epsilon M) := by
  rw [checkY]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Y j) Finset.univ _

/-- 人手 (3) の `ψ̌_μ^†` の側が必要十分版 `Ising2D.NecSuf.anticomm_add_smul` の特殊化として得られること。 -/
theorem epsilon_anticomm_checkPsiDag_of_necSuf (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsiDag K M μ = -(checkPsiDag K M μ * epsilon M) :=
  NecSuf.anticomm_add_smul (𝕜 := ℂ) (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ) _ _

/-- 人手 (3) の `ψ̌_μ` の側が必要十分版の特殊化として得られること。 -/
theorem epsilon_anticomm_checkPsi_of_necSuf (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsi K M μ = -(checkPsi K M μ * epsilon M) :=
  NecSuf.anticomm_add_smul (𝕜 := ℂ) (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ) _ _

end Ising2D
