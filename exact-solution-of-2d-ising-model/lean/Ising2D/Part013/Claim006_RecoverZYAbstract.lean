/-
# `check(Z), check(Y)` からの復元を**抽象版から導出**する

対応する人手証明のラベル: `recover_Z_Y_from_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_006_claim_recover_Z_Y`）

具体版（直接証明）は `Ising2D/Part013/Claim006_RecoverZY.lean`、
抽象版は `Ising2D/Abstract/AntiperiodicFourier.lean` の
`Ising2D.Abstract.inverse_dft_antiperiodic`。

特殊化の中身は `ξ := expPhase (2M) (-1) = e^{+iπ/M}`（1 の原始 `2M` 乗根）と、
`V := Mat(2,ℂ)^{⊗M}` を `ℂ`-加群として渡すことだけである。
**行列であること・積があること・Clifford 関係は使っていない。**
-/
import Ising2D.Part013.Claim006_RecoverZY
import Ising2D.Part013.Claim002_AntiperiodicExpSumAbstract

namespace Ising2D

variable {M : ℕ}

/-- **`inverse_dft_check` を `Abstract.inverse_dft_antiperiodic` の特殊化として導いたもの**。 -/
theorem inverse_dft_check_of_abstract (hM : M ≠ 0) (x : Fin M → TensorPow M) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j)
      = (M : ℂ) • x m := by
  have hξ : IsPrimitiveRoot (expPhase (2 * M) (-1)) (2 * M) :=
    isPrimitiveRoot_expPhase_neg_one (by omega)
  have h := Abstract.inverse_dft_antiperiodic (K := ℂ) (V := TensorPow M) hM hξ x m
  refine Eq.trans ?_ h
  refine Finset.sum_congr rfl fun μ _ => ?_
  have houter : checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1)
      = (expPhase (2 * M) (-1)) ^ ((((m : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1)) := by
    rw [checkPhase, ← expPhase_neg_eq_zpow_neg_one]
    congr 1
    ring
  rw [houter]
  congr 1
  refine Finset.sum_congr rfl fun j _ => ?_
  have hinner : checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1)
      = (expPhase (2 * M) (-1)) ^ (-((((j : ℕ) : ℤ) + 1) * (2 * ((μ : ℕ) : ℤ) + 1))) := by
    rw [checkPhase, ← expPhase_neg_eq_zpow_neg_one]
    congr 1
    ring
  rw [hinner]

/-- **原文第 1 式を抽象版の系として導いたもの**:
`∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ} = M Z_j`。 -/
theorem recover_checkZ_of_abstract (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkZ M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Z m := by
  simp_rw [checkZ]
  exact inverse_dft_check_of_abstract hM Z m

/-- **原文第 2 式を抽象版の系として導いたもの**:
`∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ} = M Y_j`。 -/
theorem recover_checkY_of_abstract (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkY M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Y m := by
  simp_rw [checkY]
  exact inverse_dft_check_of_abstract hM Y m

end Ising2D
