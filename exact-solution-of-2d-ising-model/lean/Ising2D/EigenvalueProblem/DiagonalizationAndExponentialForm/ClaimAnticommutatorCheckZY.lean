/-
# `check(Z)`, `check(Y)` の反交換関係（**具体版**）

対応する人手証明のラベル: `anticommutator_of_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evensector_005_claim_anticommutator_check_Z_Y`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean` の
`Ising2D.NecSuf.acomm_antiperiodic_fourier_clifford`（同じラベル）。
必要十分版からの導出は `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimAnticommutatorCheckZYFromNecSuf.lean`。

## 原文の主張（`μ, ν ∈ 𝓜̌`）

  `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`
  `[check(Z)_μ, check(Y)_ν]₊ = 0`
  `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`

## 形式化の方針

* まず `μ, ν ∈ ℤ` 全体で `δ^M_{(μ+ν,1)}`（合同式の形）で述べ、
  そのあと `def_check_index_set` (5)（`Ising2D.deltaMod_add_one_eq`）で
  `μ, ν ∈ 𝓜̌` の場合の `δ_{ν, M+1-μ}` に落とす。原文の構成と同じ順序である。
* 第 1〜3 式の証明は原文の一続きの式変形と 1 行ずつ対応する `calc` で書く（第 1・3 式の最後の
  `def_check_index_set` (5) の行は `_of_mem` の形が受け持つ）。
  各行の根拠は行の直前のコメントに原文の `(∵ …)` を写した。
* 原文の `exp_sum` は `exp(+√-1·2π jk/M)` の和で述べ、`k = -(μ+ν-1)` に適用して
  `δ^M_{(-(μ+ν-1),0)}` を得る。Lean の位相因子 `expPhase M k = exp(-√-1·2π k/M)` は符号が逆なので、
  同じ和を `Ising2D.expPhase_sum`（`exp_sum` の形式化）に `k = μ+ν-1` で当てて `δ^M_{(μ+ν-1,0)}` を得る。
  `M ∣ x ⟺ M ∣ -x` なので二つの `δ` は同じ値であり、次の `def_delta_M` の行で同じ `δ^M_{(μ+ν,1)}` に着く。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.ClaimConjugateIndex
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionHalfIntegerModes
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimAnticommutatorZY
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimExpSum

namespace Ising2D

variable {M : ℕ}

/-- 原文の行「`1 ≤ j, k ≤ M` では `δ^M_{(j,k)} = 1 ⟺ j = k`」:
二重和 `∑_j ∑_k c_j d_k · 2I δ^M_{(j,k)}` は `j = k` の項だけが残り `2I ∑_j c_j d_j` になる。 -/
theorem sum_sum_smul_two_deltaM_smul_one (c d : Fin M → ℂ) :
    ∑ j, ∑ k, (c j * d k) • ((2 * deltaM j k) • (1 : TensorPow M))
      = (2 * ∑ j, c j * d j) • (1 : TensorPow M) := by
  rw [Finset.mul_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_eq_single_of_mem j (Finset.mem_univ j)]
  · rw [deltaM, if_pos rfl, smul_smul]
    congr 1
    ring
  · intro k _ hkj
    rw [deltaM, if_neg (Ne.symm hkj), mul_zero, zero_smul, smul_zero]

/-- `δ^M_{(μ+ν-1, 0)} = δ^M_{(μ+ν, 1)}`（`def_delta_M` の定義による書き換え）。 -/
theorem deltaMod_sub_one (M : ℕ) (μ ν : ℤ) :
    deltaMod M (μ + ν - 1) 0 = deltaMod M (μ + ν) 1 := by
  rw [deltaMod, deltaMod, sub_zero]

/-! ## 原文の 3 つの反交換関係（`μ, ν ∈ ℤ` 版） -/

/-- **原文第 1 式（合同式版）**: `[check(Z)_μ, check(Z)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkZ_checkZ (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  calc acomm (checkZ M μ) (checkZ M ν)
      -- (∵ def_half_integer_checkZ)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Z k) := by
        rw [checkZ, checkZ]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Z j) (Z k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • ((2 * deltaM j k) • (1 : TensorPow M)) := by
        simp_rw [anticomm_Z_Z]
      -- (∵ 1 ≤ j, k ≤ M では δ^M_{(j,k)} = 1 ⟺ j = k)
    _ = (2 * ∑ j : Fin M,
          checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν)
            • (1 : TensorPow M) :=
        sum_sum_smul_two_deltaM_smul_one _ _
      -- (∵ theorem_exp_product (n = 1))
    _ = (2 * ∑ j : Fin M,
          expPhase (2 * M) ((((j : ℕ) : ℤ) + 1) * (2 * μ - 1) + (((j : ℕ) : ℤ) + 1) * (2 * ν - 1)))
            • (1 : TensorPow M) := by
        simp_rw [checkPhase, ← expPhase_add]
      -- (∵ θ~_μ + θ~_ν = 2π(μ+ν-1)/M)
    _ = (2 * ∑ j : Fin M, expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)))
            • (1 : TensorPow M) := by
        congr 2
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [show (((j : ℕ) : ℤ) + 1) * (2 * μ - 1) + (((j : ℕ) : ℤ) + 1) * (2 * ν - 1)
            = 2 * ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) by ring,
          expPhase_two_mul hM]
      -- (∵ exp_sum)
    _ = (2 * ((M : ℂ) * deltaMod M (μ + ν - 1) 0)) • (1 : TensorPow M) := by
        rw [expPhase_sum hM]
      -- (∵ def_delta_M)
    _ = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
        rw [deltaMod_sub_one, mul_assoc]

/-- **原文第 3 式（合同式版）**: `[check(Y)_μ, check(Y)_ν]₊ = 2M δ^M_{(μ+ν,1)} I`。 -/
theorem acomm_checkY_checkY (hM : M ≠ 0) (μ ν : ℤ) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
  calc acomm (checkY M μ) (checkY M ν)
      -- (∵ def_half_integer_checkY)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Y j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Y k) := by
        rw [checkY, checkY]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Y j) (Y k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • ((2 * deltaM j k) • (1 : TensorPow M)) := by
        simp_rw [anticomm_Y_Y]
      -- (∵ 1 ≤ j, k ≤ M では δ^M_{(j,k)} = 1 ⟺ j = k)
    _ = (2 * ∑ j : Fin M,
          checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((j : ℕ) : ℤ) + 1) ν)
            • (1 : TensorPow M) :=
        sum_sum_smul_two_deltaM_smul_one _ _
      -- (∵ theorem_exp_product (n = 1))
    _ = (2 * ∑ j : Fin M,
          expPhase (2 * M) ((((j : ℕ) : ℤ) + 1) * (2 * μ - 1) + (((j : ℕ) : ℤ) + 1) * (2 * ν - 1)))
            • (1 : TensorPow M) := by
        simp_rw [checkPhase, ← expPhase_add]
      -- (∵ θ~_μ + θ~_ν = 2π(μ+ν-1)/M)
    _ = (2 * ∑ j : Fin M, expPhase M ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)))
            • (1 : TensorPow M) := by
        congr 2
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [show (((j : ℕ) : ℤ) + 1) * (2 * μ - 1) + (((j : ℕ) : ℤ) + 1) * (2 * ν - 1)
            = 2 * ((((j : ℕ) : ℤ) + 1) * (μ + ν - 1)) by ring,
          expPhase_two_mul hM]
      -- (∵ exp_sum)
    _ = (2 * ((M : ℂ) * deltaMod M (μ + ν - 1) 0)) • (1 : TensorPow M) := by
        rw [expPhase_sum hM]
      -- (∵ def_delta_M)
    _ = (2 * (M : ℂ) * deltaMod M (μ + ν) 1) • (1 : TensorPow M) := by
        rw [deltaMod_sub_one, mul_assoc]

/-- **原文第 2 式**: `[check(Z)_μ, check(Y)_ν]₊ = 0`（二重和のすべての項が `0`）。 -/
theorem acomm_checkZ_checkY (μ ν : ℤ) : acomm (checkZ M μ) (checkY M ν) = 0 := by
  calc acomm (checkZ M μ) (checkY M ν)
      -- (∵ def_half_integer_checkZ, def_half_integer_checkY)
      = acomm (∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j)
          (∑ k : Fin M, checkPhase M (((k : ℕ) : ℤ) + 1) ν • Y k) := by
        rw [checkZ, checkY]
      -- (∵ 反交換子の ℂ 双線型性)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • acomm (Z j) (Y k) :=
        acomm_sum_smul _ _ _ _
      -- (∵ anticommutator_of_Z_and_Y)
    _ = ∑ j : Fin M, ∑ k : Fin M,
          (checkPhase M (((j : ℕ) : ℤ) + 1) μ * checkPhase M (((k : ℕ) : ℤ) + 1) ν)
            • (0 : TensorPow M) := by
        simp_rw [anticomm_Z_Y]
      -- (∵ ℂ の四則)
    _ = 0 := by
        simp_rw [smul_zero, Finset.sum_const_zero]

/-- `[check(Y)_μ, check(Z)_ν]₊ = 0`（上の左右を入れ替えた形）。 -/
theorem acomm_checkY_checkZ (μ ν : ℤ) : acomm (checkY M μ) (checkZ M ν) = 0 := by
  rw [acomm_comm]; exact acomm_checkZ_checkY ν μ

/-! ## `μ, ν ∈ 𝓜̌` に絞った形（原文の主張そのもの） -/

/-- **原文第 1 式**: `μ, ν ∈ 𝓜̌` では `[check(Z)_μ, check(Z)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkZ_checkZ_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkZ M μ) (checkZ M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkZ_checkZ hM, deltaMod_add_one_eq hM hμ hν]

/-- **原文第 3 式**: `μ, ν ∈ 𝓜̌` では `[check(Y)_μ, check(Y)_ν]₊ = 2M δ_{ν, M+1-μ} I`。 -/
theorem acomm_checkY_checkY_of_mem (hM : M ≠ 0) {μ ν : ℤ}
    (hμ : CheckIndex M μ) (hν : CheckIndex M ν) :
    acomm (checkY M μ) (checkY M ν)
      = (2 * (M : ℂ) * (if ν = (M : ℤ) + 1 - μ then 1 else 0)) • (1 : TensorPow M) := by
  rw [acomm_checkY_checkY hM, deltaMod_add_one_eq hM hμ hν]

end Ising2D
