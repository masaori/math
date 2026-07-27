/-
# `check(Z), check(Y)` の反交換関係を**抽象版から導出**する

対応する人手証明のラベル: `anticommutator_of_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_005_claim_anticommutator_check_Z_Y`）

具体版（直接証明）は `Ising2D/Part013/Claim005_AnticommutatorCheckZY.lean`、
抽象版は `Ising2D/Abstract/AntiperiodicFourier.lean` の
`Ising2D.Abstract.acomm_antiperiodic_fourier_clifford`
（それ自体が既存の `Abstract.acomm_fourier_clifford_weights` の特殊化）。

特殊化の中身は `ξ := expPhase (2M) 1 = e^{-iπ/M}`（1 の原始 `2M` 乗根）と、
`x = y = Z`（あるいは `Y`）に Clifford 関係 `[Z_j, Z_k]₊ = 2δ_{jk} I` を渡すことだけである。
-/
import Ising2D.Part013.Claim005_AnticommutatorCheckZY
import Ising2D.Part013.Claim002_AntiperiodicExpSumAbstract

namespace Ising2D

variable {M : ℕ}

/-- `check(Z)_μ` を抽象版の形（1 の原始 `2M` 乗根の**奇数**周波数の和）に書き直す。 -/
theorem checkZ_eq_zpow_sum (_hM : M ≠ 0) (ρ : ℤ) :
    checkZ M ρ
      = ∑ j : Fin M, (expPhase (2 * M) 1) ^ ((((j : ℕ) : ℤ) + 1) * (2 * ρ - 1)) • Z j := by
  rw [checkZ]
  exact Finset.sum_congr rfl fun j _ => by rw [checkPhase, expPhase_eq_zpow_one]

/-- `check(Y)_μ` を抽象版の形に書き直す。 -/
theorem checkY_eq_zpow_sum (_hM : M ≠ 0) (ρ : ℤ) :
    checkY M ρ
      = ∑ j : Fin M, (expPhase (2 * M) 1) ^ ((((j : ℕ) : ℤ) + 1) * (2 * ρ - 1)) • Y j := by
  rw [checkY]
  exact Finset.sum_congr rfl fun j _ => by rw [checkPhase, expPhase_eq_zpow_one]

/-- **原文第 1 式を抽象版の系として導いたもの**:
`[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkZ_checkZ_of_abstract (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  have hξ : IsPrimitiveRoot (expPhase (2 * M) 1) (2 * M) :=
    isPrimitiveRoot_expPhase_one (by omega)
  rw [checkZ_eq_zpow_sum hM μ, checkZ_eq_zpow_sum hM ν,
    Abstract.acomm_antiperiodic_fourier_clifford (K := ℂ) hM hξ Z Z acomm_Z_Z_clifford μ ν,
    deltaMod]

/-- **原文第 3 式を抽象版の系として導いたもの**:
`[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkY_checkY_of_abstract (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  have hξ : IsPrimitiveRoot (expPhase (2 * M) 1) (2 * M) :=
    isPrimitiveRoot_expPhase_one (by omega)
  rw [checkY_eq_zpow_sum hM μ, checkY_eq_zpow_sum hM ν,
    Abstract.acomm_antiperiodic_fourier_clifford (K := ℂ) hM hξ Y Y acomm_Y_Y_clifford μ ν,
    deltaMod]

end Ising2D
