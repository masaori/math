/-
# `σ^z_m` の基底 `f_{ι(μ)}` への作用（対角性）

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `bridge_002_claim_sigma_z_diagonal_action`（ラベル **`sigma_z_diagonal_action`**）:
  `σ^z_m f_{ι(μ)} = μ(m)_ℂ f_{ι(μ)}`
* `transfer_matrix_claim_sigma_z_product_action`（ラベル `sigma_z_product_action`）:
  `σ^z_m σ^z_{m'} f_{ι(μ)} = μ(m)_ℂ μ(m')_ℂ f_{ι(μ)}`
* `transfer_matrix_claim_site_sigma_z_is_diagonal`（ラベル `site_sigma_z_is_diagonal`）:
  `σ^z_m` は対角行列（`def_diagonal_matrix`）
* `transfer_matrix_claim_site_sigma_z_product_is_diagonal`（ラベル `site_sigma_z_product_is_diagonal`）:
  `σ^z_m σ^z_{m'}` は対角行列
* `transfer_matrix_claim_site_sigma_z_product_diagonal_entry`（ラベル `site_sigma_z_product_diagonal_entry`）:
  `(σ^z_m σ^z_{m'})_{ι(μ),ι(μ)} = μ(m)_ℂ μ(m')_ℂ`

Lean の定理との対応:

* `sigmaZ_eq_diagonal` ↔ `site_sigma_z_is_diagonal`（対角成分が `sgn(I m)` であることも含む）
* `sigmaZ_mulVec_basisVec` ↔ `sigma_z_diagonal_action`
* `sigmaZ_mul_sigmaZ_eq_diagonal`: `σ^z_m σ^z_{m'}` を対角成分 `sgn(I m) sgn(I m')` の対角行列として書いた形（人手の主張と 1 対 1 の具体版は、非対角成分が `sigmaZ_mul_sigmaZ_apply_of_ne`、対角成分が `sigmaZ_mul_sigmaZ_apply_configBasisIso_self`）
* `sigmaZ_mul_sigmaZ_apply_of_ne` ↔ `site_sigma_z_product_is_diagonal`（成分で述べた形。人手の準備と 3 行と同じ順）
* `sigmaZ_mul_sigmaZ_apply_configBasisIso_self` ↔ `site_sigma_z_product_diagonal_entry`（人手の 8 行と同じ順）
* `sigmaZ_mul_sigmaZ_mulVec_basisVec` ↔ `sigma_z_product_action`（人手の 6 行と同じ順:
  `mulVec_mulVec`（結合律）→ 作用 → `mulVec_smul` → 作用 → `smul_smul` → `mul_comm`）

人手と 1 対 1 でないのは `sigmaZ_eq_diagonal`・`sigmaZ_mulVec_basisVec` の 2 つである（`sigmaZ_mul_sigmaZ_eq_diagonal` は人手の主張の具体版ではない。`site_sigma_z_product_is_diagonal`・`site_sigma_z_product_diagonal_entry` の具体版は `sigmaZ_mul_sigmaZ_apply_of_ne`・`sigmaZ_mul_sigmaZ_apply_configBasisIso_self` に置いた）。
人手は、場合分け（`σ^z e_{i_m} = μ(m)_ℂ e_{i_m}`）から固有ベクトルの等式を示し、対角性はクロネッカー積の成分の 0 の因子
（`σ_m^z`）と、行列の積の成分の和の各項が 0 であること（`σ_m^zσ_{m'}^z`）から別に示す。
Lean は対角性（`sigmaZ_eq_diagonal`）を先に示して作用をその系とする（`sigmaZ_mul_sigmaZ_eq_diagonal` は積を `Matrix.diagonal_mul_diagonal` で閉じる）。

必要十分版: `Ising2D/NecSuf/SiteDiagonal.lean`（対角性の側、ラベル `site_sigma_z_is_diagonal`）。
そこで確かめたとおり、効いているのは「サイトごとの積 `siteProd` の成分が因子の成分の積である」
ことと「Pauli 行列 `σ^z` が対角行列であること」だけで、`σ^z` の具体的な成分も
複素数であることも効いていない。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.NecSuf.SiteDiagonal

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 各因子が対角行列なら、クロネッカー積も対角行列で、対角成分は因子の対角成分の積。

（必要十分版 `Ising2D.NecSuf.prod_diagonal_entry` の特殊化として証明する。） -/
theorem siteProd_diagonal (d : Fin M → Fin 2 → ℂ) :
    siteProd M (fun i => Matrix.diagonal (d i)) =
      Matrix.diagonal (fun I : Conf M => ∏ i : Fin M, d i (I i)) := by
  ext s t
  rw [siteProd_apply]
  by_cases h : s = t
  · subst h
    rw [Matrix.diagonal_apply_eq]
    exact Finset.prod_congr rfl fun i _ => Matrix.diagonal_apply_eq _ _
  · rw [Matrix.diagonal_apply_ne _ h]
    exact NecSuf.prod_entry_eq_zero_of_ne
      (fun i => (Matrix.diagonal (d i) : Matrix (Fin 2) (Fin 2) ℂ))
      (fun _ _ _ hab => Matrix.diagonal_apply_ne _ hab) s t h

/-- `σ^z = diagonal (sgn)`。原文の `σ^z e_1 = e_1`, `σ^z e_2 = -e_2` にあたる。 -/
theorem pauliZ_eq_diagonal : pauliZ = Matrix.diagonal sgnC := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [pauliZ, Matrix.diagonal, sgnC, sgn]

/-- **`σ^z_m` は基底 `(f_I)` に関して対角行列で、`f_I` の固有値は `sgn(I m)`。**
人手の `site_sigma_z_is_diagonal` に当たる。 -/
theorem sigmaZ_eq_diagonal (m : Fin M) :
    sigmaZ m = Matrix.diagonal (fun I : Conf M => sgnC (I m)) := by
  have h : (Function.update (1 : Fin M → Matrix (Fin 2) (Fin 2) ℂ) m pauliZ)
      = fun i => Matrix.diagonal (fun k => if i = m then sgnC k else 1) := by
    funext i
    by_cases hi : i = m
    · subst hi; simp [pauliZ_eq_diagonal]
    · simp [hi, Matrix.diagonal_one]
  rw [sigmaZ, siteOp_apply, h, siteProd_diagonal]
  congr 1
  funext I
  simp

/-- **原文の `σ^z_m f_{ι(μ)} = μ(m) f_{ι(μ)}`。** -/
theorem sigmaZ_mulVec_basisVec (m : Fin M) (I : Conf M) :
    sigmaZ m *ᵥ basisVec I = sgnC (I m) • basisVec I := by
  rw [sigmaZ_eq_diagonal, basisVec, Matrix.diagonal_mulVec_single, mul_one]
  funext J
  by_cases h : J = I
  · subst h; simp
  · simp [Pi.single_apply, h]

/-- 人手の `site_sigma_z_product_is_diagonal`（`σ^z_m σ^z_{m'}` は対角行列）に当たる。 -/
theorem sigmaZ_mul_sigmaZ_eq_diagonal (m m' : Fin M) :
    sigmaZ m * sigmaZ m' = Matrix.diagonal (fun I : Conf M => sgnC (I m) * sgnC (I m')) := by
  rw [sigmaZ_eq_diagonal, sigmaZ_eq_diagonal, Matrix.diagonal_mul_diagonal]

theorem sigmaZ_mul_sigmaZ_mulVec_basisVec (m m' : Fin M) (I : Conf M) :
    (sigmaZ m * sigmaZ m') *ᵥ basisVec I = (sgnC (I m) * sgnC (I m')) • basisVec I := by
  rw [← Matrix.mulVec_mulVec, sigmaZ_mulVec_basisVec, Matrix.mulVec_smul,
    sigmaZ_mulVec_basisVec, smul_smul, mul_comm]

/-- **人手 `site_sigma_z_product_is_diagonal`**（`def_diagonal_matrix` に沿って成分で述べた形）:
`k ≠ l` なら `(σ^z_m σ^z_{m'})_{kl} = 0_ℂ`。

人手の準備（各 `q` で `(σ^z_m)_{kq}(σ^z_{m'})_{ql} = 0_ℂ`。`q ≠ k` なら `site_sigma_z_is_diagonal` と
`complex_zero_times_is_zero`、`q = k` なら `site_sigma_z_is_diagonal` を `m'` で使い `complex_times_zero_is_zero`）は `hterm`、
3 行の鎖は同じ順の `calc` である。`site_sigma_z_is_diagonal` は `sigmaZ_eq_diagonal` の非対角成分
（`Matrix.diagonal_apply_ne`）、`finite_sum_of_complex_zeros` は具体版が無く `Finset.sum_const_zero`（既存の慣行どおり）。 -/
theorem sigmaZ_mul_sigmaZ_apply_of_ne (m m' : Fin M) {k l : Conf M} (hkl : k ≠ l) :
    (sigmaZ m * sigmaZ m') k l = 0 := by
  have hterm : ∀ q : Conf M, sigmaZ m k q * sigmaZ m' q l = 0 := fun q => by
    by_cases hq : q ≠ k
    · rw [sigmaZ_eq_diagonal m, Matrix.diagonal_apply_ne _ (Ne.symm hq)]
                                                              -- `site_sigma_z_is_diagonal`
      exact zero_mul _                                        -- `complex_zero_times_is_zero`
    · rw [not_not] at hq
      subst hq
      rw [sigmaZ_eq_diagonal m', Matrix.diagonal_apply_ne _ hkl]
                                                              -- `site_sigma_z_is_diagonal`（`m → m'`）
      exact mul_zero _                                        -- `complex_times_zero_is_zero`
  calc (sigmaZ m * sigmaZ m') k l
      = ∑ q : Conf M, sigmaZ m k q * sigmaZ m' q l := Matrix.mul_apply  -- `mat_mult`
    _ = ∑ _q : Conf M, (0 : ℂ) := Finset.sum_congr rfl fun q _ => hterm q
                                                              -- 準備の各項が `0_ℂ` であることを各 `q` へ
    _ = 0 := Finset.sum_const_zero                            -- `finite_sum_of_complex_zeros`

/-- **人手 `site_sigma_z_product_diagonal_entry`**: `k := ι(μ)` について
`(σ^z_m σ^z_{m'})_{kk} = μ(m)_ℂ μ(m')_ℂ`。

人手の 8 行と同じ順の `calc` である。準備の「`l ≠ k` なら `(σ^z_mσ^z_{m'})_{kl}(f_{ι(μ)})_l = 0_ℂ`」は `hoff`
（`site_sigma_z_product_is_diagonal` は `sigmaZ_mul_sigmaZ_apply_of_ne`、`complex_zero_times_is_zero` は `zero_mul`）。
`config_basis_vector_own_component`（`(f_I)_{ν(I)} = 1_ℂ`）は具体版が無く、`basisVec` の定義 `Pi.single I 1` の
`Pi.single_eq_same`、`finite_sum_with_single_nonzero_term` は `Finset.sum_eq_single`、`complex_numbers_form_a_field` の
乗法の単位元は `mul_one` である（いずれも既存の慣行どおり）。`sigma_z_product_action` は
`sigmaZ_mul_sigmaZ_mulVec_basisVec` を `sgnC_configBasisIso`（`sgn(ι(μ)(m)) = μ(m)`）で `μ` の言葉に読んだもの。
Lean のベクトルの添字は `ι(μ)` そのものなので、人手の `k = ν(ι(μ))` の `ν` は添字の読み方である。 -/
theorem sigmaZ_mul_sigmaZ_apply_configBasisIso_self (μ : SpinConf M) (m m' : Fin M) :
    (sigmaZ m * sigmaZ m') (configBasisIso M μ) (configBasisIso M μ)
      = ((μ m : ℝ) : ℂ) * ((μ m' : ℝ) : ℂ) := by
  set k := configBasisIso M μ
  have hoff : ∀ l : Conf M, l ≠ k → (sigmaZ m * sigmaZ m') k l * basisVec k l = 0 :=
    fun l hl => by
      rw [sigmaZ_mul_sigmaZ_apply_of_ne m m' (Ne.symm hl)]   -- `site_sigma_z_product_is_diagonal`
      exact zero_mul _                                        -- `complex_zero_times_is_zero`
  calc (sigmaZ m * sigmaZ m') k k
      = (sigmaZ m * sigmaZ m') k k * 1 := (mul_one _).symm   -- `complex_numbers_form_a_field` の乗法の単位元
    _ = (sigmaZ m * sigmaZ m') k k * basisVec k k := by
        rw [basisVec, Pi.single_eq_same]                     -- `config_basis_vector_own_component`（`I → ι(μ)`）
    _ = ∑ l : Conf M, (sigmaZ m * sigmaZ m') k l * basisVec k l :=
        (Finset.sum_eq_single k (fun l _ hl => hoff l hl)
          (fun h => absurd (Finset.mem_univ _) h)).symm      -- `finite_sum_with_single_nonzero_term`（準備の `hoff`）
    _ = ((sigmaZ m * sigmaZ m') *ᵥ basisVec k) k := rfl      -- `mat_mult`
    _ = ((((μ m : ℝ) : ℂ) * ((μ m' : ℝ) : ℂ)) • basisVec k) k := by
        rw [sigmaZ_mul_sigmaZ_mulVec_basisVec, sgnC_configBasisIso, sgnC_configBasisIso]
                                                              -- `sigma_z_product_action`
    _ = ((μ m : ℝ) : ℂ) * ((μ m' : ℝ) : ℂ) * basisVec k k := by
        rw [Pi.smul_apply, smul_eq_mul]                      -- `def_matrix_scalar_multiple`
    _ = ((μ m : ℝ) : ℂ) * ((μ m' : ℝ) : ℂ) * 1 := by
        rw [basisVec, Pi.single_eq_same]                     -- `config_basis_vector_own_component`（`I → ι(μ)`）
    _ = ((μ m : ℝ) : ℂ) * ((μ m' : ℝ) : ℂ) := mul_one _       -- `complex_numbers_form_a_field` の乗法の単位元

/-- 原文の主張をスピン配置 `μ ∈ 𝔐` の言葉で書いた形
（`sgn(ι(μ)(m)) = μ(m)` を代入したもの）。 -/
theorem sigmaZ_mulVec_basisVec_spin (m : Fin M) (μ : SpinConf M) :
    sigmaZ m *ᵥ basisVec (configBasisIso M μ) =
      (((μ m : ℝ) : ℂ)) • basisVec (configBasisIso M μ) := by
  rw [sigmaZ_mulVec_basisVec, sgnC_configBasisIso]

end Ising2D
