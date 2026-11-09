/-
# `V_1` のパウリ行列表示

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `transfer_matrix_definition_site_pauli_periodic_extension`
  （ラベル **`def_site_pauli_periodic_extension`**）: `σ^z_{M_col+1} := σ^z_1`
* `transfer_matrix_claim_first_transfer_matrix_pauli_form`
  （ラベル **`first_transfer_matrix_pauli_form`**）

主張: `def_transfer_matrix` で成分により定めた `V_1`（`Ising2D.V1`）は
`V_1 = exp(K_1 ∑_{m=1}^{M_col} σ^z_m σ^z_{m+1})` と表せる。

`V1PauliForm M K1` はこの**右辺の式**に付けた名前であり、`V_1` の定義ではない。
結合定数は `K1 : ℂ` の一般の値で定義しておき（`RoutesNotAdopted/MinusSector/` の偶奇セクターの議論は
この一般形のまま使う）、人手の主張は `K1 : ℝ` を埋め込んだ値について述べる
（`first_transfer_matrix_pauli_form`）。人手は `K_1 > 0` を置くが、証明は正値性を使わない。

## 人手証明との対応

* `def_site_pauli_periodic_extension` の `σ^z_{M_col+1} := σ^z_1` は、Lean では添字の巡回後者
  `nextSite` で `σ^z_{m+1}` を `sigmaZ (nextSite m)` と書くことで表す
  （`sigmaZ_nextSite_of_last` が `m = M_col` での `σ^z_{M_col+1} = σ^z_1`）。
  このため人手が `m^+` を置いて `σ^z_{m+1} = σ^z_{m^+}`・`μ(m+1) = μ(m^+)` を各項へ当てる行は、Lean では段が無い。
* 準備の `d(μ) := ∑_m μ(m)μ(m+1)` → `adjacentSpinProductSum`。
* 中間目標「`D` は対角行列」（`D_{kl} = 0_ℂ`、`k ≠ l` の 4 行）→ `sum_sigmaZ_sigmaZ_apply_of_ne`。
* 中間目標「`D` の対角成分」（`D_{kk} = d(μ)_ℂ` の 7 行。`real_inclusion_preserves_product` を各項へ、
  `real_inclusion_preserves_finite_sum`）→ `sum_sigmaZ_sigmaZ_apply_configBasisIso_self`。
* 中間目標「`K_1D` も対角行列で、対角成分は `(K_1)_ℂ d(μ)_ℂ`」→ `K1SmulD_apply_of_ne`（3 行）・
  `K1SmulD_apply_configBasisIso_self`（2 行）。`def_diagonal_matrix` を Lean の `Matrix.diagonal` へ読み替える段が `K1SmulD_eq_diagonal`。
* 中間目標「成分の一致」の 7 行 → `V1PauliForm_apply_configBasisIso` の `calc`。
  * 1 行目・5 行目の `config_numbering_equals_kronecker_numbering`（`ord(μ)` と `ν(ι(μ))` の読み替え）は、
    Lean では行列の添字が `ι(μ)` そのもの
    （`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean` 冒頭の「行列の添字」）なので段は無い。
  * 2 行目の `exp_of_diagonal_matrix` を対角行列 `K_1D` へ → `matrixExp_diagonal_apply`。
  * 3 行目の `real_inclusion_preserves_product` → `real_inclusion_mul`、4 行目の `complex_exp_of_real_argument` →
    具体版が無く `Complex.ofReal_exp`。mathlib の `push_cast`・`Complex.ofReal_mul` は使わない。
  * 6 行目の `ord(μ) = ord(μ') ⟺ μ = μ'`（`row_configuration_numbering_bijective` の単射性）
    → Lean の添字では `ι(μ) = ι(μ') ⟺ μ = μ'`（`configBasisIso_eq_iff`）。
  * 7 行目の `= (V_1)_{ord(μ),ord(μ')}`（`def_transfer_matrix`）→ `V1_apply_configBasisIso`
    （`first_transfer_matrix_pauli_form` の中で当てる）。
* 「全射性より、すべての行・列番号の組は `(ord(μ), ord(μ'))` の形に書ける」
  → `ι` の全射性（`(configBasisIso M).surjective`）。以上が `first_transfer_matrix_pauli_form`。

人手 `W_has_positive_entries` の Step 1 の `D` の 2 本の鎖も同じ式なので、
`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimPhysicalWHasPositiveEntries.lean` は本ファイルの
`adjacentSpinProductSum`・`sum_sigmaZ_sigmaZ_apply_of_ne`・`sum_sigmaZ_sigmaZ_apply_configBasisIso_self` を引く。

必要十分版はこの主張には置かない。内容は「対角行列の指数関数」（必要十分版は
`Ising2D/NecSuf/ExpDiagonal.lean`）と「因子が対角なら積も対角」（必要十分版は
`Ising2D/NecSuf/SiteDiagonal.lean`）の合成であり、本ファイル固有の内容は
具体的な行列 `V_1` の成分定義とパウリ行列表示の突き合わせだからである。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionTransferMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimSigmaZDiagonalAction
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesProduct
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimExpOfDiagonalMatrix

namespace Ising2D

variable {M : ℕ}

/-! ## `σ^z_{M_col+1} := σ^z_1`（`def_site_pauli_periodic_extension`） -/

/-- 人手の周期的な延長 `σ^z_{M_col+1} = σ^z_1`: 最後のサイト（Lean の `(m : ℕ) + 1 = M`）の
次のサイトは最初のサイト（Lean の `0`）である。 -/
theorem sigmaZ_nextSite_of_last {m : Fin M} (h : (m : ℕ) + 1 = M) :
    sigmaZ (nextSite m) = sigmaZ (⟨0, m.pos⟩ : Fin M) := by
  congr 1
  exact Fin.ext (nextSite_val_of_last h)

/-! ## パウリ行列表示の右辺 -/

/-- **人手 `first_transfer_matrix_pauli_form` の右辺 `exp(K_1 ∑_m σ^z_m σ^z_{m+1})`**
（`K1 : ℂ` の一般の値で定義する）。 -/
noncomputable def V1PauliForm (M : ℕ) (K1 : ℂ) : TensorPow M :=
  matExp (K1 • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))

/-! ## 準備: `d(μ)` -/

/-- 人手の準備の `d(μ) := ∑_{m=1}^{M_col} μ(m)μ(m+1) ∈ ℝ`（`def_finite_sum_of_real_numbers` の和）。
人手の `μ(m+1)`（周期規約 `μ(M_col+1) := μ(1)`）は Lean の `μ (nextSite m)` である。
人手 `W_has_positive_entries` の準備の `d(μ)` も同じ式で、`ClaimPhysicalWHasPositiveEntries.lean` はこれを引く。 -/
noncomputable def adjacentSpinProductSum (μ : SpinConf M) : ℝ :=
  ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)

/-! ## 中間目標「`D` は対角行列」 -/

/-- **人手の中間目標「`D` は対角行列」の鎖**（`p ≠ q`）: `D = ∑_m σ^z_mσ^z_{m+1}` について `D_{pq} = 0_ℂ`。

人手の 4 行のうち 2 行目（`σ^z_{m+1} = σ^z_{m^+}` を各項へ）は、Lean では `σ^z_{m+1}` を最初から
`sigmaZ (nextSite m)`（`= σ^z_{m^+}`、`def_site_pauli_periodic_extension`）と書くので、添字の読み方であって段は無い。
`finite_sum_of_matrices_entrywise` は具体版が無く `Matrix.sum_apply`、`finite_sum_of_complex_zeros` は
`Finset.sum_const_zero`（既存の慣行どおり）。人手 `W_has_positive_entries` の Step 1 の `D_{pq}` の 4 行も同じ鎖である。 -/
theorem sum_sigmaZ_sigmaZ_apply_of_ne {p q : Conf M} (hpq : p ≠ q) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q = 0 :=
  calc (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q
      = ∑ m : Fin M, (sigmaZ m * sigmaZ (nextSite m)) p q :=
        Matrix.sum_apply _ _ _ _                              -- `finite_sum_of_matrices_entrywise`
    _ = ∑ _m : Fin M, (0 : ℂ) :=
        Finset.sum_congr rfl fun m _ =>
          sigmaZ_mul_sigmaZ_apply_of_ne m (nextSite m) hpq     -- `site_sigma_z_product_is_diagonal` を各 `(m, m^+)` へ
    _ = 0 := Finset.sum_const_zero                            -- `finite_sum_of_complex_zeros`

/-! ## 中間目標「`D` の対角成分」 -/

/-- **人手の中間目標「`D` の対角成分」の鎖**（`k := ν(ι(μ))`）: `D_{kk} = d(μ)_ℂ`。

人手の 7 行のうち 2 行目（`σ^z_{m+1} = σ^z_{m^+}`）と 6 行目（`μ(m+1) = μ(m^+)`）は、Lean では両方を最初から
`nextSite m` で書くので、添字の読み方であって段は無い。`real_inclusion_preserves_product` は `real_inclusion_mul`、
`real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype_or_empty`
（Lean の主張は `M = 0` も含むので、空の和の場合を分ける版）。
人手 `W_has_positive_entries` の Step 1 の `D_{kk}` の 7 行も同じ鎖である。 -/
theorem sum_sigmaZ_sigmaZ_apply_configBasisIso_self (μ : SpinConf M) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = ((adjacentSpinProductSum μ : ℝ) : ℂ) :=
  calc (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = ∑ m : Fin M, (sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ) :=
        Matrix.sum_apply _ _ _ _                              -- `finite_sum_of_matrices_entrywise`
    _ = ∑ m : Fin M, ((μ m : ℝ) : ℂ) * ((μ (nextSite m) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun m _ =>
          sigmaZ_mul_sigmaZ_apply_configBasisIso_self μ m (nextSite m)
                                                              -- `site_sigma_z_product_diagonal_entry` を各 `(m, m^+)` へ
    _ = ∑ m : Fin M, (((μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun _m _ => real_inclusion_mul _ _ -- `real_inclusion_preserves_product` を各項へ
    _ = ((∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ) :=
        real_inclusion_of_finite_sum_fintype_or_empty _       -- `real_inclusion_preserves_finite_sum`
    _ = ((adjacentSpinProductSum μ : ℝ) : ℂ) := rfl           -- `d(μ)` の定義

/-! ## 中間目標「`K_1 D` も対角行列で、対角成分は `(K_1)_ℂ d(μ)_ℂ`」 -/

/-- 人手の `(K_1D)_{kl} = 0_ℂ`（`k ≠ l`）の 3 行。`def_matrix_scalar_multiple` は具体版が無く `Matrix.smul_apply`、
`complex_times_zero_is_zero` は `mul_zero`（既存の慣行どおり）。 -/
theorem K1SmulD_apply_of_ne (K1 : ℝ) {p q : Conf M} (hpq : p ≠ q) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q = 0 :=
  calc ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q
      = (K1 : ℂ) * (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) p q := by
        rw [Matrix.smul_apply, smul_eq_mul]                   -- `def_matrix_scalar_multiple`
    _ = (K1 : ℂ) * 0 := by
        rw [sum_sigmaZ_sigmaZ_apply_of_ne hpq]                -- 上の `D` が対角行列であること
    _ = 0 := mul_zero _                                       -- `complex_times_zero_is_zero`

/-- 人手の `(K_1D)_{kk} = (K_1)_ℂ d(μ)_ℂ`（`k = ν(ι(μ))`）の 2 行。 -/
theorem K1SmulD_apply_configBasisIso_self (K1 : ℝ) (μ : SpinConf M) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = (K1 : ℂ) * ((adjacentSpinProductSum μ : ℝ) : ℂ) :=
  calc ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ)
      = (K1 : ℂ) * (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) (configBasisIso M μ) (configBasisIso M μ) := by
        rw [Matrix.smul_apply, smul_eq_mul]                   -- `def_matrix_scalar_multiple`
    _ = (K1 : ℂ) * ((adjacentSpinProductSum μ : ℝ) : ℂ) := by
        rw [sum_sigmaZ_sigmaZ_apply_configBasisIso_self]      -- 上の `D` の対角成分

/-- 人手の「`K_1D` は対角行列（`def_diagonal_matrix`）」: 非対角成分が `0_ℂ` なので、`K_1D` は対角成分の
Lean の対角行列 `Matrix.diagonal` に等しい（成分ごとの比較 `Matrix.diagonal_apply` による読み替え。
`exp_of_diagonal_matrix` の具体版 `matrixExp_diagonal_apply` が `Matrix.diagonal` の形を受け取るため）。 -/
theorem K1SmulD_eq_diagonal (K1 : ℝ) :
    ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))
      = Matrix.diagonal (fun I => ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) I I) := by
  ext p q
  by_cases h : p = q
  · subst h
    rw [Matrix.diagonal_apply_eq]
  · rw [Matrix.diagonal_apply_ne _ h, K1SmulD_apply_of_ne K1 h]

/-! ## 中間目標「成分の一致」 -/

open Classical in
/-- **人手の中間目標「成分の一致」の鎖**
`(exp(K_1D))_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 ∑_m μ(m)μ(m+1))`。

人手の 1 行目・5 行目（`config_numbering_equals_kronecker_numbering`、`ord(μ)` と `ν(ι(μ))` の読み替え）は、
Lean では行列の添字が `ι(μ)` そのものなので段は無い。`complex_exp_of_real_argument` は具体版が無く
`Complex.ofReal_exp`（既存の慣行どおり）。6 行目の `δ_{μ=μ'}` は人手の記法どおり実数の `1`・`0` で書き、
`0_ℂ = (0)_ℂ` は `inclusion_rr_to_cc` の略記（`Complex.ofReal_zero`）として読む。 -/
theorem V1PauliForm_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    V1PauliForm M (K1 : ℂ) (configBasisIso M μ) (configBasisIso M μ')
      = (((if μ = μ' then 1 else 0 : ℝ) *
          Real.exp (K1 * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)) : ℝ) : ℂ) :=
  calc V1PauliForm M (K1 : ℂ) (configBasisIso M μ) (configBasisIso M μ')
      = matExp ((K1 : ℂ) • ∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))
          (configBasisIso M μ) (configBasisIso M μ') := rfl  -- `V1PauliForm` は右辺 `exp(K_1D)` の名前
    _ = if configBasisIso M μ = configBasisIso M μ'
          then Complex.exp ((K1 : ℂ) * ((adjacentSpinProductSum μ : ℝ) : ℂ)) else 0 := by
        rw [K1SmulD_eq_diagonal, matExp, matrixExp_diagonal_apply, K1SmulD_apply_configBasisIso_self]
                                                              -- `exp_of_diagonal_matrix` を対角行列 `K_1D` とその対角成分へ
    _ = if configBasisIso M μ = configBasisIso M μ'
          then Complex.exp (((K1 * adjacentSpinProductSum μ : ℝ) : ℂ)) else 0 := by
        rw [real_inclusion_mul]                               -- `real_inclusion_preserves_product`
    _ = if configBasisIso M μ = configBasisIso M μ'
          then ((Real.exp (K1 * adjacentSpinProductSum μ) : ℝ) : ℂ) else 0 := by
        rw [Complex.ofReal_exp]                               -- `complex_exp_of_real_argument`
    _ = (((if μ = μ' then 1 else 0 : ℝ) *
          Real.exp (K1 * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)) : ℝ) : ℂ) := by
        -- `row_configuration_numbering_bijective` の単射性より `ι(μ) = ι(μ') ⟺ μ = μ'`
        by_cases h : μ = μ'
        · rw [if_pos (congrArg (configBasisIso M) h), if_pos h, one_mul]
          rfl                                                 -- `d(μ)` の定義
        · rw [if_neg (fun hc => h ((configBasisIso_eq_iff μ μ').mp hc)), if_neg h, zero_mul,
            Complex.ofReal_zero]                              -- `0_ℂ = (0)_ℂ`（`inclusion_rr_to_cc` の略記）

/-- **人手 `first_transfer_matrix_pauli_form`: `V_1 = exp(K_1 ∑_{m=1}^{M_col} σ^z_m σ^z_{m+1})`。** -/
theorem first_transfer_matrix_pauli_form (K1 : ℝ) : V1 M K1 = V1PauliForm M (K1 : ℂ) := by
  ext I J
  -- すべての行・列番号の組は `(ι(μ), ι(μ'))` の形に書ける
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective I
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective J
  rw [V1PauliForm_apply_configBasisIso, V1_apply_configBasisIso]

end Ising2D
