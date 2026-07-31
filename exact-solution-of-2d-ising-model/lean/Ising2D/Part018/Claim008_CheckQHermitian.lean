/-
# `ň_μ, Q̌_ε` はエルミート（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_008_claim_check_Q_is_hermitian`、
ラベル **`check_number_operator_is_hermitian`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）の
`Ising2D.NecSuf.star_projOn`。(4) 後半はその**系**である
（`Ising2D.CheckFermi.Qproj_conjTranspose`、`Part018/Setup.lean`）。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `Z_j^* = Z_j`, `Y_j^* = Y_j` | `Ising2D.Z_conjTranspose` / `Y_conjTranspose`（章 009 で証明済み） |
| (2) `Ž_μ^* = Ž_{M+1-μ}`, `Y̌_μ^* = Y̌_{M+1-μ}` | `Ising2D.checkZ_conjTranspose` / `checkY_conjTranspose` |
| (3) `(ψ̌_μ^†)^* = ψ̌_{M+1-μ}` | `CheckFermi.hstar`（章 016 からの入力） |
| (4) `ň_μ^* = ň_μ`, `Q̌_ε^* = Q̌_ε` | `CheckFermi.nOp_conjTranspose` / `Qproj_conjTranspose` |
| `x^* Q̌_ε x = ‖Q̌_ε x‖² ≥ 0` | `Ising2D.EvenSectorBridge.quad_Qproj`（`Theorem009_...` にある） |

**(1)(2) は無条件である。**
-/
import Ising2D.Part018.Setup
import Ising2D.Part013.Claim003b_ConjugateIndex

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 位相因子の複素共役: `conj(e^{-2πik/M}) = e^{2πik/M}`。 -/
theorem expPhase_conj (M : ℕ) (k : ℤ) :
    (starRingEnd ℂ) (expPhase M k) = expPhase M (-k) := by
  rw [expPhase, expPhase, ← Complex.exp_conj]
  congr 1
  simp only [map_div₀, map_neg, map_mul, map_ofNat, Complex.conj_I, Complex.conj_ofReal,
    map_intCast, map_natCast, Int.cast_neg]
  ring

theorem checkPhase_conj_star (hM : M ≠ 0) (k μ : ℤ) :
    (starRingEnd ℂ) (checkPhase M k μ) = checkPhase M k ((M : ℤ) + 1 - μ) := by
  rw [checkPhase, expPhase_conj, checkPhase_conj hM]

/-- **人手証明 (2)**: `Ž_μ^* = Ž_{M+1-μ}`。 -/
theorem checkZ_conjTranspose (hM : M ≠ 0) (μ : ℤ) :
    (checkZ M μ)ᴴ = checkZ M ((M : ℤ) + 1 - μ) := by
  rw [checkZ, checkZ, Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.conjTranspose_smul, Z_conjTranspose, Complex.star_def, checkPhase_conj_star hM]

/-- **人手証明 (2)**: `Y̌_μ^* = Y̌_{M+1-μ}`。 -/
theorem checkY_conjTranspose (hM : M ≠ 0) (μ : ℤ) :
    (checkY M μ)ᴴ = checkY M ((M : ℤ) + 1 - μ) := by
  rw [checkY, checkY, Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.conjTranspose_smul, Y_conjTranspose, Complex.star_def, checkPhase_conj_star hM]

end Ising2D
