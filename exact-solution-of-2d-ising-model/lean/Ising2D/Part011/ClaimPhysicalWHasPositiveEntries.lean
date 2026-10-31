/-
# 具体的な `W = V_1^{1/2} V_2 V_1^{1/2}` の成分はすべて正

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_004_claim_W_has_positive_entries`、ラベル **`W_has_positive_entries`**）

## 人手証明との対応

人手の行・列番号 `ι(μ)`（`def_config_basis_iso`）は Lean の `configBasisIso M μ`、
人手の `μ(m+1)`（周期端で `μ(M_col+1) := μ(1)`）は `μ (nextSite m)` である。

| 人手証明 | 本ファイル |
| --- | --- |
| Step 1: `(V_1^{1/2})_{ι(μ),ι(μ')}` は `μ = μ'` で `exp(½K_1∑_m μ(m)μ(m+1))`、それ以外で `0` | `physicalV1halfC_apply_configBasisIso`（`V_1^{1/2} = exp(½K_1D)` の成分。`sigma_z_diagonal_action` で `½K_1D` を対角行列に書き、`exp_of_diagonal_matrix` で成分を読む `V1PauliForm_apply_configBasisIso` を結合定数 `K_1/2` で引く）・`physicalV1halfR_apply_configBasisIso`（その実成分。前者から導く） |
| Step 1 の `exp(…) > 0` | `physicalV1halfR_apply_configBasisIso_self_pos` |
| Step 2: `(V_2)_{ι(μ),ι(μ')} = exp(K_2∑_m μ(m)μ'(m)) > 0` | `V2_apply_configBasisIso`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`、`def_transfer_matrix` の `V_2` の成分）・`physicalV2R_apply_configBasisIso`（その実成分。前者から導く）・`physicalV2R_apply_configBasisIso_pos` |
| Step 3 の 1〜4 行目（`W` の定義、行列の積の定義、`j ≠ ι(μ)` の項が `0`、`k ≠ ι(μ')` の項が `0`） | `physicalSymTransferR_apply_configBasisIso` の式変形の各行。3・4 行目の「Step 1 の対角性」は `physicalV1halfR_offDiag`（Step 1 の補題の `μ ≠ μ'` の場合） |
| Step 3 の「3 つの因子はいずれも正」と主張 | `W_has_positive_entries_physical` |

Lean の `W`（`physicalSymTransferR`）は実行列で、その成分を `ℂ` へ埋め込んだものが人手の
`W = V_1^{1/2}V_2V_1^{1/2}`（`physicalSymTransferC`）である（`physicalSymTransferC_eq_map`）。
Step 1・Step 2 の実成分は、人手の `V_1^{1/2} = exp(½K_1D)`・`V_2` の成分（複素数）から
`physicalV1halfC_eq_map`・`physicalV2C_eq_map` と `ℝ → ℂ` の単射性で読み取る。この読み取りの段は人手に無い
（人手は `ℝ ⊂ ℂ` の包含を明示せずに使う）。

`EvenSectorBridge` が受け取る形 `∀ k l, 0 < W k l` は、`ι` が全単射であること
（`def_config_basis_iso`）から `physicalSymTransferR_pos` で得る。この最後の段は人手の主張の
言い換え（`𝓘` の任意の元は `ι(μ)` の形）であり、人手には書かれていない。

必要十分版は `NecSuf/SandwichByDiagonal.lean`（Step 3 と同じ式変形を、有限の添字と
結合律・可換律を仮定しない半環の係数で書いたもの）。具体版をその特殊化として導出するのは
`ClaimPhysicalWHasPositiveEntriesFromNecSuf.lean`。
-/
import Ising2D.Part011.PhysicalSymTransferBridge

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 1: `V_1^{1/2}` は正の対角行列 -/

/-- **人手 Step 1**: `V_1^{1/2} = exp(½K_1D)`（`def_transfer_matrix_square_root`）の成分は、
`μ = μ'` で `exp(½K_1∑_m μ(m)μ(m+1))`、それ以外で `0`。

`V1PauliForm_apply_configBasisIso`（`sigma_z_diagonal_action` の `sum_sigmaZ_sigmaZ_eq_diagonal` で `K D` を対角行列に書き、
`exp_of_diagonal_matrix` の `matrixExp_diagonal_apply` で成分を読む）を結合定数 `K_1/2` で引く。 -/
theorem physicalV1halfC_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    physicalV1halfC M K1 (configBasisIso M μ) (configBasisIso M μ')
      = ((if μ = μ' then
            Real.exp ((K1 / 2) * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ))
          else 0 : ℝ) : ℂ) := by
  rw [physicalV1halfC, V1PauliForm_apply_configBasisIso (K1 / 2)]
  by_cases h : μ = μ'
  · rw [if_pos h, if_pos h, one_mul]
  · rw [if_neg h, if_neg h, zero_mul]

/-- 人手 Step 1 の `V_1^{1/2}` の実成分（`ι` による番号付け）。
`physicalV1halfC_apply_configBasisIso` の両辺を `physicalV1halfC_eq_map` で実成分の埋め込みと読み、
`ℝ → ℂ` の単射性で実数の等式に移す。 -/
theorem physicalV1halfR_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ')
      = if μ = μ' then
          Real.exp ((K1 / 2) * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ))
        else 0 := by
  apply Complex.ofReal_injective
  rw [← physicalV1halfC_apply_configBasisIso, physicalV1halfC_eq_map K1, Matrix.map_apply,
    Complex.ofRealHom_eq_coe]

/-- 人手 Step 1 の対角性: `V_1^{1/2}` の非対角成分は `0`（行・列番号を `ι(μ), ι(μ')` と書き、
`physicalV1halfR_apply_configBasisIso` の `μ ≠ μ'` の場合を使う）。 -/
theorem physicalV1halfR_offDiag (K1 : ℝ) (i j : Conf M) (hij : i ≠ j) :
    physicalV1halfR M K1 i j = 0 := by
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective i
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective j
  rw [physicalV1halfR_apply_configBasisIso, if_neg (fun h => hij (by rw [h]))]

/-- 人手 Step 1 の `exp(½K_1∑_m μ(m)μ(m+1)) > 0`（実指数関数の正値性）。 -/
theorem physicalV1halfR_apply_configBasisIso_self_pos (K1 : ℝ) (μ : SpinConf M) :
    0 < physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ) := by
  rw [physicalV1halfR_apply_configBasisIso, if_pos rfl]
  exact Real.exp_pos _

/-! ## Step 2: `V_2` の成分は正 -/

/-- 人手 Step 2 の `V_2` の実成分（`ι` による番号付け）。
`def_transfer_matrix` の `V_2` の成分 `V2_apply_configBasisIso` を `physicalV2C_eq_map` で実成分の埋め込みと読み、
`ℝ → ℂ` の単射性で実数の等式に移す。 -/
theorem physicalV2R_apply_configBasisIso (K2 : ℝ) (μ μ' : SpinConf M) :
    physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ')
      = Real.exp (K2 * ∑ m : Fin M, (μ m : ℝ) * (μ' m : ℝ)) := by
  apply Complex.ofReal_injective
  rw [← V2_apply_configBasisIso, physicalV2C_eq_map K2, Matrix.map_apply, Complex.ofRealHom_eq_coe]

/-- 人手 Step 2 の「指数は実数なので値は正」（実指数関数の正値性）。 -/
theorem physicalV2R_apply_configBasisIso_pos (K2 : ℝ) (μ μ' : SpinConf M) :
    0 < physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ') := by
  rw [physicalV2R_apply_configBasisIso]
  exact Real.exp_pos _

/-! ## Step 3: `W` の成分は三つの正の数の積 -/

/-- **人手 Step 3 の式変形**:
`W_{ι(μ),ι(μ')} = (V_1^{1/2})_{ι(μ),ι(μ)} (V_2)_{ι(μ),ι(μ')} (V_1^{1/2})_{ι(μ'),ι(μ')}`。 -/
theorem physicalSymTransferR_apply_configBasisIso (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ')
      = physicalV1halfR M K1 (configBasisIso M μ) (configBasisIso M μ)
          * physicalV2R M K2 (configBasisIso M μ) (configBasisIso M μ')
          * physicalV1halfR M K1 (configBasisIso M μ') (configBasisIso M μ') := by
  set B := physicalV1halfR M K1
  set V := physicalV2R M K2
  set I := configBasisIso M μ
  set I' := configBasisIso M μ'
  -- `B` の非対角成分は `0`（Step 1 の対角性）
  have hBoff : ∀ i j : Conf M, i ≠ j → B i j = 0 := physicalV1halfR_offDiag K1
  calc physicalSymTransferR M K1 K2 I I'
      = (B * V * B) I I' := rfl  -- (∵ W = V_1^{1/2} V_2 V_1^{1/2})
    _ = ∑ k : Conf M, (∑ j : Conf M, B I j * V j k) * B k I' := by
        -- (∵ 行列の積の定義)
        rw [Matrix.mul_apply]
        simp only [Matrix.mul_apply]
    _ = ∑ k : Conf M, (B I I * V I k) * B k I' := by
        -- (∵ Step 1 の対角性で j ≠ ι(μ) の項は 0)
        refine Finset.sum_congr rfl fun k _ => ?_
        rw [Finset.sum_eq_single I (fun j _ hj => by rw [hBoff I j (Ne.symm hj), zero_mul])
          (fun h => absurd (Finset.mem_univ I) h)]
    _ = B I I * V I I' * B I' I' := by
        -- (∵ Step 1 の対角性で k ≠ ι(μ') の項は 0)
        rw [Finset.sum_eq_single I' (fun k _ hk => by rw [hBoff k I' hk, mul_zero])
          (fun h => absurd (Finset.mem_univ I') h)]

/-- **人手 `W_has_positive_entries`**: 具体的な `W = V_1^{1/2}V_2V_1^{1/2}` について
`W_{ι(μ),ι(μ')} > 0`（`μ, μ' ∈ 𝔐`）。 -/
theorem W_has_positive_entries_physical (K1 K2 : ℝ) (μ μ' : SpinConf M) :
    0 < physicalSymTransferR M K1 K2 (configBasisIso M μ) (configBasisIso M μ') := by
  rw [physicalSymTransferR_apply_configBasisIso]
  -- (∵ 3 つの因子はいずれも正の実数なので、積も正)
  exact mul_pos (mul_pos (physicalV1halfR_apply_configBasisIso_self_pos K1 μ)
    (physicalV2R_apply_configBasisIso_pos K2 μ μ'))
    (physicalV1halfR_apply_configBasisIso_self_pos K1 μ')

/-- `W` のすべての成分が正（`ι` が全単射なので、任意の行・列番号は `ι(μ)` の形）。
`EvenSectorBridge.rayleighSup_sandwich_LambdaM` の入力の形。 -/
theorem physicalSymTransferR_pos (K1 K2 : ℝ) (k l : Conf M) :
    0 < physicalSymTransferR M K1 K2 k l := by
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective k
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective l
  exact W_has_positive_entries_physical K1 K2 μ μ'

end Ising2D
