/-
# `ε` の固有空間への射影子 `P^{(+)}` とその性質

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `bridge_008_definition_epsilon_projectors`（ラベル **`def_epsilon_projectors`**）
  — `P^{(+)} := (1/2)(I + ε)`（`Ising2D.epsProjPlus`）
* `bridge_009_claim_epsilon_projector_properties`（ラベル **`epsilon_projector_properties`**）
  — (1) `(P^{(+)})^2 = P^{(+)}`（`epsProjPlus_sq`）、
    (2) `im P^{(+)} = 𝓕^{(+)}`（`epsilon_projector_properties_image`。二つの包含は
    `epsProjPlus_mulVec_mem` と `epsProjPlus_mulVec_eq_self`）

## 符号引数つきの一般形（補助）

`epsProj M η := (1/2)(I + ηε)` は符号引数つきの補助の一般形で、`P^{(+)}` は `η = 1`
（`epsProjPlus_eq_epsProj`）。`η = -1` の `P^{(-)}` と、`P^{(+)}P^{(-)} = 0`・`P^{(+)} + P^{(-)} = I`
（`epsProj_mul_epsProj_neg` / `epsProj_add_epsProj_neg`）は、人手の本文から参照用ノート
`structured-latex/notes/minus_sector_not_adopted.ts` へ退避した `(−)` セクターの議論
（`partition_function_sector_decomposition` ほか）の形式化の記録として残してある。

(1) は本文の 15 行の鎖（スカラー倍の出し入れ・分配律・単位行列・`ε² = I`・成分ごとの加法）を
`TensorPow M` の具体版の主張で一行ずつ辿る（`epsProjPlus_sq`）。
必要十分版は `Ising2D/NecSuf/Projector.lean`（同じラベル）。一般形がその特殊化であることは
導出 `ClaimEpsilonProjectorsFromNecSuf.lean` だけが述べる。

(2)（`im P^{(+)} = 𝓕^{(+)}`）は「行列がベクトルに作用する」という具体的な文脈が要るので、
ベクトルの言葉で直接述べる。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionTransferMatrixSymbols
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowMatMultDistributesOverSum
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## 射影子の定義 -/

/-- 補助: 符号引数つきの一般形 `(I + ηε)/2`（`η = 1` が人手の `P^{(+)}`）。 -/
noncomputable def epsProj (M : ℕ) (η : ℂ) : TensorPow M :=
  (1 / 2 : ℂ) • (1 + η • epsilon M)

/-- `ε² = I`（人手 `epsilon_square_and_eigenvalues`。既存の `Ising2D.epsilon_mul_self` の言い換え）。 -/
theorem epsilon_sq : epsilon M * epsilon M = 1 := epsilon_mul_self

/-- `η² = 1` のとき `(η ε)² = I`。 -/
theorem eta_smul_epsilon_sq {η : ℂ} (hη : η * η = 1) :
    (η • epsilon M) * (η • epsilon M) = 1 := by
  rw [smul_mul_smul_comm, epsilon_sq, hη, one_smul]

/-- 補助: 一般形の冪等性（退避した `(−)` セクターの議論が使う）。 -/
theorem epsProj_sq {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M η = epsProj M η := by
  rw [epsProj, smul_mul_smul_comm, mul_add, add_mul, add_mul, one_mul, one_mul, mul_one,
    eta_smul_epsilon_sq hη, add_comm (η • epsilon M) 1, ← two_smul ℂ (1 + η • epsilon M), smul_smul]
  norm_num

/-- 退避した `(−)` セクターの議論の記録: `P^{(+)}P^{(-)} = 0`。 -/
theorem epsProj_mul_epsProj_neg {η : ℂ} (hη : η * η = 1) :
    epsProj M η * epsProj M (-η) = 0 := by
  rw [epsProj, epsProj, smul_mul_smul_comm, neg_smul, ← sub_eq_add_neg, mul_sub, add_mul, add_mul,
    one_mul, one_mul, mul_one, eta_smul_epsilon_sq hη, add_comm (η • epsilon M) 1, sub_self, smul_zero]

/-- 退避した `(−)` セクターの議論の記録: `P^{(+)} + P^{(-)} = I`。 -/
theorem epsProj_add_epsProj_neg (η : ℂ) :
    epsProj M η + epsProj M (-η) = 1 := by
  rw [epsProj, epsProj, ← smul_add, neg_smul, add_add_add_comm, add_neg_cancel, add_zero,
    ← two_smul ℂ (1 : TensorPow M), smul_smul]
  norm_num

/-! ## 一般形の像は `ε` の固有空間（補助） -/

/-- 補助: `ε (I + ηε)/2 = η (I + ηε)/2`。 -/
theorem epsilon_mul_epsProj {η : ℂ} (hη : η * η = 1) :
    epsilon M * epsProj M η = η • epsProj M η := by
  rw [epsProj, mul_smul_comm, smul_comm η (1 / 2 : ℂ)]
  congr 1
  rw [mul_add, mul_one, mul_smul_comm, epsilon_sq, smul_add, smul_smul, hη, one_smul,
    add_comm]

/-- 補助: 一般形で `ε ((I + ηε)/2 x) = η ((I + ηε)/2 x)`。 -/
theorem epsProj_mulVec_mem {η : ℂ} (hη : η * η = 1) (x : Conf M → ℂ) :
    epsilon M *ᵥ (epsProj M η *ᵥ x) = η • (epsProj M η *ᵥ x) := by
  rw [Matrix.mulVec_mulVec, epsilon_mul_epsProj hη, Matrix.smul_mulVec]

/-- 補助: 一般形で `ε f = η f` なら `(I + ηε)/2 f = f`。 -/
theorem epsProj_mulVec_eq_self {η : ℂ} (hη : η * η = 1) {f : Conf M → ℂ}
    (hf : epsilon M *ᵥ f = η • f) : epsProj M η *ᵥ f = f := by
  rw [epsProj, Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec,
    Matrix.smul_mulVec, hf, smul_smul, hη, one_smul, ← two_smul ℂ f, smul_smul]
  norm_num

/-! ## `P^{(+)}`（人手 `def_epsilon_projectors`, `epsilon_projector_properties`） -/

/-- **人手本文 `def_epsilon_projectors`**: `P^{(+)} := (1/2)(I + ε)`。 -/
noncomputable def epsProjPlus (M : ℕ) : TensorPow M :=
  (1 / 2 : ℂ) • (1 + epsilon M)

/-- `P^{(+)}` は一般形 `epsProj` の `η = 1`。 -/
theorem epsProjPlus_eq_epsProj : epsProjPlus M = epsProj M 1 := by
  rw [epsProjPlus, epsProj, one_smul]

/-- **人手本文 `epsilon_projector_properties` (1)**: `(P^{(+)})^2 = P^{(+)}`。
本文の鎖の各行と 1 対 1 に対応する（`scalar_multiple_is_associative` は具体版が無いので mathlib の `smul_smul`）。 -/
theorem epsProjPlus_sq : epsProjPlus M * epsProjPlus M = epsProjPlus M := by
  -- `ℂ` の数の等式 `(1/2)·(1/2) = 1/4`（包含で写した実数の積を `real_inclusion_preserves_product` で読む）
  have hquarter : (1 / 2 : ℂ) * (1 / 2 : ℂ) = (1 / 4 : ℂ) :=
    calc (1 / 2 : ℂ) * (1 / 2 : ℂ)
        = ((1 / 2 : ℝ) : ℂ) * ((1 / 2 : ℝ) : ℂ) := by norm_num        -- 包含で写した実数 `1/2`
      _ = (((1 / 2) * (1 / 2) : ℝ) : ℂ) := real_inclusion_mul _ _     -- `real_inclusion_preserves_product`
      _ = ((1 / 4 : ℝ) : ℂ) := by norm_num                             -- `ℝ` での `1/2·1/2 = 1/4`
      _ = (1 / 4 : ℂ) := by norm_num                                   -- 包含で写した実数 `1/4`
  -- `ℂ` の数の等式 `(1/4)·2 = 1/2`
  have hhalf : (1 / 4 : ℂ) * (2 : ℂ) = (1 / 2 : ℂ) :=
    calc (1 / 4 : ℂ) * (2 : ℂ)
        = ((1 / 4 : ℝ) : ℂ) * ((2 : ℝ) : ℂ) := by norm_num              -- 包含で写した実数 `1/4`・`2`
      _ = (((1 / 4) * 2 : ℝ) : ℂ) := real_inclusion_mul _ _            -- `real_inclusion_preserves_product`
      _ = ((1 / 2 : ℝ) : ℂ) := by norm_num                             -- `ℝ` での `1/4·2 = 1/2`
      _ = (1 / 2 : ℂ) := by norm_num                                   -- 包含で写した実数 `1/2`
  calc epsProjPlus M * epsProjPlus M
      = ((1 / 2 : ℂ) • (1 + epsilon M)) * ((1 / 2 : ℂ) • (1 + epsilon M)) := rfl
                                                        -- `def_epsilon_projectors`
    _ = (1 / 2 : ℂ) • ((1 + epsilon M) * ((1 / 2 : ℂ) • (1 + epsilon M))) :=
          smul_mul_matrix_tensorPow _ _ _               -- `scalar_multiple_factors_out_of_left_factor`
    _ = (1 / 2 : ℂ) • ((1 / 2 : ℂ) • ((1 + epsilon M) * (1 + epsilon M))) := by
          rw [mul_smul_matrix_tensorPow]                -- `scalar_multiple_factors_out_of_right_factor`
    _ = ((1 / 2 : ℂ) * (1 / 2 : ℂ)) • ((1 + epsilon M) * (1 + epsilon M)) :=
          smul_smul _ _ _                               -- `scalar_multiple_is_associative`
    _ = (1 / 4 : ℂ) • ((1 + epsilon M) * (1 + epsilon M)) := by
          rw [hquarter]         -- `real_inclusion_preserves_product` と `ℝ` での `1/2·1/2 = 1/4`
    _ = (1 / 4 : ℂ) • (1 * (1 + epsilon M) + epsilon M * (1 + epsilon M)) := by
          rw [add_mul_matrix_tensorPow]                 -- `mat_mult_distributes_over_sum_in_left_factor`
    _ = (1 / 4 : ℂ) • ((1 * 1 + 1 * epsilon M) + (epsilon M * 1 + epsilon M * epsilon M)) := by
          rw [mul_add_matrix_tensorPow, mul_add_matrix_tensorPow]
                                                        -- `mat_mult_distributes_over_sum_in_right_factor` を二つの積へ
    _ = (1 / 4 : ℂ) • ((1 + epsilon M) + (epsilon M * 1 + epsilon M * epsilon M)) := by
          rw [identity_matrix_mul_tensorPow, identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を `II`・`Iε` へ
    _ = (1 / 4 : ℂ) • ((1 + epsilon M) + (epsilon M + epsilon M * epsilon M)) := by
          rw [mul_identity_matrix_tensorPow]            -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = (1 / 4 : ℂ) • ((1 + epsilon M) + (epsilon M + 1)) := by
          rw [epsilon_mul_self]                         -- `εε = I`（`epsilon_square_and_eigenvalues`）
    _ = (1 / 4 : ℂ) • ((1 + epsilon M) + (1 + epsilon M)) :=
          congrArg (fun Y : TensorPow M => (1 / 4 : ℂ) • ((1 + epsilon M) + Y))
            (Matrix.ext fun I K => by rw [tensorPow_add_apply, tensorPow_add_apply, add_comm])
                                                        -- `def_matrix_sum` による成分ごとの加法の可換性
    _ = (1 / 4 : ℂ) • ((2 : ℂ) • (1 + epsilon M)) :=
          congrArg (fun Y : TensorPow M => (1 / 4 : ℂ) • Y)
            (Matrix.ext fun I K => by rw [tensorPow_add_apply, tensorPow_smul_apply, two_mul])
                                                        -- `def_matrix_sum` と `def_matrix_scalar_multiple` により成分ごとに `z + z = 2z`
    _ = ((1 / 4 : ℂ) * (2 : ℂ)) • (1 + epsilon M) :=
          smul_smul _ _ _                               -- `scalar_multiple_is_associative`
    _ = (1 / 2 : ℂ) • (1 + epsilon M) := by
          rw [hhalf]          -- `real_inclusion_preserves_product` と `ℝ` での `1/4·2 = 1/2`
    _ = epsProjPlus M := rfl                            -- `def_epsilon_projectors`

/-- **人手本文 `epsilon_projector_properties` (2) の `(⊆)`**:
`P^{(+)} x ∈ 𝓕^{(+)}`、すなわち `ε (P^{(+)} x) = P^{(+)} x`。

人手の鎖（`ε y = ε P^{(+)} y = (1/2)(ε + ε²) y = (1/2)(I + ε) y = y`）は、行列の等式
`ε P^{(+)} = P^{(+)}`（`epsilon_mul_epsProj` の `η = 1`）を `x` に作用させる形で辿る。 -/
theorem epsProjPlus_mulVec_mem (x : Conf M → ℂ) :
    epsilon M *ᵥ (epsProjPlus M *ᵥ x) = epsProjPlus M *ᵥ x := by
  rw [epsProjPlus_eq_epsProj, epsProj_mulVec_mem (by norm_num) x, one_smul]

/-- **人手本文 `epsilon_projector_properties` (2) の `(⊇)`**: `ε f = f` なら `P^{(+)} f = f`。 -/
theorem epsProjPlus_mulVec_eq_self {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    epsProjPlus M *ᵥ f = f := by
  rw [epsProjPlus_eq_epsProj]
  exact epsProj_mulVec_eq_self (by norm_num) (by rw [hf, one_smul])

/-- **人手本文 `epsilon_projector_properties` (2)**: `im P^{(+)} = 𝓕^{(+)}`
（`𝓕^{(+)}` は `def_even_eigenvectors_of_epsilon` の `{f | ε f = f}`）。 -/
theorem epsilon_projector_properties_image :
    Set.range (fun x : Conf M → ℂ => epsProjPlus M *ᵥ x)
      = {f : Conf M → ℂ | epsilon M *ᵥ f = f} := by
  ext y
  constructor
  · rintro ⟨x, rfl⟩
    exact epsProjPlus_mulVec_mem x
  · intro hy
    exact ⟨y, epsProjPlus_mulVec_eq_self hy⟩

end Ising2D
