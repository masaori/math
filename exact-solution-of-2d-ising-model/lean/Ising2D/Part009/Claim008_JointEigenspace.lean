/-
# 数演算子の同時固有空間分解（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `joint_eigenspace_decomposition`（`eigenvalues_of_V_008_claim_joint_eigenspace_decomposition`）
- `trace_of_number_operator_product`（`eigenvalues_of_V_007_claim_trace_of_number_operator_product`）

必要十分版は `Ising2D/NecSuf/JointEigenspace.lean`。(1)(2)(3)(4) は
**すべて必要十分版の特殊化として導出する**。(5)（`ℂ^{2^M}` の直和分解）だけは
台が行列環であることを本質的に使うので、ここにしか無い。

## 添字づけ

人手証明の `ε ∈ {0,1}^𝓘` は「`ε_μ = 1` となる `μ` の集合 `T ⊆ 𝓘`」と同じデータなので、
Lean では `T : Finset 𝓘` で添字づける（`ε_μ = 1 ⟺ μ ∈ T`）。
`ε : 𝓘 → Bool` の形も `Qproj'` として与える。
-/
import Ising2D.Part009.Definition004_NumberOperator

namespace Ising2D

open Matrix

namespace FermiSetup

variable {M : ℕ} {K : IsingConst} (F : FermiSetup M K)

/-- **原文 `joint_eigenspace_decomposition` の `Q_ε`**:
`Q_T = ∏_{μ∈𝓘} (μ ∈ T ? n_μ : I - n_μ)`。 -/
noncomputable def Qproj (T : Finset F.Idx) : TensorPow M :=
  NecSuf.projOn F.nOp F.commute_nOp_nOp Finset.univ T

/-- `ε : 𝓘 → Bool` の形（人手証明の記法に合わせた版）。 -/
noncomputable def Qproj' (ε : F.Idx → Bool) : TensorPow M :=
  F.Qproj (Finset.univ.filter fun i => ε i)

theorem Qproj'_eq (ε : F.Idx → Bool) :
    F.Qproj' ε = F.Qproj (Finset.univ.filter fun i => ε i) := rfl

/-- **原文 (1) 後半**: `Q_ε^2 = Q_ε`。 -/
theorem Qproj_mul_self (T : Finset F.Idx) : F.Qproj T * F.Qproj T = F.Qproj T :=
  NecSuf.projOn_mul_self F.nOp_mul_self _ _

/-- **原文 (1) 前半**: `ε ≠ ε'` なら `Q_ε Q_{ε'} = 0`。 -/
theorem Qproj_mul_Qproj_of_ne {T T' : Finset F.Idx} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  obtain ⟨ν, hν⟩ : ∃ ν : F.Idx, ¬(ν ∈ T ↔ ν ∈ T') := by
    by_contra hc
    push_neg at hc
    exact h (Finset.ext fun ν => hc ν)
  exact NecSuf.projOn_mul_projOn_of_ne F.nOp_mul_self (Finset.mem_univ ν) hν

/-- **原文 (2)**: `∑_ε Q_ε = I`。 -/
theorem sum_Qproj : ∑ T : Finset F.Idx, F.Qproj T = 1 := by
  have := NecSuf.sum_projOn (n := F.nOp) (hn := F.commute_nOp_nOp) Finset.univ
  rwa [Finset.powerset_univ] at this

/-- **原文 (3)**: `n_ν Q_ε = ε_ν Q_ε`。 -/
theorem nOp_mul_Qproj (ν : F.Idx) (T : Finset F.Idx) :
    F.nOp ν * F.Qproj T = (if ν ∈ T then (1 : ℂ) else 0) • F.Qproj T := by
  have h := NecSuf.num_mul_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    F.nOp_mul_self (T := T) (Finset.mem_univ ν)
  rw [Qproj, h]
  by_cases hT : ν ∈ T <;> simp [hT]

/-! ## トレース（原文 (4)、および `trace_of_number_operator_product`） -/

/-- **原文 `trace_of_number_operator_product` の内容**（必要十分版として述べたもの）:
`2^{|𝓘|} tr(Q_ε) = tr(I) = 2^M`。

人手証明は `Q_ε` を二項展開して `tr(n_{μ_1}⋯n_{μ_k}) = 2^{M-k}` と二項定理を使うが、
必要十分版（`NecSuf.two_pow_smul_tau_projOn`）で分かる通り、効いているのは
「どちらの因子でも `2 tr(R_j X) = tr(X)`」の 1 段だけで二項定理は要らない。 -/
theorem two_pow_mul_trace_Qproj (T : Finset F.Idx) :
    ((2 ^ F.I.card : ℕ) : ℂ) * (F.Qproj T).trace = ((2 ^ M : ℕ) : ℂ) := by
  have h := NecSuf.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
    (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
    (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
    (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij)
    Finset.univ T
  rw [trace_one_tensorPow] at h
  have hcard : (Finset.univ : Finset F.Idx).card = F.I.card := by
    rw [Finset.card_univ]
    exact Fintype.card_coe _
  rw [hcard, nsmul_eq_mul] at h
  exact h

/-- `|𝓘| ≤ M`（`𝓘 ⊆ {1,…,M}` から）。原文が `2^{M-m}` と書けることの根拠。 -/
theorem card_I_le : F.I.card ≤ M := by
  have hsub : F.I ⊆ Finset.Icc (1 : ℤ) (M : ℤ) := by
    intro μ hμ
    exact Finset.mem_Icc.2 ⟨F.hIlow μ hμ, F.hIhigh μ hμ⟩
  have := Finset.card_le_card hsub
  simpa using this

/-- **原文 (4)**: `tr(Q_ε) = 2^{M-m}`。 -/
theorem trace_Qproj (T : Finset F.Idx) :
    (F.Qproj T).trace = ((2 ^ (M - F.I.card) : ℕ) : ℂ) := by
  have h := F.two_pow_mul_trace_Qproj T
  have hne : ((2 ^ F.I.card : ℕ) : ℂ) ≠ 0 := by
    simp
  have hle := F.card_I_le
  have hsplit : ((2 ^ M : ℕ) : ℂ)
      = ((2 ^ F.I.card : ℕ) : ℂ) * ((2 ^ (M - F.I.card) : ℕ) : ℂ) := by
    rw [← Nat.cast_mul, ← pow_add]
    congr 2
    omega
  rw [hsplit] at h
  exact mul_left_cancel₀ hne h

/-- **原文 (4) 後半**: `dim_ℂ (im Q_ε) = 2^{M-m}`（冪等性と `trace_of_idempotent` より）。 -/
theorem finrank_range_Qproj (T : Finset F.Idx) :
    ((Module.finrank ℂ (LinearMap.range (Matrix.toLin' (F.Qproj T))) : ℕ) : ℂ)
      = ((2 ^ (M - F.I.card) : ℕ) : ℂ) := by
  rw [← trace_of_idempotent _ (F.Qproj_mul_self T), F.trace_Qproj T]

/-! ## 原文 (5): `ℂ^{2^M}` の直和分解 -/

/-- **原文 (5) 前半**: 任意の `x` は `x = ∑_ε Q_ε x` と書ける（和が全体を張る）。 -/
theorem sum_Qproj_mulVec (x : Conf M → ℂ) :
    ∑ T : Finset F.Idx, (F.Qproj T).mulVec x = x := by
  rw [← Matrix.sum_mulVec]
  rw [F.sum_Qproj, Matrix.one_mulVec]

/-- **原文 (5) 後半**: `y_ε ∈ im Q_ε` かつ `∑_ε y_ε = 0` なら各 `y_ε = 0`（直和性）。 -/
theorem eq_zero_of_sum_eq_zero (y : Finset F.Idx → Conf M → ℂ)
    (hy : ∀ T, ∃ x, y T = (F.Qproj T).mulVec x)
    (hsum : ∑ T : Finset F.Idx, y T = 0) (T₀ : Finset F.Idx) : y T₀ = 0 := by
  classical
  have hfix : ∀ T, (F.Qproj T₀).mulVec (y T) = if T = T₀ then y T else 0 := by
    intro T
    obtain ⟨x, hx⟩ := hy T
    by_cases hT : T = T₀
    · subst hT
      rw [if_pos rfl, hx, Matrix.mulVec_mulVec, F.Qproj_mul_self]
    · rw [if_neg hT, hx, Matrix.mulVec_mulVec,
        F.Qproj_mul_Qproj_of_ne (Ne.symm hT), Matrix.zero_mulVec]
  have : (F.Qproj T₀).mulVec (∑ T : Finset F.Idx, y T) = y T₀ := by
    rw [Matrix.mulVec_sum]
    rw [Finset.sum_congr rfl (fun T _ => hfix T)]
    simp
  rw [hsum, Matrix.mulVec_zero] at this
  exact this.symm

end FermiSetup

end Ising2D
