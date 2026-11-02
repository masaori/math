/-
# 半整数運動量の数演算子 `ň_μ`（**具体版**）

対応する人手証明（`def_check_number_operator` は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`、ほかは `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
- `def_check_number_operator`（`evenEigen_001_definition_check_number_operator`）
- `check_number_operator_idempotent`（`evenEigen_002_claim_...`）
- `check_number_operators_commute`（`evenEigen_003_claim_...`）

**必要十分版**は `Ising2D/NecSuf/NumberOperator.lean`（章 009 と共通）と
`Ising2D/NecSuf/PairedFermion.lean`（対をなす添字の対合）。
`check_number_operator_idempotent` の `cre_add_self_eq_zero`・`cre_sq`・`ann_add_self_eq_zero`・`ann_sq`（(1)）、
`cre_ann_add_ann_cre_eq_one`・`ann_mul_cre`（(2)）、`nOp_sq`・`nOp_mul_self`（(3)）と、`check_number_operators_commute` の
`mul_nOp_of_anticommute`・`commute_cre_nOp`・`commute_ann_nOp`・`nOp_mul_nOp_of_ne` は、人手の鎖と 1 対 1 の具体版である。
同じ主張を必要十分版の特殊化として得たものを `*_of_necSuf` の名前で並べて置く。

## 章 009 との関係（本章の要点）

章 009 の `n_μ = ψ_μ^† ψ_{-μ}` と本章の `ň_μ = ψ̌_μ^† ψ̌_{M+1-μ}` は、
**同じ必要十分版（`NecSuf.num`）の別の特殊化**である。違いは
「対をなす添字を与える単射 `σ`」だけで、章 009 では `σ(μ) = -μ`、
本章では `σ(μ) = M+1-μ` である（`Ising2D/NecSuf/PairedFermion.lean` 冒頭）。

**決定的な違いは添字集合の同定にある。** 章 009 の `FermiSetup` は
「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` となる有限集合 `I`」を**仮定として**
受け取り、臨界点では `|I| = M-1` になりえた（原文 `gamma_2_theta_is_0`）。
半整数運動量では `γ_2(θ~_μ) ≠ 0` が例外なく成り立つ（原文
`gamma_2_theta_tilde_nonzero`）ので、**添字集合は無条件に
`𝓜̌ = {1,…,M}` に確定する**。本ファイルの `CheckIdx M` はその確定した集合であり、
仮定として受け取る余地は無い。この 1 点が、章 009 で言えなかった
`tr(Q̌_ε) = 1`（同時固有空間が 1 次元）と最大固有値の単純性を可能にする。

## 他章への依存（仮定として受け取るもの）

`ψ̌_μ^†`, `ψ̌_μ` の定義（章 015 `def_check_fermi`）とその反交換関係
（章 015 `anticommutator_of_check_psi`）は**並行して形式化中**なので、
本章では `CheckFermiSetup` の場（フィールド）として受け取る。
受け取るのは次の 3 本だけである（`μ, ν ∈ 𝓜̌`）:

  `[ψ̌_μ^†, ψ̌_ν^†]_+ = 0`,
  `[ψ̌_μ^†, ψ̌_ν]_+ = δ_{ν, M+1-μ} I`,
  `[ψ̌_μ, ψ̌_ν]_+ = 0`.
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionCheckIndexSet
import Ising2D.NecSuf.PairedFermion
import Ising2D.NecSuf.NumberOperator
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDoubleNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroMatrixProductAndSumEquationsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionMatrixAnticommutator
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixEqualsNegationIfSumIsZeroFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf

namespace Ising2D

open Matrix

/-! ## 添字集合 `𝓜̌ = {1,…,M}` -/

/-- 原文 `def_check_index_set` の `𝓜̌ = {1,…,M}` を `Finset ℤ` として
（`{1,…,M}` を `{0,…,M-1}` の像として作ると、後段の和の付け替えがそのまま使える）。 -/
def checkIdxFinset (M : ℕ) : Finset ℤ := (Finset.range M).image (fun k : ℕ => (k : ℤ) + 1)

theorem checkIdxFinset_injOn : Function.Injective (fun k : ℕ => (k : ℤ) + 1) := by
  intro a b h
  have h' : (a : ℤ) + 1 = (b : ℤ) + 1 := h
  omega

theorem mem_checkIdxFinset {M : ℕ} {μ : ℤ} : μ ∈ checkIdxFinset M ↔ CheckIndex M μ := by
  simp only [checkIdxFinset, Finset.mem_image, Finset.mem_range, CheckIndex]
  constructor
  · rintro ⟨k, hk, rfl⟩
    omega
  · rintro ⟨h1, h2⟩
    exact ⟨(μ - 1).toNat, by omega, by omega⟩

theorem checkIdxFinset_card (M : ℕ) : (checkIdxFinset M).card = M := by
  rw [checkIdxFinset, Finset.card_image_of_injective _ checkIdxFinset_injOn, Finset.card_range]

/-- 原文の添字 `μ ∈ 𝓜̌` を型として。 -/
def CheckIdx (M : ℕ) : Type := {μ : ℤ // μ ∈ checkIdxFinset M}

namespace CheckIdx

instance (M : ℕ) : Fintype (CheckIdx M) := FinsetCoe.fintype _
instance (M : ℕ) : DecidableEq (CheckIdx M) := Subtype.instDecidableEq
instance (M : ℕ) : CoeOut (CheckIdx M) ℤ := ⟨Subtype.val⟩

theorem prop' {M : ℕ} (i : CheckIdx M) : CheckIndex M i.1 := mem_checkIdxFinset.1 i.2

/-- **`|𝓜̌| = M`**。章 009 の `|I| ≤ M`（等号は言えない）との違いがここに出る。 -/
theorem card (M : ℕ) : Fintype.card (CheckIdx M) = M := by
  have h : Fintype.card (CheckIdx M) = (checkIdxFinset M).card := Fintype.card_coe _
  rw [h, checkIdxFinset_card]

end CheckIdx

/-- **原文 `def_check_number_operator` (1) の共役添字** `μ ↦ M+1-μ`。 -/
def conjIdx (M : ℕ) (i : CheckIdx M) : CheckIdx M :=
  ⟨(M : ℤ) + 1 - i.1, by
    obtain ⟨h1, h2⟩ := CheckIdx.prop' i
    rw [mem_checkIdxFinset]
    exact ⟨by omega, by omega⟩⟩

@[simp]
theorem conjIdx_val {M : ℕ} (i : CheckIdx M) : (conjIdx M i).1 = (M : ℤ) + 1 - i.1 := rfl

/-- `j = M+1-i` を成分の等式として書き直したもの（`if` の条件の突き合わせに使う）。 -/
theorem conjIdx_eq_iff {M : ℕ} (i j : CheckIdx M) :
    j = conjIdx M i ↔ j.1 = (M : ℤ) + 1 - i.1 := by
  constructor
  · intro h; rw [h]; rfl
  · intro h; exact Subtype.ext h

/-- **原文 `def_check_number_operator` (1)**: `μ ↦ M+1-μ` は `𝓜̌` 上の対合。 -/
theorem conjIdx_involutive (M : ℕ) : Function.Involutive (conjIdx M) := by
  intro i
  apply Subtype.ext
  simp

theorem conjIdx_injective (M : ℕ) : Function.Injective (conjIdx M) :=
  (conjIdx_involutive M).injective

/-! ## `Mat(2^M, ℂ)` に 2-捩れが無いこと（原文 `check_number_operator_idempotent` (1) で使う） -/

/-- `Mat(2^M, ℂ)` の `x` について `x + x = 0` なら `x = 0`。人手 `matrix_sum_with_itself_zero_implies_zero` の
`TensorPow M` の系 `eq_zero_of_add_self_eq_zero_tensorPow` の別名である。
必要十分版 `NecSuf.sq_eq_zero_of_acomm_self`・`NecSuf.num_mul_num` が、環の公理と反交換関係のほかに仮定する唯一の性質である。 -/
theorem tensorPow_two_torsion_free {M : ℕ} (x : TensorPow M) (h : x + x = 0) : x = 0 :=
  eq_zero_of_add_self_eq_zero_tensorPow x h

/-! ## 原文 `def_check_fermi` / `anticommutator_of_check_psi` の受け取り -/

/-- 章 015 の `ψ̌_μ^†`, `ψ̌_μ` とその反交換関係（`μ, ν ∈ 𝓜̌`）をまとめたもの。

**章 009 の `FermiSetup` と違い、添字集合を仮定として受け取っていない**
（半整数運動量では `γ_2(θ~_μ) ≠ 0` が例外なく成り立つので `𝓜̌ = {1,…,M}` に確定する）。 -/
structure CheckFermiSetup (M : ℕ) where
  hM : M ≠ 0
  psiDag : ℤ → TensorPow M
  psi : ℤ → TensorPow M
  hcc : ∀ μ ν : ℤ, CheckIndex M μ → CheckIndex M ν →
    psiDag μ * psiDag ν + psiDag ν * psiDag μ = 0
  haa : ∀ μ ν : ℤ, CheckIndex M μ → CheckIndex M ν →
    psi μ * psi ν + psi ν * psi μ = 0
  hca : ∀ μ ν : ℤ, CheckIndex M μ → CheckIndex M ν →
    psiDag μ * psi ν + psi ν * psiDag μ = if ν = (M : ℤ) + 1 - μ then (1 : TensorPow M) else 0

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- `𝓜̌` へ制限した生成演算子。 -/
noncomputable def cre (i : CheckIdx M) : TensorPow M := F.psiDag i.1

/-- `𝓜̌` へ制限した消滅演算子（付け替え前）。 -/
noncomputable def annRaw (i : CheckIdx M) : TensorPow M := F.psi i.1

/-- 共役添字で付け替えた消滅演算子 `ψ̌_{M+1-μ}`（必要十分版 `NecSuf.annPaired` の特殊化）。 -/
noncomputable def ann (i : CheckIdx M) : TensorPow M :=
  NecSuf.annPaired F.annRaw (conjIdx M) i

theorem ann_def (i : CheckIdx M) : F.ann i = F.psi ((M : ℤ) + 1 - i.1) := rfl

/-- **原文 `def_check_number_operator` の形式化**: `ň_μ := ψ̌_μ^† ψ̌_{M+1-μ}`。 -/
noncomputable def nOp (i : CheckIdx M) : TensorPow M := NecSuf.num F.cre F.ann i

theorem nOp_def (i : CheckIdx M) : F.nOp i = F.cre i * F.ann i := rfl

/-- `ň_μ` を原文の記法のまま書いたもの。 -/
theorem nOp_eq (i : CheckIdx M) : F.nOp i = F.psiDag i.1 * F.psi ((M : ℤ) + 1 - i.1) := rfl

/-- `ň_μ` が必要十分版 `NecSuf.numPaired`（対合 `σ` で対をなす個数演算子）の特殊化であること。 -/
theorem nOp_eq_numPaired (i : CheckIdx M) :
    F.nOp i = NecSuf.numPaired F.cre F.annRaw (conjIdx M) i := rfl

/-! ## 正準反交換関係（原文 `anticommutator_of_check_psi` の `𝓜̌` への制限） -/

theorem acomm_cre_cre (i j : CheckIdx M) : F.cre i * F.cre j + F.cre j * F.cre i = 0 :=
  F.hcc _ _ (CheckIdx.prop' i) (CheckIdx.prop' j)

theorem acomm_ann_ann (i j : CheckIdx M) : F.ann i * F.ann j + F.ann j * F.ann i = 0 :=
  F.haa ((M : ℤ) + 1 - i.1) ((M : ℤ) + 1 - j.1)
    (CheckIdx.prop' (conjIdx M i)) (CheckIdx.prop' (conjIdx M j))

/-- **本章の要点（`check_number_operator_idempotent` (2) と
`check_number_operators_commute` Step 1）**:
原文の `δ_{ν, M+1-μ}` は、消滅演算子を共役添字で付け替えると
Kronecker のデルタ `δ_{μν}` になる。**合同式の書き換えは要らない。** -/
theorem acomm_cre_ann (i j : CheckIdx M) :
    F.cre i * F.ann j + F.ann j * F.cre i = if i = j then (1 : TensorPow M) else 0 := by
  have hca : ∀ i j : CheckIdx M,
      F.cre i * F.annRaw j + F.annRaw j * F.cre i
        = if j = conjIdx M i then (1 : TensorPow M) else 0 := by
    intro i j
    have h : F.cre i * F.annRaw j + F.annRaw j * F.cre i
        = if j.1 = (M : ℤ) + 1 - i.1 then (1 : TensorPow M) else 0 :=
      F.hca i.1 j.1 (CheckIdx.prop' i) (CheckIdx.prop' j)
    rw [h]
    by_cases hj : j.1 = (M : ℤ) + 1 - i.1
    · rw [if_pos hj, if_pos ((conjIdx_eq_iff i j).2 hj)]
    · rw [if_neg hj, if_neg (fun hc => hj ((conjIdx_eq_iff i j).1 hc))]
  have h := NecSuf.acomm_cre_ann_comp F.cre F.annRaw (conjIdx_injective M) hca i j
  show F.cre i * NecSuf.annPaired F.annRaw (conjIdx M) j
      + NecSuf.annPaired F.annRaw (conjIdx M) j * F.cre i = _
  rw [h]
  by_cases hij : i = j
  · rw [if_pos hij, if_pos hij.symm]
  · rw [if_neg hij, if_neg (Ne.symm hij)]

theorem acomm_cre_ann_self (i : CheckIdx M) : F.cre i * F.ann i + F.ann i * F.cre i = 1 := by
  simpa using F.acomm_cre_ann i i

/-! ## 原文 `check_number_operator_idempotent` -/

/-- **原文 `check_number_operator_idempotent` (1)** の第 1 の鎖: `ψ̌_μ^†ψ̌_μ^† + ψ̌_μ^†ψ̌_μ^† = [ψ̌_μ^†, ψ̌_μ^†]_+ = O`。 -/
theorem cre_add_self_eq_zero (i : CheckIdx M) : F.cre i * F.cre i + F.cre i * F.cre i = 0 :=
  calc F.cre i * F.cre i + F.cre i * F.cre i
      = matAnticomm (F.cre i) (F.cre i) := rfl     -- `def_matrix_anticommutator` を右辺から左辺へ
    _ = 0 := F.acomm_cre_cre i i                   -- `anticommutator_of_check_psi` の第 1 式（`ν → μ`）

/-- **原文 `check_number_operator_idempotent` (1)**: `ψ̌_μ^†ψ̌_μ^† = O`（`matrix_sum_with_itself_zero_implies_zero`）。 -/
theorem cre_sq (i : CheckIdx M) : F.cre i * F.cre i = 0 :=
  eq_zero_of_add_self_eq_zero_tensorPow _ (F.cre_add_self_eq_zero i)

/-- **原文 `check_number_operator_idempotent` (1)** の第 2 の鎖:
`ψ̌_{M+1-μ}ψ̌_{M+1-μ} + ψ̌_{M+1-μ}ψ̌_{M+1-μ} = [ψ̌_{M+1-μ}, ψ̌_{M+1-μ}]_+ = O`。 -/
theorem ann_add_self_eq_zero (i : CheckIdx M) : F.ann i * F.ann i + F.ann i * F.ann i = 0 :=
  calc F.ann i * F.ann i + F.ann i * F.ann i
      = matAnticomm (F.ann i) (F.ann i) := rfl     -- `def_matrix_anticommutator` を右辺から左辺へ
    _ = 0 := F.acomm_ann_ann i i                   -- `anticommutator_of_check_psi` の第 3 式（`μ, ν → M+1-μ`）

/-- **原文 `check_number_operator_idempotent` (1)**: `ψ̌_{M+1-μ}ψ̌_{M+1-μ} = O`（`matrix_sum_with_itself_zero_implies_zero`）。 -/
theorem ann_sq (i : CheckIdx M) : F.ann i * F.ann i = 0 :=
  eq_zero_of_add_self_eq_zero_tensorPow _ (F.ann_add_self_eq_zero i)

/-- **原文 `check_number_operator_idempotent` (2)** の第 1 の鎖:
`ψ̌_μ^†ψ̌_{M+1-μ} + ψ̌_{M+1-μ}ψ̌_μ^† = [ψ̌_μ^†, ψ̌_{M+1-μ}]_+ = δ I = 1_ℂ I = I`。
`CheckFermiSetup` は反交換関係の右辺 `δ I` を `if … then I else O` の形で受け取っている（`acomm_cre_ann` は対の添字を
付け替えた後の形）。このため人手の `δ_{M+1-μ, M+1-μ} = 1_ℂ`（`def_kronecker_delta`）と `1_ℂ I = I`（`scalar_multiple_by_one`）の
2 行は、`if` の条件が成り立つことによる 1 段（`if_pos rfl`）になる。 -/
theorem cre_ann_add_ann_cre_eq_one (i : CheckIdx M) : F.cre i * F.ann i + F.ann i * F.cre i = 1 :=
  calc F.cre i * F.ann i + F.ann i * F.cre i
      = matAnticomm (F.cre i) (F.ann i) := rfl              -- `def_matrix_anticommutator` を右辺から左辺へ
    _ = (if i = i then (1 : TensorPow M) else 0) := F.acomm_cre_ann i i
                                                            -- `anticommutator_of_check_psi` の第 2 式（`ν → M+1-μ`）
    _ = 1 := if_pos rfl                                     -- `def_kronecker_delta` の `i = j` の場合と `scalar_multiple_by_one`

/-- **原文 `check_number_operator_idempotent` (2)**: `ψ̌_{M+1-μ} ψ̌_μ^† = I - ň_μ`。人手の 2 行の鎖と 1 対 1。 -/
theorem ann_mul_cre (i : CheckIdx M) : F.ann i * F.cre i = 1 - F.nOp i :=
  calc F.ann i * F.cre i
      = 1 - F.cre i * F.ann i := eq_sub_of_add_eq_tensorPow _ _ _ (F.cre_ann_add_ann_cre_eq_one i)
                                                            -- `matrix_summand_from_sum_equation` と直前の鎖
    _ = 1 - F.nOp i := rfl                                  -- `ň_μ` の定義（`def_check_number_operator`）

/-- `cre_sq` を必要十分版 `NecSuf.sq_eq_zero_of_acomm_self` の特殊化として得る。 -/
theorem cre_sq_of_necSuf (i : CheckIdx M) : F.cre i * F.cre i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_cre_cre i i)

/-- `ann_sq` を必要十分版 `NecSuf.sq_eq_zero_of_acomm_self` の特殊化として得る。 -/
theorem ann_sq_of_necSuf (i : CheckIdx M) : F.ann i * F.ann i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_ann_ann i i)

/-- `ann_mul_cre` を必要十分版 `NecSuf.ann_mul_cre` の特殊化として得る。 -/
theorem ann_mul_cre_of_necSuf (i : CheckIdx M) : F.ann i * F.cre i = 1 - F.nOp i :=
  NecSuf.ann_mul_cre F.cre F.ann i (F.acomm_cre_ann_self i)

/-- **原文 `check_number_operator_idempotent` (3)** の鎖のうち、`ň_μň_μ` から `ň_μ` までの 19 行と 1 対 1 に書く。
冪を積へ運ぶ先頭の 4 行は `nOp_sq`。 -/
theorem nOp_mul_self (i : CheckIdx M) : F.nOp i * F.nOp i = F.nOp i :=
  calc F.nOp i * F.nOp i
      = (F.cre i * F.ann i) * (F.cre i * F.ann i) := rfl
                                                        -- `ň_μ` の定義（`def_check_number_operator`）
    _ = F.cre i * (F.ann i * (F.cre i * F.ann i)) := Matrix.mul_assoc _ _ _
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
    _ = F.cre i * ((F.ann i * F.cre i) * F.ann i) := by
          rw [Matrix.mul_assoc (F.ann i) (F.cre i) (F.ann i)]
                                                        -- `mat_mult_associative` を右辺から左辺へ
    _ = F.cre i * ((1 - F.nOp i) * F.ann i) := by rw [F.ann_mul_cre i]
                                                        -- (2)
    _ = F.cre i * ((1 + (-F.nOp i)) * F.ann i) := by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.cre i * (1 * F.ann i + (-F.nOp i) * F.ann i) := by rw [add_mul_matrix_tensorPow]
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = F.cre i * (F.ann i + (-F.nOp i) * F.ann i) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = F.cre i * (F.ann i + (-(F.nOp i * F.ann i))) := by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor`
    _ = F.cre i * F.ann i + F.cre i * (-(F.nOp i * F.ann i)) := mul_add_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = F.cre i * F.ann i + (-(F.cre i * (F.nOp i * F.ann i))) := by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor`
    _ = F.cre i * F.ann i - F.cre i * (F.nOp i * F.ann i) := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = F.nOp i - F.cre i * (F.nOp i * F.ann i) := rfl
                                                        -- `ň_μ` の定義
    _ = F.nOp i - F.cre i * ((F.cre i * F.ann i) * F.ann i) := rfl
                                                        -- `ň_μ` の定義
    _ = F.nOp i - F.cre i * (F.cre i * (F.ann i * F.ann i)) := by
          rw [Matrix.mul_assoc (F.cre i) (F.ann i) (F.ann i)]
                                                        -- `mat_mult_associative`
    _ = F.nOp i - (F.cre i * F.cre i) * (F.ann i * F.ann i) := by
          rw [← Matrix.mul_assoc (F.cre i) (F.cre i) (F.ann i * F.ann i)]
                                                        -- `mat_mult_associative` を右辺から左辺へ
    _ = F.nOp i - 0 * (F.ann i * F.ann i) := by rw [F.cre_sq i]
                                                        -- (1) の第 1 式
    _ = F.nOp i - 0 * 0 := by rw [F.ann_sq i]           -- (1) の第 2 式
    _ = F.nOp i - 0 := by rw [zero_matrix_mul_tensorPow]
                                                        -- `zero_matrix_is_left_zero_of_mat_mult`（`B → O`）
    _ = F.nOp i := matrix_sub_zero_matrix_tensorPow _   -- `matrix_minus_zero_matrix`

/-- **原文 `check_number_operator_idempotent` (3)**: `ň_μ^2 = ň_μ`。人手の鎖の先頭の 4 行（`def_exp` (1) の冪を積へ運ぶ）と、
続く `nOp_mul_self` の 19 行。 -/
theorem nOp_sq (i : CheckIdx M) : F.nOp i ^ 2 = F.nOp i :=
  calc F.nOp i ^ 2
      = F.nOp i ^ 1 * F.nOp i := pow_succ _ _           -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 1`）
    _ = (F.nOp i ^ 0 * F.nOp i) * F.nOp i := by rw [pow_succ (F.nOp i) 0]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 0`）
    _ = (1 * F.nOp i) * F.nOp i := by rw [pow_zero]     -- `def_exp` (1) の `A^0 := I`
    _ = F.nOp i * F.nOp i := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = F.nOp i := F.nOp_mul_self i                     -- 続く 19 行（`nOp_mul_self`）

/-- `nOp_mul_self` を必要十分版 `NecSuf.num_mul_num` の特殊化として得る。 -/
theorem nOp_mul_self_of_necSuf (i : CheckIdx M) : F.nOp i * F.nOp i = F.nOp i :=
  NecSuf.num_mul_num F.cre F.ann i tensorPow_two_torsion_free
    (F.acomm_cre_cre i i) (F.acomm_ann_ann i i) (F.acomm_cre_ann_self i)

/-! ## 原文 `check_number_operators_commute` -/

/-- **原文 `check_number_operators_commute` Step 2 の鎖**: `X ψ̌_ν^† = -(ψ̌_ν^† X)` と
`X ψ̌_{M+1-ν} = -(ψ̌_{M+1-ν} X)`（Step 1）から `X ň_ν = ň_ν X`。人手の 10 行と 1 対 1。
必要十分版の対応は `NecSuf.commute_mul_of_anticommute`。 -/
theorem mul_nOp_of_anticommute (X : TensorPow M) (j : CheckIdx M)
    (hD : X * F.cre j = -(F.cre j * X)) (hP : X * F.ann j = -(F.ann j * X)) :
    X * F.nOp j = F.nOp j * X :=
  calc X * F.nOp j
      = X * (F.cre j * F.ann j) := rfl                  -- `ň_ν` の定義
    _ = (X * F.cre j) * F.ann j := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative` を右辺から左辺へ
    _ = (-(F.cre j * X)) * F.ann j := by rw [hD]        -- Step 1 の `Xψ̌_ν^† = -(ψ̌_ν^†X)`
    _ = -((F.cre j * X) * F.ann j) := neg_mul_matrix_tensorPow _ _
                                                        -- `negation_factors_out_of_left_factor`
    _ = -(F.cre j * (X * F.ann j)) := by rw [Matrix.mul_assoc (F.cre j) X (F.ann j)]
                                                        -- `mat_mult_associative`
    _ = -(F.cre j * (-(F.ann j * X))) := by rw [hP]     -- Step 1 の `Xψ̌_{M+1-ν} = -(ψ̌_{M+1-ν}X)`
    _ = -(-(F.cre j * (F.ann j * X))) := by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor`
    _ = F.cre j * (F.ann j * X) := neg_neg_tensorPow _  -- `matrix_double_negation`
    _ = (F.cre j * F.ann j) * X := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative` を右辺から左辺へ
    _ = F.nOp j * X := rfl                              -- `ň_ν` の定義

/-- **原文 `check_number_operators_commute` Step 1** の第 1 式: `[ψ̌_μ^†, ψ̌_ν^†]_+ = O`。 -/
theorem anticomm_cre_cre_eq_zero (i j : CheckIdx M) : matAnticomm (F.cre i) (F.cre j) = 0 :=
  F.acomm_cre_cre i j                                   -- `anticommutator_of_check_psi` の第 1 式

/-- `CheckFermiSetup` が反交換関係の右辺 `δ I` を受け取る形 `if c then I else O` を、人手の `δ I`（係数 `δ ∈ ℂ` のスカラー倍）へ読み替える。
人手の式には現れない、場の形と人手の記法をつなぐ段である。 -/
theorem ite_one_zero_eq_delta_smul (c : Prop) [Decidable c] :
    (if c then (1 : TensorPow M) else 0) = (if c then (1 : ℂ) else 0) • (1 : TensorPow M) := by
  by_cases hc : c
  · rw [if_pos hc, if_pos hc, one_smul]       -- `scalar_multiple_by_one`（`TensorPow M` の系が無いので mathlib の `one_smul`）
  · rw [if_neg hc, if_neg hc, zero_smul_tensorPow]
                                              -- `zero_scalar_multiple_is_zero_matrix`

/-- **原文 `check_number_operators_commute` Step 1** の第 2 式（`μ ≠ ν`）: `[ψ̌_μ^†, ψ̌_{M+1-ν}]_+ = δ I = 0_ℂ I = O`。
`CheckFermiSetup` は右辺の `δ_{M+1-ν, M+1-μ}` を付け替え後の `δ_{μ,ν}`（`if μ = ν`）で受け取る（`acomm_cre_ann`）。
付け替え `δ_{M+1-ν, M+1-μ} = δ_{μ,ν}` は人手の直前の `δ` の計算の 1 行目で、`acomm_cre_ann` の中で済んでいる。 -/
theorem anticomm_cre_ann_eq_zero {i j : CheckIdx M} (hij : i ≠ j) :
    matAnticomm (F.cre i) (F.ann j) = 0 :=
  calc matAnticomm (F.cre i) (F.ann j)
      = (if i = j then (1 : ℂ) else 0) • (1 : TensorPow M) := by
          rw [← ite_one_zero_eq_delta_smul]; exact F.acomm_cre_ann i j
                                                        -- `anticommutator_of_check_psi` の第 2 式（`ν → M+1-ν`）
    _ = (0 : ℂ) • (1 : TensorPow M) := by rw [if_neg hij]
                                                        -- 直前の `δ` の計算（`μ ≠ ν`）
    _ = 0 := zero_smul_tensorPow _                      -- `zero_scalar_multiple_is_zero_matrix`（`A → I`）

/-- **原文 `check_number_operators_commute` Step 1** の第 3 式（`μ ≠ ν`）: 人手の 7 行の鎖
`[ψ̌_{M+1-μ}, ψ̌_ν^†]_+ = ψ̌_{M+1-μ}ψ̌_ν^† + ψ̌_ν^†ψ̌_{M+1-μ} = ψ̌_ν^†ψ̌_{M+1-μ} + ψ̌_{M+1-μ}ψ̌_ν^† = [ψ̌_ν^†, ψ̌_{M+1-μ}]_+
= δ_{M+1-μ, M+1-ν} I = δ_{M+1-ν, M+1-μ} I = 0_ℂ I = O`。`δ` は付け替え後の `δ_{ν,μ}`・`δ_{μ,ν}`（`if j = i`・`if i = j`）で持つ。 -/
theorem anticomm_ann_cre_eq_zero {i j : CheckIdx M} (hij : i ≠ j) :
    matAnticomm (F.ann i) (F.cre j) = 0 :=
  calc matAnticomm (F.ann i) (F.cre j)
      = F.ann i * F.cre j + F.cre j * F.ann i := rfl    -- `def_matrix_anticommutator`
    _ = F.cre j * F.ann i + F.ann i * F.cre j := add_comm_tensorPow _ _
                                                        -- `matrix_sum_is_commutative`
    _ = matAnticomm (F.cre j) (F.ann i) := rfl          -- `def_matrix_anticommutator` を右辺から左辺へ
    _ = (if j = i then (1 : ℂ) else 0) • (1 : TensorPow M) := by
          rw [← ite_one_zero_eq_delta_smul]; exact F.acomm_cre_ann j i
                                                        -- `anticommutator_of_check_psi` の第 2 式（`μ → ν`, `ν → M+1-μ`）
    _ = (if i = j then (1 : ℂ) else 0) • (1 : TensorPow M) := by
          simp only [eq_comm]
                                                        -- `def_kronecker_delta`（`i = j` と `j = i` は同値）
    _ = (0 : ℂ) • (1 : TensorPow M) := by rw [if_neg hij]
                                                        -- 直前の `δ` の計算（`μ ≠ ν`）
    _ = 0 := zero_smul_tensorPow _                      -- `zero_scalar_multiple_is_zero_matrix`（`A → I`）

/-- **原文 `check_number_operators_commute` Step 1** の第 4 式: `[ψ̌_{M+1-μ}, ψ̌_{M+1-ν}]_+ = O`。 -/
theorem anticomm_ann_ann_eq_zero (i j : CheckIdx M) : matAnticomm (F.ann i) (F.ann j) = 0 :=
  F.acomm_ann_ann i j                                   -- `anticommutator_of_check_psi` の第 3 式

/-- **原文 `check_number_operators_commute` Step 1** の結論: `[X, W]_+ = O` なら `XW = -(WX)`。
人手の 2 行の鎖 `XW + WX = [X, W]_+ = O` と、`matrix_equals_negation_if_sum_is_zero`（`X → XW`, `Y → WX`）。 -/
theorem mul_eq_neg_of_anticomm_eq_zero (X W : TensorPow M) (h : matAnticomm X W = 0) :
    X * W = -(W * X) :=
  eq_neg_of_add_eq_zero_tensorPow (X * W) (W * X)
    (calc X * W + W * X
        = matAnticomm X W := rfl                        -- `def_matrix_anticommutator` を右辺から左辺へ
      _ = 0 := h)                                       -- 上の 4 式のうち `[X, W]_+` を左辺に持つ式
                                                        -- 外側: `matrix_equals_negation_if_sum_is_zero`

/-- **原文 `check_number_operators_commute` (1)** 前半: `X = ψ̌_μ^†` で Step 2 の鎖を使う。
Step 1 の `Xψ̌_ν^† = -(ψ̌_ν^†X)`・`Xψ̌_{M+1-ν} = -(ψ̌_{M+1-ν}X)` は `mul_eq_neg_of_anticomm_eq_zero` に第 1 式・第 2 式を渡す。 -/
theorem commute_cre_nOp {i j : CheckIdx M} (hij : i ≠ j) :
    F.cre i * F.nOp j = F.nOp j * F.cre i :=
  F.mul_nOp_of_anticommute (F.cre i) j
    (mul_eq_neg_of_anticomm_eq_zero _ _ (F.anticomm_cre_cre_eq_zero i j))
    (mul_eq_neg_of_anticomm_eq_zero _ _ (F.anticomm_cre_ann_eq_zero hij))

/-- **原文 `check_number_operators_commute` (1)** 後半: `X = ψ̌_{M+1-μ}` で Step 2 の鎖を使う。
Step 1 の 2 式は `mul_eq_neg_of_anticomm_eq_zero` に第 3 式・第 4 式を渡す。 -/
theorem commute_ann_nOp {i j : CheckIdx M} (hij : i ≠ j) :
    F.ann i * F.nOp j = F.nOp j * F.ann i :=
  F.mul_nOp_of_anticommute (F.ann i) j
    (mul_eq_neg_of_anticomm_eq_zero _ _ (F.anticomm_ann_cre_eq_zero hij))
    (mul_eq_neg_of_anticomm_eq_zero _ _ (F.anticomm_ann_ann_eq_zero i j))

/-- **原文 `check_number_operators_commute` (2)** の Step 3 の鎖（`μ ≠ ν`）。人手の 7 行と 1 対 1。 -/
theorem nOp_mul_nOp_of_ne {i j : CheckIdx M} (hij : i ≠ j) :
    F.nOp i * F.nOp j = F.nOp j * F.nOp i :=
  calc F.nOp i * F.nOp j
      = (F.cre i * F.ann i) * F.nOp j := rfl            -- `ň_μ` の定義
    _ = F.cre i * (F.ann i * F.nOp j) := Matrix.mul_assoc _ _ _
                                                        -- `mat_mult_associative`
    _ = F.cre i * (F.nOp j * F.ann i) := by rw [F.commute_ann_nOp hij]
                                                        -- (1) を `X = ψ̌_{M+1-μ}` に適用
    _ = (F.cre i * F.nOp j) * F.ann i := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative` を右辺から左辺へ
    _ = (F.nOp j * F.cre i) * F.ann i := by rw [F.commute_cre_nOp hij]
                                                        -- (1) を `X = ψ̌_μ^†` に適用
    _ = F.nOp j * (F.cre i * F.ann i) := Matrix.mul_assoc _ _ _
                                                        -- `mat_mult_associative`
    _ = F.nOp j * F.nOp i := rfl                        -- `ň_μ` の定義

/-- **原文 `check_number_operators_commute` (2)**: `ň_μ ň_ν = ň_ν ň_μ`。
人手は `μ ≠ ν` について述べる。`μ = ν` は両辺が同じ行列なので自明（`Commute.refl`）で、使う側の型のために足している。 -/
theorem commute_nOp_nOp (i j : CheckIdx M) : Commute (F.nOp i) (F.nOp j) := by
  by_cases hij : i = j
  · subst hij; exact Commute.refl _
  · exact F.nOp_mul_nOp_of_ne hij

/-- `commute_cre_nOp` を必要十分版 `NecSuf.commute_cre_num` の特殊化として得る。 -/
theorem commute_cre_nOp_of_necSuf {i j : CheckIdx M} (hij : i ≠ j) :
    F.cre i * F.nOp j = F.nOp j * F.cre i :=
  NecSuf.commute_cre_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)

/-- `commute_ann_nOp` を必要十分版 `NecSuf.commute_ann_num` の特殊化として得る。 -/
theorem commute_ann_nOp_of_necSuf {i j : CheckIdx M} (hij : i ≠ j) :
    F.ann i * F.nOp j = F.nOp j * F.ann i :=
  NecSuf.commute_ann_num F.cre F.ann
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

/-- `nOp_mul_nOp_of_ne` を必要十分版 `NecSuf.commute_num_num` の特殊化として得る。 -/
theorem nOp_mul_nOp_of_ne_of_necSuf {i j : CheckIdx M} (hij : i ≠ j) :
    F.nOp i * F.nOp j = F.nOp j * F.nOp i :=
  NecSuf.commute_num_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

end CheckFermiSetup

end Ising2D
