/-
# `V_1` の成分定義とパウリ表示の一致

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_004_claim_V1_component_equals_pauli`（ラベル **`V1_component_equals_pauli`**）

原文の主張（`K_1 = J'`）:

  `(exp(K_1 ∑_m σ^z_m σ^z_{m+1}))_{ι(μ),ι(μ')} = δ_{μ=μ'} exp(∑_m J' μ(m) μ(m+1))`

証明の 3 段（Step 1: `D = ∑ σ^z σ^z` が対角、Step 2: `exp_of_diagonal_matrix` を適用、
Step 3: `ι` が全単射なので `ι(μ) = ι(μ') ⟺ μ = μ'`）はそれぞれ
`sum_sigmaZ_sigmaZ_eq_diagonal`（`Part010/Definition000_ComponentTransfer.lean`）、
`matrixExp_diagonal`（`Part010/Claim003_ExpDiagonal.lean`）、
`configBasisIso_eq_iff`（`Part010/Definition001_ConfigBasisIso.lean`）に対応する。

抽象版はこの主張には置いていない。理由は、この主張が
「対角行列の指数関数」（抽象版は `Ising2D/Abstract/ExpDiagonal.lean`）と
「因子が対角なら積も対角」（抽象版は `Ising2D/Abstract/SiteDiagonal.lean`）の
2 つの合成にすぎず、本ファイル固有の内容は `V_1` の 2 つの定義の**突き合わせ**
（＝具体的な対象についての主張）だからである。
-/
import Ising2D.Part010.Definition000_ComponentTransfer

namespace Ising2D

variable {M : ℕ}

/-- **原文 `V1_component_equals_pauli` の行列としての形。**
成分で定義された `V_1` とパウリ表示の `V_1` は同一の行列である。 -/
theorem V1pauli_eq_V1comp (K1 : ℂ) : V1pauli M K1 = V1comp M K1 := by
  rw [V1pauli_eq_diagonal, V1comp]
  congr 1
  funext I
  congr 1
  rw [rowEnergy, Finset.mul_sum]
  exact Finset.sum_congr rfl fun m _ => by ring

/-- **原文 `V1_component_equals_pauli` の成分の形（スピン配置 `μ, μ'` で書いたもの）。** -/
theorem V1_component_equals_pauli (J' : ℝ) (μ μ' : SpinConf M) :
    V1pauli M (J' : ℂ) (configBasisIso M μ) (configBasisIso M μ')
      = (if μ = μ' then 1 else 0) *
        Complex.exp (∑ m : Fin M, ((J' * (μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ)) := by
  rw [V1pauli_eq_V1comp, V1comp_apply]
  have hrow : rowEnergy (J' : ℂ) (configBasisIso M μ)
      = ∑ m : Fin M, ((J' * (μ m : ℝ) * (μ (nextSite m) : ℝ) : ℝ) : ℂ) := by
    rw [rowEnergy]
    refine Finset.sum_congr rfl fun m _ => ?_
    rw [sgnC_configBasisIso, sgnC_configBasisIso]
    push_cast
    ring
  by_cases h : μ = μ'
  · subst h; rw [if_pos rfl, if_pos rfl, one_mul, hrow]
  · rw [if_neg (fun hc => h ((configBasisIso M).injective hc)), if_neg h, zero_mul]

end Ising2D
