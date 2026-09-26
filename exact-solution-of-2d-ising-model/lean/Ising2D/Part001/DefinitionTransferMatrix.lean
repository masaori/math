/-
# 転送行列 `V_1, V_2`（成分による唯一の定義）

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_003_definition_transfer_matrix`（ラベル **`def_transfer_matrix`**）

人手の定義（`K_1, K_2 ∈ ℝ_{>0}`, `μ, μ' ∈ 𝔐`, 周期規約 `μ(M_col+1) := μ(1)`）:

  `(V_1)_{ord(μ), ord(μ')} := δ_{μ=μ'} exp(K_1 ∑_{m=1}^{M_col} μ(m) μ(m+1))`
  `(V_2)_{ord(μ), ord(μ')} := exp(K_2 ∑_{m=1}^{M_col} μ(m) μ'(m))`

**`V_1, V_2` の Lean での定義はここにある `Ising2D.V1`, `Ising2D.V2` ただ 1 つである。**
パウリ行列による表示は定義ではなく主張であり、`Part004/ClaimFirstTransferMatrixPauliForm.lean`
（`first_transfer_matrix_pauli_form`）と `Part004/ClaimSecondTransferMatrixPauliForm.lean`
（`second_transfer_matrix_pauli_form`）にある。`V1pm`（人手の `V_1^{(±)}`）は別の行列である。

## 行列の添字

Lean の `TensorPow M = Matrix (Conf M) (Conf M) ℂ` は `Mat(2^{M_col}, ℂ)` の表現で、
添字 `I : Conf M` は人手の行番号 `ν(I)`（`def_kronecker`）を表す。人手の行番号 `ord(μ)` は
`config_numbering_equals_kronecker_numbering`（`ord = ν ∘ ι`）により Lean の添字 `ι(μ)`
（`Ising2D.configBasisIso`）である。したがって人手の定義式は Lean では
`V1 M K1 (ι μ) (ι μ') = …`（`V1_apply_configBasisIso`）であり、
定義そのものは添字 `I` を `ι` の逆写像でスピン配置 `ι⁻¹(I) ∈ 𝔐` へ戻して書く
（人手が `ord` の全単射性 `row_configuration_numbering_bijective` により
すべての成分が定まるとしているのと同じく、`ι` が全単射なのですべての成分が定まる）。

## 記号

* 人手の列数 `M_col` は Lean の束縛変数 `M`（列の添字は `Fin M`）。
* 周期規約 `μ(M_col+1) := μ(1)` は巡回後者 `Ising2D.nextSite`（`Part004/Definition010_H1H2V1V2.lean`）。
* 人手の `K_1, K_2 ∈ ℝ_{>0}` は `K1 K2 : ℝ`。定義に正値性は要らないので仮定に置かない。
* 成分の値は人手どおり実数 `exp(…) ∈ ℝ_{>0}` を `ℂ` へ埋め込んだもの。
-/
import Ising2D.Part004.DefinitionConfigBasisIso
import Ising2D.Part004.Definition010_H1H2V1V2

namespace Ising2D

variable {M : ℕ}

open Classical in
/-- **人手 `def_transfer_matrix` の `V_1`。**
`(V_1)_{ord(μ),ord(μ')} = δ_{μ=μ'} exp(K_1 ∑_m μ(m) μ(m+1))`（`μ = ι⁻¹(I)`, `μ' = ι⁻¹(J)`）。 -/
noncomputable def V1 (M : ℕ) (K1 : ℝ) : TensorPow M :=
  Matrix.of fun I J =>
    (((if (configBasisIso M).symm I = (configBasisIso M).symm J then 1 else 0 : ℝ) *
      Real.exp (K1 * ∑ m : Fin M,
        ((configBasisIso M).symm I m : ℝ) * ((configBasisIso M).symm I (nextSite m) : ℝ)) : ℝ) : ℂ)

/-- **人手 `def_transfer_matrix` の `V_2`。**
`(V_2)_{ord(μ),ord(μ')} = exp(K_2 ∑_m μ(m) μ'(m))`（`μ = ι⁻¹(I)`, `μ' = ι⁻¹(J)`）。 -/
noncomputable def V2 (M : ℕ) (K2 : ℝ) : TensorPow M :=
  Matrix.of fun I J =>
    ((Real.exp (K2 * ∑ m : Fin M,
        ((configBasisIso M).symm I m : ℝ) * ((configBasisIso M).symm J m : ℝ)) : ℝ) : ℂ)

open Classical in
/-- **人手 `def_transfer_matrix` の `V_1` の定義式そのもの**（行番号 `ord(μ)` は Lean の添字 `ι(μ)`）。 -/
theorem V1_apply_configBasisIso (K1 : ℝ) (μ μ' : SpinConf M) :
    V1 M K1 (configBasisIso M μ) (configBasisIso M μ')
      = (((if μ = μ' then 1 else 0 : ℝ) *
          Real.exp (K1 * ∑ m : Fin M, (μ m : ℝ) * (μ (nextSite m) : ℝ)) : ℝ) : ℂ) := by
  simp only [V1, Matrix.of_apply, Equiv.symm_apply_apply]

/-- **人手 `def_transfer_matrix` の `V_2` の定義式そのもの**（行番号 `ord(μ)` は Lean の添字 `ι(μ)`）。 -/
theorem V2_apply_configBasisIso (K2 : ℝ) (μ μ' : SpinConf M) :
    V2 M K2 (configBasisIso M μ) (configBasisIso M μ')
      = ((Real.exp (K2 * ∑ m : Fin M, (μ m : ℝ) * (μ' m : ℝ)) : ℝ) : ℂ) := by
  simp only [V2, Matrix.of_apply, Equiv.symm_apply_apply]

/-- `ι⁻¹(I)` のスピン値は `sgn(I m)`（`ι` の逆向きの読み替え）。 -/
theorem coe_configBasisIso_symm_apply (I : Conf M) (m : Fin M) :
    (((configBasisIso M).symm I m : SpinVal) : ℝ) = sgn (I m) := by
  rw [← sgn_configBasisIso ((configBasisIso M).symm I) m, Equiv.apply_symm_apply]

/-- `V_1` の成分を添字 `I, J : Conf M` のまま書いた形（以降の章で使う）。 -/
theorem V1_apply (K1 : ℝ) (I J : Conf M) :
    V1 M K1 I J = if I = J then
      ((Real.exp (K1 * ∑ m : Fin M, sgn (I m) * sgn (I (nextSite m))) : ℝ) : ℂ) else 0 := by
  simp only [V1, Matrix.of_apply, coe_configBasisIso_symm_apply,
    (configBasisIso M).symm.apply_eq_iff_eq]
  by_cases h : I = J
  · rw [if_pos h, if_pos h, one_mul]
  · rw [if_neg h, if_neg h, zero_mul, Complex.ofReal_zero]

/-- `V_1` は対角行列（`δ_{μ=μ'}` による）。 -/
theorem V1_eq_diagonal (K1 : ℝ) :
    V1 M K1 = Matrix.diagonal (fun I : Conf M =>
      ((Real.exp (K1 * ∑ m : Fin M, sgn (I m) * sgn (I (nextSite m))) : ℝ) : ℂ)) := by
  ext I J
  rw [V1_apply]
  by_cases h : I = J
  · subst h; rw [if_pos rfl, Matrix.diagonal_apply_eq]
  · rw [if_neg h, Matrix.diagonal_apply_ne _ h]

/-- `V_2` の成分を添字 `I, J : Conf M` のまま書いた形（以降の章で使う）。 -/
theorem V2_apply (K2 : ℝ) (I J : Conf M) :
    V2 M K2 I J = ((Real.exp (K2 * ∑ m : Fin M, sgn (I m) * sgn (J m)) : ℝ) : ℂ) := by
  simp only [V2, Matrix.of_apply, coe_configBasisIso_symm_apply]

end Ising2D
