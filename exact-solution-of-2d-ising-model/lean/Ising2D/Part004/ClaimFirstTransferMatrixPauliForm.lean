/-
# `V_1` のパウリ行列表示

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_definition_site_pauli_periodic_extension`
  （ラベル **`def_site_pauli_periodic_extension`**）: `σ^z_{M_col+1} := σ^z_1`
* `transfer_matrix_claim_first_transfer_matrix_pauli_form`
  （ラベル **`first_transfer_matrix_pauli_form`**）

主張: `def_transfer_matrix` で成分により定めた `V_1`（`Ising2D.V1`）は
`V_1 = exp(K_1 ∑_{m=1}^{M_col} σ^z_m σ^z_{m+1})` と表せる。

`V1PauliForm M K1` はこの**右辺の式**に付けた名前であり、`V_1` の定義ではない。
結合定数は `K1 : ℂ` の一般の値で定義しておき（`Part010` の偶奇セクターの議論は
この一般形のまま使う）、人手の主張は `K1 : ℝ` を埋め込んだ値について述べる
（`first_transfer_matrix_pauli_form`）。人手は `K_1 > 0` を置くが、証明は正値性を使わない。

## 人手証明との対応

* `def_site_pauli_periodic_extension` の `σ^z_{M_col+1} := σ^z_1` は、Lean では添字の巡回後者
  `nextSite` で `σ^z_{m+1}` を `sigmaZ (nextSite m)` と書くことで表す
  （`sigmaZ_nextSite_of_last` が `m = M_col` での `σ^z_{M_col+1} = σ^z_1`）。
  このため人手が周期端 `σ^z_{M_col}σ^z_1` を和から分けて扱う段は、Lean では分けずに済む。
* 中間目標「`D` の対角成分」（`D f_{ι(μ)} = (∑_m μ(m)μ(m+1)) f_{ι(μ)}`、`sigma_z_diagonal_action` を各項へ）
  → `sum_sigmaZ_sigmaZ_mulVec_basisVec_spin`、および `D` が対角行列であること
  `sum_sigmaZ_sigmaZ_eq_diagonal`。
* 中間目標「成分の一致」
  * `(exp(K_1D))_{ord(μ),ord(μ')} = (exp(K_1D))_{ν(ι(μ)),ν(ι(μ'))}`
    （`config_numbering_equals_kronecker_numbering`）→ Lean では行列の添字が `ι(μ)` そのもの
    （`Part001/DefinitionTransferMatrix.lean` 冒頭の「行列の添字」）なので、この段は添字の読み方である。
  * `exp_of_diagonal_matrix` を対角行列 `K_1D` へ → `matrixExp_diagonal_apply`。
  * `ord(μ) = ord(μ') ⟺ μ = μ'`（`row_configuration_numbering_bijective` の単射性）
    → Lean の添字では `ι(μ) = ι(μ') ⟺ μ = μ'`（`configBasisIso_eq_iff`）。
  * `= (V_1)_{ord(μ),ord(μ')}`（`def_transfer_matrix`）→ `V1_apply_configBasisIso`。
  以上が `V1PauliForm_apply_configBasisIso`。
* 「全射性より、すべての行・列番号の組は `(ord(μ), ord(μ'))` の形に書ける」
  → `ι` の全射性（`(configBasisIso M).surjective`）。以上が `first_transfer_matrix_pauli_form`。

必要十分版はこの主張には置かない。内容は「対角行列の指数関数」（必要十分版は
`Ising2D/NecSuf/ExpDiagonal.lean`）と「因子が対角なら積も対角」（必要十分版は
`Ising2D/NecSuf/SiteDiagonal.lean`）の合成であり、本ファイル固有の内容は
具体的な行列 `V_1` の成分定義とパウリ行列表示の突き合わせだからである。
-/
import Ising2D.Part001.DefinitionTransferMatrix
import Ising2D.Part004.ClaimSigmaZDiagonalAction
import Ising2D.Part004.ClaimExpOfDiagonalMatrix

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

/-! ## 中間目標「`D` の対角成分」 -/

open Matrix in
/-- 人手の `D f_{ι(μ)} = (∑_m μ(m)μ(m+1)) f_{ι(μ)}`（`sigma_z_diagonal_action` を各項へ）。 -/
theorem sum_sigmaZ_sigmaZ_mulVec_basisVec_spin (μ : SpinConf M) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m)) *ᵥ basisVec (configBasisIso M μ)
      = (((∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ))
          • basisVec (configBasisIso M μ) := by
  rw [Matrix.sum_mulVec, Complex.ofReal_sum, Finset.sum_smul]
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [sigmaZ_mul_sigmaZ_mulVec_basisVec, sgnC_configBasisIso, sgnC_configBasisIso,
    Complex.ofReal_mul]

/-- `D = ∑_m σ^z_m σ^z_{m+1}` は対角行列で、対角成分は `∑_m μ(m)μ(m+1)`。 -/
theorem sum_sigmaZ_sigmaZ_eq_diagonal (M : ℕ) :
    (∑ m : Fin M, sigmaZ m * sigmaZ (nextSite m))
      = Matrix.diagonal (fun I : Conf M => ∑ m : Fin M, sgnC (I m) * sgnC (I (nextSite m))) := by
  ext I J
  rw [Matrix.sum_apply]
  by_cases h : I = J
  · subst h
    simp only [sigmaZ_mul_sigmaZ_eq_diagonal, Matrix.diagonal_apply_eq]
  · simp only [sigmaZ_mul_sigmaZ_eq_diagonal, Matrix.diagonal_apply_ne _ h,
      Finset.sum_const_zero]

/-- `exp(K_1 D)` も対角行列で、対角成分は `exp(K_1 ∑_m μ(m)μ(m+1))`（`K1 : ℂ` の一般の値で）。 -/
theorem V1PauliForm_eq_diagonal (K1 : ℂ) :
    V1PauliForm M K1 = Matrix.diagonal
      (fun I : Conf M => Complex.exp (K1 * ∑ m : Fin M, sgnC (I m) * sgnC (I (nextSite m)))) := by
  rw [V1PauliForm, sum_sigmaZ_sigmaZ_eq_diagonal, ← Matrix.diagonal_smul, matExp_diagonal]
  simp only [Pi.smul_apply, smul_eq_mul]

/-! ## 中間目標「成分の一致」 -/

open Classical in
/-- 人手の中間目標「成分の一致」の式変形
`(exp(K_1D))_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 ∑_m μ(m)μ(m+1))`。 -/
theorem V1PauliForm_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    V1PauliForm M (K1 : ℂ) (configBasisIso M μ) (configBasisIso M μ')
      = (((if μ = μ' then 1 else 0 : ℝ) *
          Real.exp (K1 * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)) : ℝ) : ℂ) := by
  -- `exp_of_diagonal_matrix` を対角行列 `K_1 D` へ
  rw [V1PauliForm, sum_sigmaZ_sigmaZ_eq_diagonal, ← Matrix.diagonal_smul, matExp,
    matrixExp_diagonal_apply]
  -- `ι(μ) = ι(μ') ⟺ μ = μ'`
  by_cases h : μ = μ'
  · subst h
    rw [if_pos rfl, if_pos rfl, one_mul, Pi.smul_apply, smul_eq_mul, Complex.ofReal_exp]
    congr 1
    push_cast
    refine congrArg _ (Finset.sum_congr rfl fun m _ => ?_)
    rw [sgnC_configBasisIso, sgnC_configBasisIso]
  · rw [if_neg (fun hc => h ((configBasisIso_eq_iff μ μ').mp hc)), if_neg h, zero_mul,
      Complex.ofReal_zero]

/-- **人手 `first_transfer_matrix_pauli_form`: `V_1 = exp(K_1 ∑_{m=1}^{M_col} σ^z_m σ^z_{m+1})`。** -/
theorem first_transfer_matrix_pauli_form (K1 : ℝ) : V1 M K1 = V1PauliForm M (K1 : ℂ) := by
  ext I J
  -- すべての行・列番号の組は `(ι(μ), ι(μ'))` の形に書ける
  obtain ⟨μ, rfl⟩ := (configBasisIso M).surjective I
  obtain ⟨μ', rfl⟩ := (configBasisIso M).surjective J
  rw [V1PauliForm_apply_configBasisIso, V1_apply_configBasisIso]

end Ising2D
