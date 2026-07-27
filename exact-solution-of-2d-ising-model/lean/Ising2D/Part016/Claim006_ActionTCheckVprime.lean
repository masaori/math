/-
# `T_{(V̌')}` の `ψ̌` への作用

対応する人手証明のラベル: `action_of_T_check_Vprime_on_check_psi`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_006_claim_action_T_check_Vprime`）

**抽象版**は 2 本ある（いずれも同じラベル）:

* `Ising2D/Abstract/FermionLadder.lean` — Step 1, 1', 2, 2'（CAR から出る梯子作用）
* `Ising2D/Abstract/ExpEigenvector.lean` — Step 3, 4, 5（`ad X` の固有ベクトルは
  `exp` 共役の固有ベクトル）

本ファイルの具体版は**両方の特殊化として導出している**。

## 原文の Step との対応

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1 | `Abstract.lie_creAnn_cre`（`hed`, `hdd` を与えて適用） |
| Step 1' | `Abstract.lie_creAnn_ann`（`hee`, `hde` を与えて適用） |
| Step 2 | `lie_checkX_checkPsiDag` |
| Step 2' | `lie_checkX_checkPsi` |
| Step 3〜5 | `matExp_conj_eigen`（抽象版 `Abstract.exp_conj_of_lie_eigen` の特殊化） |

原文が Step 3（帰納法）・Step 4（部分和の極限）・Step 5（`exp` の積公式）と 3 段で
書いているところは、008 章で用意した `exp` 共役の級数展開
（`Ising2D/Abstract/ExpConjugation.lean`）の **1 次元不変部分空間への退化**であり、
新しい解析は要らなかった。

## 015 章への依存（**仮定として受け取る**）

* 重み `γ(θ̃_μ)` は任意の `g : ℤ → ℂ` として持つ（`Ising2D.checkX` の引数）。
* 原文が使う `γ` の性質は `periodicity_of_check_fermi` (3) の
  `γ(θ̃_{M+1-μ}) = γ(θ̃_μ)` ただ 1 つで、仮定 `hgconj` として明示する。
* `gamma_2_theta_tilde_nonzero`（015 章）は仮定 `hga` として明示する。
-/
import Ising2D.Part016.Definition005_CheckVprime
import Ising2D.Abstract.FermionLadder
import Ising2D.Abstract.ExpEigenvector
import Ising2D.Part008.Definition016_TV

namespace Ising2D

open NormedSpace

variable {M : ℕ}

/-! ## Step 3〜5: `ad X` の固有ベクトルは `exp` 共役の固有ベクトル（具体版） -/

open scoped Matrix.Norms.Operator in
/-- 抽象版 `Abstract.exp_conj_of_lie_eigen` の特殊化（`l^∞` 作用素ノルムの文脈での版）。 -/
private theorem matExp_conj_eigen_aux {X a : TensorPow M} {c : ℂ} (h : X * a - a * X = c • a) :
    NormedSpace.exp X * a * NormedSpace.exp (-X) = Complex.exp c • a :=
  Abstract.exp_conj_of_lie_eigen h

set_option backward.isDefEq.respectTransparency false in
/-- **原文 Step 3〜5 の具体版**: `[X, a] = c a ⟹ exp(X) a exp(-X) = e^c a`。 -/
theorem matExp_conj_eigen {X a : TensorPow M} {c : ℂ} (h : X * a - a * X = c • a) :
    matExp X * a * matExp (-X) = Complex.exp c • a :=
  matExp_conj_eigen_aux h

/-! ## Step 2 / Step 2': `X̌` との交換子 -/

/-- `checkX` は抽象版の `Abstract.carHam` そのものである（橋渡し）。 -/
theorem checkX_eq_carHam (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) :
    checkX K M g
      = Abstract.carHam (fun j : Fin M => g (checkIdx M j))
          (fun j : Fin M => checkPsiDag K M (checkIdx M j))
          (fun j : Fin M => checkPsi K M (checkIdx M j)) Fin.rev (1 / 2 : ℂ) := by
  rw [checkX, Abstract.carHam]
  exact Finset.sum_congr rfl fun j _ => by rw [checkIdx_rev]

variable (K : IsingConst) (g : ℤ → ℂ)

/-- **原文 Step 2**: `[X̌, ψ̌_μ^†] = γ(θ̃_μ) ψ̌_μ^†`（`μ = checkIdx j₀ ∈ 𝓜̌`）。 -/
theorem lie_checkX_checkPsiDag (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0) (j₀ : Fin M) :
    checkX K M g * checkPsiDag K M (checkIdx M j₀)
        - checkPsiDag K M (checkIdx M j₀) * checkX K M g
      = g (checkIdx M j₀) • checkPsiDag K M (checkIdx M j₀) := by
  rw [checkX_eq_carHam]
  refine Abstract.lie_carHam_cre (S := ℂ) _ _ _ _ _ j₀ ?_ ?_
  · intro ν
    have h := acomm_checkPsi_checkPsiDag K hM (checkIndex_checkIdx M j₀)
      (checkIndex_checkIdx M (Fin.rev ν)) (hga _ (checkIndex_checkIdx M j₀))
    have hiff : (checkIdx M (Fin.rev ν) = (M : ℤ) + 1 - checkIdx M j₀) ↔ (ν = j₀) := by
      rw [checkIdx_eq_rev_iff]
      exact ⟨fun hh => Fin.rev_injective hh, fun hh => by rw [hh]⟩
    rw [h, if_congr hiff rfl rfl]
  · intro ν
    exact acomm_checkPsiDag_checkPsiDag K hM (checkIndex_checkIdx M ν)
      (checkIndex_checkIdx M j₀) (hga _ (checkIndex_checkIdx M ν))

/-- **原文 Step 2'**: `[X̌, ψ̌_μ] = -γ(θ̃_μ) ψ̌_μ`（`μ = checkIdx j₀ ∈ 𝓜̌`）。

`γ(θ̃_{M+1-μ}) = γ(θ̃_μ)`（原文 `periodicity_of_check_fermi` (3)）を仮定 `hgconj` として使う。 -/
theorem lie_checkX_checkPsi (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ) (j₀ : Fin M) :
    checkX K M g * checkPsi K M (checkIdx M j₀)
        - checkPsi K M (checkIdx M j₀) * checkX K M g
      = (-g (checkIdx M j₀)) • checkPsi K M (checkIdx M j₀) := by
  rw [checkX_eq_carHam, neg_smul]
  refine Abstract.lie_carHam_ann (S := ℂ) _ _ _ _ _ j₀ (Fin.rev_rev j₀) ?_ ?_ ?_
  · rw [← checkIdx_rev]
    exact hgconj _ (checkIndex_checkIdx M j₀)
  · intro ν
    exact acomm_checkPsi_checkPsi K hM (checkIndex_checkIdx M (Fin.rev ν))
      (checkIndex_checkIdx M j₀) (hga _ (checkIndex_checkIdx M (Fin.rev ν)))
  · intro ν
    have h := acomm_checkPsiDag_checkPsi K hM (checkIndex_checkIdx M ν)
      (checkIndex_checkIdx M j₀) (hga _ (checkIndex_checkIdx M ν))
    have hiff : (checkIdx M j₀ = (M : ℤ) + 1 - checkIdx M ν) ↔ (ν = Fin.rev j₀) := by
      rw [checkIdx_eq_rev_iff]
      constructor
      · intro hh; rw [hh, Fin.rev_rev]
      · intro hh; rw [hh, Fin.rev_rev]
    rw [h, if_congr hiff rfl rfl]

/-! ## 原文 `action_of_T_check_Vprime_on_check_psi` -/

/-- **原文第 1 式**: `T_{(V̌')}(ψ̌_μ^†) = e^{+γ(θ̃_μ)} ψ̌_μ^†`。 -/
theorem TCheckVprime_checkPsiDag (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0) (j₀ : Fin M) :
    TConj (checkVprimeUnits K M g) (checkPsiDag K M (checkIdx M j₀))
      = Complex.exp (g (checkIdx M j₀)) • checkPsiDag K M (checkIdx M j₀) := by
  rw [TConj_apply, checkVprimeUnits_val, checkVprimeUnits_inv, checkVprime]
  exact matExp_conj_eigen (lie_checkX_checkPsiDag K g hM hga j₀)

/-- **原文第 2 式**: `T_{(V̌')}(ψ̌_μ) = e^{-γ(θ̃_μ)} ψ̌_μ`。 -/
theorem TCheckVprime_checkPsi (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ) (j₀ : Fin M) :
    TConj (checkVprimeUnits K M g) (checkPsi K M (checkIdx M j₀))
      = Complex.exp (-g (checkIdx M j₀)) • checkPsi K M (checkIdx M j₀) := by
  rw [TConj_apply, checkVprimeUnits_val, checkVprimeUnits_inv, checkVprime]
  exact matExp_conj_eigen (lie_checkX_checkPsi K g hM hga hgconj j₀)

end Ising2D
