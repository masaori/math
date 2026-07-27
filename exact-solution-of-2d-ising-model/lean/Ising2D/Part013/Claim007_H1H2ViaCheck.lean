/-
# `H_1^{(+)}, H_2` を `check(Z), check(Y)` で表す（**具体版**）

対応する人手証明のラベル: `H1_H2_via_check_Z_Y`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_007_claim_H1_H2_via_check_Z_Y`）

**抽象版は無い。** 整数運動量版 `H1_H2_via_hatZ_hatY`（`Part004/Claim011_H1H2ViaHat.lean`）
と同じ理由で、この等式は `check(Z), check(Y)` の**具体形（半整数運動量の離散フーリエ変換）**に
本質的に依存しており、抽象化する余地がない。本ファイルの結果を使う交換関係の側
（`commutator_of_H_and_check_Z_Y`）は、既存の抽象版
`Ising2D/Abstract/CommutatorClifford.lean` の系として導く
（`Ising2D/Part013/Claim004_CommutatorHCheckZY.lean`）。

## 原文の主張

  `H_1^{(+)} = (1/M) ∑_{μ=1}^{M} check(Y)_μ check(Z)_{M+1-μ} e^{-iθ~_μ}`
  `H_2       = (1/M) ∑_{μ=1}^{M} check(Z)_{M+1-μ} check(Y)_μ`

## 形式化の方針

整数運動量版（`Part004/Claim011_H1H2ViaHat.lean`）と同じ 3 段構成:

1. 2 つの和の積を `Y_{k₁} Z_{k₂}`（`Z_{k₁} Y_{k₂}`）の二重和へ展開する
2. `μ` の和を最内へ移し、反周期的指数和（`Ising2D.sum_checkPhase`）で潰す
3. `δ^M` により `k₂` が一意に決まる（`H_1` では `k₂ = nextSite k₁`、`H_2` では `k₂ = k₁`）

**原文が「境界項 `-Y_M Z_1` の符号は `(-1)^1` として自動的に出る」と述べている点**は、
Lean では `expPhase_nextSite`（`e^{-i(k₁-k₂+1)θ~} = lastSign (-1) k₁`）に対応する:
`k₁` が最終サイトのときだけ指数が `M` になり、反周期性 `expPhase (2M) M = -1` で
符号 `-1`（= `H_1^{(+)}` の最終項の係数）が出る。
-/
import Ising2D.Part013.Claim003b_ConjugateIndex

namespace Ising2D

variable {M : ℕ}

/-- **境界の符号が反周期性から出ることの中身**:

  `e^{-i(k₁ - nextSite(k₁) + 1)θ~} = (k₁ が最終サイトなら -1、そうでなければ 1)`

最終サイト以外では指数が `0`（位相因子は `1`）、最終サイトでは指数が `M` になり
反周期性 `expPhase (2M) M = -1` で `H_1^{(+)}` の最終項の係数 `-1` が出る。 -/
theorem expPhase_nextSite (hM : M ≠ 0) (m : Fin M) :
    expPhase (2 * M) (((m : ℕ) : ℤ) - (((nextSite m : Fin M) : ℕ) : ℤ) + 1)
      = lastSign (-1) m := by
  by_cases h : (m : ℕ) + 1 = M
  · rw [nextSite_val_of_last h, lastSign_of_last h,
      show ((m : ℕ) : ℤ) - ((0 : ℕ) : ℤ) + 1 = (M : ℤ) by push_cast; omega,
      expPhase_two_mul_half hM]
  · have hlt : (m : ℕ) + 1 < M := by have := m.isLt; omega
    rw [nextSite_val_of_lt hlt, lastSign_of_not_last h,
      show ((m : ℕ) : ℤ) - (((m : ℕ) + 1 : ℕ) : ℤ) + 1 = 0 by push_cast; ring,
      expPhase_zero]

/-! ## `H_2` -/

/-- **原文第 2 式の形式化**: `H_2 = (1/M) ∑_{μ=1}^{M} check(Z)_{M+1-μ} check(Y)_μ`。 -/
theorem H2_eq_check_sum (hM : M ≠ 0) :
    H2 M = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      (checkZ M ((M : ℤ) + 1 - (((μ : ℕ) : ℤ) + 1)) * checkY M (((μ : ℕ) : ℤ) + 1)) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have hterm : ∀ μ : Fin M,
      checkZ M ((M : ℤ) + 1 - (((μ : ℕ) : ℤ) + 1)) * checkY M (((μ : ℕ) : ℤ) + 1)
        = ∑ k₁ : Fin M, ∑ k₂ : Fin M,
            checkPhase M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) (((μ : ℕ) : ℤ) + 1) •
              (Z k₁ * Y k₂) := by
    intro μ
    rw [checkZ_conj_eq hM, checkY, sum_smul_mul_sum_smul]
    refine Finset.sum_congr rfl fun k₁ _ => ?_
    refine Finset.sum_congr rfl fun k₂ _ => ?_
    congr 1
    simp only [checkPhase]
    rw [← expPhase_add]
    congr 1
    ring
  have hinner : ∀ k₁ k₂ : Fin M,
      ∑ μ : Fin M,
          checkPhase M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) (((μ : ℕ) : ℤ) + 1) • (Z k₁ * Y k₂)
        = (expPhase (2 * M) (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) *
            ((M : ℂ) * deltaMod M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) 0)) • (Z k₁ * Y k₂) := by
    intro k₁ k₂
    rw [← Finset.sum_smul, sum_checkPhase hM]
  have houter : ∀ k₁ : Fin M,
      ∑ k₂ : Fin M,
          (expPhase (2 * M) (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) *
            ((M : ℂ) * deltaMod M (((k₂ : ℕ) : ℤ) - ((k₁ : ℕ) : ℤ)) 0)) • (Z k₁ * Y k₂)
        = (M : ℂ) • (Z k₁ * Y k₁) := by
    intro k₁
    rw [Finset.sum_eq_single_of_mem k₁ (Finset.mem_univ _)]
    · rw [sub_self, deltaMod, sub_zero, if_pos (dvd_zero _), mul_one, expPhase_zero, one_mul]
    · intro k₂ _ hk₂
      rw [deltaMod, sub_zero, if_neg (fun hd => hk₂ ((dvd_sub_iff_eq k₂ k₁).1 hd)),
        mul_zero, mul_zero, zero_smul]
  symm
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) => Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) =>
      (Finset.sum_congr rfl fun k₂ (_ : k₂ ∈ Finset.univ) => hinner k₁ k₂).trans (houter k₁),
    ← Finset.smul_sum, smul_smul, inv_mul_cancel₀ hMC, one_smul, H2]

/-! ## `H_1^{(+)}` -/

/-- **原文第 1 式の形式化**:
`H_1^{(+)} = (1/M) ∑_{μ=1}^{M} check(Y)_μ check(Z)_{M+1-μ} e^{-iθ~_μ}`。 -/
theorem H1Plus_eq_check_sum (hM : M ≠ 0) :
    H1 M (-1) = ((M : ℂ))⁻¹ • ∑ μ : Fin M,
      checkPhase M 1 (((μ : ℕ) : ℤ) + 1) •
        (checkY M (((μ : ℕ) : ℤ) + 1) *
          checkZ M ((M : ℤ) + 1 - (((μ : ℕ) : ℤ) + 1))) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  have hterm : ∀ μ : Fin M,
      checkPhase M 1 (((μ : ℕ) : ℤ) + 1) •
          (checkY M (((μ : ℕ) : ℤ) + 1) *
            checkZ M ((M : ℤ) + 1 - (((μ : ℕ) : ℤ) + 1)))
        = ∑ k₁ : Fin M, ∑ k₂ : Fin M,
            checkPhase M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) •
              (Y k₁ * Z k₂) := by
    intro μ
    rw [checkY, checkZ_conj_eq hM, sum_smul_mul_sum_smul, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k₁ _ => ?_
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun k₂ _ => ?_
    rw [smul_smul]
    congr 1
    simp only [checkPhase]
    rw [← expPhase_add, ← expPhase_add]
    congr 1
    ring
  have hinner : ∀ k₁ k₂ : Fin M,
      ∑ μ : Fin M,
          checkPhase M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) (((μ : ℕ) : ℤ) + 1) •
            (Y k₁ * Z k₂)
        = (expPhase (2 * M) (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) *
            ((M : ℂ) * deltaMod M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) 0)) •
              (Y k₁ * Z k₂) := by
    intro k₁ k₂
    rw [← Finset.sum_smul, sum_checkPhase hM]
  have houter : ∀ k₁ : Fin M,
      ∑ k₂ : Fin M,
          (expPhase (2 * M) (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) *
            ((M : ℂ) * deltaMod M (((k₁ : ℕ) : ℤ) - ((k₂ : ℕ) : ℤ) + 1) 0)) • (Y k₁ * Z k₂)
        = (M : ℂ) • (lastSign (-1) k₁ • (Y k₁ * Z (nextSite k₁))) := by
    intro k₁
    rw [Finset.sum_eq_single_of_mem (nextSite k₁) (Finset.mem_univ _)]
    · rw [deltaMod, sub_zero,
        if_pos ((dvd_succ_sub_iff_eq_nextSite k₁ (nextSite k₁)).2 rfl), mul_one,
        expPhase_nextSite hM, smul_smul]
      congr 1
      ring
    · intro k₂ _ hk₂
      rw [deltaMod, sub_zero,
        if_neg (fun hd => hk₂ ((dvd_succ_sub_iff_eq_nextSite k₁ k₂).1 hd)),
        mul_zero, mul_zero, zero_smul]
  symm
  rw [Finset.sum_congr rfl fun μ _ => hterm μ, Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) => Finset.sum_comm,
    Finset.sum_congr rfl fun k₁ (_ : k₁ ∈ Finset.univ) =>
      (Finset.sum_congr rfl fun k₂ (_ : k₂ ∈ Finset.univ) => hinner k₁ k₂).trans (houter k₁),
    ← Finset.smul_sum, smul_smul, inv_mul_cancel₀ hMC, one_smul, H1]

end Ising2D
