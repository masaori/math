/-
# `V̌'` の定義

対応する人手証明のラベル: `def_check_Vprime`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evenfermi_005_definition_check_Vprime`）

## 形式化の方針

原文の

    X̌ := Σ_{μ ∈ 𝓜̌} γ(θ̃_μ) (ψ̌_μ^† ψ̌_{M+1-μ} - ½ I),   V̌' := exp(X̌)

を、添字集合 `𝓜̌ = {1,…,M}` を `Fin M` で走らせる形（人手の `μ` は名前を付けた写像の像 `finIndexToZZ M j`。`def_index_set_from_one_to_n`）で定義する。

* 重み `γ(θ̃_μ)`（章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `def_gamma_theta` の `θ = θ̃_μ` での値）は本セッションの担当範囲外なので、
  **任意の関数 `g : ℤ → ℂ` として持つ**。015 章が `γ` を用意したら `g := fun μ => γ(θ̃_μ)`
  と置くだけでよい。原文が使う `γ` の性質は
  `periodicity_of_check_fermi` (3) の `γ(θ̃_{M+1-μ}) = γ(θ̃_μ)` ただ 1 つで、
  これは `Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimActionTCheckVprime` の仮定 `hgconj` として明示する。
* 原文 (1)（和の範囲に例外が要らないこと）は、`Ising2D.checkIdx_rev`
  （`M+1-finIndexToZZ M j = finIndexToZZ M (Fin.rev j)`、`Fin.rev` は `Fin M` 上の対合）と
  `Ising2D.checkIndex_checkIdx`（すべての `j : Fin M` で `finIndexToZZ M j ∈ 𝓜̌`）に対応する。
  008 章の `def_Vprime` が和を `γ_2(θ_μ) ≠ 0` なる `μ` に限定していたのと違い、
  ここでは `Fin M` 全体を走る（除外は無い）。
* 原文 (2)（`V̌'` の可逆性）は 004 章の `Ising2D.matExpUnits` に帰着する。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimAnticommutatorCheckPsi
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionH1H2V1V2

namespace Ising2D

variable {M : ℕ}

/-! ## 添字 `𝓜̌ = {1,…,M}` を `Fin M` で走らせる

人手の和の添字 `μ ∈ 𝓜̌ = {1,…,M}` と Lean の `j : Fin M` の行き来は、名前を付けた写像 `finIndexToZZ M`
（`def_index_set_from_one_to_n`）だけを通す。`checkIndex_checkIdx` と `checkIdx_rev` は原文 (1) に対応し（冒頭の説明）、
`checkIdx_eq_rev_iff` は `checkIdx_rev` と写像の単射（`finIndexToZZ_bijective_onto_index_set` の一つ目）から従う Lean だけの段の補題である。
名前の `checkIdx` は `𝓜̌` の添字を指す（この名前の定義は無い）。名前は、未定義の記号の台帳
`lean/mathlib-symbols-undefined-in-text-ledger.txt` の行（`checkIdx_rev`・`checkIdx_eq_rev_iff` の `Fin.rev`）に合わせて残す。
台帳の行は減らすだけなので、改名すると新しい行が増えるためである。 -/

/-- `finIndexToZZ M j ∈ 𝓜̌`（`finIndexToZZ_bijective_onto_index_set` の値の範囲を `def_check_index_set` の形へ移す）。 -/
theorem checkIndex_checkIdx (M : ℕ) (j : Fin M) : CheckIndex M (finIndexToZZ M j) := by
  obtain ⟨h1, h2⟩ := (finIndexToZZ_bijective_onto_index_set M).2.1 j
  rw [inclusionNNtoZZ_eq_natCast] at h2
  exact ⟨h1, h2⟩

/-- **対になる添字は `Fin.rev`**: `M + 1 - finIndexToZZ M j = finIndexToZZ M (Fin.rev j)`。 -/
theorem checkIdx_rev (M : ℕ) (j : Fin M) :
    (M : ℤ) + 1 - finIndexToZZ M j = finIndexToZZ M (Fin.rev j) := by
  have hlt : (j : ℕ) < M := j.isLt
  simp only [finIndexToZZ, inclusionNNtoZZ_eq_natCast, Fin.val_rev]
  omega

/-- `finIndexToZZ M i = M + 1 - finIndexToZZ M j ⟺ i = Fin.rev j`。 -/
theorem checkIdx_eq_rev_iff (M : ℕ) (i j : Fin M) :
    finIndexToZZ M i = (M : ℤ) + 1 - finIndexToZZ M j ↔ i = Fin.rev j := by
  rw [checkIdx_rev]
  exact ⟨fun h => (finIndexToZZ_bijective_onto_index_set M).1 _ _ h, fun h => by rw [h]⟩

/-! ## `X̌` と `V̌'`（原文 `def_check_Vprime`） -/

/-- **原文 `def_check_Vprime` の `X̌`**:
`X̌ = Σ_{μ ∈ 𝓜̌} γ(θ̃_μ) (ψ̌_μ^† ψ̌_{M+1-μ} - ½ I)`。 -/
noncomputable def checkX (K : IsingConst) (M : ℕ) (g : ℤ → ℂ) : TensorPow M :=
  ∑ j : Fin M, g (finIndexToZZ M j) •
    (checkPsiDag K M (finIndexToZZ M j) * checkPsi K M ((M : ℤ) + 1 - finIndexToZZ M j)
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
