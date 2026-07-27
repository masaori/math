/-
# フェルミオン数演算子（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `def_number_operator`（`eigenvalues_of_V_004_definition_number_operator`）
- `number_operator_idempotent`（`eigenvalues_of_V_005_claim_number_operator_idempotent`）
- `number_operators_commute`（`eigenvalues_of_V_006_claim_number_operators_commute`）

抽象版は `Ising2D/Abstract/NumberOperator.lean`。本ファイルの主定理は
**すべて抽象版の特殊化として導出する**（`Ising2D.Abstract.num_mul_num` /
`Abstract.commute_cre_num` / `Abstract.commute_ann_num` / `Abstract.commute_num_num`）。

## 原文の設定を Lean へ移すにあたって

原文の `𝓘 := {μ ∈ {1,…,M} | γ_2(θ_μ) ≠ 0}` は、Lean では
**「`{1,…,M}` に含まれ、そこで `γ_2(θ_μ) ≠ 0` が成り立つ添字の有限集合 `I`」**として
仮定に持つ（`FermiSetup`）。`γ_2(θ_μ) = 0` になる `μ` の同定（原文
`gamma_2_theta_is_0`）は 008 章の内容で、そこは既に
`Ising2D.gamma2_eq_zero_iff` として形式化済みなので、本章では
「そういう `I` が与えられた」形にして依存を切っている。

`ψ_μ^†` の定義には平方根 `t_μ = √(γ_2(θ_μ)γ_2(-θ_μ))` の**分枝の選択**が要る
（`Ising2D/Part008/Definition030_Fermi.lean` 冒頭の「原文の穴」参照）。
本章でも同じく、分枝関数 `t : ℤ → ℂ` と整合条件
`hbr : M ∣ (a+b) → t b = t a` を仮定として受け取る。

`γ(θ_μ) = arccosh(γ_1(θ_μ))`（原文 `def_gamma_theta_mu`）は mathlib に
`Real.arccosh` が無いため、**非負実数値の族 `g : Idx → ℝ` として仮定に持つ**
（本章が `γ` について使うのは `γ(θ_μ) ≥ 0` だけである）。
-/
import Ising2D.Part008.Definition030_Fermi
import Ising2D.Abstract.NumberOperator
import Ising2D.Abstract.JointEigenspace
import Ising2D.Part009.Definition001_Trace

namespace Ising2D

open Matrix

/-! ## `Mat(2^M, ℂ)` に 2-捩れが無いこと -/

/-- 抽象版が要求する唯一の非自明な仮定（`x + x = 0 → x = 0`）は
複素行列では成り立つ。原文 `number_operator_idempotent` (1) の「`2 ≠ 0` なので」。 -/
theorem tensorPow_two_torsion_free {M : ℕ} (x : TensorPow M) (h : x + x = 0) : x = 0 := by
  ext i j
  have h' : x i j + x i j = 0 := by
    have := congrFun (congrFun h i) j
    simpa using this
  have : (2 : ℂ) * x i j = 0 := by rw [two_mul]; exact h'
  simpa using this

/-! ## 原文 `def_number_operator` の設定 -/

/-- 原文 `def_number_operator` が置いている状況をまとめたもの。

- `I` が原文の `𝓘`（`{1,…,M}` の部分集合で、そこでは `γ_2(θ_μ) ≠ 0`）
- `t` が平方根 `√(γ_2(θ_μ)γ_2(-θ_μ))` の分枝の選択（原文の穴に対応する仮定）
-/
structure FermiSetup (M : ℕ) (K : IsingConst) where
  hM : M ≠ 0
  I : Finset ℤ
  hIlow : ∀ μ ∈ I, 1 ≤ μ
  hIhigh : ∀ μ ∈ I, μ ≤ (M : ℤ)
  t : ℤ → ℂ
  ht : ∀ μ : ℤ, (t μ) ^ 2 = gamma2 K (thetaMu M μ) * gamma2 K (-thetaMu M μ)
  hgam : ∀ μ ∈ I, gamma2 K (thetaMu M μ) ≠ 0
  hbr : ∀ a b : ℤ, (M : ℤ) ∣ (a + b) → t b = t a

namespace FermiSetup

variable {M : ℕ} {K : IsingConst} (F : FermiSetup M K)

/-- 原文の `𝓘` を添字型として扱う。 -/
def Idx : Type := {μ : ℤ // μ ∈ F.I}

instance : Fintype F.Idx := FinsetCoe.fintype _
instance : DecidableEq F.Idx := Subtype.instDecidableEq
instance : CoeOut F.Idx ℤ := ⟨Subtype.val⟩

/-- `μ ∈ 𝓘` なら `γ_2(θ_{-μ}) ≠ 0`（原文 `def_number_operator` の
「`relation_of_gamma_2` より `γ_2(-θ_μ) ≠ 0` すなわち `γ_2(θ_{-μ}) ≠ 0`」）。 -/
theorem gam_neg {μ : ℤ} (h : μ ∈ F.I) : gamma2 K (thetaMu M (-μ)) ≠ 0 := by
  rw [thetaMu_neg]
  intro hz
  exact F.hgam μ h ((gamma2_neg_eq_zero_iff K _).1 hz)

/-- 原文の `ψ_μ^†`（生成演算子）。 -/
noncomputable def cre (i : F.Idx) : TensorPow M := psiDag K M i.1 (F.t i.1)

/-- 原文の `ψ_{-μ}`（消滅演算子）。 -/
noncomputable def ann (i : F.Idx) : TensorPow M := psi K M (-i.1) (F.t (-i.1))

/-- **原文 `def_number_operator` の形式化**: `n_μ := ψ_μ^† ψ_{-μ}`。 -/
noncomputable def nOp (i : F.Idx) : TensorPow M := Abstract.num F.cre F.ann i

theorem nOp_def (i : F.Idx) : F.nOp i = F.cre i * F.ann i := rfl

/-! ## 正準反交換関係（原文 `anticommutator_of_psi` の `𝓘` への制限） -/

/-- 相異なる `μ, ν ∈ 𝓘 ⊆ {1,…,M}` は `M` を法として合同でない
（原文 `number_operators_commute` Step 1 の「`1 ≤ |μ-ν| ≤ M-1`」）。 -/
theorem not_dvd_sub_of_ne {i j : F.Idx} (hij : i ≠ j) : ¬ ((M : ℤ) ∣ (i.1 - j.1)) := by
  intro hd
  have hne : i.1 - j.1 ≠ 0 := fun h => hij (Subtype.ext (by omega))
  have h1 : 1 ≤ i.1 := F.hIlow _ i.2
  have h2 : i.1 ≤ (M : ℤ) := F.hIhigh _ i.2
  have h3 : 1 ≤ j.1 := F.hIlow _ j.2
  have h4 : j.1 ≤ (M : ℤ) := F.hIhigh _ j.2
  have habs : |i.1 - j.1| < (M : ℤ) := by
    rw [abs_lt]; omega
  exact hne (Int.eq_zero_of_abs_lt_dvd hd habs)

/-- `[ψ_μ^†, ψ_ν^†]₊ = 0`。 -/
theorem acomm_cre_cre (i j : F.Idx) : F.cre i * F.cre j + F.cre j * F.cre i = 0 := by
  have := acomm_psiDag_psiDag (M := M) K F.hM i.1 j.1 (F.t i.1) (F.t j.1)
    (F.ht i.1) (F.ht j.1) (F.hgam _ i.2) (F.hgam _ j.2) (fun h => F.hbr i.1 j.1 h)
  simpa [cre, acomm] using this

/-- `[ψ_{-μ}, ψ_{-ν}]₊ = 0`。 -/
theorem acomm_ann_ann (i j : F.Idx) : F.ann i * F.ann j + F.ann j * F.ann i = 0 := by
  have := acomm_psi_psi (M := M) K F.hM (-i.1) (-j.1) (F.t (-i.1)) (F.t (-j.1))
    (F.ht _) (F.ht _) (F.gam_neg i.2) (F.gam_neg j.2) (fun h => F.hbr (-i.1) (-j.1) h)
  simpa [ann, acomm] using this

/-- `[ψ_μ^†, ψ_{-ν}]₊ = δ_{μν} I`。原文の `δ^M_{μ+ν,0}` が、`ν → -ν` と
`μ, ν ∈ {1,…,M}` の制限のもとで Kronecker のデルタ `δ_{μν}` になる。 -/
theorem acomm_cre_ann (i j : F.Idx) :
    F.cre i * F.ann j + F.ann j * F.cre i = if i = j then (1 : TensorPow M) else 0 := by
  have h := acomm_psiDag_psi (M := M) K F.hM i.1 (-j.1) (F.t i.1) (F.t (-j.1))
    (F.ht i.1) (F.ht _) (F.hgam _ i.2) (F.gam_neg j.2) (fun h => F.hbr i.1 (-j.1) h)
  rw [acomm] at h
  have hd : deltaMod M (i.1 + -j.1) 0 = if i = j then (1 : ℂ) else 0 := by
    by_cases hij : i = j
    · subst hij
      simp [deltaMod]
    · have := F.not_dvd_sub_of_ne hij
      simp only [deltaMod, sub_zero, if_neg hij]
      rw [if_neg]
      intro hcon
      exact this (by simpa [sub_eq_add_neg] using hcon)
  rw [hd] at h
  simp only [cre, ann]
  rw [h]
  by_cases hij : i = j <;> simp [hij]

/-! ## 原文 `number_operator_idempotent` / `number_operators_commute` -/

/-- **原文 `number_operator_idempotent` (1)**: `(ψ_μ^†)^2 = 0`, `(ψ_{-μ})^2 = 0`。 -/
theorem cre_sq (i : F.Idx) : F.cre i * F.cre i = 0 :=
  Abstract.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_cre_cre i i)

theorem ann_sq (i : F.Idx) : F.ann i * F.ann i = 0 :=
  Abstract.sq_eq_zero_of_acomm_self tensorPow_two_torsion_free (F.acomm_ann_ann i i)

theorem acomm_cre_ann_self (i : F.Idx) :
    F.cre i * F.ann i + F.ann i * F.cre i = 1 := by
  have := F.acomm_cre_ann i i
  simpa using this

/-- **原文 `number_operator_idempotent` (2)**: `ψ_{-μ}ψ_μ^† = I - n_μ`。 -/
theorem ann_mul_cre (i : F.Idx) : F.ann i * F.cre i = 1 - F.nOp i :=
  Abstract.ann_mul_cre F.cre F.ann i (F.acomm_cre_ann_self i)

/-- **原文 `number_operator_idempotent` (3)**: `n_μ^2 = n_μ`（抽象版の特殊化）。 -/
theorem nOp_mul_self (i : F.Idx) : F.nOp i * F.nOp i = F.nOp i :=
  Abstract.num_mul_num F.cre F.ann i tensorPow_two_torsion_free
    (F.acomm_cre_cre i i) (F.acomm_ann_ann i i) (F.acomm_cre_ann_self i)

/-- **原文 `number_operators_commute` (1)** 前半（抽象版の特殊化）。 -/
theorem commute_cre_nOp {i j : F.Idx} (hij : i ≠ j) :
    F.cre i * F.nOp j = F.nOp j * F.cre i :=
  Abstract.commute_cre_num F.cre F.ann (F.acomm_cre_cre i j)
    (by have := F.acomm_cre_ann i j; rwa [if_neg hij] at this)

/-- **原文 `number_operators_commute` (1)** 後半（抽象版の特殊化）。 -/
theorem commute_ann_nOp {i j : F.Idx} (hij : i ≠ j) :
    F.ann i * F.nOp j = F.nOp j * F.ann i :=
  Abstract.commute_ann_num F.cre F.ann
    (by
      have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this)
    (F.acomm_ann_ann i j)

/-- **原文 `number_operators_commute` (2)**: `n_μ n_ν = n_ν n_μ`（抽象版の特殊化）。 -/
theorem commute_nOp_nOp (i j : F.Idx) : Commute (F.nOp i) (F.nOp j) := by
  by_cases hij : i = j
  · subst hij; exact Commute.refl _
  · refine Abstract.commute_num_num F.cre F.ann (F.acomm_cre_cre i j) ?_ ?_ (F.acomm_ann_ann i j)
    · have := F.acomm_cre_ann i j; rwa [if_neg hij] at this
    · have := F.acomm_cre_ann j i
      rw [if_neg (Ne.symm hij)] at this
      linear_combination (norm := noncomm_ring) this

end FermiSetup

end Ising2D
