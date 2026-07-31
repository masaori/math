/-
# `check(Z), check(Y)` から `Z_j, Y_j` を復元する（**具体版**）

対応する人手証明のラベル: `recover_Z_Y_from_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_006_claim_recover_Z_Y`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean` の
`Ising2D.NecSuf.inverse_dft_antiperiodic`（同じラベル）。
必要十分版からの導出は `Ising2D/Part013/Claim006_RecoverZYFromNecSuf.lean`。

## 原文の主張（`j ∈ {1,…,M}`）

  `Z_j = (1/M) ∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ}`,
  `Y_j = (1/M) ∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ}`

とくに `check(Z)_1,…,check(Z)_M, check(Y)_1,…,check(Y)_M` は `Mat(2^M, ℂ)` を
単位的 `ℂ` 代数として生成する。

## 形式化の方針

整数運動量版（`Part004/Claim013_RecoverZY.lean`）と同じく、まず族 `x : Fin M → TensorPow M`
に対する一般形（`inverse_dft_check`）を証明し、それを `Z`, `Y` に適用する。
違いは直交性として `Ising2D.sum_checkPhase`（反周期的指数和）を使う点だけである。
-/
import Ising2D.Part013.Claim003b_ConjugateIndex
import Ising2D.Part004.Claim014_ZYGenerateAlgebra

namespace Ising2D

variable {M : ℕ}

/-- **反周期的離散フーリエ逆変換（原文の計算の骨格）**。

族 `x : Fin M → Mat(2,ℂ)^{⊗M}` の変換 `check(x)_μ = ∑_j x_j e^{-i j θ~_μ}` に対し

  `∑_{μ=1}^{M} check(x)_μ e^{i m θ~_μ} = M x_m`。 -/
theorem inverse_dft_check (hM : M ≠ 0) (x : Fin M → TensorPow M) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j)
      = (M : ℂ) • x m := by
  -- Step 0: 指数法則で位相をまとめる
  have step1 : ∀ μ : Fin M,
      checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
          (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) • x j)
        = ∑ j : Fin M,
            checkPhase M (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) (((μ : ℕ) : ℤ) + 1) • x j := by
    intro μ
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [smul_smul]
    congr 1
    rw [checkPhase, checkPhase, checkPhase, ← expPhase_add]
    congr 1
    ring
  simp_rw [step1]
  -- Step 1: 有限二重和の順序交換
  rw [Finset.sum_comm]
  -- Step 2: `μ` についての反周期的直交性
  have step2 : ∀ j : Fin M,
      (∑ μ : Fin M, checkPhase M (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) (((μ : ℕ) : ℤ) + 1) • x j)
        = (expPhase (2 * M) (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) *
            ((M : ℂ) * deltaMod M (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) 0)) • x j := by
    intro j
    rw [← Finset.sum_smul, sum_checkPhase hM]
  simp_rw [step2]
  -- Step 3: `|j - m| < M` なので `j = m` の項だけ残る
  rw [Finset.sum_eq_single_of_mem m (Finset.mem_univ m)]
  · rw [sub_self, deltaMod, sub_zero, if_pos (dvd_zero _), mul_one, expPhase_zero, one_mul]
  · intro j _ hj
    rw [deltaMod, sub_zero, if_neg (fun h => hj ((dvd_sub_iff_eq j m).1 h)), mul_zero,
      mul_zero, zero_smul]

/-- **原文第 1 式（分母を払った形）**: `∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ} = M Z_j`。 -/
theorem recover_checkZ (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkZ M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Z m := by
  simp_rw [checkZ]
  exact inverse_dft_check hM Z m

/-- **原文第 2 式（分母を払った形）**: `∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ} = M Y_j`。 -/
theorem recover_checkY (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) •
        checkY M (((μ : ℕ) : ℤ) + 1)
      = (M : ℂ) • Y m := by
  simp_rw [checkY]
  exact inverse_dft_check hM Y m

/-- **原文第 1 式**: `Z_j = (1/M) ∑_{μ=1}^{M} check(Z)_μ e^{ij θ~_μ}`。 -/
theorem Z_eq_inverse_dft_check (hM : M ≠ 0) (m : Fin M) :
    Z m = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) • checkZ M (((μ : ℕ) : ℤ) + 1) := by
  rw [recover_checkZ hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

/-- **原文第 2 式**: `Y_j = (1/M) ∑_{μ=1}^{M} check(Y)_μ e^{ij θ~_μ}`。 -/
theorem Y_eq_inverse_dft_check (hM : M ≠ 0) (m : Fin M) :
    Y m = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      checkPhase M (-(((m : ℕ) : ℤ) + 1)) (((μ : ℕ) : ℤ) + 1) • checkY M (((μ : ℕ) : ℤ) + 1) := by
  rw [recover_checkY hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

/-! ## 生成性 -/

/-- 原文の `{check(Z)_1, …, check(Z)_M, check(Y)_1, …, check(Y)_M}`。 -/
noncomputable def checkZYSet (M : ℕ) : Set (TensorPow M) :=
  (Set.range fun μ : Fin M => checkZ M (((μ : ℕ) : ℤ) + 1)) ∪
    (Set.range fun μ : Fin M => checkY M (((μ : ℕ) : ℤ) + 1))

theorem checkZ_mem_adjoin (μ : Fin M) :
    checkZ M (((μ : ℕ) : ℤ) + 1) ∈ Algebra.adjoin ℂ (checkZYSet M) :=
  Algebra.subset_adjoin (Or.inl ⟨μ, rfl⟩)

theorem checkY_mem_adjoin (μ : Fin M) :
    checkY M (((μ : ℕ) : ℤ) + 1) ∈ Algebra.adjoin ℂ (checkZYSet M) :=
  Algebra.subset_adjoin (Or.inr ⟨μ, rfl⟩)

/-- **原文の「とくに」**: `check(Z), check(Y)` は `Mat(2^M, ℂ)` を単位的 `ℂ` 代数として生成する。

復元公式により各 `Z_j, Y_j` が `check(Z)_μ, check(Y)_μ` の `ℂ` 線型結合なので、
`<Z_Y_generate_algebra>` に帰着する。 -/
theorem checkZ_checkY_generate_algebra (hM : M ≠ 0) :
    Algebra.adjoin ℂ (checkZYSet M) = ⊤ := by
  have hsub : ZYSet M ⊆ (Algebra.adjoin ℂ (checkZYSet M) : Set (TensorPow M)) := by
    rintro w (⟨m, rfl⟩ | ⟨m, rfl⟩)
    · rw [Z_eq_inverse_dft_check hM m]
      exact Subalgebra.smul_mem _
        (Subalgebra.sum_mem _ fun μ _ => Subalgebra.smul_mem _ (checkZ_mem_adjoin μ) _) _
    · rw [Y_eq_inverse_dft_check hM m]
      exact Subalgebra.smul_mem _
        (Subalgebra.sum_mem _ fun μ _ => Subalgebra.smul_mem _ (checkY_mem_adjoin μ) _) _
  refine top_le_iff.1 ?_
  rw [← Z_Y_generate_algebra M]
  exact Algebra.adjoin_le hsub

end Ising2D
