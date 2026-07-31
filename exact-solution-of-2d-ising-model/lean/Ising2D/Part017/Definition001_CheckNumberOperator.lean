/-
# 半整数運動量の数演算子 `ň_μ`（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
- `def_check_number_operator`（`evenEigen_001_definition_check_number_operator`）
- `check_number_operator_idempotent`（`evenEigen_002_claim_...`）
- `check_number_operators_commute`（`evenEigen_003_claim_...`）

**必要十分版**は `Ising2D/NecSuf/NumberOperator.lean`（章 009 と共通）と
`Ising2D/NecSuf/PairedFermion.lean`（対をなす添字の対合）。
本ファイルの主定理は**すべて必要十分版の特殊化として導出する**。

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
import Ising2D.Part009.Claim009_EigenvaluesVprime
import Ising2D.Part013.Definition003a_CheckIndexSet
import Ising2D.NecSuf.PairedFermion

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

/-- **原文 `check_number_operator_idempotent` (1)**: `(ψ̌_μ^†)^2 = 0`。 -/
theorem cre_sq (i : CheckIdx M) : F.cre i * F.cre i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_cre_cre i i)

/-- **原文 `check_number_operator_idempotent` (1)**: `(ψ̌_{M+1-μ})^2 = 0`。 -/
theorem ann_sq (i : CheckIdx M) : F.ann i * F.ann i = 0 :=
  NecSuf.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_ann_ann i i)

/-- **原文 `check_number_operator_idempotent` (2)**: `ψ̌_{M+1-μ} ψ̌_μ^† = I - ň_μ`。 -/
theorem ann_mul_cre (i : CheckIdx M) : F.ann i * F.cre i = 1 - F.nOp i :=
  NecSuf.ann_mul_cre F.cre F.ann i (F.acomm_cre_ann_self i)

/-- **原文 `check_number_operator_idempotent` (3)**: `ň_μ^2 = ň_μ`（必要十分版の特殊化）。 -/
theorem nOp_mul_self (i : CheckIdx M) : F.nOp i * F.nOp i = F.nOp i :=
  NecSuf.num_mul_num F.cre F.ann i tensorPow_two_torsion_free
    (F.acomm_cre_cre i i) (F.acomm_ann_ann i i) (F.acomm_cre_ann_self i)

/-! ## 原文 `check_number_operators_commute` -/

/-- **原文 `check_number_operators_commute` (1)** 前半（必要十分版の特殊化）。 -/
theorem commute_cre_nOp {i j : CheckIdx M} (hij : i ≠ j) :
    F.cre i * F.nOp j = F.nOp j * F.cre i :=
  NecSuf.commute_cre_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)

/-- **原文 `check_number_operators_commute` (1)** 後半（必要十分版の特殊化）。 -/
theorem commute_ann_nOp {i j : CheckIdx M} (hij : i ≠ j) :
    F.ann i * F.nOp j = F.nOp j * F.ann i :=
  NecSuf.commute_ann_num F.cre F.ann
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

/-- **原文 `check_number_operators_commute` (2)**: `ň_μ ň_ν = ň_ν ň_μ`（必要十分版の特殊化）。 -/
theorem commute_nOp_nOp (i j : CheckIdx M) : Commute (F.nOp i) (F.nOp j) := by
  by_cases hij : i = j
  · subst hij; exact Commute.refl _
  · refine NecSuf.commute_num_num F.cre F.ann (F.acomm_cre_cre i j) ?_ ?_ (F.acomm_ann_ann i j)
    · have := F.acomm_cre_ann i j; rwa [if_neg hij] at this
    · have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this

end CheckFermiSetup

end Ising2D
