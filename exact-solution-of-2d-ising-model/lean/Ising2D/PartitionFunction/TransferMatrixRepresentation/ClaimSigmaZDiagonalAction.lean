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

Lean の定理との対応:

* `sigmaZ_eq_diagonal` ↔ `site_sigma_z_is_diagonal`（対角成分が `sgn(I m)` であることも含む）
* `sigmaZ_mulVec_basisVec` ↔ `sigma_z_diagonal_action`
* `sigmaZ_mul_sigmaZ_eq_diagonal` ↔ `site_sigma_z_product_is_diagonal`（対角成分が `sgn(I m) sgn(I m')` であることも含む。人手では `site_sigma_z_product_diagonal_entry`）
* `sigmaZ_mul_sigmaZ_mulVec_basisVec` ↔ `sigma_z_product_action`（人手の 6 行と同じ順:
  `mulVec_mulVec`（結合律）→ 作用 → `mulVec_smul` → 作用 → `smul_smul` → `mul_comm`）

人手と 1 対 1 でないのは `sigmaZ_eq_diagonal`・`sigmaZ_mulVec_basisVec`・`sigmaZ_mul_sigmaZ_eq_diagonal` の 3 つである。
人手は、場合分け（`σ^z e_{i_m} = μ(m)_ℂ e_{i_m}`）から固有ベクトルの等式を示し、対角性はクロネッカー積の成分の 0 の因子
（`σ_m^z`）と、行列の積の成分の和の各項が 0 であること（`σ_m^zσ_{m'}^z`）から別に示す。
Lean は対角性（`sigmaZ_eq_diagonal`）を先に示して作用をその系とし、積の対角性を `Matrix.diagonal_mul_diagonal` で閉じる。

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

/-- 原文の主張をスピン配置 `μ ∈ 𝔐` の言葉で書いた形
（`sgn(ι(μ)(m)) = μ(m)` を代入したもの）。 -/
theorem sigmaZ_mulVec_basisVec_spin (m : Fin M) (μ : SpinConf M) :
    sigmaZ m *ᵥ basisVec (configBasisIso M μ) =
      (((μ m : ℝ) : ℂ)) • basisVec (configBasisIso M μ) := by
  rw [sigmaZ_mulVec_basisVec, sgnC_configBasisIso]

end Ising2D
