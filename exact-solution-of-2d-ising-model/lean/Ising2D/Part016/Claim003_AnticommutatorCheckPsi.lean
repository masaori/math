/-
# `ψ̌` の反交換関係（半整数運動量の CAR）

対応する人手証明のラベル: `anticommutator_of_check_psi`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_003_claim_anticommutator`）

**必要十分版**は 008 章のものがそのまま使える: `Ising2D/NecSuf/Fermion.lean` の
`Ising2D.NecSuf.car_of_coeffs`（人手証明のラベルは `anticommutator_of_psi`）。
本ファイルの 3 式は**すべてその特殊化として導出している**（`checkPsi_car`）。

## 008 章の必要十分版がそのまま使えることの確認（本セッションの主目的の 1 つ）

`NecSuf.car_of_coeffs` が要求するのは次だけである。

1. 台となる 4 元 `z, y, z', y'` の反交換関係 4 本
   （`[z,z']₊ = D·1`, `[z,y']₊ = 0`, `[y,z']₊ = 0`, `[y,y']₊ = D·1`）
2. 係数についてのスカラー恒等式 2 本
   （`(p p' + q q')·D = 0` と `(-(p p') + q q')·D = δ`）

半整数運動量では 1 が `Ising2D.acomm_checkZ_checkZ_of_mem` /
`acomm_checkZ_checkY` / `acomm_checkY_checkZ` / `acomm_checkY_checkY_of_mem`（013 章）で、
`D = 2M δ_{ν,M+1-μ}` である。整数運動量の `D = 2M δ^M_{μ+ν,0}` と**形が違うだけ**で、
必要十分版の仮定の形（「反交換子がスカラー倍の `1`」）は変わらない。
したがって**必要十分版はそのまま流用でき、書き換えは一切要らなかった**。

## 008 章との差（原文 Step 1 の指摘の機械的裏づけ）

008 章の `anticommutator_of_psi` では係数に平方根 `√(γ_2(θ_μ)γ_2(-θ_μ))` が入るため、
`Ising2D/Part008/Definition030_Fermi.lean` は分枝の一致を仮定
`hbr : (M:ℤ) ∣ (μ+ν) → tν = tμ` として持っている。

半整数運動量では係数が `r_μ = |γ_2(θ̃_μ)|`（非負実数）なので、
`Ising2D.checkR_sq`（`(r:ℂ)^2 = -(γ_2(θ̃_μ)γ_2(-θ̃_μ))` が**無条件**）と
`Ising2D.checkR_conj`（`r_{M+1-μ} = r_μ` が**絶対値の計算だけ**から従う）により、
**対応する仮定は本ファイルに 1 つも現れない**。原文が Step 1 で述べているとおりである。

**したがって、008 章で問題になった「同一分枝であることが自明でない」という論点は、
本章の `anticommutator_of_check_psi` には存在しない**（穴は無い）。
詳細は `docs/tasks/2026-07_lean-ch009-013/010_ch016_no_sqrt_branch_gap.md`。

## 残っている仮定

`hga : gamma2 K (thetaTilde M μ) ≠ 0` — 015 章の `gamma_2_theta_tilde_nonzero`。
015 章がこれを無条件に閉じれば消える（`K_1, K_2 ∈ ℝ_{>0}` から従う）。
-/
import Ising2D.Part016.Definition001_CheckFermi
import Ising2D.NecSuf.Fermion
import Ising2D.Part013.Claim005_AnticommutatorCheckZY

namespace Ising2D

variable {M : ℕ}

/-! ## 係数についてのスカラー恒等式（原文 Step 1） -/

theorem checkQ_mul_checkQ (hM : M ≠ 0) : checkQ M * checkQ M = 1 / (4 * (M : ℂ)) := by
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hs2 : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
  rw [checkQ, div_mul_div_comm, one_mul]
  rw [show (2 * sqrtM M) * (2 * sqrtM M) = 4 * sqrtM M ^ 2 by ring, hs2]

/-- **原文 Step 1 の結論**: `p_μ p_{M+1-μ} = -1/(4M)`。

`b_{M+1-μ} = a_μ`（`gamma2_neg_thetaTilde_conj`）、`r_{M+1-μ} = r_μ`（`checkR_conj`）、
`a_μ b_μ = -r_μ^2`（`checkR_sq`）の 3 つだけを使う。 -/
theorem checkP_mul_checkP_conj (K : IsingConst) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    checkP K M μ * checkP K M ((M : ℤ) + 1 - μ) = -(1 / (4 * (M : ℂ))) := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.2 hM
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hs2 : sqrtM M ^ 2 = (M : ℂ) := sqrtM_sq M
  have hgb : gamma2 K (-thetaTilde M μ) ≠ 0 := fun h =>
    hga ((gamma2_neg_eq_zero_iff K _).1 h)
  have hr : ((checkR K M μ : ℝ) : ℂ) ≠ 0 := checkR_ne_zero K M hga
  have hr2 : ((checkR K M μ : ℝ) : ℂ) ^ 2
      = -(gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) := checkR_sq K M μ
  have hab : gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)
      = -(((checkR K M μ : ℝ) : ℂ) ^ 2) := by rw [hr2, neg_neg]
  rw [checkP, checkP, gamma2_neg_thetaTilde_conj K hM μ, checkR_conj K hM μ]
  rw [div_mul_div_comm]
  rw [show (-((checkR K M μ : ℝ) : ℂ)) * (-((checkR K M μ : ℝ) : ℂ))
      = ((checkR K M μ : ℝ) : ℂ) ^ 2 by ring]
  rw [show (2 * sqrtM M * gamma2 K (-thetaTilde M μ)) * (2 * sqrtM M * gamma2 K (thetaTilde M μ))
      = 4 * sqrtM M ^ 2 * (gamma2 K (thetaTilde M μ) * gamma2 K (-thetaTilde M μ)) by ring]
  rw [hs2, hab, hr2, neg_neg]
  field_simp

/-! ## CAR（原文 `anticommutator_of_check_psi`） -/

/-- **原文 `anticommutator_of_check_psi` の 3 式**（008 章の必要十分版
`Ising2D.NecSuf.car_of_coeffs` の特殊化として導出した形）。 -/
theorem checkPsi_car (K : IsingConst) (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν)
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    acomm (checkPsiDag K M μ) (checkPsiDag K M ν) = 0
      ∧ acomm (checkPsiDag K M μ) (checkPsi K M ν)
          = (if ν = (M : ℤ) + 1 - μ then (1 : ℂ) else 0) • (1 : TensorPow M)
      ∧ acomm (checkPsi K M μ) (checkPsi K M ν) = 0 := by
  have hMC : (M : ℂ) ≠ 0 := Nat.cast_ne_zero.2 hM
  set δ : ℂ := if ν = (M : ℤ) + 1 - μ then (1 : ℂ) else 0 with hδ
  have hzero : (checkP K M μ * checkP K M ν + checkQ M * checkQ M) * (2 * (M : ℂ) * δ) = 0 := by
    by_cases h : ν = (M : ℤ) + 1 - μ
    · subst h
      rw [hδ, if_pos rfl, checkP_mul_checkP_conj K hM hga, checkQ_mul_checkQ hM]
      ring
    · rw [hδ, if_neg h]; ring
  have hone : (-(checkP K M μ * checkP K M ν) + checkQ M * checkQ M) * (2 * (M : ℂ) * δ) = δ := by
    by_cases h : ν = (M : ℤ) + 1 - μ
    · subst h
      rw [hδ, if_pos rfl, checkP_mul_checkP_conj K hM hga, checkQ_mul_checkQ hM]
      field_simp
      norm_num
    · rw [hδ, if_neg h]; ring
  exact NecSuf.car_of_coeffs (checkP K M μ) (checkQ M) (checkP K M ν) (checkQ M)
    (2 * (M : ℂ) * δ) δ (checkZ M μ) (checkY M μ) (checkZ M ν) (checkY M ν)
    (acomm_checkZ_checkZ_of_mem hM hμ hν) (acomm_checkZ_checkY μ ν)
    (acomm_checkY_checkZ μ ν) (acomm_checkY_checkY_of_mem hM hμ hν) hzero hone

/-- **原文第 1 式**: `[ψ̌_μ^†, ψ̌_ν^†]₊ = 0`。 -/
theorem acomm_checkPsiDag_checkPsiDag (K : IsingConst) (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν)
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    acomm (checkPsiDag K M μ) (checkPsiDag K M ν) = 0 :=
  (checkPsi_car K hM hμ hν hga).1

/-- **原文第 2 式**: `[ψ̌_μ^†, ψ̌_ν]₊ = δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkPsiDag_checkPsi (K : IsingConst) (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν)
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    acomm (checkPsiDag K M μ) (checkPsi K M ν)
      = (if ν = (M : ℤ) + 1 - μ then (1 : ℂ) else 0) • (1 : TensorPow M) :=
  (checkPsi_car K hM hμ hν hga).2.1

/-- **原文第 3 式**: `[ψ̌_μ, ψ̌_ν]₊ = 0`。 -/
theorem acomm_checkPsi_checkPsi (K : IsingConst) (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν)
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    acomm (checkPsi K M μ) (checkPsi K M ν) = 0 :=
  (checkPsi_car K hM hμ hν hga).2.2

/-- 第 2 式の左右を入れ替えた形（反交換子の対称性）。`X̌` との交換子で使う。 -/
theorem acomm_checkPsi_checkPsiDag (K : IsingConst) (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν)
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    acomm (checkPsi K M ν) (checkPsiDag K M μ)
      = (if ν = (M : ℤ) + 1 - μ then (1 : ℂ) else 0) • (1 : TensorPow M) := by
  rw [acomm_comm]; exact acomm_checkPsiDag_checkPsi K hM hμ hν hga

end Ising2D
