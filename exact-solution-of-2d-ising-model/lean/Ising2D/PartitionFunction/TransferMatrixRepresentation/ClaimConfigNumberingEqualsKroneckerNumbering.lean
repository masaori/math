/-
# スピン配置の番号付けはクロネッカー積の番号付けと一致する

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `transfer_matrix_claim_config_numbering_equals_kronecker_numbering`
  （ラベル **`config_numbering_equals_kronecker_numbering`**）

主張: 任意の `μ ∈ 𝔐` で `ord(μ) = ν(ι(μ))`。

## Lean の行列の添字との関係

人手の `def_kronecker` は多重添字 `I ∈ 𝓘 = {1,2}^M` を行番号・列番号 `ν(I)` と同一視して使う。
Lean の `TensorPow M = Matrix (Conf M) (Conf M) ℂ` は添字型が `Conf M`（= `𝓘`）そのものであり、
この同一視を**添字型の選択として**実現している。したがって人手の成分 `A_{ν(I),ν(J)}` は
Lean の `A I J` であり、本主張により人手の成分 `A_{ord(μ),ord(μ')}` は Lean の
`A (ι μ) (ι μ')` である。`def_transfer_matrix` の `V_1, V_2`（`PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean`）
をこの添字で定義しているのは、この主張による。

`ν` 自体は `def_kronecker`（002 章）の定義で、Lean では `kroneckerNumbering`
（`MathematicalTools/KroneckerProductAndMultiFactorBasis/DefinitionKroneckerNumbering.lean`。`ν` が全単射であることの
`def_kronecker` の証明と逆写像 `ν^{-1}` も同じファイル）である。

## 人手証明との対応

人手証明は `i_m - 1 = (1-μ(m))/2`（`idxOfSpin_val_eq_spinBit`）を各項へ代入する一段である。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionRowConfigurationNumbering
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionKroneckerNumbering

namespace Ising2D

variable {M : ℕ}

/-- 人手証明の `i_m - 1 = (1 - μ(m))/2`（`ι` の定義による）。 -/
theorem idxOfSpin_val_eq_spinBit (s : SpinVal) :
    ((((idxOfSpin s : Fin 2) : ℕ)) : ℤ) = spinBit s := by
  by_cases h : (s : ℝ) = 1
  · rw [idxOfSpin, if_pos h, spinBit, if_pos h]; rfl
  · rw [idxOfSpin, if_neg h, spinBit, if_neg h]; rfl

/-- **人手 `config_numbering_equals_kronecker_numbering`: `ord(μ) = ν(ι(μ))`。** -/
theorem config_numbering_equals_kronecker_numbering (μ : SpinConf M) :
    rowConfigOrd μ = kroneckerNumbering (configBasisIso M μ) := by
  rw [kroneckerNumbering, rowConfigOrd]
  congr 1
  refine Finset.sum_congr rfl fun m _ => ?_
  rw [configBasisIso_apply, idxOfSpin_val_eq_spinBit]

end Ising2D
