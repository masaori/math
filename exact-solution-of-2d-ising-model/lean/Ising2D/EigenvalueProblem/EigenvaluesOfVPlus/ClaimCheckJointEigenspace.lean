/-
# 数演算子の同時固有空間分解（各空間は 1 次元）（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`check_joint_eigenspace_decomposition`（`evenEigen_005_claim_...`）。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean`（章 009 と共通）。
(1)(2)(3)(4) は**すべて必要十分版の特殊化として導出する**。
ただし証明の Step 0 の冒頭の `ň_μň_μ = ň_μ` と 4 本の鎖（`R_μ^{(1)}R_μ^{(0)} = 0`・`R_μ^{(0)}R_μ^{(1)} = 0`・
`R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`・`R_μ^{(1)} + R_μ^{(0)} = I`）は、人手の行と 1 対 1 の `calc` を
`nOp_mul_nOp_of_sq`・`nOp_mul_one_sub_nOp`・`one_sub_nOp_mul_nOp`・`one_sub_nOp_mul_self`・`nOp_add_one_sub_nOp` に置く
（Step 3 の `ε_ν = 0` の場合の `ň_ν R_ν^{(0)} = 0` も `nOp_mul_one_sub_nOp` と同じ行である。`R_μ^{(1)}R_μ^{(1)} = R_μ^{(1)}` と
Step 3 の `ε_ν = 1` の場合の `ň_ν R_ν^{(1)} = R_ν^{(1)}` は、定義の行を除くと `nOp_mul_nOp_of_sq` の 1 行である）。
Step 3 の二つの場合の鎖（`ň_ν R_ν^{(ε_ν)} = ε_ν R_ν^{(ε_ν)}`）は、場合の仮定の行まで含めて `nOp_mul_projFactor_of_mem`（`ε_ν = 1`）・
`nOp_mul_projFactor_of_not_mem`（`ε_ν = 0`）に置く。人手の `R_ν^{(ε_ν)}` は `NecSuf.projFactor F.nOp T ν`、`ε_ν` は
`if ν ∈ T then (1 : ℂ) else 0` である。
Step 0 の異なる添字の因子の可換性の鎖（`YI = IY` の 2 行と、4 通りの上付き添字の組 `R_ν^{(e')}R_μ^{(e)} = R_μ^{(e)}R_ν^{(e')}` の鎖）、
Step 3 の最後の鎖（`ň_νQ̌_ε = (∏_{μ≠ν}R_μ^{(ε_μ)})(ε_νR_ν^{(ε_ν)}) = ⋯ = ε_νQ̌_ε`）と左右の鎖、Step 1〜Step 5 の鎖と 1 対 1 の具体版はまだ無い。
(5)（`ℂ^{2^M}` の直和分解）だけは台が行列環であることを本質的に使うので、ここにしか無い。

## 章 009 との違い（本章の要点）

章 009 の `joint_eigenspace_decomposition` (4) は `tr(Q_ε) = 2^{M-m}`（`m = |I|`）で、
臨界点では `m = M-1` なので `2` になりえた。半整数運動量では
`𝓜̌ = {1,…,M}` すなわち `m = M` が**無条件に**確定するので、
`tr(Q̌_ε) = 2^0 = 1` であり、同時固有空間は**すべて 1 次元**である。

計算そのものは章 009 とまったく同じ（同じ必要十分版の特殊化）で、
違うのは `Fintype.card (CheckIdx M) = M` という 1 行だけである。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimTraceCheckNumberOperatorProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimAddAndSubtractZeroMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixPlusDifferenceCancelsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-! ## 原文 Step 0（1 つの添字についての関係）

人手の `R_μ^{(1)} := ň_μ`、`R_μ^{(0)} := I - ň_μ` を、そのまま `F.nOp i`・`1 - F.nOp i` と書く。
各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **原文 Step 0 の冒頭**: `check_number_operator_idempotent` (3) の `ň_μ^2 = ň_μ` を積の形 `ň_μň_μ = ň_μ` にする 5 行。 -/
theorem nOp_mul_nOp_of_sq (i : CheckIdx M) : F.nOp i * F.nOp i = F.nOp i :=
  calc F.nOp i * F.nOp i
      = (1 * F.nOp i) * F.nOp i := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
    _ = (F.nOp i ^ 0 * F.nOp i) * F.nOp i := by rw [pow_zero]
                                                        -- `def_exp` (1) の `A^0 := I` を右辺から左辺へ
    _ = F.nOp i ^ 1 * F.nOp i := by rw [← pow_succ (F.nOp i) 0]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 0`）を右辺から左辺へ
    _ = F.nOp i ^ 2 := (pow_succ _ _).symm              -- `def_exp` (1) の `A^{m+1} := A^m A`（`m → 1`）を右辺から左辺へ
    _ = F.nOp i := F.nOp_sq i                           -- `check_number_operator_idempotent` (3)

/-- **原文 Step 0** の `R_μ^{(1)}R_μ^{(0)} = 0`（と Step 3 の `ε_ν = 0` の場合の `ň_ν R_ν^{(0)} = 0`）。 -/
theorem nOp_mul_one_sub_nOp (i : CheckIdx M) : F.nOp i * (1 - F.nOp i) = 0 :=
  calc F.nOp i * (1 - F.nOp i)
      = F.nOp i * (1 + (-F.nOp i)) := by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = F.nOp i * 1 + F.nOp i * (-F.nOp i) := mul_add_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = F.nOp i + F.nOp i * (-F.nOp i) := by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = F.nOp i + (-(F.nOp i * F.nOp i)) := by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor`
    _ = F.nOp i - F.nOp i * F.nOp i := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = F.nOp i - F.nOp i := by rw [F.nOp_mul_nOp_of_sq i]
                                                        -- Step 0 冒頭の `ň_μň_μ = ň_μ`
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl
                                                        -- `matrix_difference_zero_iff_equal` の `⟸`

/-- **原文 Step 0** の `R_μ^{(0)}R_μ^{(1)} = 0`。 -/
theorem one_sub_nOp_mul_nOp (i : CheckIdx M) : (1 - F.nOp i) * F.nOp i = 0 :=
  calc (1 - F.nOp i) * F.nOp i
      = (1 + (-F.nOp i)) * F.nOp i := by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation`
    _ = 1 * F.nOp i + (-F.nOp i) * F.nOp i := add_mul_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = F.nOp i + (-F.nOp i) * F.nOp i := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = F.nOp i + (-(F.nOp i * F.nOp i)) := by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor`
    _ = F.nOp i - F.nOp i * F.nOp i := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = F.nOp i - F.nOp i := by rw [F.nOp_mul_nOp_of_sq i]
                                                        -- Step 0 冒頭の `ň_μň_μ = ň_μ`
    _ = 0 := (matrix_sub_eq_zero_iff_tensorPow _ _).mpr rfl
                                                        -- `matrix_difference_zero_iff_equal` の `⟸`

/-- **原文 Step 0** の `R_μ^{(0)}R_μ^{(0)} = R_μ^{(0)}`。 -/
theorem one_sub_nOp_mul_self (i : CheckIdx M) : (1 - F.nOp i) * (1 - F.nOp i) = 1 - F.nOp i :=
  calc (1 - F.nOp i) * (1 - F.nOp i)
      = (1 + (-F.nOp i)) * (1 - F.nOp i) :=
        congrArg (· * (1 - F.nOp i)) (sub_eq_add_neg_tensorPow _ _)
                                                        -- `matrix_difference_is_sum_with_negation`（左の因子）
    _ = 1 * (1 - F.nOp i) + (-F.nOp i) * (1 - F.nOp i) := add_mul_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (1 - F.nOp i) + (-F.nOp i) * (1 - F.nOp i) := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = (1 - F.nOp i) + (-(F.nOp i * (1 - F.nOp i))) := by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor`
    _ = (1 - F.nOp i) - F.nOp i * (1 - F.nOp i) := (sub_eq_add_neg_tensorPow _ _).symm
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ
    _ = (1 - F.nOp i) - 0 := by rw [F.nOp_mul_one_sub_nOp i]
                                                        -- 上の `R_μ^{(1)}R_μ^{(0)} = 0`
    _ = 1 - F.nOp i := matrix_sub_zero_matrix_tensorPow _
                                                        -- `matrix_minus_zero_matrix`

/-- **原文 Step 0** の `R_μ^{(1)} + R_μ^{(0)} = I`。 -/
theorem nOp_add_one_sub_nOp (i : CheckIdx M) : F.nOp i + (1 - F.nOp i) = 1 :=
  calc F.nOp i + (1 - F.nOp i)
      = 1 := add_sub_cancel_tensorPow _ _               -- `matrix_plus_difference_cancels`（`A → ň_μ`、`B → I`）

/-! ## 原文 Step 3 の二つの場合（`ň_ν R_ν^{(ε_ν)} = ε_ν R_ν^{(ε_ν)}`）

人手の `R_ν^{(ε_ν)}` を `NecSuf.projFactor F.nOp T ν`（`ν ∈ T` なら `ň_ν`、そうでなければ `I - ň_ν`）、
`R_ν^{(1)}` を `F.nOp ν`、`R_ν^{(0)}` を `1 - F.nOp ν`、`ε_ν` を `if ν ∈ T then (1 : ℂ) else 0` と書く。
人手は場合を分ける段落で `R_ν^{(ε_ν)}` を `R_ν^{(1)}`（`R_ν^{(0)}`）にしてから鎖を始めるので、Lean の 1 段目はその置き換えと定義の行を合わせて運ぶ。各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **原文 Step 3 の `ε_ν = 1` の場合**: `ň_ν R_ν^{(1)} = ň_νň_ν = ň_ν = R_ν^{(1)} = 1_ℂ R_ν^{(1)} = ε_ν R_ν^{(ε_ν)}`。 -/
theorem nOp_mul_projFactor_of_mem {ν : CheckIdx M} {T : Finset (CheckIdx M)} (hν : ν ∈ T) :
    F.nOp ν * NecSuf.projFactor F.nOp T ν
      = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν :=
  calc F.nOp ν * NecSuf.projFactor F.nOp T ν
      = F.nOp ν * F.nOp ν := by rw [NecSuf.projFactor_of_mem hν]
                                                        -- 場合の仮定で `R_ν^{(ε_ν)} = R_ν^{(1)}`、続けて `R_ν^{(1)}` の定義（冒頭）
    _ = F.nOp ν := F.nOp_mul_nOp_of_sq ν                -- Step 0 冒頭の `ň_μň_μ = ň_μ`（`μ → ν`）
    _ = (1 : ℂ) • F.nOp ν := (one_smul_tensorPow _).symm
                                                        -- `scalar_multiple_by_one` を右辺から左辺へ
                                                        -- （人手の `= R_ν^{(1)}`（定義）の行は、Lean では `F.nOp ν` のままで同じ項）
    _ = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν := by
        rw [if_pos hν, NecSuf.projFactor_of_mem hν]     -- 場合の仮定 `ε_ν = 1`

/-- **原文 Step 3 の `ε_ν = 0` の場合**: `ň_ν R_ν^{(0)} = ň_ν(I - ň_ν) = ⋯ = O = 0_ℂ R_ν^{(0)} = ε_ν R_ν^{(ε_ν)}`。 -/
theorem nOp_mul_projFactor_of_not_mem {ν : CheckIdx M} {T : Finset (CheckIdx M)} (hν : ν ∉ T) :
    F.nOp ν * NecSuf.projFactor F.nOp T ν
      = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν :=
  calc F.nOp ν * NecSuf.projFactor F.nOp T ν
      = F.nOp ν * (1 - F.nOp ν) := by rw [NecSuf.projFactor_of_notMem hν]
                                                        -- 場合の仮定で `R_ν^{(ε_ν)} = R_ν^{(0)}`、続けて `R_ν^{(0)}` の定義（冒頭）
    _ = 0 := F.nOp_mul_one_sub_nOp ν                    -- 人手の続く 7 行（`nOp_mul_one_sub_nOp` の calc と同じ行）
    _ = (0 : ℂ) • (1 - F.nOp ν) := (zero_smul_tensorPow _).symm
                                                        -- `zero_scalar_multiple_is_zero_matrix` を右辺から左辺へ
    _ = (if ν ∈ T then (1 : ℂ) else 0) • NecSuf.projFactor F.nOp T ν := by
        rw [if_neg hν, NecSuf.projFactor_of_notMem hν]  -- 場合の仮定 `ε_ν = 0`

/-- **原文 `check_joint_eigenspace_decomposition` の `Q̌_ε`**:
`Q̌_T = ∏_{μ∈𝓜̌} (μ ∈ T ? ň_μ : I - ň_μ)`。 -/
noncomputable def Qproj (T : Finset (CheckIdx M)) : TensorPow M :=
  NecSuf.projOn F.nOp F.commute_nOp_nOp Finset.univ T

/-- `ε : 𝓜̌ → Bool` の形（人手証明の記法に合わせた版）。 -/
noncomputable def Qproj' (ε : CheckIdx M → Bool) : TensorPow M :=
  F.Qproj (Finset.univ.filter fun i => ε i)

/-- **原文 (1) 後半**: `Q̌_ε^2 = Q̌_ε`。 -/
theorem Qproj_mul_self (T : Finset (CheckIdx M)) : F.Qproj T * F.Qproj T = F.Qproj T :=
  NecSuf.projOn_mul_self F.nOp_mul_self _ _

/-- **原文 (1) 前半**: `ε ≠ ε'` なら `Q̌_ε Q̌_{ε'} = 0`。 -/
theorem Qproj_mul_Qproj_of_ne {T T' : Finset (CheckIdx M)} (h : T ≠ T') :
    F.Qproj T * F.Qproj T' = 0 := by
  obtain ⟨ν, hν⟩ : ∃ ν : CheckIdx M, ¬(ν ∈ T ↔ ν ∈ T') := by
    by_contra hc
    push_neg at hc
    exact h (Finset.ext fun ν => hc ν)
  exact NecSuf.projOn_mul_projOn_of_ne F.nOp_mul_self (Finset.mem_univ ν) hν

/-- **原文 (2)**: `∑_ε Q̌_ε = I`。 -/
theorem sum_Qproj : ∑ T : Finset (CheckIdx M), F.Qproj T = 1 := by
  have := NecSuf.sum_projOn (n := F.nOp) (hn := F.commute_nOp_nOp) Finset.univ
  rwa [Finset.powerset_univ] at this

/-- **原文 (3)**: `ň_ν Q̌_ε = ε_ν Q̌_ε`。 -/
theorem nOp_mul_Qproj (ν : CheckIdx M) (T : Finset (CheckIdx M)) :
    F.nOp ν * F.Qproj T = (if ν ∈ T then (1 : ℂ) else 0) • F.Qproj T := by
  have h := NecSuf.num_mul_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    F.nOp_mul_self (T := T) (Finset.mem_univ ν)
  rw [Qproj, h]
  by_cases hT : ν ∈ T <;> simp [hT]

/-- `ň_ν` は `Q̌_ε` と可換（人手 Step 3 の `Q̌_εň_ν = ň_νQ̌_ε`。人手は Step 0 の可換性と `matrix_commuting_with_each_factor_commutes_with_finite_product` で示す）。 -/
theorem commute_nOp_Qproj (ν : CheckIdx M) (T : Finset (CheckIdx M)) :
    Commute (F.nOp ν) (F.Qproj T) :=
  NecSuf.commute_projOn (n := F.nOp) (hn := F.commute_nOp_nOp)
    (fun i _ => F.commute_nOp_nOp ν i)

/-! ## トレースと次元（原文 (4)） -/

/-- **原文 (4)**: `tr(Q̌_ε) = 1`。

章 009 の同じ計算が `2^{M-m}` を与えるところで、`m = M` により `2^0 = 1` になる。 -/
theorem trace_Qproj (T : Finset (CheckIdx M)) : (F.Qproj T).trace = 1 := by
  have h : ((2 ^ M : ℕ) : ℂ) * (F.Qproj T).trace = ((2 ^ M : ℕ) : ℂ) := by
    have h0 := NecSuf.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
      (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
      (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
      (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij)
      Finset.univ T
    rw [trace_one_tensorPow, nsmul_eq_mul, Finset.card_univ, CheckIdx.card] at h0
    exact h0
  have hne : ((2 ^ M : ℕ) : ℂ) ≠ 0 := by simp
  refine mul_left_cancel₀ hne ?_
  rw [mul_one]
  exact h

/-- **原文 (4) 後半**: `dim_ℂ (im Q̌_ε) = 1`。 -/
theorem finrank_range_Qproj (T : Finset (CheckIdx M)) :
    ((Module.finrank ℂ (LinearMap.range (Matrix.toLin' (F.Qproj T))) : ℕ) : ℂ) = 1 := by
  rw [← trace_of_idempotent _ (F.Qproj_mul_self T), F.trace_Qproj T]

/-! ## 原文 (5): `ℂ^{2^M}` の直和分解 -/

/-- **原文 (5) 前半**: 任意の `x` は `x = ∑_ε Q̌_ε x` と書ける（和が全体を張る）。 -/
theorem sum_Qproj_mulVec (x : Conf M → ℂ) :
    ∑ T : Finset (CheckIdx M), (F.Qproj T).mulVec x = x := by
  rw [← Matrix.sum_mulVec, F.sum_Qproj, Matrix.one_mulVec]

/-- **原文 (5) 後半**: `y_ε ∈ im Q̌_ε` かつ `∑_ε y_ε = 0` なら各 `y_ε = 0`（直和性）。 -/
theorem eq_zero_of_sum_eq_zero (y : Finset (CheckIdx M) → Conf M → ℂ)
    (hy : ∀ T, ∃ x, y T = (F.Qproj T).mulVec x)
    (hsum : ∑ T : Finset (CheckIdx M), y T = 0) (T₀ : Finset (CheckIdx M)) : y T₀ = 0 := by
  classical
  have hfix : ∀ T, (F.Qproj T₀).mulVec (y T) = if T = T₀ then y T else 0 := by
    intro T
    obtain ⟨x, hx⟩ := hy T
    by_cases hT : T = T₀
    · subst hT
      rw [if_pos rfl, hx, Matrix.mulVec_mulVec, F.Qproj_mul_self]
    · rw [if_neg hT, hx, Matrix.mulVec_mulVec,
        F.Qproj_mul_Qproj_of_ne (Ne.symm hT), Matrix.zero_mulVec]
  have hkey : (F.Qproj T₀).mulVec (∑ T : Finset (CheckIdx M), y T) = y T₀ := by
    rw [Matrix.mulVec_sum, Finset.sum_congr rfl (fun T _ => hfix T)]
    simp
  rw [hsum, Matrix.mulVec_zero] at hkey
  exact hkey.symm

end CheckFermiSetup

end Ising2D
