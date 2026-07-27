/-
# `T_{(V^{(+)})}` と `T_{(V̌')}` は `Ž, Y̌` 上で一致する

対応する人手証明のラベル: `T_V_plus_eq_T_check_Vprime_on_check_Z_Y`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_007_claim_T_eq_on_check_Z_Y`）

## 形式化の方針

原文 Step 1 は `P̌_μ^{-1}` を使って `Ž_μ, Y̌_μ` をフェルミオンで書き直している
（015 章 `diagonalization_check_P_D` の `det P̌_μ ≠ 0`）。本ファイルはこれを、
定義式から直接得られる

    ψ̌_μ^† - ψ̌_μ = 2 p_μ Ž_μ,   ψ̌_μ^† + ψ̌_μ = 2 q Y̌_μ

に置き換える（`checkPsiDag_sub_checkPsi` / `checkPsiDag_add_checkPsi`）。
`p_μ ≠ 0`, `q ≠ 0` は `det P̌_μ ≠ 0` と同じ内容であり、`γ_2(θ̃_μ) ≠ 0` から従う。
これにより 015 章の完成を待たずに本章を閉じられる。

Step 2・Step 3 はそのまま「線型写像が 2 つの基底元の上で一致すれば
その張る空間の上で一致する」ことに帰着する。
-/
import Ising2D.Part016.Claim006_ActionTCheckVprime
import Ising2D.Part016.Claim004_CommutationVPlusCheckPsi

namespace Ising2D

variable {M : ℕ}

/-! ## `Ž_μ, Y̌_μ` をフェルミオンで書く（原文 Step 1） -/

theorem checkPsiDag_sub_checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ - checkPsi K M μ = (2 * checkP K M μ) • checkZ M μ := by
  rw [checkPsiDag, checkPsi]
  module

theorem checkPsiDag_add_checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) :
    checkPsiDag K M μ + checkPsi K M μ = (2 * checkQ M) • checkY M μ := by
  rw [checkPsiDag, checkPsi]
  module

theorem checkP_ne_zero (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) : checkP K M μ ≠ 0 := by
  have hs : sqrtM M ≠ 0 := sqrtM_ne_zero hM
  have hgb : gamma2 K (-thetaTilde M μ) ≠ 0 := fun h =>
    hga ((gamma2_neg_eq_zero_iff K _).1 h)
  exact div_ne_zero (neg_ne_zero.2 (checkR_ne_zero K M hga))
    (mul_ne_zero (mul_ne_zero two_ne_zero hs) hgb)

theorem checkQ_ne_zero (M : ℕ) (hM : M ≠ 0) : checkQ M ≠ 0 :=
  one_div_ne_zero (mul_ne_zero two_ne_zero (sqrtM_ne_zero hM))

/-- 原文 Step 1: `Ž_μ` はフェルミオンの ℂ 線型結合である。 -/
theorem checkZ_eq_smul (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0) :
    checkZ M μ = (2 * checkP K M μ)⁻¹ • (checkPsiDag K M μ - checkPsi K M μ) := by
  rw [checkPsiDag_sub_checkPsi, smul_smul,
    inv_mul_cancel₀ (mul_ne_zero two_ne_zero (checkP_ne_zero K M hM hga)), one_smul]

/-- 原文 Step 1: `Y̌_μ` はフェルミオンの ℂ 線型結合である。 -/
theorem checkY_eq_smul (K : IsingConst) (M : ℕ) (hM : M ≠ 0) (μ : ℤ) :
    checkY M μ = (2 * checkQ M)⁻¹ • (checkPsiDag K M μ + checkPsi K M μ) := by
  rw [checkPsiDag_add_checkPsi, smul_smul,
    inv_mul_cancel₀ (mul_ne_zero two_ne_zero (checkQ_ne_zero M hM)), one_smul]

/-! ## 原文 Step 2・Step 3: フェルミオン上の一致を `Ž, Y̌` へ移す -/

/-- **原文 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` の骨格**。

2 つの ℂ 線型写像が `ψ̌_μ^†` と `ψ̌_μ` の上で一致すれば、`Ž_μ` と `Y̌_μ` の上でも一致する。 -/
theorem eq_on_checkZY_of_eq_on_checkPsi (K : IsingConst) (M : ℕ) (hM : M ≠ 0) {μ : ℤ}
    (hga : gamma2 K (thetaTilde M μ) ≠ 0)
    {T₁ T₂ : TensorPow M →ₗ[ℂ] TensorPow M}
    (hdag : T₁ (checkPsiDag K M μ) = T₂ (checkPsiDag K M μ))
    (hpsi : T₁ (checkPsi K M μ) = T₂ (checkPsi K M μ)) :
    T₁ (checkZ M μ) = T₂ (checkZ M μ) ∧ T₁ (checkY M μ) = T₂ (checkY M μ) := by
  constructor
  · rw [checkZ_eq_smul K M hM hga, map_smul, map_smul, map_sub, map_sub, hdag, hpsi]
  · rw [checkY_eq_smul K M hM μ, map_smul, map_smul, map_add, map_add, hdag, hpsi]

/-- **原文 `T_V_plus_eq_T_check_Vprime_on_check_Z_Y` そのもの**。

`T_{(V^{(+)})}` の側は 014 章の作用（`hT`）と 015 章の固有値の同定（`hlam`）を仮定として受け取る。
`T_{(V̌')}` の側は `Ising2D.TCheckVprime_checkPsiDag` / `TCheckVprime_checkPsi`（本章、証明済み）。 -/
theorem TVPlus_eq_TCheckVprime_on_checkZY (K : IsingConst) (g : ℤ → ℂ) (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ)
    {TPlus : TensorPow M →ₗ[ℂ] TensorPow M}
    (hT : ∀ j : Fin M, ActsBy TPlus (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat K (thetaTilde M (checkIdx M j))))
    (hlamPlus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      + ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (g (checkIdx M j)))
    (hlamMinus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      - ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (-g (checkIdx M j)))
    (j : Fin M) :
    TPlus (checkZ M (checkIdx M j))
        = TConj (checkVprimeUnits K M g) (checkZ M (checkIdx M j))
      ∧ TPlus (checkY M (checkIdx M j))
        = TConj (checkVprimeUnits K M g) (checkY M (checkIdx M j)) := by
  have hgaj := hga _ (checkIndex_checkIdx M j)
  have hplus := TVPlus_checkPsiDag_psi_of_action K M hM hgaj (hlamPlus j) (hlamMinus j) (hT j)
  refine eq_on_checkZY_of_eq_on_checkPsi (T₁ := TPlus)
    (T₂ := (TConj (checkVprimeUnits K M g)).toLinearMap) K M hM hgaj ?_ ?_
  · rw [hplus.1]
    exact (TCheckVprime_checkPsiDag K g hM hga j).symm
  · rw [hplus.2]
    exact (TCheckVprime_checkPsi K g hM hga hgconj j).symm

end Ising2D
