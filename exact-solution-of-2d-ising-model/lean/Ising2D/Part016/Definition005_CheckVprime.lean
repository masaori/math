/-
# `V̌'` の定義

対応する人手証明のラベル: `def_check_Vprime`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_005_definition_check_Vprime`）

## 形式化の方針

原文の

    X̌ := Σ_{μ ∈ 𝓜̌} γ(θ̃_μ) (ψ̌_μ^† ψ̌_{M+1-μ} - ½ I),   V̌' := exp(X̌)

を、添字集合 `𝓜̌ = {1,…,M}` を `Fin M` で走らせる形（`checkIdx j := j + 1`）で定義する。

* 重み `γ(θ̃_μ)`（**015 章** `def_gamma_theta_tilde_mu`）は本セッションの担当範囲外なので、
  **任意の関数 `g : ℤ → ℂ` として持つ**。015 章が `γ` を用意したら `g := fun μ => γ(θ̃_μ)`
  と置くだけでよい。原文が使う `γ` の性質は
  `periodicity_of_check_fermi` (3) の `γ(θ̃_{M+1-μ}) = γ(θ̃_μ)` ただ 1 つで、
  これは `Ising2D.Part016.Claim006_ActionTCheckVprime` の仮定 `hgconj` として明示する。
* 原文 (1)（和の範囲に例外が要らないこと）は、`Ising2D.checkIdx_rev`
  （`M+1-checkIdx j = checkIdx (Fin.rev j)`、`Fin.rev` は `Fin M` 上の対合）と
  `Ising2D.checkIndex_checkIdx`（すべての `j : Fin M` で `checkIdx j ∈ 𝓜̌`）に対応する。
  008 章の `def_Vprime` が和を `γ_2(θ_μ) ≠ 0` なる `μ` に限定していたのと違い、
  ここでは `Fin M` 全体を走る（除外は無い）。
* 原文 (2)（`V̌'` の可逆性）は 004 章の `Ising2D.matExpUnits` に帰着する。
-/
import Ising2D.Part016.Claim003_AnticommutatorCheckPsi

namespace Ising2D

variable {M : ℕ}

/-! ## 添字 `𝓜̌ = {1,…,M}` を `Fin M` で走らせる -/

/-- `Fin M` から `𝓜̌ = {1,…,M}` への同一視 `j ↦ j+1`。 -/
def checkIdx (M : ℕ) (j : Fin M) : ℤ := ((j : ℕ) : ℤ) + 1

theorem checkIndex_checkIdx (M : ℕ) (j : Fin M) : CheckIndex M (checkIdx M j) := by
  refine ⟨by simp [checkIdx], ?_⟩
  have : ((j : ℕ) : ℤ) + 1 ≤ (M : ℤ) := by exact_mod_cast j.isLt
  simpa [checkIdx] using this

theorem checkIdx_injective (M : ℕ) : Function.Injective (checkIdx M) := by
  intro i j h
  have : ((i : ℕ) : ℤ) = ((j : ℕ) : ℤ) := by simpa [checkIdx] using h
  exact Fin.ext (by exact_mod_cast this)

/-- **対になる添字は `Fin.rev`**: `M + 1 - checkIdx j = checkIdx (Fin.rev j)`。 -/
theorem checkIdx_rev (M : ℕ) (j : Fin M) :
    (M : ℤ) + 1 - checkIdx M j = checkIdx M (Fin.rev j) := by
  have hlt : (j : ℕ) < M := j.isLt
  rw [checkIdx, checkIdx, Fin.val_rev]
  have : ((M - ((j : ℕ) + 1) : ℕ) : ℤ) = (M : ℤ) - ((j : ℕ) : ℤ) - 1 := by
    have : ((j : ℕ) : ℤ) + 1 ≤ (M : ℤ) := by exact_mod_cast hlt
    omega
  rw [this]
  ring

/-- `checkIdx i = M + 1 - checkIdx j ⟺ i = Fin.rev j`。 -/
theorem checkIdx_eq_rev_iff (M : ℕ) (i j : Fin M) :
    checkIdx M i = (M : ℤ) + 1 - checkIdx M j ↔ i = Fin.rev j := by
  rw [checkIdx_rev]
  exact ⟨fun h => checkIdx_injective M h, fun h => by rw [h]⟩

/-! ## `X̌` と `V̌'`（原文 `def_check_Vprime`） -/

/-- **原文 `def_check_Vprime` の `X̌`**:
`X̌ = Σ_{μ ∈ 𝓜̌} γ(θ̃_μ) (ψ̌_μ^† ψ̌_{M+1-μ} - ½ I)`。 -/
noncomputable def checkX (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) : TensorPow M :=
  ∑ j : Fin M, g (checkIdx M j) •
    (checkPsiDag K M (checkIdx M j) * checkPsi K M ((M : ℤ) + 1 - checkIdx M j)
      - (1 / 2 : ℂ) • (1 : TensorPow M))

/-- **原文 `def_check_Vprime` の `V̌' := exp(X̌)`**。 -/
noncomputable def checkVprime (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) : TensorPow M :=
  matExp (checkX K M g)

/-- **原文 `def_check_Vprime` (2)**: `V̌'` は可逆で `(V̌')^{-1} = exp(-X̌)`。 -/
noncomputable def checkVprimeUnits (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) : (TensorPow M)ˣ :=
  matExpUnits (checkX K M g)

@[simp]
theorem checkVprimeUnits_val (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) :
    ((checkVprimeUnits K M g : (TensorPow M)ˣ) : TensorPow M) = checkVprime K M g := rfl

@[simp]
theorem checkVprimeUnits_inv (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) :
    (((checkVprimeUnits K M g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = matExp (-checkX K M g) := rfl

/-- **原文 `def_check_Vprime` (2)** の `IsUnit` 版。 -/
theorem isUnit_checkVprime (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) :
    IsUnit (checkVprime K M g) :=
  ⟨checkVprimeUnits K M g, rfl⟩

end Ising2D
