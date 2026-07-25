/-
# `hat(Z), hat(Y)` から `Z, Y` の復元（離散フーリエ逆変換）

対応する人手証明:
`parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ` (`<recover_Z_Y_from_hatZ_hatY>`)

原文の主張（各 `m ∈ {1, …, M}` について）:

  `∑_{μ=1}^M hat(Y)_μ exp(√-1 m · 2πμ/M) = M Y_m`
  `∑_{μ=1}^M hat(Z)_μ^{(-)} exp(√-1 m · 2πμ/M) = M Z_m`
  ゆえに `Y_m = (1/M) ∑_μ …`、`Z_m = (1/M) ∑_μ …`

## 形式化の方針

原文の証明は「指数和の直交性 `(∗)`（`<exp_sum>` の読み替え）→ 二重和の順序交換 →
`δ` で 1 項だけ残す」という 3 段。ここでも同じ順序で証明する。

`Z` と `Y` で証明が完全に同じ（使うのは `hat` の定義だけで `Z, Y` の代数的性質は使わない）なので、
**任意の族 `x : Fin M → Mat(2,ℂ)^{⊗M}` に対する逆変換公式** `inverse_dft` を先に証明し、
`Y`（`hatY`）と `Z`（`hatZMinus`）はその特殊化として得る。
原文が `hat(Z)^{(-)}`（一様和の方）でしか復元を述べていない理由もこれで明確になる:
`hat(Z)^{(+)}` は `j = 1` の項の重みが `-1` なので、この形の逆変換は成り立たない。

添字の読み替えは `Definition009_HatZHatY.lean` と同じ
（原文の `j, μ, m ∈ {1, …, M}` は Lean の `Fin M` の元 `j` に対して `(j : ℕ) + 1`）。
位相因子 `exp(√-1 m · 2πμ/M)` は `expPhase M (-(m μ))` である。
-/
import Ising2D.Part004.Definition009_HatZHatY

namespace Ising2D

variable {M : ℕ}

/-- **離散フーリエ逆変換（原文 Step 1・Step 2 に共通の計算）**。

族 `x : Fin M → Mat(2,ℂ)^{⊗M}` の変換 `hat(x)_μ = ∑_j x_j exp(-√-1 · 2π j μ/M)` に対し

  `∑_{μ=1}^M hat(x)_μ exp(√-1 · 2π m μ/M) = M x_m`。 -/
theorem inverse_dft (hM : M ≠ 0) (x : Fin M → TensorPow M) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        (∑ j : Fin M, expPhase M ((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) • x j)
      = (M : ℂ) • x m := by
  -- Step 0: 指数法則で位相をまとめる（原文の「指数法則」の行）
  have step1 : ∀ μ : Fin M,
      expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
          (∑ j : Fin M, expPhase M ((((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)) • x j)
        = ∑ j : Fin M,
            expPhase M ((((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) * ((((μ : ℕ)) : ℤ) + 1)) • x j := by
    intro μ
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    have hexp : -((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))
        + (((j : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1)
        = (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) * ((((μ : ℕ)) : ℤ) + 1) := by ring
    rw [smul_smul, ← expPhase_add, hexp]
  simp_rw [step1]
  -- Step 1: 有限二重和の順序交換（原文の「有限二重和の順序交換」の行）
  rw [Finset.sum_comm]
  -- Step 2: `μ` についての指数和の直交性 `(∗)`（`<exp_sum>`）
  have step2 : ∀ j : Fin M,
      (∑ μ : Fin M,
          expPhase M ((((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) * ((((μ : ℕ)) : ℤ) + 1)) • x j)
        = ((M : ℂ) * deltaMod M (((j : ℕ) : ℤ) - ((m : ℕ) : ℤ)) 0) • x j := by
    intro j
    rw [← Finset.sum_smul]
    congr 1
    rw [← expPhase_sum hM]
    exact Finset.sum_congr rfl fun μ _ => by rw [mul_comm]
  simp_rw [step2]
  -- Step 3: `δ` で `j = m` の項だけ残る
  rw [Finset.sum_eq_single_of_mem m (Finset.mem_univ m)]
  · rw [sub_self, deltaMod, sub_zero, if_pos (dvd_zero _), mul_one]
  · intro j _ hj
    rw [deltaMod, sub_zero, if_neg (fun h => hj ((dvd_sub_iff_eq j m).1 h)), mul_zero, zero_smul]

/-- **`<recover_Z_Y_from_hatZ_hatY>` Step 1 の形式化**:
`∑_{μ=1}^M hat(Y)_μ exp(√-1 m · 2πμ/M) = M Y_m`。 -/
theorem recover_Y (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatY M ((((μ : ℕ)) : ℤ) + 1)
      = (M : ℂ) • Y m := by
  simp_rw [hatY]
  exact inverse_dft hM Y m

/-- **`<recover_Z_Y_from_hatZ_hatY>` Step 2 の形式化**:
`∑_{μ=1}^M hat(Z)_μ^{(-)} exp(√-1 m · 2πμ/M) = M Z_m`。 -/
theorem recover_Z (hM : M ≠ 0) (m : Fin M) :
    ∑ μ : Fin M, expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatZMinus M ((((μ : ℕ)) : ℤ) + 1)
      = (M : ℂ) • Z m := by
  simp_rw [hatZMinus_eq]
  exact inverse_dft hM Z m

/-- **`<recover_Z_Y_from_hatZ_hatY>` Step 3 の形式化**（両辺を `M` で割った復元式）:
`Y_m = (1/M) ∑_{μ=1}^M hat(Y)_μ exp(√-1 m · 2πμ/M)`。 -/
theorem Y_eq_inverse_dft (hM : M ≠ 0) (m : Fin M) :
    Y m = ((M : ℂ)⁻¹) • ∑ μ : Fin M,
      expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatY M ((((μ : ℕ)) : ℤ) + 1) := by
  rw [recover_Y hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

/-- `Z_m = (1/M) ∑_{μ=1}^M hat(Z)_μ^{(-)} exp(√-1 m · 2πμ/M)`。 -/
theorem Z_eq_inverse_dft (hM : M ≠ 0) (m : Fin M) :
    Z m = ((M : ℂ)⁻¹) • ∑ μ : Fin M,
      expPhase M (-((((m : ℕ) : ℤ) + 1) * ((((μ : ℕ)) : ℤ) + 1))) •
        hatZMinus M ((((μ : ℕ)) : ℤ) + 1) := by
  rw [recover_Z hM, smul_smul, inv_mul_cancel₀ (Nat.cast_ne_zero.2 hM), one_smul]

end Ising2D
