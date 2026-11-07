# Lean 4 + mathlib4 による機械的証明

`exact-solution-of-2d-ising-model` の人手証明を Lean 4 で機械的に検証するためのプロジェクト。
SageMath による数値検証（`sagemath/`）と併用する。

**人手証明の正本は `structured-latex/content/*.ts`（構造化TeX）**である
（`.mjs` は全廃済み。ファイル形式は TypeScript に統一されている）。
旧 Typst 一式は `_old/typst/` へ参照用に退避されており（更新されない）、
本 README で `parts/…/*.typ` と書いているのは `_old/typst/parts/…` のことである。
対応づけは**ラベル**（`labels` フィールド、例 `def_hatZ_pm`）で辿る。

## セットアップ

### 1. elan（Lean のツールチェーン管理ツール）

```bash
curl -fsSL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -o elan-init.sh
sh elan-init.sh -y
export PATH="$HOME/.elan/bin:$PATH"   # 恒久化するには shell の rc に追記
```

`lean-toolchain` にツールチェーンが固定してあるので、このディレクトリで `lake` を実行すれば
elan が自動的に該当バージョン（`leanprover/lean4:v4.32.1`）を取得する。

### 2. 依存の取得と mathlib のビルド済みキャッシュ

```bash
cd exact-solution-of-2d-ising-model/lean
lake exe cache get     # mathlib のビルド済み .olean を取得（初回は数 GB のダウンロード）
lake build
```

`lake exe cache get` を省略すると mathlib 全体をローカルでビルドすることになるので必ず実行する。

### 3. バージョン固定

| ファイル | 内容 |
| --- | --- |
| `lean-toolchain` | `leanprover/lean4:v4.32.1` |
| `lakefile.toml` | mathlib4 を git tag `v4.32.1` に固定 |
| `lake-manifest.json` | mathlib4 と推移的依存の commit を固定（コミット対象） |

**mathlib を更新するときは `lean-toolchain` と `lakefile.toml` の `rev` を必ず同じタグに揃える。**
揃っていないと mathlib のビルド済みキャッシュが使えず、全ビルドが走る。

## ビルド

```bash
cd exact-solution-of-2d-ising-model/lean
lake build          # 全体
lake build Ising2D.Representation   # 単一モジュール
```

`sorry` を残したまま「証明済み」としないため、主要な定理の依存公理を確認するスクリプトを用意してある。

```bash
cd exact-solution-of-2d-ising-model/lean
./scripts/check-no-sorry.sh   # 終了コード 0 なら OK
```

ソース中の `sorry` / `admit` の有無と、主要定理の `#print axioms` に `sorryAx` が
現れないことを検査する（`propext` / `Classical.choice` / `Quot.sound` は
mathlib 標準の 3 公理で問題ない）。新しい定理を追加したら、このスクリプトの
`targets` 配列にも追加すること。

単発で確認する場合は次のようにする（`lean -` ではなく `--stdin` を使う）。

```bash
lake env lean --stdin <<'EOF'
import Ising2D
#print axioms Ising2D.tensorPowAlgEquiv
EOF
```

この README と `docs/` の対応表が、いまの Lean のファイルと宣言を指していることは次で確かめる。
ファイルを動かす・改名する、定理を消す・改名したら、同じ回で通す。

```bash
cd exact-solution-of-2d-ising-model/lean
./scripts/check-docs-references.sh   # 書かれた .lean のパスと Ising2D. の名前がすべて実在すれば終了コード 0
```

## 人手証明との対応の付け方

- **フォルダは承認された章立て（部と章の名前）に合わせて組み直している途中である。** 置き場の規則の正本は
  `docs/tasks/lean-end-to-end-runbook.md` の「作業の順序」の最後の項目「フォルダを章立てに合わせて組み直す」である。
  章のフォルダは `Ising2D/<部>/<章>/`（番号を付けない英語名）で、移し終えた章は次のとおりである。

  | 部 | 章 | フォルダ |
  | --- | --- | --- |
  | 分配関数 | 転送行列による表示 | `Ising2D/PartitionFunction/TransferMatrixRepresentation/` |
  | 分配関数 | ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示 | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/` |
  | 固有値問題 | 離散 Fourier 変換による 2×2 行列 A(θ̃_μ) への帰着 | `Ising2D/EigenvalueProblem/ReductionToATheta/` |
  | 固有値問題 | A(θ̃_μ) の対角化と V^{(+)} の指数表示 | `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/` |
  | 固有値問題 | V^{(+)} の固有値 | `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/` |
  | 固有値問題 | V^{(+)} の最大固有値に属する固有ベクトル | `Ising2D/EigenvalueProblem/EigenvectorOfMaxEigenvalue/` |
  | 熱力学極限 | N→∞ の極限と最大固有値 c(M) | `Ising2D/ThermodynamicLimit/RowLimitAndMaxEigenvalue/` |
  | 熱力学極限 | M→∞ の極限と閉形式 | `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/` |
  | 臨界点 | 臨界点 K_c と d²f/dK² の対数発散 | `Ising2D/CriticalPoint/CriticalPointAndLogDivergence/` |

- 部「数学的道具立て」の項目を形式化したファイルは、棚卸しのまとまりごとに `Ising2D/MathematicalTools/<まとまりの英語名>/` へ置く。移し終えたまとまりは次のとおりである。

  | まとまり | フォルダ |
  | --- | --- |
  | 実数の平方根・指数関数・双曲線関数 | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/` |
  | クロネッカー積と多因子基底 | `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/` |
  | 有限行列・Pauli行列・交換子 | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/` |
  | 行列指数関数と交換子計算 | `Ising2D/MathematicalTools/MatrixExponentialAndCommutators/` |
  | 可逆行列・線型写像との対応・共役変換 | `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/` |
  | トレース・共役転置・正定値性 | `Ising2D/MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/` |
  | 三角関数の評価・有限和・積分 | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/` |

- 旧 Typst の章番号のフォルダ（`Part000`〜`Part020`）は残っていない。章のフォルダへ移したファイルは番号を外した名前にしてある。下の表は旧 Typst のファイルとの対応で、Lean の側はいまの置き場を書く。

  | 人手証明（Typst） | Lean |
  | --- | --- |
  | `parts/000_計算公式/045_claim_共役写像は環準同型.typ` | `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/ClaimConjugationIsRingHom.lean` |
  | `parts/000_計算公式/046_claim_交換子と反交換子の関係.typ` | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutatorViaAnticommutators.lean` |
  | `<def_eigenvector>`・`<def_eigenvalue>`・`<def_det_two_by_two>`・`<nonzero_kernel_iff_det_zero_two_by_two>`（Typst の原本なし。2026-11-01 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` |
  | `<def_matrix_difference>`・`<def_zero_matrix>`・`<def_matrix_negation>`・`<matrix_difference_zero_iff_equal>`・`<matrix_difference_mul_vector>`（Typst の原本なし。2026-11-01 に本文へ足した）と、`002_linear_space_general.ts` の `<def_kronecker_delta>`・`<def_identity_matrix>`・`<def_matrix_scalar_multiple>`・`<identity_matrix_is_left_unit_of_mat_mult>`・`<scalar_multiple_factors_out_of_left_factor>` の右の因子が数ベクトルの場合 | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean`（必要十分版からの導出は同じフォルダの `ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`） |
  | `parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` | `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean` |
  | `parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ` | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/LemmaScalarIdentityCommutes.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `LemmaScalarIdentityCommutesFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<identity_matrix_is_left_unit_of_mat_mult>`・`<identity_matrix_is_right_unit_of_mat_mult>`・`<scalar_multiple_factors_out_of_left_factor>`・`<scalar_multiple_factors_out_of_right_factor>`（Typst の原本なし）の行列同士の積の場合 | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityAndScalarMultipleInMatrixProduct.lean`（必要十分版からの導出は同じフォルダの `ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<def_matrix_sum>`・`<matrix_plus_zero_matrix>`・`<zero_matrix_plus_matrix>`・`<matrix_minus_zero_matrix>`・`<finite_sum_of_zero_matrices>`（Typst の原本なし。後の 4 つは 2026-11-01 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimAddAndSubtractZeroMatrix.lean`（必要十分版からの導出は同じフォルダの `ClaimAddAndSubtractZeroMatrixFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<scalar_multiple_of_zero_matrix>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfZeroMatrix.lean`（必要十分版からの導出は同じフォルダの `ClaimScalarMultipleOfZeroMatrixFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<negation_factors_out_of_left_factor>`・`<negation_factors_out_of_right_factor>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationFactorsOutOfMatrixProduct.lean`（必要十分版からの導出は同じフォルダの `ClaimNegationFactorsOutOfMatrixProductFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<scalar_multiple_of_negated_matrix>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleOfNegatedMatrix.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimScalarMultipleOfNegatedMatrixFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<negation_is_scalar_multiple_by_minus_one>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationIsScalarMultipleByMinusOne.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimNegationIsScalarMultipleByMinusOneFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_double_negation>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDoubleNegation.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixDoubleNegationFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<finite_sum_of_complex_sums>`・`<mat_mult_distributes_over_sum_in_right_factor>`・`<mat_mult_distributes_over_sum_in_left_factor>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatMultDistributesOverSum.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatMultDistributesOverSumFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<mat_conj>`（`parts/000_計算公式/005_theorem_行列の共役.typ`）と `<matrix_conjugation_preserves_finite_sum>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesSums.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixConjugationPreservesSumsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<negation_distributes_over_matrix_sum>`・`<finite_sum_of_negated_matrices>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimNegationDistributesOverMatrixSum.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimNegationDistributesOverMatrixSumFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_difference_is_sum_with_negation>`・`<difference_of_negated_matrices>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixDifferenceIsSumWithNegation.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixDifferenceIsSumWithNegationFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<def_matrix_anticommutator>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionMatrixAnticommutator.lean` |
  | `002_linear_space_general.ts` の `<zero_matrix_is_left_zero_of_mat_mult>`・`<matrix_sum_with_itself_zero_implies_zero>`・`<matrix_summand_from_sum_equation>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixProductAndSumEquations.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimZeroMatrixProductAndSumEquationsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<zero_matrix_is_right_zero_of_mat_mult>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroMatrixIsRightZeroOfMatMult.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimZeroMatrixIsRightZeroOfMatMultFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<def_finite_product_of_matrices>`・`<finite_product_of_identity_matrices>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionFiniteProductOfMatrices.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `DefinitionFiniteProductOfMatricesFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<def_sum_over_binary_words>`・`<def_sum_over_binary_words_of_complex_numbers>`（2026-11-03 に本文へ足した。Lean は `binaryWordComplexSum`）・`<def_sum_over_binary_words_of_real_numbers>`（2026-11-03 に本文へ足した。Lean は `binaryWordRealSum`）・`<sum_over_binary_words_distributes_in_left_factor>`・`<sum_over_binary_words_distributes_in_right_factor>`・`<sum_over_binary_words_with_one_nonzero_term>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionSumOverBinaryWords.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `DefinitionSumOverBinaryWordsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<real_inclusion_preserves_sum_over_binary_words>`（Typst の原本なし。2026-11-03 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimRealInclusionPreservesSumOverBinaryWords.lean`（必要十分版 `NecSuf.binWordSum_map`（`f := (↑· : ℝ → ℂ)`）からの導出と `NecSuf.binWordSum` での系 `binWordSum_ofReal` は同じフォルダの `ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<expansion_of_finite_product_of_two_term_sums>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimExpansionOfFiniteProductOfTwoTermSums.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimExpansionOfFiniteProductOfTwoTermSumsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<real_sum_over_binary_words_distributes_in_left_factor>`・`<expansion_of_finite_product_of_two_term_sums_of_real_numbers>`（Typst の原本なし。2026-11-04 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean`（必要十分版からの導出は同じフォルダの `ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbersFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_commuting_with_each_factor_commutes_with_finite_product>`・`<product_of_two_finite_products_of_matrices>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteProductsOfCommutingMatrices.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimFiniteProductsOfCommutingMatricesFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<def_finite_product_of_matrices_omitting_one_index>`・`<moving_one_factor_of_finite_product_to_the_end>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionFiniteProductOfMatricesOmittingOneIndex.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `DefinitionFiniteProductOfMatricesOmittingOneIndexFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_equals_negation_if_sum_is_zero>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixEqualsNegationIfSumIsZero.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixEqualsNegationIfSumIsZeroFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<commuting_with_difference>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutingWithDifference.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimCommutingWithDifferenceFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<commuting_with_scalar_multiple>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimCommutingWithScalarMultiple.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimCommutingWithScalarMultipleFromNecSuf.lean`。必要十分版は `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean`） |
  | `002_linear_space_general.ts` の `<product_of_anticommuting_matrices_commutes>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimProductOfAnticommutingMatricesCommutes.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimProductOfAnticommutingMatricesCommutesFromNecSuf.lean`。必要十分版は `Ising2D/NecSuf/CommuteWithAnticommutingProductAndScalarMultiple.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<mat_columnwise>`（`parts/000_計算公式/004_theorem_行列の組みへの作用.typ`。2026-11-04 に Lean の具体版を足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatColumnwise.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatColumnwiseFromNecSuf.lean`。必要十分版は `Ising2D/NecSuf/MatColumnwise.lean`） |
  | `002_linear_space_general.ts` の `<zero_scalar_multiple_is_zero_matrix>`・`<matrix_sum_is_commutative>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimZeroScalarMultipleAndMatrixSumCommutative.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimZeroScalarMultipleAndMatrixSumCommutativeFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_plus_difference_cancels>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixPlusDifferenceCancels.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixPlusDifferenceCancelsFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<scalar_multiple_by_one>`（Typst の原本なし。2026-11-01 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleByOne.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimScalarMultipleByOneFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<matrix_conjugation_preserves_negation>`・`<matrix_conjugation_preserves_difference>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimMatrixConjugationPreservesDifference.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimMatrixConjugationPreservesDifferenceFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<scalar_multiple_distributes_over_matrix_difference>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixDifference.lean`（必要十分版からの導出は同じフォルダの `ClaimScalarMultipleDistributesOverMatrixDifferenceFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<scalar_multiple_distributes_over_matrix_sum>`・`<finite_sum_of_scalar_multiples>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixSum.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<finite_sum_of_matrices_distributes_in_left_factor>`（Typst の原本なし。2026-11-03 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInLeftFactor.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<finite_sum_of_matrices_distributes_in_right_factor>`（Typst の原本なし。2026-11-03 に本文へ足した） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimFiniteSumOfMatricesDistributesInRightFactor.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<difference_of_scalar_multiples_of_one_matrix>`（Typst の原本なし。2026-11-03 に本文へ足した）・`<finite_sum_of_scalar_multiples_of_one_matrix>`（Typst の原本なし） | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultiplesOfOneMatrix.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimScalarMultiplesOfOneMatrixFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<def_finite_sum_of_real_numbers>`・`<finite_sum_of_real_differences>`・`<finite_sum_of_negated_real_numbers>`・`<finite_sum_of_real_scalar_multiples>`・`<finite_sum_of_nonnegative_reals_is_at_least_each_term>`（Typst の原本なし。2026-11-03・2026-11-04 に本文へ足した）・`<finite_sum_of_real_numbers_triangle_inequality>`・`<finite_sum_of_real_numbers_is_monotone>`（Typst の原本なし。2026-11-06 に本文へ足した。必要十分版は `Ising2D/NecSuf/FiniteSumSubadditiveAndMonotone.lean`）・`<finite_sum_of_real_sums>`（Typst の原本なし。2026-11-06 に本文へ足した。必要十分版は `Ising2D/NecSuf/MatMulDistribSum.lean`）・`<finite_double_sum_of_real_numbers_interchange>`（Typst の原本なし。2026-11-06 に本文へ足した。必要十分版は `Ising2D/NecSuf/FiniteDoubleSumInterchange.lean`）・`<finite_sum_of_real_numbers_moves_one_term_to_end>`（Typst の原本なし。2026-11-06 に本文へ足した。必要十分版は `Ising2D/NecSuf/FiniteSumMovesOneTermToEnd.lean`） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumsOfRealNumbers.lean`（必要十分版からの導出は同じフォルダの `ClaimFiniteSumsOfRealNumbersFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<def_index_skipping_map>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionIndexSkippingMap.lean` |
  | `000_calculation_formulae_00_09.ts` の `<index_skipping_map_never_takes_skipped_index>`・`<index_skipping_map_is_injective>`・`<index_skipping_map_reaches_every_other_index>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimIndexSkippingMapProperties.lean` |
  | `000_calculation_formulae_00_09.ts` の `<bijection_composed_with_index_skipping_map_stays_in_lower_indices>`・`<def_bijection_composed_with_index_skipping_map>`・`<bijection_composed_with_index_skipping_map_is_bijective>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimBijectionComposedWithIndexSkippingMap.lean`（必要十分版は `Ising2D/NecSuf/BijectionComposedWithIndexSkippingMap.lean`、導出は同じフォルダの `ClaimBijectionComposedWithIndexSkippingMapFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteSumOfRealNumbersReindexedByBijection.lean`（必要十分版は `Ising2D/NecSuf/FiniteSumReindexedByBijection.lean`、導出は同じフォルダの `ClaimFiniteSumOfRealNumbersReindexedByBijectionFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<def_real_absolute_value>`・`<real_number_is_at_most_its_absolute_value>`・`<negative_absolute_value_is_at_most_real_number>`・`<real_absolute_value_of_nonpositive>`・`<real_abs_triangle_inequality>`・`<real_abs_of_product>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean`（必要十分版は `Ising2D/NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean`、導出は同じフォルダの `ClaimRealAbsoluteValueBoundsTriangleAndProductFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<square_of_real_absolute_value>`・`<square_of_real_sum_is_at_most_twice_sum_of_squares>`（Typst の原本なし。2026-11-07 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealAbsoluteValueAndOfRealSum.lean`（必要十分版は `Ising2D/NecSuf/SquareOfAbsoluteValueAndOfSum.lean`、導出は同じフォルダの `ClaimSquareOfRealAbsoluteValueAndOfRealSumFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<def_maximum_value_of_real_family>`・`<maximum_value_of_real_family_is_unique>`・`<def_max_of_real_family>`（Typst の原本なし。2026-11-04 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/DefinitionMaximumValueOfRealFamily.lean`（必要十分版からの導出は同じフォルダの `DefinitionMaximumValueOfRealFamilyFromNecSuf.lean`） |
  | `000_calculation_formulae_20_29.ts` の `<finite_product_of_positive_reals_is_positive>`（Typst の原本なし。2026-11-04 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfPositiveRealsIsPositive.lean`（必要十分版からの導出は同じフォルダの `ClaimFiniteProductOfPositiveRealsIsPositiveFromNecSuf.lean`） |
  | `000_calculation_formulae_20_29.ts` の `<finite_product_of_real_products>`（Typst の原本なし。2026-11-04 に本文へ足した） | `Ising2D/MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealProducts.lean`（必要十分版からの導出は同じフォルダの `ClaimFiniteProductOfRealProductsFromNecSuf.lean`） |
  | `000_calculation_formulae_20_29.ts` の `<real_inclusion_preserves_finite_product>`（Typst の原本なし。2026-11-06 に本文へ足した） | `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealInclusionPreservesFiniteProduct.lean`（必要十分版からの導出は同じフォルダの `ClaimRealInclusionPreservesFiniteProductFromNecSuf.lean`） |
  | `020_critical_point.ts` の `<cosh_is_even>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshIsEven.lean`（必要十分版からの導出は同じフォルダの `ClaimCoshIsEvenFromNecSuf.lean`） |
  | `020_critical_point.ts` の `<cosh_at_least_one>`（Typst の原本なし。2026-11-02 に本文へ足した） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshAtLeastOne.lean`（必要十分版からの導出は同じフォルダの `ClaimCoshAtLeastOneFromNecSuf.lean`） |
  | `020_critical_point.ts` の `<real_log_of_product>`・`<real_log_of_power>`（2026-11-07 に Lean の具体版を足した） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimRealLogOfProduct.lean`・`ClaimRealLogOfPower.lean`（必要十分版からの導出は同じフォルダの `ClaimRealLogOfProductFromNecSuf.lean`・`ClaimRealLogOfPowerFromNecSuf.lean`） |
  | `000_calculation_formulae_00_09.ts` の `<positive_real_square_injective>`（2026-11-04 に Lean の具体版を足した） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimPositiveRealSquareInjective.lean`（必要十分版からの導出は同じフォルダの `ClaimPositiveRealSquareInjectiveFromNecSuf.lean`） |
  | `020_critical_point.ts` の `<nonnegative_real_order_from_squares>`（2026-11-06 に Lean の具体版を足した） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`（必要十分版からの導出は同じフォルダの `ClaimNonnegativeRealOrderFromSquaresFromNecSuf.lean`） |
  | `003_exp_linear_map.ts` の `<cosh_sinh_basic_properties>` の (1)・(3)（2026-11-05 に Lean の具体版を足した。(2)・(4) は未形式化） | `Ising2D/MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimCoshSinhBasicProperties.lean`（必要十分版からの導出は同じフォルダの `ClaimCoshSinhBasicPropertiesFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_multiplication_continuity>`（`parts/002_線型空間の一般論/002_claim_行列ノルムの劣乗法性.typ`。係数 `ℂ` の場合） | `Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimMatrixMultiplicationContinuity.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf.lean`） |
  | `002_linear_space_general.ts` の `<matrix_multiplication_continuity_in_right_factor>`・`<scalar_sequence_times_matrix_converges>`（Typst の原本なし。2026-11-03 に本文へ足した） | `Ising2D/MathematicalTools/VectorAndMatrixNormsAndConvergence/ClaimMatrixMultiplicationContinuityInRightFactor.lean`・`ClaimScalarSequenceTimesMatrixConverges.lean`（必要十分版からの導出と `TensorPow M` での系は同じフォルダの `ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf.lean`） |
  | `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` | `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/LemmaCentralizerIsScalar.lean` |
  | `parts/004_転送行列/000_definition_転送行列の記号の定義.typ` と、`006_Z_Y_anticommutation.ts` の `<pauli_matrix_products>`（Pauli 行列の積の 6 式。証明の鎖と 1 段ずつ対応）、`<transpose_of_identity_matrix_of_order_two>`・`<transpose_of_pauli_x>`・`<transpose_of_pauli_z>`・`<transpose_of_pauli_y>`（2 次の行列の転置。証明の鎖と 1 段ずつ対応） | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` |
  | `006_Z_Y_anticommutation.ts` の `<identity_matrix_of_order_two_has_real_entries>`・`<pauli_x_has_real_entries>`・`<pauli_z_has_real_entries>`・`<def_real_factor_of_pauli_y>`・`<pauli_y_is_i_times_real_factor>`・`<real_factor_of_pauli_y_has_real_entries>`（Typst の原本なし。2026-11-03 に本文へ足した。証明の鎖と 1 段ずつ対応） | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/ClaimPauliMatricesHaveRealEntries.lean` |
  | `parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` | `Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean` |
  | `<def_hatZ_pm>`・`<def_hatY>`・`<exp_sum>` に共通する複素位相因子 | `Ising2D/EigenvalueProblem/ReductionToATheta/DefinitionExpPhase.lean` |
  | `parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ` | `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimExpSum.lean` |
  | `parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ` | `Ising2D/RoutesNotAdopted/IntegerMomentum/DefinitionHatZHatY.lean` |
  | `parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ` | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/010,014,015,016,017` | `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean` |
  | `parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ` | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimHatZHatYPeriodicity.lean` |
  | `parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ` | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimRecoverZYFromHatZHatY.lean` |
  | `parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` | `Ising2D/EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimZYGenerateAlgebra.lean` |
  | `parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ` | `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean` |
  | `parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ` | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimAnticommutatorHatZHatY.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/019,020,022,023,041`（`θ_μ`, `γ_1`, `γ_2`, `A(θ)`） | `Ising2D/EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/027,028,034`（固有値・対角化・`det A`） | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/029,030,031`（`ψ` の定義・`V` との交換関係・反交換関係） | `Ising2D/RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` |
  | （表現の選択と両表現の同型） | `Ising2D/Basic.lean`, `Ising2D/Representation.lean` |

- **整数運動量の経路は本文から参照用ノートへ退避してある。** 人手証明の本文は半整数運動量
  `θ̃_μ = 2π(μ−1/2)/M` の経路だけで書かれており、整数運動量 `θ_μ = 2πμ/M` の `Ẑ^{(±)}, Ŷ`、
  `ψ`、`V'`、`V` の固有値の各主張は `structured-latex/notes/integer_momentum_route_not_adopted.ts`
  にある。退避したラベルの一覧は同ファイルの各ノートの冒頭段落が持つ。
  これらに対応する Lean ファイル（`Ẑ, Ŷ` 関係、`ψ`、`V'`・`V` の固有値の主張）は形式化の記録として
  `Ising2D/RoutesNotAdopted/IntegerMomentum/` にまとめてあり、対応先は本文ではなくそのノートである。
  同じファイルに置かれた一般の定義・補題（共役写像 `T_g`、`A(θ)`、交換子の計算など）は、
  半整数運動量の章の Lean からも引き続き import している。
- **(−) セクター（全スピン反転 `ε` の固有値 −1 の側）の議論は本文から参照用ノートへ退避してある。**
  人手証明の本文は (+) セクターだけで述べられており、`𝓕^{(-)}`、`P^{(-)}`、`V_1^{(-)}`、`c_-(M)` を
  使う主張（`def_odd_eigenvectors_of_epsilon`, `odd_eigenspace_is_complex_subspace`,
  `sector_replacement_of_V1`, `sector_replacement_pow`, `partition_function_sector_decomposition`,
  `sector_decomposition_of_rayleigh_sup` と章 019 全体（`epsilon_is_sign_flip_permutation`,
  `abs_vector_moves_to_even_sector`, `c_minus_le_c_plus`, `c_equals_c_plus`））は
  `structured-latex/notes/minus_sector_not_adopted.ts` にある。
  これらに対応する Lean ファイル（`RoutesNotAdopted/MinusSector/DefinitionOddEigenvectors.lean`, `NecSuf/NegatedVectorsSubmodule.lean`,
  `RoutesNotAdopted/MinusSector/ClaimSectorReplacementOfV1.lean`, `RoutesNotAdopted/MinusSector/ClaimPartitionFunctionSectorDecomposition.lean`,
  `RoutesNotAdopted/MinusSector/ClaimRayleighSupSectorDecomposition.lean`, `NecSuf/PermSector.lean`, `RoutesNotAdopted/MinusSector/` の章 019 の 4 本）は形式化の記録として
  残してあり（ビルドは通し続ける）、対応先は本文ではなくそのノートである。本文の主張の Lean はこれらに依存しない。
  `NecSuf/EvenSectorUpperBound.lean`（`c_between_Lambda_half_and_twice_Lambda_half` の Step 2 が `W_ℝ`・`ε_ℝ` で書き直される前の形の形式化）と、
  それを特殊化した `onsager_step3_c_le_two_c_plus`・`EvenSectorBridge.rayleighSup_le_two_mul_LambdaM`・`EvenSectorBridge.rayleighSup_sandwich_LambdaM`
  （`ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerExactSolution.lean`）も形式化の記録として残す。通しの定理はこれらを使わない。
  本文の主張も使う部分（`V_1` の `𝓕^{(+)}` への制限の補題、実行列 `epsilonR` と `ε` の成分表示、
  置換行列 `permMat`）は、`PartitionFunction/ProjectionAndJordanWigner/ClaimV1RestrictionToEigenspaces.lean`,
  `ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonIsRealSymmetric.lean`, `NecSuf/PermMatrix.lean` へ移した。
  同じとき `NecSuf/PermMatrix.lean` へ移した成分の絶対値 `absVec` の側は、今は形式化の記録（`NecSuf/EvenSectorUpperBound.lean`・`NecSuf/PermSector.lean`・`RoutesNotAdopted/MinusSector/ClaimAbsVectorMovesToEvenSector.lean`）だけが使う。
  境界項の符号を引数に持つ一般形（`H1 M η`, `V1pm`, `V1pmHalf`, `V1pmUnits`, `V1pmHalfUnits`,
  `V1pmFromDefinition`, `epsProj M η`）は、これらの記録と整数運動量の経路のために補助として残し、
  本文のラベルに対応する (+) の定義・主張（`H1plus`, `V1plus`, `V1plusHalf`, `epsProjPlus` ほか）は
  その `η` を固定した場合と定義から一致する（`H1plus_eq_H1`, `V1plus_eq_V1pm`, `V1plusHalf_eq_V1pmHalf`,
  `epsProjPlus_eq_epsProj`）。
- **どの章のゴールの主張からも使われない 5 主張は本文から参照用ノートへ退避してある（2026-10-31）。**
  `def_eigenspaces_of_epsilon`, `epsilon_action_eigenvalues_are_signs`,
  `H1_H2_via_check_Z_Y`, `V_plus_inverse_is_positive_definite`, `V_plus_inverse_positive_and_trace_positivity` は
  `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts` にある。
  これらに対応する Lean（`PartitionFunction/ProjectionAndJordanWigner/EvenEigenvectors.lean` の `evenEigenspace_carrier`、
  `RoutesNotAdopted/ClaimsUnusedByChapterGoals/ClaimEpsilonActionEigenvalues.lean` とその必要十分版の導出、
  `RoutesNotAdopted/ClaimsUnusedByChapterGoals/ClaimH1H2ViaCheckZY.lean`, `EigenvalueProblem/EigenvaluesOfVPlus/ClaimVPlusPositiveDefinite.lean` の `(V^{(+)})^{-1}` の 2 定理）は
  形式化の記録として残してあり（ビルドは通し続ける）、対応先は本文ではなくそのノートである。
- **`W P^{(+)}` の `H_1^{(+)}`, `H_2` による指数表示の主張（`symmetrized_transfer_matrix_on_sector_exponential_form`）は
  本文から参照用ノートへ退避してある（2026-10-31）。** 射影の章の章末の主張
  （`W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`）が `W P^{(+)} = V^{(+)} P^{(+)}` と
  `V^{(+)}` の指数表示（`V_plus_exponential_form`）を別々に挙げるようになり、使われなくなったためである。ノートは
  `structured-latex/notes/symmetrized_transfer_matrix_on_sector_exponential_form_not_adopted.ts`、Lean は
  `PartitionFunction/ProjectionAndJordanWigner/ClaimSymmetrizedTransferMatrixOnSectorExponentialForm.lean` に記録として残す。
- 各 Lean ファイルの冒頭コメントに、対応する `.typ` ファイル名と Typst のラベル（`<...>`）を書く。
- 原文のステートメントをそのまま形式化できない場合（記号の重複・「元」と「族」の混同など）は、
  **冒頭コメントに原文の問題点と、形式化した修正版ステートメントを明記する**
  （例: `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean`）。

## 具体版と必要十分版の 2 本立て

`exact-solution-of-2d-ising-model/README.md` 4 節の方針にしたがい、**同じ主張について
具体版と必要十分版の 2 つを置く**。

| | 何を書くか | 何のためか |
| --- | --- | --- |
| 具体版 | 人手証明と同じ抽象度（複素行列）で、1 対 1 に対応する主張 | 人手証明の正当性を保証する |
| 必要十分版 | 不要な構造を取り払い、証明に必要な概念だけを残した主張 | 何が本質的かを示す。具体版が過剰な構造を要求していないかの検査 |

規約:

- 両版のファイル冒頭コメントに**同じ人手証明のラベル**を書き、相互に参照させる。
- 必要十分版から具体版が特殊化で得られる場合は、**具体版を必要十分版の系として導出する**。
  ただし人手証明と 1 対 1 に対応する形の主張は必ず別に立てる。
- **必要十分版は Lean の中だけに置く。** 人手証明の本文（`structured-latex/content/`）にも
  参照用ノート（`structured-latex/notes/`）にも持ち込まない。
- 必要十分版は `Ising2D/NecSuf/` 以下、名前空間 `Ising2D.NecSuf` に置く。

**章 009〜020 の 2 本立ての対応表は、この README ではなく各章のドキュメント
（`lean/docs/ch0NN-formalization.md`）が正本である**（下記「章 009〜020 の形式化」節を参照）。
以下の表は章 008 までのものである。

現在 2 本立てになっている主張:

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `<commutator_via_anticommutators>` | `Ising2D.matComm_mul_eq_matAcomm_sub_matAcomm`（`Mat(n, ℂ)`） | `Ising2D.commutator_via_anticommutators`（任意の環） |
| `<matrix_difference_zero_iff_equal>` | `Ising2D.matrix_sub_eq_zero_iff` / `vec_sub_eq_zero_iff`（`Mat(m,p,ℂ)` と `ℂ^m`。必要十分版からの導出は `Ising2D.matrix_sub_eq_zero_iff_of_necSuf` / `vec_sub_eq_zero_iff_of_necSuf`） | `Ising2D.NecSuf.sub_eq_zero_iff_matrix` / `sub_eq_zero_iff_vec`（係数は加法群。`NecSuf/MatrixVectorIdentityScalarDifference.lean`） |
| `<identity_matrix_is_left_unit_of_mat_mult>`（右の因子が数ベクトルの場合） | `Ising2D.identity_matrix_mulVec`（必要十分版からの導出は `Ising2D.identity_matrix_mulVec_of_necSuf`） | `Ising2D.NecSuf.one_mulVec_eq`（係数は `NonAssocSemiring`、添字は等号を判定できる任意の有限型） |
| `<scalar_multiple_factors_out_of_left_factor>`（右の因子が数ベクトルの場合） | `Ising2D.smul_mulVec_eq`（必要十分版からの導出は `Ising2D.smul_mulVec_eq_of_necSuf`） | `Ising2D.NecSuf.smul_mulVec_eq'`（係数は `NonUnitalSemiring`。乗法の可換則は効かず、結合則は外せない `Ising2D.NecSuf.mul_assoc_of_smul_mulVec`） |
| `<matrix_difference_mul_vector>` | `Ising2D.sub_mulVec_eq`（必要十分版からの導出は `Ising2D.sub_mulVec_eq_of_necSuf`） | `Ising2D.NecSuf.sub_mulVec_eq'`（係数は `NonUnitalNonAssocRing`） |
| `<matrix_plus_zero_matrix>` | `Ising2D.matrix_add_zero_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `matrix_add_zero_matrix_apply`。必要十分版からの導出は `Ising2D.matrix_add_zero_matrix_of_necSuf`） | `Ising2D.NecSuf.add_zero_matrix`（係数は `AddZeroClass`。`NecSuf/MatrixAddSubZero.lean`） |
| `<zero_matrix_plus_matrix>` | `Ising2D.zero_matrix_add_matrix`（必要十分版からの導出は `Ising2D.zero_matrix_add_matrix_of_necSuf`） | `Ising2D.NecSuf.zero_add_matrix`（係数は `AddZeroClass`） |
| `<matrix_minus_zero_matrix>` | `Ising2D.matrix_sub_zero_matrix`（必要十分版からの導出は `Ising2D.matrix_sub_zero_matrix_of_necSuf`） | `Ising2D.NecSuf.sub_zero_matrix`（係数は `SubNegZeroMonoid`。乗法は効かない） |
| `<finite_sum_of_zero_matrices>` | `Ising2D.finite_sum_of_zero_matrices`（人手の `r` 項の和を `Fin (r + 1)` の上の和で書く。必要十分版からの導出は `Ising2D.finite_sum_of_zero_matrices_of_necSuf`） | `Ising2D.NecSuf.sum_zero_matrices`（係数は `AddCommMonoid`。可換則は `Finset.sum` の定義のためだけに要る） |
| `<scalar_multiple_of_zero_matrix>` | `Ising2D.matrix_smul_zero_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `matrix_smul_zero_matrix_apply`。必要十分版からの導出は `Ising2D.matrix_smul_zero_matrix_of_necSuf`） | `Ising2D.NecSuf.smul_zero_matrix`（係数とスカラーは `SMulZeroClass`。スカラー倍が係数の積であることも、係数の和と積の性質も効かない。`NecSuf/SmulZeroMatrix.lean`） |
| `<negation_factors_out_of_left_factor>` | `Ising2D.neg_mul_matrix`（`Mat(m,n,ℂ)`・`Mat(n,p,ℂ)`。成分の鎖は `neg_mul_matrix_apply`。必要十分版からの導出は `Ising2D.neg_mul_matrix_of_necSuf`） | `Ising2D.NecSuf.neg_mul_matrix'`（係数は `Semiring` と `HasDistribNeg`。乗法の可換則と加法の逆元は効かない。`NecSuf/NegMatrixProduct.lean`） |
| `<negation_factors_out_of_right_factor>` | `Ising2D.mul_neg_matrix`（成分の鎖は `mul_neg_matrix_apply`。必要十分版からの導出は `Ising2D.mul_neg_matrix_of_necSuf`） | `Ising2D.NecSuf.mul_neg_matrix'`（係数は `Semiring` と `HasDistribNeg`。具体版の交換律の段は `-1` との交換だけで、`-1` は単位元と `HasDistribNeg` だけから全ての元と交換するので、乗法の可換則は効かない） |
| `<scalar_multiple_of_negated_matrix>` | `Ising2D.smul_neg_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `smul_neg_matrix_apply`。必要十分版からの導出は `Ising2D.smul_neg_matrix_of_necSuf`） | `Ising2D.NecSuf.smul_neg_matrix'`（係数は `Monoid` と `HasDistribNeg`。成分の鎖に和が無いので加法は効かず、交換律の段は `-1` との交換だけなので乗法の可換則も効かない。`NecSuf/SmulNegMatrix.lean`） |
| `<negation_is_scalar_multiple_by_minus_one>` | `Ising2D.neg_eq_neg_one_smul_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `neg_eq_neg_one_smul_matrix_apply`。必要十分版からの導出は `Ising2D.neg_eq_neg_one_smul_matrix_of_necSuf`） | `Ising2D.NecSuf.neg_eq_neg_one_smul_matrix'`（係数は `MulOneClass` と `HasDistribNeg`。成分の鎖に和も 2 つ以上の積も無いので、加法と乗法の結合則は効かない。`NecSuf/NegEqNegOneSmulMatrix.lean`） |
| `<matrix_double_negation>` | `Ising2D.neg_neg_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `neg_neg_matrix_apply`。必要十分版からの導出は `Ising2D.neg_neg_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.neg_neg_tensorPow`） | `Ising2D.NecSuf.neg_neg_matrix'`（`Ising2D/NecSuf/NegNegMatrix.lean`。係数は `Monoid` と `Neg` に、`-x = (-1)x` と `(-1)(-1) = 1` を仮定で渡す。加法・積の可換律は効いていない） |
| `<def_invertible_elements_of_R>` (ii) | `Ising2D.invertible_product_isUnit`（`DefinitionInvertibleElementsProduct.lean`、`Mat(n,ℂ)`。人手の 2 本の 6 行の鎖は `invertible_product_right_inverse`・`invertible_product_left_inverse`。必要十分版からの導出は `DefinitionInvertibleElementsProductFromNecSuf.lean` の `Ising2D.invertible_product_right_inverse_of_necSuf`・`invertible_product_left_inverse_of_necSuf`・`invertible_product_isUnit_of_necSuf`、`TensorPow M` での系は `Ising2D.invertible_product_isUnit_tensorPow`） | `Ising2D.NecSuf.invertible_product_right_inverse'`・`invertible_product_left_inverse'`（`Ising2D/NecSuf/InvertibleElementsProduct.lean`。`Semigroup` と `One` に、右単位元 `a1 = a` を仮定で渡す。左単位元・加法・積の可換律は効いていない） |
| `<nonnegative_real_order_from_squares>` | `Ising2D.nonnegative_real_order_from_squares`（`MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimNonnegativeRealOrderFromSquares.lean`。人手の背理法の 4 行。必要十分版からの導出は同じフォルダの `ClaimNonnegativeRealOrderFromSquaresFromNecSuf.lean` の `Ising2D.nonnegative_real_order_from_squares_of_necSuf`） | `Ising2D.NecSuf.order_from_squares'`（`Ising2D/NecSuf/NonnegativeOrderFromSquares.lean`。全順序と `PosMulMono`・`MulPosStrictMono` だけ。平方は `u·u` で述べる。加法・乗法の結合則と単位元は効かない） |
| `<finite_sum_of_complex_sums>` | `Ising2D.finite_sum_of_complex_sums`（`Fin n` の上の和。人手の帰納法は `n + 1` 項の `finite_sum_of_complex_sums_succ`、結合律・交換律の 5 行は `finite_sum_of_complex_sums_step`。必要十分版からの導出は `Ising2D.finite_sum_of_complex_sums_of_necSuf`） | `Ising2D.NecSuf.finite_sum_add_fin'`（`Ising2D/NecSuf/MatMulDistribSum.lean`。係数は `AddCommMonoid`。効くのは加法の結合則・交換則だけ。有限型の上の和は `finite_sum_add'` が `Fintype.equivFin` で番号を付けてから同じ帰納法を使う） |
| `<mat_mult_distributes_over_sum_in_right_factor>` | `Ising2D.mul_add_matrix`（`Mat(m,p,ℂ)`。成分の鎖は `mul_add_matrix_apply`。必要十分版からの導出は `Ising2D.mul_add_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_add_matrix_tensorPow`） | `Ising2D.NecSuf.mul_add_matrix'`（`Ising2D/NecSuf/MatMulDistribSum.lean`。係数は `AddCommMonoid`・`Mul`・左分配則。乗法の結合則・単位元・可換則は効かない） |
| `<mat_mult_distributes_over_sum_in_left_factor>` | `Ising2D.add_mul_matrix`（`Mat(m,p,ℂ)`。成分の鎖は `add_mul_matrix_apply`。必要十分版からの導出は `Ising2D.add_mul_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.add_mul_matrix_tensorPow`） | `Ising2D.NecSuf.add_mul_matrix'`（`Ising2D/NecSuf/MatMulDistribSum.lean`。係数は `AddCommMonoid`・`Mul`・右分配則。乗法の結合則・単位元・可換則は効かない） |
| `<mat_conj>` | `Ising2D.conj_add_matrix`・`Ising2D.conj_smul_matrix`（`T_B` は `Conjugation.T`、`B` は `Mat(n,ℂ)` の単元。人手の和・スカラー倍の鎖の 4 行ずつと 1 対 1 の `calc`。必要十分版からの導出は `Ising2D.conj_add_matrix_of_necSuf`・`Ising2D.conj_smul_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.conj_add_tensorPow`・`Ising2D.conj_smul_tensorPow`） | `Ising2D.NecSuf.conj_add_matrix'`・`Ising2D.NecSuf.conj_smul_matrix'`（`Ising2D/NecSuf/MatrixConjugationSum.lean`。`B^{-1}` を任意の行列 `B'` に置き換えて述べる。`B` の可逆性と行列の積の結合則は効かない。和は係数の左右の分配則と加法の結合則・交換則だけが効く。スカラー倍は係数の乗法の結合則・左分配則・可換則が効き、乗法の単位元は効かない） |
| `<matrix_conjugation_preserves_finite_sum>` | `Ising2D.conj_finite_sum_of_matrices`（`r + 1` 項の帰納法。必要十分版からの導出は `Ising2D.conj_finite_sum_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.conj_finite_sum_tensorPow`） | `Ising2D.NecSuf.conj_finite_sum_matrix'`（`Ising2D/NecSuf/MatrixConjugationSum.lean`。効くのは和を保つことと有限和の定義だけ） |
| `<negation_distributes_over_matrix_sum>` | `Ising2D.neg_add_matrix`（`Mat(m,n,ℂ)`。成分の鎖は `neg_add_matrix_apply`。必要十分版からの導出は `Ising2D.neg_add_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.neg_add_tensorPow`） | `Ising2D.NecSuf.neg_add_matrix'`（`Ising2D/NecSuf/NegMatrixSum.lean`。係数は `Add`・`Mul`・`Neg`・`One` と左分配則に、`-x = (-1)x` を仮定で渡す。加法の結合則・交換則・零、乗法の結合則・単位元・可換則は効かない） |
| `<finite_sum_of_negated_matrices>` | `Ising2D.neg_finite_sum_of_matrices`（`r + 1` 項の帰納法。必要十分版からの導出は `Ising2D.neg_finite_sum_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.neg_finite_sum_tensorPow`） | `Ising2D.NecSuf.neg_finite_sum_matrix'`（`Ising2D/NecSuf/NegMatrixSum.lean`。効くのは和の符号反転と有限和の定義だけ） |
| `<matrix_difference_is_sum_with_negation>` | `Ising2D.matrix_sub_eq_add_neg`（`Mat(m,n,ℂ)`。成分の鎖は `matrix_sub_eq_add_neg_apply`。必要十分版からの導出は `Ising2D.matrix_sub_eq_add_neg_of_necSuf`、`TensorPow M` での系は `Ising2D.sub_eq_add_neg_tensorPow`） | `Ising2D.NecSuf.sub_eq_add_neg_matrix'`（`Ising2D/NecSuf/MatrixSubNeg.lean`。係数は `Add`・`Neg`・`Sub` と、差が `x + (-y)` で定まる仮定だけ） |
| `<difference_of_negated_matrices>` | `Ising2D.neg_sub_neg_matrix`（行列の等号の 3 段。必要十分版からの導出は `Ising2D.neg_sub_neg_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.neg_sub_neg_tensorPow`） | `Ising2D.NecSuf.neg_sub_neg_matrix'`（`Ising2D/NecSuf/MatrixSubNeg.lean`。差の仮定と和の符号反転だけが効く。二重の符号反転・加法の逆元は効かない） |
| `<def_matrix_anticommutator>` | `Ising2D.matAnticomm`（定義。添字は有限型 `ι`） | 置かない（定義だけで計算を含まない） |
| `<zero_matrix_is_left_zero_of_mat_mult>` | `Ising2D.zero_matrix_mul`（成分の鎖は `zero_matrix_mul_apply`。必要十分版からの導出は `Ising2D.zero_matrix_mul_of_necSuf`、`TensorPow M` での系は `Ising2D.zero_matrix_mul_tensorPow`、`TensorPow M` と 1 列の行列 `Matrix (Conf M) (Fin 1) ℂ` での系は `Ising2D.zero_matrix_mul_colVec`） | `Ising2D.NecSuf.zero_mul_matrix'`（`Ising2D/NecSuf/MatrixZeroMulAndSumEquations.lean`。係数の `0·x = 0` と零の有限和だけが効く） |
| `<zero_matrix_is_right_zero_of_mat_mult>` | `Ising2D.matrix_mul_zero_matrix`（成分の鎖は `matrix_mul_zero_matrix_apply`。必要十分版からの導出は `Ising2D.matrix_mul_zero_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.matrix_mul_zero_matrix_tensorPow`、1 列の行列での系は `Ising2D.matrix_mul_zero_colVec`） | `Ising2D.NecSuf.mul_zero_matrix'`（`Ising2D/NecSuf/MatrixMulZero.lean`。係数の `x·0 = 0` と零の有限和だけが効く） |
| `<def_finite_product_of_matrices>` | `Ising2D.finiteMatrixProduct`（定義。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。2 つの式は `finiteMatrixProduct_zero`・`finiteMatrixProduct_succ`。必要十分版との一致は `Ising2D.finiteMatrixProduct_eq_finProdLeft`） | `Ising2D.NecSuf.finProdLeft`（`Ising2D/NecSuf/FiniteProductLeft.lean`。`Mul` だけで定まる） |
| `<finite_product_of_identity_matrices>` | `Ising2D.finite_product_of_identity_matrices`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.finite_product_of_identity_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.finite_product_of_identity_matrices_tensorPow`） | `Ising2D.NecSuf.finProdLeft_const_one'`（同じファイル。`1·1 = 1` だけが効く） |
| `<def_sum_over_binary_words>` | `Ising2D.binaryWordMatrixSum`（定義。人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1`、`{0,1}^r` が `Fin (r + 1) → Fin 2`、`(ε', e)` が `Fin.snoc ε' e` に当たる。2 つの式は `binaryWordMatrixSum_zero`・`binaryWordMatrixSum_succ`。必要十分版との一致は `Ising2D.binaryWordMatrixSum_eq_binWordSum`） | `Ising2D.NecSuf.binWordSum`（`Ising2D/NecSuf/BinaryWordSum.lean`。`Add` だけで定まる） |
| `<sum_over_binary_words_distributes_in_left_factor>` | `Ising2D.binaryWordMatrixSum_mul`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.binaryWordMatrixSum_mul_of_necSuf`、`TensorPow M` での系は `Ising2D.binWordSum_mul_tensorPow`、1 列の行列を右から掛ける系は `Ising2D.binWordSum_mul_colVec`） | `Ising2D.NecSuf.binWordSum_map`（同じファイル。写像が `+` を保つことだけが効く） |
| `<sum_over_binary_words_distributes_in_right_factor>` | `Ising2D.mul_binaryWordMatrixSum`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.mul_binaryWordMatrixSum_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_binWordSum_tensorPow`、1 列の行列の和の系は `Ising2D.mul_binWordSum_colVec`） | `Ising2D.NecSuf.binWordSum_map`（同じファイル。`f := (C * ·)`。写像が `+` を保つことだけが効く） |
| `<sum_over_binary_words_with_one_nonzero_term>` | `Ising2D.binaryWordMatrixSum_eq_of_eq_zero`（帰納法の 2 つの節の `calc`。`r = 1` は `ε'` が `(1)` か `(0)` かの二つの場合、`r → r + 1` は `e = ε'_{r+1}` の二つの場合。必要十分版からの導出は `Ising2D.binaryWordMatrixSum_eq_of_eq_zero_of_necSuf`、`TensorPow M` での系は `Ising2D.binWordSum_eq_of_eq_zero_tensorPow`、1 列の行列での系は `Ising2D.binWordSum_eq_of_eq_zero_colVec`） | `Ising2D.NecSuf.binWordSum_eq_of_eq_zero`（`Ising2D/NecSuf/BinaryWordSum.lean`。`a + 0 = a`・`0 + a = a`（`AddZeroClass`）だけが効く） |
| `<real_inclusion_preserves_sum_over_binary_words>` | `Ising2D.binaryWordComplexSum_ofReal`（帰納法の 2 つの節の `calc`。和は `binaryWordComplexSum`・`binaryWordRealSum`、二項の包含は `real_inclusion_add`。必要十分版からの導出は `Ising2D.binaryWordComplexSum_ofReal_of_necSuf`、`NecSuf.binWordSum` での系は `Ising2D.binWordSum_ofReal`（具体版から運ぶ）。`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimRealInclusionPreservesSumOverBinaryWords.lean`・`ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf.lean`） | `Ising2D.NecSuf.binWordSum_map`（`f := (↑· : ℝ → ℂ)`。効くのは包含が二項の和を保つことだけ。`NecSuf/BinaryWordSum.lean`） |
| `<expansion_of_finite_product_of_two_term_sums>` | `Ising2D.expansion_of_finite_product_of_two_term_sums`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.expansion_of_finite_product_of_two_term_sums_of_necSuf`、`TensorPow M` での系は `Ising2D.expansion_of_finite_product_of_two_term_sums_tensorPow`） | `Ising2D.NecSuf.finProdLeft_add_eq_binWordSum`（同じファイル。二つの分配律（`Distrib`）だけが効く。積の結合則・因子の可換性は効かない） |
| `<real_sum_over_binary_words_distributes_in_left_factor>` | `Ising2D.binaryWordRealSum_mul`（帰納法の `r = 1` の 3 行・`r → r + 1` の 4 行と 1 対 1 の `calc`。ℝ の分配則は mathlib の `add_mul`。必要十分版からの導出は `Ising2D.binaryWordRealSum_mul_of_necSuf`。`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbers.lean`・`ClaimExpansionOfFiniteProductOfTwoTermSumsOfRealNumbersFromNecSuf.lean`） | `Ising2D.NecSuf.binWordSum_map`（`f := (· * c)`。効くのは `(a + b)c = ac + bc` だけ。`NecSuf/BinaryWordSum.lean`） |
| `<expansion_of_finite_product_of_two_term_sums_of_real_numbers>` | `Ising2D.expansion_of_finite_product_of_two_term_sums_of_real`（帰納法の `r = 1` の 4 行・`r → r + 1` の 7 行と 1 対 1 の `calc`。和は `binaryWordRealSum`、有限積は `Finset.prod`（`def_finite_product_of_real_numbers` の 2 つの式は `Fin.prod_univ_one`・`Fin.prod_univ_castSucc`）、ℝ の分配則は mathlib の `mul_add`。必要十分版からの導出は `Ising2D.expansion_of_finite_product_of_two_term_sums_of_real_of_necSuf`。同じ 2 つのファイル） | `Ising2D.NecSuf.finProdLeft_add_eq_binWordSum`（`R := ℝ`。行列の場合と同じ必要十分版で、二つの分配律（`Distrib`）だけが効く） |
| `<matrix_commuting_with_each_factor_commutes_with_finite_product>` | `Ising2D.matrix_commuting_with_each_factor_commutes_with_finite_product`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.matrix_commuting_with_each_factor_commutes_with_finite_product_of_necSuf`、`TensorPow M` での系は `Ising2D.commute_finProdLeft_tensorPow`） | `Ising2D.NecSuf.commute_finProdLeft`（`Ising2D/NecSuf/FiniteProductCommute.lean`。積の結合則（`Semigroup`）だけが効く） |
| `<product_of_two_finite_products_of_matrices>` | `Ising2D.product_of_two_finite_products_of_matrices`（帰納法の 2 つの節の `calc`。必要十分版からの導出は `Ising2D.product_of_two_finite_products_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.finProdLeft_mul_finProdLeft_tensorPow`） | `Ising2D.NecSuf.finProdLeft_mul_finProdLeft`（同じファイル。積の結合則と `j < i` の組の可換性だけが効く） |
| `<def_finite_product_of_matrices_omitting_one_index>` | `Ising2D.finiteMatrixProductOmitting`（定義。人手の `r ∈ ℤ_{≥2}` が Lean の `r + 2`、`s_{r,ν}` が `Fin.succAbove ν`。式は `finiteMatrixProductOmitting_def`。必要十分版との一致は `Ising2D.finiteMatrixProductOmitting_eq_finProdLeftOmitting`） | `Ising2D.NecSuf.finProdLeftOmitting`（`Ising2D/NecSuf/FiniteProductOmittingOneIndex.lean`。`Mul` だけで定まる） |
| `<moving_one_factor_of_finite_product_to_the_end>` | `Ising2D.moving_one_factor_of_finite_product_to_the_end`（`r = 2` の二つの場合は `..._two_first`・`..._two_second`、帰納法の段は `Fin.lastCases` の 2 つの場合の `calc`。必要十分版からの導出は `Ising2D.moving_one_factor_of_finite_product_to_the_end_of_necSuf`、`TensorPow M` での系は `Ising2D.finProdLeft_eq_omitting_mul_tensorPow`） | `Ising2D.NecSuf.finProdLeft_eq_omitting_mul`（同じファイル。積の結合則（`Semigroup`）と `ν < j` の組の可換性だけが効く） |
| `<matrix_sum_with_itself_zero_implies_zero>` | `Ising2D.matrix_eq_zero_of_add_self_eq_zero`（成分の鎖は `matrix_eq_zero_of_add_self_eq_zero_apply`、`2_ℂ` は `complexTwo`。必要十分版からの導出は `Ising2D.matrix_eq_zero_of_add_self_eq_zero_of_necSuf`、`TensorPow M` での系は `Ising2D.eq_zero_of_add_self_eq_zero_tensorPow`） | `Ising2D.NecSuf.eq_zero_of_add_self_eq_zero_matrix'`（同じファイル。`1 + 1` の左逆元・`1·x = x`・積の結合律・右分配律・`h·0 = 0` だけが効く） |
| `<matrix_summand_from_sum_equation>` | `Ising2D.matrix_eq_sub_of_add_eq`（成分の鎖は `matrix_eq_sub_of_add_eq_apply`。必要十分版からの導出は `Ising2D.matrix_eq_sub_of_add_eq_of_necSuf`、`TensorPow M` での系は `Ising2D.eq_sub_of_add_eq_tensorPow`） | `Ising2D.NecSuf.eq_sub_of_add_eq_matrix'`（同じファイル。係数は `AddCommGroup`。乗法は効かない） |
| `<matrix_equals_negation_if_sum_is_zero>` | `Ising2D.matrix_eq_neg_of_add_eq_zero`（人手の 3 行の鎖は `matrix_sub_neg_eq_zero_of_add_eq_zero`。必要十分版からの導出は `Ising2D.matrix_eq_neg_of_add_eq_zero_of_necSuf`、`TensorPow M` での系は `Ising2D.eq_neg_of_add_eq_zero_tensorPow`） | `Ising2D.NecSuf.eq_neg_of_add_eq_zero_matrix'`（`Ising2D/NecSuf/MatrixEqNegOfAddEqZero.lean`。係数は `AddGroup`。加法の可換則・乗法は効かない） |
| `<commuting_with_difference>` | `Ising2D.matrix_mul_sub_eq_sub_mul_of_commute`（人手の 8 行の鎖と 1 対 1 の calc。必要十分版からの導出は `Ising2D.matrix_mul_sub_eq_sub_mul_of_commute_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_sub_eq_sub_mul_of_commute_tensorPow`） | `Ising2D.NecSuf.mul_sub_eq_sub_mul_of_commute_matrix'`（`Ising2D/NecSuf/CommuteWithMatrixDifference.lean`。係数は `Semiring` と `HasDistribNeg` と `x - y = x + (-y)`。加法の逆元・乗法の可換則は効かない） |
| `<zero_scalar_multiple_is_zero_matrix>` | `Ising2D.matrix_zero_smul`（成分の鎖は `matrix_zero_smul_apply`。必要十分版からの導出は `Ising2D.matrix_zero_smul_of_necSuf`、`TensorPow M` での系は `Ising2D.zero_smul_tensorPow`） | `Ising2D.NecSuf.zero_smul_matrix'`（`Ising2D/NecSuf/ZeroSmulAndAddCommMatrix.lean`。スカラーの `0 • x = 0` だけが効く） |
| `<matrix_sum_is_commutative>` | `Ising2D.matrix_add_comm`（成分の鎖は `matrix_add_comm_apply`。必要十分版からの導出は `Ising2D.matrix_add_comm_of_necSuf`、`TensorPow M` での系は `Ising2D.add_comm_tensorPow`） | `Ising2D.NecSuf.add_comm_matrix'`（同じファイル。係数の加法の交換律だけが効く） |
| `<matrix_plus_difference_cancels>` | `Ising2D.matrix_add_sub_cancel`（成分の鎖は `matrix_add_sub_cancel_apply`。必要十分版からの導出は `Ising2D.matrix_add_sub_cancel_of_necSuf`、`TensorPow M` での系は `Ising2D.add_sub_cancel_tensorPow`） | `Ising2D.NecSuf.add_sub_cancel_matrix'`（`Ising2D/NecSuf/MatrixAddSubCancel.lean`。係数は `AddCommGroup`。乗法は効かない） |
| `<scalar_multiple_by_one>` | `Ising2D.matrix_one_smul`（成分の鎖は `matrix_one_smul_apply`。必要十分版からの導出は `Ising2D.matrix_one_smul_of_necSuf`、`TensorPow M` での系は `Ising2D.one_smul_tensorPow`） | `Ising2D.NecSuf.one_smul_matrix'`（`Ising2D/NecSuf/OneSmulMatrix.lean`。スカラーの `1 • x = x` だけが効く） |
| `<matrix_conjugation_preserves_negation>` | `Ising2D.conj_neg_matrix`（人手の 4 行と 1 対 1 の `calc`。必要十分版からの導出は `Ising2D.conj_neg_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.conj_neg_tensorPow`） | `Ising2D.NecSuf.conj_neg_matrix'`（`Ising2D/NecSuf/MatrixConjugationNegSub.lean`。`B^{-1}` を任意の行列 `B'` に置き換えて述べる。係数は `Semiring`・`HasDistribNeg`。`B` の可逆性、積の結合則、係数の可換則・加法の逆元は効かない） |
| `<matrix_conjugation_preserves_difference>` | `Ising2D.conj_sub_matrix`（人手の 4 行と 1 対 1 の `calc`。必要十分版からの導出は `Ising2D.conj_sub_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.conj_sub_tensorPow`） | `Ising2D.NecSuf.conj_sub_matrix'`（`Ising2D/NecSuf/MatrixConjugationNegSub.lean`。効くのは差の仮定・和を保つこと・符号反転を保つことだけ） |
| `<scalar_multiple_distributes_over_matrix_difference>` | `Ising2D.matrix_smul_sub`（`Mat(m,p,ℂ)`。成分の鎖は `matrix_smul_sub_apply`。必要十分版からの導出は `Ising2D.matrix_smul_sub_of_necSuf`） | `Ising2D.NecSuf.smul_sub_matrix'`（係数は `Semiring` と `HasDistribNeg`、差は `x - y = x + (-y)` の仮定、スカラーは係数の元。乗法の可換則・加法の逆元・添字の有限性は効かない。`NecSuf/SmulMatrixSub.lean`） |
| `<scalar_multiple_distributes_over_matrix_sum>` | `Ising2D.matrix_smul_add`（`Mat(m,n,ℂ)`。成分の鎖は `matrix_smul_add_apply`。必要十分版からの導出は `Ising2D.matrix_smul_add_of_necSuf`、`TensorPow M` での系は `Ising2D.smul_add_tensorPow`） | `Ising2D.NecSuf.smul_add_matrix'`（係数は `Add`・`Mul` と左分配則、スカラーは係数の元。加法・乗法のほかの法則と添字の有限性は効かない。`NecSuf/SmulMatrixSum.lean`） |
| `<finite_sum_of_scalar_multiples>` | `Ising2D.finite_sum_smul_of_matrices`（`r + 1` 項の帰納法。必要十分版からの導出は `Ising2D.finite_sum_smul_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.finite_sum_smul_tensorPow`） | `Ising2D.NecSuf.finite_sum_smul_matrix'`（`NecSuf/SmulMatrixSum.lean`。効くのは和のスカラー倍と有限和の定義。`AddCommMonoid` は mathlib の `Finset.sum` を使うためだけ） |
| `<finite_sum_of_matrices_distributes_in_left_factor>` | `Ising2D.finite_sum_mul_of_matrices`（`r + 1` 項の帰納法。必要十分版からの導出は `Ising2D.finite_sum_mul_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.finite_sum_mul_tensorPow`） | `Ising2D.NecSuf.finite_sum_mul_matrix'`（`NecSuf/FiniteSumMulMatrix.lean`。効くのは積の左の因子の和への分配（右分配則）と有限和の定義。乗法の結合則・単位元・可換則は効かない） |
| `<finite_sum_of_matrices_distributes_in_right_factor>` | `Ising2D.mul_finite_sum_of_matrices`（`r + 1` 項の帰納法。必要十分版からの導出は `Ising2D.mul_finite_sum_of_matrices_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_finite_sum_tensorPow`） | `Ising2D.NecSuf.mul_finite_sum_matrix'`（`NecSuf/MatrixMulFiniteSum.lean`。効くのは積の右の因子の和への分配（左分配則）と有限和の定義。乗法の結合則・単位元・可換則は効かない） |
| `<difference_of_scalar_multiples_of_one_matrix>` | `Ising2D.smul_sub_smul_matrix`（成分の鎖は `smul_sub_smul_matrix_apply`。必要十分版からの導出は `Ising2D.smul_sub_smul_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.smul_sub_smul_tensorPow`） | `Ising2D.NecSuf.smul_sub_smul_matrix'`（`NecSuf/SmulOneMatrix.lean`。係数は `Add`・`Monoid`・`HasDistribNeg`・`RightDistribClass` と差の式 `x - y = x + (-y)` だけ。加法の結合則・交換則・零、左分配則、加法の逆元、乗法の可換則は効かない） |
| `<finite_sum_of_real_differences>` | `Ising2D.finite_sum_of_real_differences`（`m + 1` 項の帰納法は `finite_sum_of_real_differences_succ`、帰納法の段の「ℝ の和と差の計算」は `finite_sum_of_real_differences_step`。必要十分版からの導出は `Ising2D.finite_sum_of_real_differences_of_necSuf`） | `Ising2D.NecSuf.finite_sum_sub_fin'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`。仮定は `SubtractionCommMonoid`。効くのは差が符号反転を足すこと・加法の結合則と交換則・和の符号反転が符号反転の和であることだけ。加法の逆元の法則・乗法・順序は効かない） |
| `<finite_sum_of_real_sums>` | `Ising2D.finite_sum_of_real_sums`（`m + 1` 項の帰納法は `finite_sum_of_real_sums_succ`、帰納法の段の結合則・交換則の 5 行は `finite_sum_of_real_sums_step`、添字が有限型の和は `finite_sum_of_real_sums_fintype`。必要十分版からの導出は `Ising2D.finite_sum_of_real_sums_of_necSuf`・`Ising2D.finite_sum_of_real_sums_fintype_of_necSuf`） | `Ising2D.NecSuf.finite_sum_add_fin'`（`NecSuf/MatMulDistribSum.lean`。複素数の兄弟 `finite_sum_of_complex_sums` と共有。仮定は加法の可換モノイドだけ。効くのは加法の結合則と交換則だけ） |
| `<finite_double_sum_of_real_numbers_interchange>` | `Ising2D.finite_double_sum_of_real_numbers_interchange`（外側の項の数についての帰納法は `finite_double_sum_of_real_numbers_interchange_succ`。人手の `p = 1` の 2 行と帰納法の段の 4 行と 1 対 1。添字が有限型の二重の和は `finite_double_sum_of_real_numbers_interchange_fintype`。必要十分版からの導出は `Ising2D.finite_double_sum_of_real_numbers_interchange_of_necSuf`・`Ising2D.finite_double_sum_of_real_numbers_interchange_fintype_of_necSuf`） | `Ising2D.NecSuf.finite_double_sum_interchange_fin'`（`NecSuf/FiniteDoubleSumInterchange.lean`。仮定は加法の可換モノイドだけ。効くのは加法の結合則と交換則だけ（帰納法の段で `finite_sum_add_fin'` を引く）。加法の逆元・乗法・順序は効かない） |
| `<finite_sum_of_negated_real_numbers>` | `Ising2D.finite_sum_of_negated_real_numbers`（`m + 1` 項の帰納法は `finite_sum_of_negated_real_numbers_succ`。人手の 6 行と 1 対 1。必要十分版からの導出は `Ising2D.finite_sum_of_negated_real_numbers_of_necSuf`） | `Ising2D.NecSuf.finite_sum_neg_fin'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`。仮定は加法についての可換モノイドと `Neg` に、明示の仮定 `-(a + b) = -a + -b`（空の和は `-0 = 0` も）を足したものだけ。符号反転の対合・差・加法の逆元の法則・乗法・順序は効かない。交換則は `Finset` の上の和が要求する） |
| `<finite_sum_of_real_scalar_multiples>` | `Ising2D.finite_sum_of_real_scalar_multiples`（`m + 1` 項の帰納法は `finite_sum_of_real_scalar_multiples_succ`。人手の 6 行と 1 対 1。添字が有限型の和へ番号を付けて当てる版は `finite_sum_of_real_scalar_multiples_fintype`。必要十分版からの導出は `Ising2D.finite_sum_of_real_scalar_multiples_of_necSuf`） | `Ising2D.NecSuf.finite_sum_mul_left_fin'`（`NecSuf/FiniteSumDifferenceAndNonnegativeTerm.lean`。仮定は加法についての可換モノイドと `Mul` に左からの分配法則（`LeftDistribClass`）を足したものだけ（空の和は明示の仮定 `c0 = 0` も）。乗法の結合則・交換則・単位元、右からの分配法則、差、順序は効かない。交換則は `Finset` の上の和が要求する） |
| `<finite_sum_of_real_numbers_triangle_inequality>` | `Ising2D.finite_sum_of_real_numbers_triangle_inequality`（`m + 1` 項の帰納法は `finite_sum_of_real_numbers_triangle_inequality_succ`。人手の `m = 1` の 2 行と帰納法の段の 4 行と 1 対 1。添字が有限型の和は `_fintype`。必要十分版からの導出は `Ising2D.finite_sum_of_real_numbers_triangle_inequality_of_necSuf`） | `Ising2D.NecSuf.finite_sum_subadditive_fin'`（`NecSuf/FiniteSumSubadditiveAndMonotone.lean`。絶対値については劣加法性 `f(a + b) ≤ f(a) + f(b)` と空の和の `f(0) ≤ 0` だけ。値の側は右に足して `≤` が保たれる前順序の可換モノイド） |
| `<finite_sum_of_real_numbers_is_monotone>` | `Ising2D.finite_sum_of_real_numbers_is_monotone`（`m + 1` 項の帰納法は `finite_sum_of_real_numbers_is_monotone_succ`。人手の 3 行と 4 行と 1 対 1。添字が有限型の和は `_fintype`。必要十分版からの導出は `Ising2D.finite_sum_of_real_numbers_is_monotone_of_necSuf`） | `Ising2D.NecSuf.finite_sum_le_fin'`（`NecSuf/FiniteSumSubadditiveAndMonotone.lean`。前順序の可換モノイドで、両辺に同じ元を左右どちらから足しても `≤` が保たれることだけ） |
| `<def_real_absolute_value>` | Lean の `\|q\|`（mathlib の `abs`）を `abs_of_nonneg`・`abs_of_neg` で定義の 2 つの場合へ開いて読む（`MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean` の冒頭） | （定義なので無い） |
| `<real_number_is_at_most_its_absolute_value>` | `Ising2D.real_number_is_at_most_its_absolute_value`（同じファイル。人手の 2 つの場合の 1 行・3 行と 1 対 1。導出は `Ising2D.real_number_is_at_most_its_absolute_value_of_necSuf`） | `Ising2D.NecSuf.le_abs'`（`NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean`。加法についての群（可換でなくてよい）・全順序・`AddLeftMono` だけ） |
| `<negative_absolute_value_is_at_most_real_number>` | `Ising2D.negative_absolute_value_is_at_most_real_number`（同じファイル。人手の 3 行・2 行と 1 対 1。導出は `Ising2D.negative_absolute_value_is_at_most_real_number_of_necSuf`） | `Ising2D.NecSuf.neg_abs_le'`（同じ必要十分版のファイル。仮定は上と同じ） |
| `<real_absolute_value_of_nonpositive>` | `Ising2D.real_absolute_value_of_nonpositive`（同じファイル。人手の `q = 0` の 4 行と 1 対 1。導出は `Ising2D.real_absolute_value_of_nonpositive_of_necSuf`） | `Ising2D.NecSuf.abs_of_nonpos'`（同じ必要十分版のファイル。仮定は上と同じ） |
| `<real_abs_triangle_inequality>` | `Ising2D.real_abs_triangle_inequality`（同じファイル。人手の前置きの 2 本の 2 行と 3 行・4 行と 1 対 1。導出は `Ising2D.real_abs_triangle_inequality_of_necSuf`） | `Ising2D.NecSuf.abs_add_le'`（同じ必要十分版のファイル。上に加法の可換性を足したもの。可換性は `-(a + b) = (-a) + (-b)` の段で効く） |
| `<real_abs_of_product>` | `Ising2D.real_abs_of_product`（同じファイル。人手の 4 つの場合の 3 行・4 行と 1 対 1。`ab ≤ 0` の場合は `real_absolute_value_of_nonpositive` を引く。導出は `Ising2D.real_abs_of_product_of_necSuf`） | `Ising2D.NecSuf.abs_mul'`（同じ必要十分版のファイル。加法の群・全順序・`AddLeftMono` に、符号の付け替え・`a·0 = 0`・`PosMulMono` を足したもの。乗法の結合則・交換則・単位元は効かない） |
| `<square_of_real_absolute_value>` | `Ising2D.square_of_real_absolute_value`（`MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfRealAbsoluteValueAndOfRealSum.lean`。人手の 2 つの場合の 1 行・2 行と 1 対 1。導出は `Ising2D.square_of_real_absolute_value_of_necSuf`） | `Ising2D.NecSuf.sq_abs'`（`NecSuf/SquareOfAbsoluteValueAndOfSum.lean`。全順序・`AddLeftMono` と符号の付け替え `(-a)(-a) = aa`。型を環にするのは、加法の群と符号の付け替えの符号反転を一つにするため） |
| `<square_of_real_sum_is_at_most_twice_sum_of_squares>` | `Ising2D.square_of_real_sum_is_at_most_twice_sum_of_squares`（同じファイル。人手の 4 行の鎖と 1 対 1。導出は `Ising2D.square_of_real_sum_is_at_most_twice_sum_of_squares_of_necSuf`） | `Ising2D.NecSuf.add_sq_le_two_mul_add'`（同じ必要十分版のファイル。環・全順序・`IsOrderedRing`。乗法の可換性は効かない） |
| `<maximum_value_of_real_family_is_unique>` | `Ising2D.maximum_value_of_real_family_is_unique`（人手の 2 本の 2 行の鎖と反対称律の 1 段と 1 対 1。定義 `<def_maximum_value_of_real_family>` は `Ising2D.IsMaxValueOfRealFamily`、記号 `<def_max_of_real_family>` は `Ising2D.maxOfRealFamily` と `Ising2D.maxOfRealFamily_eq`。必要十分版からの導出は `Ising2D.maximum_value_of_real_family_is_unique_of_necSuf`） | `Ising2D.NecSuf.maximum_value_of_family_is_unique'`（`NecSuf/MaximumValueOfFamilyIsUnique.lean`。仮定は関係 `≤` と反対称律だけ。反射律・推移律・全順序性・実数であること・添字の集合の有限性は効かない） |
| `<finite_product_of_positive_reals_is_positive>` | `Ising2D.finite_product_of_positive_reals_is_positive`（`m + 1` 項の帰納法。人手の 4 行と前置きの 2 つと 1 対 1。必要十分版からの導出は `Ising2D.finite_product_of_positive_reals_is_positive_of_necSuf`） | `Ising2D.NecSuf.finProdLeft_pos'`（`NecSuf/FiniteProductOfPositiveElementsIsPositive.lean`。仮定は `Mul`・`Zero`・`LT` と明示の仮定「`0 < a`・`0 < b` なら `0 < a * b`」だけ。`<` の推移律・非反射律、積の結合則・可換則・単位元、和は効かない） |
| `<finite_product_of_real_products>` | `Ising2D.finite_product_of_real_products`（`m + 1` 項の帰納法。人手の `m = 1` の 2 行と `m → m+1` の 4 行と 1 対 1。必要十分版からの導出は `Ising2D.finite_product_of_real_products_of_necSuf`） | `Ising2D.NecSuf.finProdLeft_mul'`（`NecSuf/FiniteProductOfProducts.lean`。仮定は `Mul` と明示の仮定 `(ab)(cd) = (ac)(bd)` だけ。積の結合則・可換則そのもの、単位元、和、順序は効かない） |
| `<real_inclusion_preserves_finite_product>` | `Ising2D.real_inclusion_preserves_finite_product`（`m + 1` 項の帰納法。人手の `m = 1` の 2 行と `m → m+1` の 4 行と 1 対 1。積の包含の段は具体版 `real_inclusion_mul`。必要十分版からの導出は `Ising2D.real_inclusion_preserves_finite_product_of_necSuf`） | `Ising2D.NecSuf.finProdLeft_map_of_mul`（`NecSuf/MultiplicativeMapOfFiniteProduct.lean`。仮定は定義域・値域の `Mul` と明示の仮定 `f(a)f(b) = f(ab)` だけ。積の結合則・可換則・単位元、`f` の単射性、和、定義域が ℝ で値域が ℂ であることは効かない） |
| `<cosh_is_even>` | `Ising2D.cosh_is_even`（人手の 4 行と 1 対 1 の `calc`。`def_cosh_sinh` は mathlib の `Real.cosh_eq` が担う。必要十分版からの導出は `Ising2D.cosh_is_even_of_necSuf`） | `Ising2D.NecSuf.symmetrized_sum_is_even'`（`NecSuf/SymmetrizedSumIsEven.lean`。`h y = d(f y + f(−y))` と書ける `h` は偶。効くのは引数の側の符号反転の対合性（`InvolutiveNeg`）と値の側の和の交換則（`AddCommMagma`）だけで、`exp` の性質と 2 で割ることは効かない。`h` の値の型は和の型と違ってよい） |
| `<cosh_at_least_one>` | `Ising2D.cosh_at_least_one`（人手の含意の 3 式と鎖の 3 行と 1 対 1。半角公式は `cosh_eq_one_add_two_sinh_half_sq`。必要十分版からの導出は `Ising2D.cosh_at_least_one_of_necSuf`） | `Ising2D.NecSuf.one_add_two_mul_sq_ge_one'`（`NecSuf/OnePlusTwiceNonnegativeIsAtLeastOne.lean`。`h = 1 + 2t²` と書ける `h` は `1` 以上。効くのは全順序の半環で平方が非負であること（`LinearOrder`・`ExistsAddOfLE`）と、非負の数を掛けることと和が順序を保つこと（`PosMulMono`・`AddLeftMono`）だけで、`cosh`・`exp` の性質、乗法の可換性、減法、逆元は効かない） |
| `<positive_real_square_injective>` | `Ising2D.positive_real_square_injective`（人手の `a = b ⇒ a^2 = b^2` と、逆向きの鎖の 2 行・含意の 4 行と 1 対 1。必要十分版からの導出は `Ising2D.positive_real_square_injective_of_necSuf`） | `Ising2D.NecSuf.positive_square_injective'`（`NecSuf/PositiveSquareInjective.lean`。零因子の無い可換環で、前順序と `AddLeftStrictMono` だけ。積の可換律は `(a-b)(a+b) = a^2-b^2` の段に効く。体・全順序・積と順序の両立は効かない） |
| `<cosh_sinh_basic_properties>` の (1)・(3) | `Ising2D.cosh_sinh_basic_properties_1`（(1) の 4 本の鎖と 2 つの含意は `cosh_sub_sinh_eq_exp_neg`・`cosh_add_sinh_eq_exp`・`cosh_sub_sinh_pos`・`real_cosh_gt_sinh`・`two_cosh_pos`・`cosh_pos_of_two_cosh_pos`）・`Ising2D.cosh_sinh_basic_properties_3`（(3) の含意と鎖は `real_neg_lt_zero_of_pos`・`real_exp_neg_lt_one`・`real_one_lt_exp`・`real_exp_sub_exp_neg_pos`・`real_sinh_pos_of_pos`）。人手の行と 1 対 1。`def_cosh_sinh` は mathlib の `Real.cosh_eq`・`Real.sinh_eq`、`real_exp_strictly_increasing` は mathlib の `Real.exp_lt_exp` が担う。必要十分版からの導出は `Ising2D.cosh_sinh_basic_properties_1_of_necSuf`・`Ising2D.cosh_sinh_basic_properties_3_of_necSuf`。(2)・(4) は未形式化） | `Ising2D.NecSuf.evenPart_sub_oddPart'` ほか（`NecSuf/HyperbolicBasicPropertiesFromMonotoneMap.lean`。写像 `e` から `c = (e(x)+e(−x))·⅟2`・`s = (e(x)−e(−x))·⅟2`（`⅟2` は `2` の逆元） を作る。(1) の等式は環と `2` の可逆性（`Invertible 2`）だけで `e` に仮定は要らない、(1) の不等号は `e` の正値性、(3) の `s(x) > 0` は `e` の狭義単調性だけが効く。`e(0) = 1`、`e(a+b) = e(a)e(b)`、乗法の可換則、ℝ であることは効かない） |
| `<finite_sum_of_nonnegative_reals_is_at_least_each_term>` | `Ising2D.finite_sum_of_nonnegative_reals_ge_term`（`m + 1` 項の帰納法は `finite_sum_of_nonnegative_reals_ge_term_succ`。人手と同じく `k ≤ m` と `k = m + 1` に分ける。添字が有限型の和は `Fintype.equivFin` で番号を付ける `finite_sum_of_nonnegative_reals_ge_term_fintype`。必要十分版からの導出は `Ising2D.finite_sum_of_nonnegative_reals_ge_term_of_necSuf`） | `Ising2D.NecSuf.finite_sum_ge_term_fin'`（同じファイル。仮定は `Preorder`・`AddLeftMono`・`AddRightMono`。効くのは `≤` の反射律・推移律、両辺に同じ元を足しても `≤` が保たれること、`0` が加法の単位元であることだけ。反対称律・差・乗法・全順序は効かない） |
| `<finite_sum_of_scalar_multiples_of_one_matrix>` | `Ising2D.finite_sum_smul_one_matrix`（成分の鎖は `finite_sum_smul_one_matrix_apply`。必要十分版からの導出は `Ising2D.finite_sum_smul_one_matrix_of_necSuf`、`TensorPow M` での系は `Ising2D.finite_sum_smul_one_tensorPow`） | `Ising2D.NecSuf.finite_sum_smul_one_matrix'`（`NecSuf/SmulOneMatrix.lean`。効くのは成分の有限和と係数の有限和の右分配だけ） |
| `<matrix_multiplication_continuity>` | `Ising2D.matrix_mul_right_tendsto`（係数 `ℂ`、Frobenius ノルム。人手の 3 行どおり。必要十分版からの導出は `Ising2D.matrix_mul_right_tendsto_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_right_tendsto_tensorPow`） | `Ising2D.NecSuf.mul_right_tendsto'`（`NecSuf/ContinuityOfProductsAndScalarMultiples.lean`。効くのは右分配則・劣乗法性・ノルムの非負性） |
| `<matrix_multiplication_continuity_in_right_factor>` | `Ising2D.matrix_mul_left_tendsto`（係数 `ℂ`、Frobenius ノルム。人手の 3 行どおり。必要十分版からの導出は `Ising2D.matrix_mul_left_tendsto_of_necSuf`、`TensorPow M` での系は `Ising2D.mul_left_tendsto_tensorPow`） | `Ising2D.NecSuf.mul_left_tendsto'`（`NecSuf/ContinuityOfProductsAndScalarMultiples.lean`。効くのは差に対する左分配則・劣乗法性・ノルムの非負性だけで、加法と乗法の結合則は効かない） |
| `<scalar_sequence_times_matrix_converges>` | `Ising2D.smul_matrix_tendsto`（Frobenius ノルム。人手の 3 行どおり。必要十分版からの導出は `Ising2D.smul_matrix_tendsto_of_necSuf`、`TensorPow M` での系は `Ising2D.smul_tendsto_tensorPow`） | `Ising2D.NecSuf.smul_tendsto'`（`NecSuf/ContinuityOfProductsAndScalarMultiples.lean`。効くのは係数の差のくくり出しと `‖ax‖ = ‖a‖‖x‖` だけで、係数の乗法は効かない） |
| `<exponential_series_of_even_odd_power_terms>` のノルムの評価と `ε` の鎖 | `Ising2D.evenOddPartialSum_sub_limit_norm_le`・`Ising2D.evenOddPartialSum_sub_limit_norm_tendsto`（Frobenius ノルム。人手の 8 行・3 行どおり。主張そのものは `Ising2D.exponential_series_of_even_odd_power_terms`。必要十分版からの導出は `Ising2D.evenOddPartialSum_sub_limit_norm_le_of_necSuf`・`Ising2D.evenOddPartialSum_sub_limit_norm_tendsto_of_necSuf`） | `Ising2D.NecSuf.evenOdd_norm_le'`・`Ising2D.NecSuf.evenOdd_err_tendsto'`（`NecSuf/EvenOddSeriesNormEstimate.lean`。効くのは三角不等式・斉次性・`‖kl‖ = ‖k‖‖l‖`・絶対値を保つ `ι : ℝ → K` だけで、行列であること・係数が ℂ であることは効かない） |
| `<scalar_identity_commutes>` | `Ising2D.scalar_identity_commutes`（`Mat(n, ℂ)`。人手の 6 段の鎖どおり。必要十分版からの導出は `Ising2D.scalar_identity_commutes_of_necSuf`、`LemmaScalarIdentityCommutesFromNecSuf.lean`） | `Ising2D.NecSuf.smul_one_commute` / `smul_one_sub_comm`（任意の `S`-代数。`NecSuf/ScalarCentral.lean`） |
| `<identity_matrix_is_left_unit_of_mat_mult>` | `Ising2D.identity_matrix_mul`（`ClaimIdentityAndScalarMultipleInMatrixProduct.lean`。必要十分版からの導出は `Ising2D.identity_matrix_mul_of_necSuf`、`ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`。`TensorPow M` と 1 列の行列 `Matrix (Conf M) (Fin 1) ℂ` での系は `Ising2D.identity_matrix_mul_colVec`） | `Ising2D.NecSuf.one_mul_matrix`（係数は `NonAssocSemiring`。`NecSuf/MatrixProductIdentityAndScalar.lean`） |
| `<identity_matrix_is_right_unit_of_mat_mult>` | `Ising2D.mul_identity_matrix`（必要十分版からの導出は `Ising2D.mul_identity_matrix_of_necSuf`） | `Ising2D.NecSuf.mul_one_matrix`（係数は `NonAssocSemiring`。乗法の可換則は効かない） |
| `<scalar_multiple_factors_out_of_left_factor>` | `Ising2D.smul_mul_matrix`（必要十分版からの導出は `Ising2D.smul_mul_matrix_of_necSuf`） | `Ising2D.NecSuf.smul_mul_matrix'`（係数は `NonUnitalSemiring`） |
| `<scalar_multiple_factors_out_of_right_factor>` | `Ising2D.mul_smul_matrix`（必要十分版からの導出は `Ising2D.mul_smul_matrix_of_necSuf`） | `Ising2D.NecSuf.mul_smul_matrix'`（係数は `NonUnitalCommSemiring`。可換則が外せないことは `Ising2D.NecSuf.mul_comm_of_mul_smul_matrix`） |
| `<centralizer_is_scalar>` | `Ising2D.centralizer_is_scalar`（`Mat(2,ℂ)^{⊗M}`） | `Ising2D.NecSuf.centralizer_is_scalar_semiring`（係数は任意の半環） |
| `<centralizer_is_scalar>` Step 2 の `E_{IJ}E_{KL} = δ_{JK}E_{IL}` | `Ising2D.E_mul_E` | `Ising2D.NecSuf.single_mul_single_eq_ite`（任意の半環・添字は 4 つとも別の型でよい。`NecSuf/MatrixUnits.lean`） |
| `<centralizer_is_scalar>` Step 2 の `I = Σ_P E_{PP}` | `Ising2D.one_eq_sum_E` | `Ising2D.NecSuf.one_eq_sum_single`（任意の半環・任意の有限添字型） |
| `<anticommutator_of_psi>` | `Ising2D.acomm_psiDag_psiDag` / `acomm_psiDag_psi` / `acomm_psi_psi`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.acomm_psi_relations_of_car`） | `Ising2D.NecSuf.acomm_lincomb_clifford` / `NecSuf.car_of_coeffs`（係数は任意の可換環、台は任意の環） |
| `Z_Y_linearly_independent` | `Ising2D.ZY_linearIndependent`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.ZY_linearIndependent_of_necSuf`、`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependentFromNecSuf.lean`） | `Ising2D.NecSuf.linearIndependent_of_clifford_necSuf`（係数は任意の可換環、台は任意の環。仮定は Clifford 関係＋スカラーの忠実性＋`2` の非零因子性だけ。`NecSuf/CliffordIndependence.lean`） |
| `two_by_two_transfer_identity` の中間目標「`exp(tσ^x)` の閉じた形」`exp(tσ^x) = cosh(t)I + sinh(t)σ^x` | `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh`（`Mat(2,ℂ)`、`t ∈ ℂ`。必要十分版からの導出は `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh_of_necSuf`、`PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentityFromNecSuf.lean`） | `Ising2D.NecSuf.exp_series_sum_of_sq_eq_one`（`A^2 = 1` を満たす元を持つ `ℂ`-代数の半環で、`ContinuousAdd`・`ContinuousSMul ℂ`・`T2`。`NecSuf/ExpOfInvolution.lean`） |
| `exp_sum` | `Ising2D.expPhase_sum`（複素指数関数。必要十分版からの導出は `Ising2D.expPhase_sum_of_necSuf`、`EigenvalueProblem/ReductionToATheta/ClaimExpSumFromNecSuf.lean`） | `Ising2D.NecSuf.sum_zpow_primitiveRoot`（任意の体と 1 の原始 `M` 乗根。`NecSuf/RootOfUnitySum.lean`） |
| `anticommutator_of_hat_Z_and_hat_Y` | `Ising2D.acomm_hatZ_hatZ_same` / `acomm_hatZ_hatZ_opp` / `acomm_hatY_hatY` / `acomm_hatZPlus_hatZMinus`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.acomm_hatZ_hatZ_same_of_necSuf` / `acomm_hatY_hatY_of_necSuf` / `acomm_hatZPlus_hatZMinus_of_necSuf`、`RoutesNotAdopted/IntegerMomentum/ClaimAnticommutatorHatZHatYFromNecSuf.lean`） | `Ising2D.NecSuf.acomm_fourier_clifford` / `acomm_fourier_clifford_flip` / `acomm_fourier_clifford_weights`（体上の任意の環、Clifford 関係と 1 の原始 `M` 乗根だけ。`NecSuf/FourierClifford.lean`） |
| `constant_c_value_even_sector` Step 2 の `U exp(S) U^{-1} = exp(USU^{-1})` | `Ising2D.Uflip_conj_pow` / `Uflip_conj_expPartialSum` / `Uflip_conj_matExp`（`Mat(2,ℂ)^{⊗M}`、`EigenvalueProblem/EigenvaluesOfVPlus/ClaimSignFlipConjugation.lean`。必要十分版からの導出は `*_of_necSuf`、`ClaimSignFlipConjugationFromNecSuf.lean`） | `Ising2D.NecSuf.conj_pow_of_inv` / `conj_partialSum_of_inv` / `conj_series_limit_of_inv`（台は半環、`u` の両側の逆、`x ↦ uxv` の連続性と T2 だけ。`NecSuf/ConjugationOfExpSeries.lean`） |
| `constant_c_value_even_sector` の準備・Step 1〜5 | `Ising2D.half_smul_add_half_smul` / `matExp_half_mul_matExp_half` / `matExp_neg_half_mul_matExp_neg_half`（準備）、`trace_VPlus_eq_tauPlus` / `trace_VPlusInv_eq_tauPlusPrime`（Step 1）、`tauPlusPrime_eq_tauPlus`（Step 2。`trace_basic_properties` (4) の人手の形は `Ising2D.trace_similarity_invariant`）、`VPlus_mul_W` / `W_mul_VPlus` / `VPlusInv_eq_W` / `trace_VPlus_eq_c_mul` / `trace_VPlusInv_eq_cinv_mul`（Step 3）、`constant_c_steps_four_five`（Step 4・Step 5。必要十分版からの導出は `constant_c_steps_four_five_of_necSuf`、`EigenvalueProblem/EigenvaluesOfVPlus/ClaimConstantCEvenSectorFromNecSuf.lean`） | `Ising2D.NecSuf.const_eq_of_trace_chains`（`NecSuf/ConstantC.lean`。Step 4・Step 5 だけ。係数は零を持つ群、包含は積と `0`・`1` を保つ単射、実数の側は順序体） |
| `<exp_X_Y_exp_-X>` | `Ising2D.hasSum_matExp_conj` / `matExp_conj_eq_tsum`（`Mat(2,ℂ)^{⊗M}`、`EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`） | `Ising2D.NecSuf.exp_adCLM_apply` / `NecSuf.hasSum_exp_conj`（ℂ 上の完備ノルム環なら何でもよい、`NecSuf/ExpConjugation.lean`） |
| `<exp_X_Y_exp_-X>` の 2 次元不変部分空間版（`<extract_taylor_coefficient_of_Z_Y>` の cosh/sinh の根拠） | `Ising2D.matExp_conj_two_dim_z` / `matExp_conj_two_dim_y` | `Ising2D.NecSuf.exp_conj_two_dim_z` / `exp_conj_two_dim_y` |
| `<commutator_of_H_and_Z_Y>` | `Ising2D.lie_H1_hatZ_same` / `lie_H1_hatY` / `lie_H1_hatZ_opp` / `lie_H2_hatZMinus` / `lie_H2_hatY` / `lie_H2_hatZPlus`（`Mat(2,ℂ)^{⊗M}`、`RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean`） | `Ising2D.NecSuf.CliffordTriple.lie_sum_yz_z` ほか 6 本（台は任意の環、係数は任意の可換半環、族の添字型も任意。`NecSuf/CommutatorClifford.lean`） |
| `<ホロノミック量子場_p142下段_1>` / `<T_V_hatZ_hatY>`（exp 共役の 2 次元部分空間への「行列としての」作用） | `Ising2D.actsBy_TConj_V1pmHalf` / `actsBy_TConj_V2H2Form` / `TV_hatZ_hatY`（`Mat(2,ℂ)^{⊗M}`、`RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`。経路に依らない `actsBy_TConj_matExpUnits` / `actsBy_TConj_smulUnits` は `EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean`） | `Ising2D.NecSuf.twoDimConjMat` / `NecSuf.exp_conj_two_dim_actsBy` / `NecSuf.conj_smul_eq`（ℂ 上の完備ノルム環。スカラー相殺は任意の ℂ-代数。`NecSuf/TVAction.lean`） |
| `anticommutator_of_Z_and_Y` | `Ising2D.anticomm_Z_Z` / `anticomm_Z_Y` / `anticomm_Y_Y`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.anticomm_Z_Z_of_necSuf` / `anticomm_Z_Y_of_necSuf` / `anticomm_Y_Y_of_necSuf`、`EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZYFromNecSuf.lean`） | `Ising2D.NecSuf.acomm_jwStr` / `NecSuf.jwStr_sq` / `NecSuf.acomm_of_single_site`（台は任意の環、サイトごとの積は「単位的・乗法的・多重線型」な写像なら何でもよい。`NecSuf/SiteLocalAnticomm.lean`） |
| `tensor_commutation_from_all_sites` | `Ising2D.siteProd_commute_of_sitewise_commute`（`Mat(2,ℂ)^{⊗M}`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimTensorCommutationFromAllSites.lean`。必要十分版からの導出は `Ising2D.siteProd_commute_of_sitewise_commute_of_necSuf`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimTensorCommutationFromAllSitesFromNecSuf.lean`） | `Ising2D.NecSuf.commute_of_sitewise_commute`（族から元を作る写像が積を保つことだけを仮定する。`NecSuf/SitewiseCommute.lean`） |
| `def_kronecker` (1) / `kronecker_product_rule` (3)（と証明の準備「多重添字の和を各因子ごとの和の積へ直すこと」） | `Ising2D.vecKron`（`v_1⊠⋯⊠v_M`。成分は `vecKron_apply` で `rfl`。`MathematicalTools/KroneckerProductAndMultiFactorBasis/DefinitionKroneckerProductOfVectors.lean`）/ `Ising2D.sum_over_multi_index_of_product_eq_product_of_sums`（人手の `M = 1` の 2 段・`M → M+1` の 4 段と 1 対 1。1 段目は `sum_conf_succ_eq_sum_last_sum_init`）/ `Ising2D.kronecker_product_rule_mulVec`（人手の (3) の 6 行と 1 対 1 の `calc`。人手の `M` は Lean の `M + 1`。`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerProductRuleOnVectors.lean`。必要十分版からの導出は `Ising2D.siteProd_eq_matKron'` / `vecKron_eq_vecKron'` / `sum_over_multi_index_of_product_eq_product_of_sums_of_necSuf` / `kronecker_product_rule_mulVec_of_necSuf`、同じフォルダの `ClaimKroneckerProductRuleOnVectorsFromNecSuf.lean`） | `Ising2D.NecSuf.sum_pi_finProdLeft_eq_finProdLeft_sum` / `matKron'_mulVec_vecKron'`（`NecSuf/KroneckerProductRuleOnVectors.lean`。有限積は左から掛ける `finProdLeft`、因子の添字は任意の有限型。準備に効くのは和の可換モノイド・二つの分配律・`0·0 = 0`（`ι` が空のときだけ）だけで、積の結合則・可換則・単位元は効かない。仮定の `NonUnitalNonAssocSemiring` は `Finset.mul_sum`・`Finset.sum_mul` の要求。(3) はこれに `(ab)(cd) = (ac)(bd)` を足すだけで、行列が正方であることは効かない） |
| `kronecker_transpose` | `Ising2D.siteProd_transpose_apply`（人手の成分の鎖の 4 行と 1 対 1 の `calc`）/ `siteProd_transpose`（`Mat(2,ℂ)^{⊗M}`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTranspose.lean`。必要十分版からの導出は `Ising2D.siteProd_eq_kroneckerProdOf` / `siteProd_transpose_of_necSuf`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerTransposeFromNecSuf.lean`） | `Ising2D.NecSuf.kroneckerProdOf_transpose_apply` / `kroneckerProdOf_transpose`（係数は `CommMonoid`、因子の添字は任意の型。係数の演算は何も効いていない。`NecSuf/KroneckerTranspose.lean`） |
| `finite_product_of_real_inclusions_is_real` | `Ising2D.finite_product_of_real_inclusions_is_real`（人手の帰納法の `m = 1` の 2 行・`m → m+1` の 4 行と 1 対 1 の `calc`。`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimFiniteProductOfRealInclusionsIsReal.lean`。必要十分版からの導出は `Ising2D.finite_product_of_real_inclusions_is_real_of_necSuf`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`） | `Ising2D.NecSuf.prod_mem_of_mul_closed`（係数は `CommMonoid`、実数の像を積で閉じた任意の性質に置き換えた。効いているのは積で閉じることだけ。`NecSuf/KroneckerOfRealEntryMatrices.lean`） |
| `kronecker_of_real_entry_matrices_has_real_entries` | `Ising2D.siteProd_hasRealEntries`（人手の成分の鎖の 2 行と 1 対 1 の `calc`。`Mat(2,ℂ)^{⊗M}`、`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimKroneckerOfRealEntryMatricesHasRealEntries.lean`。定義 `def_matrix_with_real_entries` は `Ising2D.MatrixHasRealEntries`（`DefinitionMatrixWithRealEntries.lean`）。必要十分版からの導出は `Ising2D.siteProd_hasRealEntries_of_necSuf`、`ClaimKroneckerOfRealEntryMatricesFromNecSuf.lean`） | `Ising2D.NecSuf.kroneckerProdOf_entries_mem`（同上の性質、因子の添字は任意の型。`NecSuf/KroneckerOfRealEntryMatrices.lean`） |
| `inclusion_rr_to_cc_is_injective` / `def_real_matrix_of_real_entry_matrix` | `Ising2D.inclusion_rr_to_cc_is_injective`（人手の 3 行の鎖 `(a,0) = a_ℂ = b_ℂ = (b,0)` の各辺の第 1 成分（`Complex.re`）を取った `calc`）/ `Ising2D.realMatrixOfRealEntries`（`ϱ^{m,n}_{ℂ→ℝ}`。`w_pq(B)` は存在 `hB p q` から `Classical.choose`）・`ofReal_realMatrixOfRealEntries_apply`（`((B_ℝ)_pq)_ℂ = B_pq`）・`realMatrixOfRealEntries_apply_eq`（一意性の段）（`MathematicalTools/KroneckerProductAndMultiFactorBasis/DefinitionRealMatrixOfRealEntryMatrix.lean`）。具体的な `W` については `Ising2D.physicalSymTransferR_eq_realMatrixOfRealEntries` | なし（単射性の証明は `ℝ²` の元の第 1 成分の比較だけで、取り払える代数の構造を使わない。`ϱ` は定義） |
| `def_real_matrix_product` / `def_real_identity_matrix` / `real_matrix_of_real_entry_matrix_preserves_product` / `real_matrix_of_real_entry_matrix_preserves_power` | 実数の行列の積と単位行列は `Matrix ι ι ℝ` の `*` と `1` / `Ising2D.real_matrix_of_real_entry_matrix_preserves_product`（人手の 6 行の鎖と 1 対 1 の `calc` と単射性）/ `Ising2D.identity_matrix_entry_eq_real_identity_entry`（`q = 0` の 4 行の鎖。1・2 行目は `Matrix.one_apply` の 1 段）・`identity_matrix_hasRealEntries`・`matrix_pow_hasRealEntries`（`A^q` の成分の実性）・`real_matrix_of_real_entry_matrix_preserves_power`（`q = 0` の 4 行の鎖と単射性、`q + 1` の 4 行の鎖）（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixOfRealEntryMatrixPreservesProductAndPower.lean`。`A^{q+1} = A^qA` の行は `realMatrixOfRealEntries_congr`） | なし（`ℝ → ℂ` の包含が和と積を保ち単射であることの成分ごとの組み合わせで、抽象的な内容は引いた主張の側に尽きている） |
| `def_real_matrix_vector_product` / `real_matrix_vector_product_is_associative` / `real_identity_matrix_is_left_unit_of_real_matrix_vector_product` | 実数の行列とベクトルの積は `Matrix _ _ ℝ` の `*ᵥ`（成分は `dotProduct` で人手の式と `rfl`）/ `Ising2D.real_matrix_vector_product_is_associative`（人手の 10 行の鎖と 1 対 1 の `calc`。和の順序の入れ替えは `finite_double_sum_of_real_numbers_interchange_fintype`）/ `Ising2D.real_identity_matrix_is_left_unit_of_real_matrix_vector_product`（人手の 4 行・3 行・5 行の鎖と 1 対 1 の `calc` と単射性。一つの項のほかが 0 の和は `Finset.sum_eq_single`）（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixVectorProductAssociativityAndIdentity.lean`） | なし（具体版は人手と同じく ℝ の乗法の交換則を使う。結合則・左単位が交換則なしで成り立つことは、まだ必要十分版で確かめていない） |
| `real_matrix_vector_product_commutes_with_real_scalar_multiple` | `Ising2D.real_matrix_vector_product_commutes_with_real_scalar_multiple`（すべての `k` で `w_k = c u_k` なら、すべての `i` で `(Pw)_i = c(Pu)_i`。人手の 7 行の鎖と 1 対 1 の `calc`。`w` は成分の等式の仮定 `hw` で受け取る）（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixVectorProductCommutesWithRealScalarMultiple.lean`） | `Ising2D.NecSuf.matrix_vector_product_commutes_with_scalar_multiple'`（`NecSuf/MatrixVectorProductCommutesWithScalarMultiple.lean`。係数は非単位的な半環で、`c` が行 `i` の各成分 `P_ij` と可換という明示の仮定。乗法の可換性一般・単位元は効かない。同じ 7 段）。導出は `Ising2D.real_matrix_vector_product_commutes_with_real_scalar_multiple_of_necSuf`（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealMatrixVectorProductCommutesWithRealScalarMultipleFromNecSuf.lean`） |
| `def_real_vector_inclusion` / `real_vector_inclusion_is_injective` / `real_vector_inclusion_intertwines_matrix_vector_product` | `Ising2D.cvec`（`ι^n_{ℝ→ℂ}`。成分は `cvec_apply` で `rfl`）/ `Ising2D.real_vector_inclusion_is_injective`（人手の 3 行の鎖と 1 対 1 の `calc` と `inclusion_rr_to_cc_is_injective`）/ `Ising2D.real_vector_inclusion_intertwines_matrix_vector_product`（人手の 7 行の鎖と 1 対 1 の `calc`。包含が和・積を保つ段は `Complex.ofReal_sum`・`real_inclusion_mul`）（`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealVectorInclusion.lean`） | なし（抽象的な内容は、引いた主張（包含が有限和と積を保つこと、`((B_ℝ)_pq)_ℂ = B_pq`）の側に尽きている） |
| `def_epsilon_real` / `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors` | `Ising2D.epsilonReal`（`ε_ℝ := ϱ(ε)`。`((ε_ℝ)_kl)_ℂ = ε_kl` は `ofReal_epsilonReal_apply`）/ `Ising2D.epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`（(⇒)・(⇐) の 2 行の鎖と 1 対 1 の `calc` と `real_vector_inclusion_is_injective`）。`evenSectorSet` が受け取る置換行列 `epsilonR` と同じ行列であることは `Ising2D.epsilonR_eq_epsilonReal`、その形の主張は `Ising2D.epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors`（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors.lean`） | なし（`real_vector_inclusion_intertwines_matrix_vector_product` と `real_vector_inclusion_is_injective` を 1 回ずつ当てることに尽き、`ε` について使うのは成分の実性だけ） |
| `epsilon_real_is_symmetric` / `epsilon_real_square_is_identity` | `Ising2D.epsilon_real_entry_symm`（人手の 4 行の鎖と 1 対 1 の `calc`）・`epsilon_real_is_symmetric` / `Ising2D.epsilon_real_square_is_identity`（`ε_ℝε_ℝ = I`。人手の 5 行の鎖と 1 対 1 の `calc`。人手の `εε = I` は `epsilon_sq`。既存の `epsilonR_isSymm`・`epsilonR_mul_self` は同じ内容を置換行列の必要十分版から出したもので、人手と 1 対 1 なのはこちら）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealIsSymmetricAndSquareIsIdentity.lean`） | なし（引いた主張を成分ごと、または 1 回ずつ当てることに尽き、それらの外に抽象的な内容を持たない） |
| `epsilon_real_fixes_sum_of_vector_and_its_image` | `Ising2D.epsilon_real_fixes_sum_of_vector_and_its_image`（`v_k = u_k + (ε_ℝu)_k` なら `ε_ℝv = v`。人手の各成分の 10 行の鎖と 1 対 1 の `calc`。`v` は成分の等式の仮定 `hv` で受け取る）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealFixesSumOfVectorAndItsImage.lean`） | なし（引いた主張と ℝ の分配則・加法の交換則を成分ごとに 1 回ずつ当てることに尽き、それらの外に抽象的な内容を持たない） |
| `W_real_has_positive_entries` / `epsilon_real_commutes_with_W_real` | `Ising2D.W_has_positive_entries_as_inclusion`（人手 `W_has_positive_entries` の言い換えの形「`W_kl = w_ℂ` を満たす `w ∈ ℝ_{>0}` が在る」）・`Ising2D.W_real_has_positive_entries`（人手の 2 行の鎖と 1 対 1 の `calc` と単射性）/ `Ising2D.epsilon_real_commutes_with_W_real`（人手の 3 行の鎖と 1 対 1 の `calc`。人手の `εW = Wε` は `epsilon_commute_physicalSymTransferC`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealCommutesWithWRealAndWRealHasPositiveEntries.lean`） | なし（引いた主張を成分ごと、または 1 回ずつ当てることに尽き、それらの外に抽象的な内容を持たない） |
| `W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice` | `Ising2D.W_real_bilinear_value_at_sum_of_nonnegative_vector_and_its_epsilon_real_image_is_at_least_twice`（すべての `k` で `u_k ≥ 0` かつ `v_k = u_k + (ε_ℝu)_k` なら `v^⊤W_ℝv ≥ 2(u^⊤W_ℝu)`。人手の準備の 3 つ（交差項 `u^⊤W_ℝũ`・`ũ^⊤W_ℝu ≥ 0` とその和の不等式、`ε_ℝ(W_ℝũ) = W_ℝu` の 7 行、`ũ^⊤W_ℝũ = u^⊤W_ℝu` の 5 行。`ũ := ε_ℝu`）と主張の 11 行の鎖と 1 対 1 の `calc`。`v` は成分の等式の仮定 `hv` で受け取る）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimWRealBilinearValueAtSumOfNonnegativeVectorAndItsEpsilonRealImageIsAtLeastTwice.lean`） | なし（`W_ℝ` は成分の非負性と `ε_ℝ` との可換性だけが効き、対称性は使わない。双線型値の加法性・非負性、行列とベクトルの積の結合性、`ε_ℝ` の対称性・`ε_ℝε_ℝ = I`・非負のベクトルを保つことを順に当てることに尽きる） |
| `c_between_Lambda_half_and_twice_Lambda_half` の Step 2 | `Ising2D.c_le_twice_c_plus_physical`（具体的な `W_ℝ = ϱ(W)`・`ε_ℝ` について `Λ = c_+(M)` なら `c(M) ≤ 2Λ`。人手の準備の各行・7 行の鎖・続く 2 行・`c(M) = sup𝓡 ≤ 2Λ` の 2 行と 1 対 1。`ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerExactSolution.lean`。通しの定理は `rayleighSup_sandwich_LambdaM_physical` からこれを引く） | 置かない（準備で本文の主張を 1 つずつ引き、上限の性質と `ℝ` の四則演算・大小でつなぐだけで、引いた主張の外に取り払える構造を持たない。`ε_ℝ`・`W_ℝ` のどの性質が効くかは引いた各主張の行に書いた）。`NecSuf/EvenSectorUpperBound.lean` の `Ising2D.NecSuf.rayleighSup_le_two_mul_evenSectorRayleighSup` とその `ε = epsilonR M` への特殊化 `Ising2D.onsager_step3_c_le_two_c_plus` は、Step 2 が `W_ℝ`・`ε_ℝ` で書き直される前の形（Cauchy–Schwarz で `‖v‖² ≤ 4`）の形式化の記録で、今の Step 2 の必要十分版ではない（手順が違い、具体版をその特殊化として導いていない） |
| `def_negated_row_configuration` / `epsilon_entries_in_row_configuration_numbering` / `epsilon_real_permutes_entries_by_spin_flip` | `Ising2D.negSpinConf`（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean`）/ `Ising2D.pauliX_configBasisIso_apply_of_eq_neg`・`pauliX_configBasisIso_apply_of_ne_neg`（証明の準備の 2 本の 3 行の含意）・`Ising2D.epsilon_entries_in_row_configuration_numbering`（場合ごとの 5 行・4 行の鎖と 1 対 1 の `calc`。鎖の 1 行目 `ord = ν∘ι` は Lean では添字の読み方）/ `Ising2D.epsilon_real_permutes_entries_by_spin_flip`（人手の 5 行・5 行・5 行の鎖と 1 対 1 の `calc` と単射性）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPermutesEntriesBySpinFlip.lean`）。置換行列の必要十分版から出した `epsilonR_mulVec_apply` は同じ内容で、人手と 1 対 1 なのはこちら | なし（`σ^x` の成分と `{-1,1}` の場合分けの計算、および引いた主張を 1 回ずつ当てることに尽きる） |
| `epsilon_real_preserves_nonnegative_vectors` | `Ising2D.epsilon_real_preserves_nonnegative_vectors`（番号付けの全射性で `k = ord(s)` と置き（人手の鎖の 1 行目。Lean では `show` で、段は無い）、人手の鎖の 2・3 行目と 1 対 1 の `calc`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPreservesNonnegativeVectors.lean`） | なし（`epsilon_real_permutes_entries_by_spin_flip` と番号付けの全射性を 1 回ずつ当てることに尽きる） |
| `sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero` | `Ising2D.sum_of_nonnegative_vector_and_its_epsilon_real_image_is_nonzero`（`u_k ≥ 0`（すべての `k`）かつ `u ≠ 0` で `v_k = u_k + (ε_ℝu)_k` なら `v ≠ 0`。人手の準備（`u_{k_0} ≠ 0` なる `k_0`、`u_{k_0} > 0`、`(ε_ℝu)_{k_0} ≥ 0`）と 4 行の鎖と 1 対 1 の `calc`。`v` は成分の等式の仮定 `hv` で受け取る）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimSumOfNonnegativeVectorAndItsEpsilonRealImageIsNonzero.lean`） | なし（`epsilon_real_preserves_nonnegative_vectors` を 1 回当て、ℝ の順序と加法の両立・加法の単位元を 1 回ずつ使うことに尽きる） |
| `norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four` | `Ising2D.norm_squared_of_sum_of_unit_vector_and_its_epsilon_real_image_is_at_most_four`（`‖u‖ = 1` で `v_k = u_k + (ε_ℝu)_k` なら `‖v‖^2 ≤ 4`。人手の準備（`‖x‖^2 = Σ|x_k|^2` の 2 行は `vecNorm_sq_eq_sum_abs_sq`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimNormOfNormalizedRealVectorIsOne.lean`）、`|v_k|^2 ≤ 2|u_k|^2 + 2|(ε_ℝu)_k|^2` の 4 行）と 8 行の鎖と 1 対 1 の `calc`。`v` は成分の等式の仮定 `hv` で受け取る）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimNormSquaredOfSumOfUnitVectorAndItsEpsilonRealImageIsAtMostFour.lean`） | なし（`ε_ℝ` は `epsilon_real_preserves_norm` を通してだけ効く。それを抜いた「`‖x‖ = ‖y‖ = 1` なら `‖x + y‖^2 ≤ 4`」は、`square_of_real_absolute_value`・`square_of_real_sum_is_at_most_twice_sum_of_squares` と有限和の 3 つの主張を成分ごとに当てることに尽きる） |
| `negated_row_configuration_is_involutive` | `Ising2D.negSpinConf_negSpinConf`（人手の 3 行の鎖と 1 対 1 の `calc`。人手は `ℤ` で、Lean の `SpinVal` は `{-1,1} ⊂ ℝ` の部分型なので値を ℝ へ埋め込んで書く。写像の等号は `funext`・`Subtype.ext`）（`EigenvalueProblem/EigenvectorOfMaxEigenvalue/ClaimTraceEpsilonVPlusMatrixEntries.lean`） | なし（定義を 2 回開いて符号反転を 2 回行うことに尽きる） |
| `epsilon_real_preserves_norm` | `Ising2D.epsilon_real_preserves_norm`（準備の `χ(k) := ord(-ord^{-1}(k))` は `spinFlipIndex`、`χ(χ(k)) = k` の 5 行は `spinFlipIndex_spinFlipIndex`、全単射性は `spinFlipIndex_bijective`、`(ε_ℝu)_k = u_{χ(k)}` の 3 行は `epsilon_real_mulVec_eq_spinFlipIndex`、主張の 4 行と 1 対 1 の `calc`。付け替えの段は添字が有限型の系 `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing_fintype`）（`ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimEpsilonRealPreservesNorm.lean`） | なし（番号付けの全単射性と `epsilon_real_permutes_entries_by_spin_flip`・`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`（必要十分版は `NecSuf/FiniteSumReindexedByBijection.lean`）を 1 回ずつ当てることに尽きる） |
| `real_bilinear_value_of_symmetric_matrix_is_symmetric` | `Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric`（人手の 7 行の鎖と 1 対 1 の `calc`。人手の対称性 `P_kl = P_lk` は `Matrix.IsSymm.apply`）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueOfSymmetricMatrixIsSymmetric.lean`） | `Ising2D.NecSuf.bilinear_value_of_symmetric_matrix_is_symmetric'`（`NecSuf/BilinearValueOfSymmetricMatrixIsSymmetric.lean`。係数は非単位的な可換半環。乗法の可換則は外せない。同じ 7 段）。導出は `Ising2D.real_bilinear_value_of_symmetric_matrix_is_symmetric_of_necSuf`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueOfSymmetricMatrixIsSymmetricFromNecSuf.lean`） |
| `real_bilinear_value_is_additive_in_right_vector` / `real_bilinear_value_is_additive_in_left_vector` | `Ising2D.real_bilinear_value_is_additive_in_right_vector`（人手の 6 行の鎖と 1 対 1 の `calc`）/ `Ising2D.real_bilinear_value_is_additive_in_left_vector`（人手の 7 行の鎖と 1 対 1 の `calc`）。人手と同じく `w` は成分の等式の仮定で与える（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueIsAdditive.lean`） | `Ising2D.NecSuf.bilinear_value_is_additive_in_right_vector'`・`Ising2D.NecSuf.bilinear_value_is_additive_in_left_vector'`（`NecSuf/BilinearValueIsAdditive.lean`。係数は非単位的な半環。右は左分配則、左は右分配則だけが主張の段で効く。同じ段の並び）。導出は `Ising2D.real_bilinear_value_is_additive_in_right_vector_of_necSuf`・`Ising2D.real_bilinear_value_is_additive_in_left_vector_of_necSuf`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueIsAdditiveFromNecSuf.lean`） |
| `real_bilinear_value_with_nonnegative_entries_is_nonnegative` / `real_bilinear_value_of_scalar_multiple_vector` | `Ising2D.real_bilinear_value_with_nonnegative_entries_is_nonnegative`（人手の準備・各 `p` の鎖・3 行の鎖と 1 対 1。人手の `n ≥ 1` は `[Nonempty n]`）/ `Ising2D.real_bilinear_value_of_scalar_multiple_vector`（人手の 13 行の鎖と 1 対 1 の `calc`。`w` は成分の等式 `w_k = c u_k` の仮定で与える）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultiple.lean`） | `Ising2D.NecSuf.bilinear_value_with_nonnegative_entries_is_nonnegative'`・`Ising2D.NecSuf.bilinear_value_of_scalar_multiple_vector'`（`NecSuf/BilinearValueNonnegativeAndScalarMultiple.lean`。係数は非単位的な半環。非負性は前順序・加法の単調性と積の非負性の仮定、実数倍は `c` と各 `u_kP_kl` の可換性の仮定だけを足す）。導出は `MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueWithNonnegativeEntriesAndScalarMultipleFromNecSuf.lean` |
| `real_bilinear_value_is_sum_with_real_matrix_vector_product` / `real_symmetric_matrix_moves_between_factors_of_sum_of_products` | `Ising2D.real_bilinear_value_is_sum_with_real_matrix_vector_product`（左辺は人手 `def_real_bilinear_value` の和 `Σ_kΣ_l (u_kP_kl)v_l` で書き、人手の 2〜4 行目と 1 対 1 の `calc`。mathlib の `u ⬝ᵥ P *ᵥ v` は定義から右辺と `rfl` で一致するので、`⬝ᵥ` の値から引く側は `rfl` で足りる）/ `Ising2D.real_symmetric_matrix_moves_between_factors_of_sum_of_products`（人手の 10 行の鎖と 1 対 1 の `calc`。人手の対称性 `Q_kl = Q_lk` は `Matrix.IsSymm.apply`）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`） | `Ising2D.NecSuf.bilinear_value_is_sum_with_matrix_vector_product'`（係数は非単位的な半環）・`Ising2D.NecSuf.symmetric_matrix_moves_between_factors_of_sum_of_products'`（係数は非単位的な可換半環。乗法の可換則は外せない）（`NecSuf/BilinearValueAsSumAndSymmetricMatrixMovesBetweenFactors.lean`。同じ段の並び）。導出は `Ising2D.real_bilinear_value_is_sum_with_real_matrix_vector_product_of_necSuf`・`Ising2D.real_symmetric_matrix_moves_between_factors_of_sum_of_products_of_necSuf`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealBilinearValueAsSumAndSymmetricMatrixMovesBetweenFactorsFromNecSuf.lean`） |
| `real_bilinear_value_at_most_value_at_absolute_vector` | `Ising2D.real_bilinear_value_at_most_value_at_absolute_vector`（準備の各 `k` の三角不等式は `abs_real_bilinear_row_le_row_abs_sum`、主張の 9 行と 1 対 1 の `calc`。人手の `u` は `fun k => \|x k\|`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimRealBilinearValueAtMostValueAtAbsoluteVector.lean`） | `Ising2D.NecSuf.bilinear_value_at_most_value_at_absolute_vector'`（`NecSuf/BilinearValueAtMostValueAtAbsoluteVector.lean`。係数は加法の可換群で全順序と両立し、`PosMulMono` と乗法の結合則（mathlib の `⬝ᵥ` を人手の和へ開く段だけ）を持つ環。乗法の可換性・単位元は効かない。具体版と同じ 9 段）。導出は `Ising2D.real_bilinear_value_at_most_value_at_absolute_vector_of_necSuf`（`ClaimRealBilinearValueAtMostValueAtAbsoluteVectorFromNecSuf.lean`） |
| `norm_of_vector_of_absolute_values_equals_norm` | `Ising2D.norm_of_vector_of_absolute_values_equals_norm`（主張の 4 行と 1 対 1 の `calc`。人手の `u` は `fun k => \|x k\|`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimNormOfVectorOfAbsoluteValuesEqualsNorm.lean`） | 置かない（`def_matrix_norm` を開いて `square_of_real_absolute_value` を各項へ当てることに尽きる） |
| `norm_of_normalized_real_vector_is_one` | `Ising2D.norm_of_normalized_real_vector_is_one`（準備の `‖v‖ > 0` は `vecNorm_pos_of_ne_zero`、`‖x‖^2 = Σ\|x_k\|^2` は `vecNorm_sq_eq_sum_abs_sq`、主張の 9 行と 1 対 1 の `calc`。人手の `v̂` は仮定 `∀ k, vhat k = v k / vecNorm v`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimNormOfNormalizedRealVectorIsOne.lean`） | 置かない（`def_matrix_norm` を開いて `square_of_real_absolute_value`・`finite_sum_of_real_scalar_multiples` を当て、`ℝ` の四則演算で 1 にすることに尽きる） |
| `real_matrix_fixed_vector_stays_fixed_after_normalization` | `Ising2D.real_matrix_fixed_vector_stays_fixed_after_normalization`（準備の `‖v‖ ≠ 0` は `vecNorm_pos_of_ne_zero`、`v̂_k = (1/‖v‖)v_k` の 2 行は `hscal`、主張の 4 行と 1 対 1 の `calc`。人手の `v̂` は仮定 `∀ k, vhat k = v k / vecNorm v`、仮定 `(Pv)_i = v_i` は `hfix`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimRealMatrixFixedVectorStaysFixedAfterNormalization.lean`） | 置かない（`real_matrix_vector_product_commutes_with_real_scalar_multiple` を `c → 1/‖v‖` で 1 回当て、`ℝ` の四則演算で整えることに尽きる） |
| `real_bilinear_value_of_normalized_vector` | `Ising2D.real_bilinear_value_of_normalized_vector`（準備の `‖v‖ ≠ 0`・`‖v‖^2 ≠ 0` は `vecNorm_pos_of_ne_zero` から、`v̂_k = (1/‖v‖)v_k` の 2 行は `hscal`、主張の 4 行と 1 対 1 の `calc`。人手の `‖v‖^2 := ‖v‖‖v‖` は `vecNorm v ^ 2` と `sq`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimRealBilinearValueOfNormalizedVector.lean`） | 置かない（`real_bilinear_value_of_scalar_multiple_vector` を `c → 1/‖v‖` で 1 回当て、`ℝ` の四則演算で整えることに尽きる） |
| `def_W_real` / `W_real_is_symmetric` / `W_real_is_positive_definite` | `realMatrixOfRealEntries (physicalSymTransferC …) (physicalSymTransferC_hasRealEntries …)`（`W_ℝ := ϱ(W)`。実成分で組んだ `physicalSymTransferR` に等しいことは `Ising2D.physicalSymTransferR_eq_realMatrixOfRealEntries`）/ `Ising2D.W_real_entry_symm`（人手の 4 行の鎖と 1 対 1 の `calc`）・`W_real_is_symmetric` / `Ising2D.conjugate_bilinear_value_of_real_vector_W`（人手の 10 行の鎖のうち 9 行と 1 対 1 の `calc`。10 行目は `W_real_is_positive_definite` の `rw`）・`W_real_is_positive_definite`（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`。`physicalSymTransferR` で読んだものは `physicalSymTransferR_isSymm`・`physicalSymTransferR_posDef`） | なし（具体的な `W` についての主張で、引いた主張（`inclusion_rr_to_cc_is_injective`・`real_inclusion_preserves_product` など）の外に抽象的な内容を持たない） |
| `trace_of_W_power_via_W_real` | `Ising2D.trace_of_W_power_via_W_real`（人手の 4 行の鎖と 1 対 1 の `calc`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`）。`partition_function_sandwich` の準備 `Z(K_1,K_2) = T` の `Ising2D.partition_function_eq_sum_diag_W_real_pow` がこれを `q → N_row` で引く | なし（具体的な `W` についての主張で、引いた主張の外に抽象的な内容を持たない） |
| `trace_power_upper_bound` | `Ising2D.trace_power_upper_bound`（一般の `W : TensorPow M` で述べ、人手が引く `W` の実対称性と `W_ℝ` の対称性・正定値性を仮定に置く。【`e_k` のノルム】・【冪の対称性】・【対角成分の表示】・【`(W_ℝ)^ae_k` の成分とノルム】・偶数の 5 行と 9 行・奇数の 7 行と 5 行と 12 行・最後のトレースの 4 行が `calc` の段と 1 対 1。`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerUpperBound.lean`）/ `Ising2D.trace_power_upper_bound_physical`（本文の `W` への当てはめ。`PhysicalPartitionFunctionSandwich.lean`） | 必要十分版は各 `k` の評価の部分の `NecSuf.IsPsdPair.moment_le_pow`（同じ偶奇の手順。具体版と同じ型での導出は `trace_power_upper_bound_of_necSuf`、`ClaimTracePowerUpperBoundFromNecSuf.lean`） |
| `moment_log_convexity` | `Ising2D.moment_log_convexity`（一般の `W : TensorPow M` で述べ、人手が引く `W` の実対称性と `W_ℝ` の対称性・正定値性を仮定に置く。`m_k` は `momentWReal`。【冪の実数の行列】の `I_ℝ` の 3 行・【冪の分け方】の 3 行と 7 行と 5 行・【二つの冪で挟んだ値】の 10 行・【`I_ℝ` と `W_ℝ` の正値性】の 3 行と 3 行・【`(W_ℝ)^ax` は零でない】の 4 行と 7 行と 8 行と 5 行・【正値性】の 5 行ずつ・二つの不等式の 8 行ずつ・偶奇の 4 行ずつが `calc` の段と 1 対 1。`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimMomentLogConvexity.lean`）/ `Ising2D.moment_log_convexity_physical`（本文の `W` への当てはめ。`PhysicalPartitionFunctionSandwich.lean`） | 必要十分版は `NecSuf.IsPdPair.moment_pos`・`NecSuf.IsPsdPair.moment_log_convex`（同じ手順。添字は `k → k+1`。具体版と同じ型での導出は `moment_log_convexity_of_necSuf`、`ClaimMomentLogConvexityFromNecSuf.lean`） |
| `trace_power_sandwich`（下からの評価の前半: 【冪の実数の行列】の `(W_ℝ)^1 = W_ℝ`・【`(W_ℝ)^n` の成分の対称性】・【`(W_ℝ)^n` の半正定値性】・【`(W_ℝ)^n` の成分の評価】・【単位ベクトルでの評価】） | `Ising2D.real_bilinear_value_pow_le_trace_of_power` ほか（一般の `W : TensorPow M` で述べ、人手が引く `W` の実対称性と `W_ℝ` の対称性・正定値性を仮定に置く。`(W_ℝ)^1` の 6 行・`‖z‖^2 > 0` の 3 行・`‖w‖ = 1` の 9 行・半正定値性の 2 行と 5 行・成分の評価の 7 行・`Σx_k^2 = 1` の 3 行・`m_0` の 7 行・`m_1` の 2 行・二つの帰納法・`m_n ≤ T` の 8 行・まとめの 3 行が `calc` の段と 1 対 1。`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerSandwichUnitVectorBound.lean`） | `m_k ≥ m_1m_{k-1}`・`m_p ≥ m_1^p` は `NecSuf.IsPdPair.moment_ratio_le`・`moment_pow_le`（具体版と同じ型での導出は `moment_ge_moment_one_pow_of_necSuf`、`ClaimTracePowerSandwichUnitVectorBoundFromNecSuf.lean`）。成分の評価と `m_n ≤ T` は標準基底とトレースに固有なので置かない |
| `trace_power_sandwich`（【正の実数の冪の比較】・【上限への移行】と主張） | `Ising2D.power_comparison_of_positive_reals`（`p` の帰納法。初段と、一歩の (a) の 4 行・(b) の 5 行）・`Ising2D.trace_of_power_pos`（`T ≥ m_n > 0`）・`Ising2D.pow_pred_pos_of_pos`（`c^{n-1} > 0` の場合分け）・`Ising2D.rayleighSup_pow_le_trace_of_power`（背理法。`δ < c` の 7 行と `T > T` の 6 行）・`Ising2D.trace_power_sandwich`（一般の `W : TensorPow M`。下は【上限への移行】、上は `trace_power_upper_bound`）が `calc` の段と 1 対 1（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimTracePowerSandwich.lean`）/ `Ising2D.trace_power_sandwich_physical`（本文の `W` への当てはめ。`PhysicalPartitionFunctionSandwich.lean`）。人手が捨てた経路（`|A_kl| ≤ √A_kk√A_ll` と `n` 乗根）は消した | 置かない（【正の実数の冪の比較】は順序体の冪の初等的な不等式、【上限への移行】は `def_rayleigh_sup` の上限と `ℝ` の順序に固有） |
| `partition_function_sandwich` | `Ising2D.partition_function_sandwich_physical`（準備の `Z(K_1,K_2) = T` は `Ising2D.partition_function_eq_sum_diag_W_real_pow`（人手の 2 行の鎖と単射性と 1 対 1）、2 行の鎖 2 本と 1 対 1 の `calc`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/PhysicalPartitionFunctionSandwich.lean`） | なし（`Z_equals_trace_of_W`・`trace_of_W_power_via_W_real` と `trace_power_sandwich` をつなぐだけ） |
| `limit_of_log_Z_in_N_row` | `Ising2D.abs_log_Z_sub_log_c_le`（含意の鎖の 10 行と 1 対 1。`MN` で一度に割る）・`Ising2D.log_two_pos`（準備の 3 行）・`Ising2D.limit_of_log_Z_in_N_row`（`ε` とアルキメデス性の `N_0`、3 行の鎖。収束は `Metric.tendsto_atTop`）（`ThermodynamicLimit/RowLimitAndMaxEigenvalue/ClaimLimitInNRow.lean`）。必要十分版からの導出は `Ising2D.abs_log_Z_sub_log_c_le_of_necSuf`・`limit_of_log_Z_in_N_row_of_necSuf`（`ClaimLimitInNRowFromNecSuf.lean`） | `Ising2D.NecSuf.abs_div_sub_le_of_sandwich`（`log` を、順序半環 `D` から順序体 `K` への写像 `L` で「`0 < u` かつ `u < v` なら `L u ≤ L v`」と積の法則だけを持つものに、底 `2` を `b > 0` に置き換える）・`Ising2D.NecSuf.tendsto_of_abs_sub_le_div`（`log 2` を `C ≥ 0` に）（`NecSuf/LogSqueeze.lean`） |
| `real_log_strictly_increasing` | `Ising2D.real_log_strictly_increasing`（三分律の 2 つの場合の 3 行の鎖。`PartitionFunction/TransferMatrixRepresentation/ClaimRealLogStrictlyIncreasing.lean`）。必要十分版からの導出は `Ising2D.real_log_strictly_increasing_of_necSuf`（`ClaimRealLogStrictlyIncreasingFromNecSuf.lean`） | `Ising2D.NecSuf.inv_strictMono`（狭義単調な `f` と、`P y` で `f(L y) = y` の `L`。`f` の加法の法則は効かない。`NecSuf/InverseOfAdditiveToMultiplicativeMap.lean`） |
| `real_log_of_product` | `Ising2D.real_log_of_product`（準備の 2 行と本体の 2 行。`MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimRealLogOfProduct.lean`）。必要十分版からの導出は `Ising2D.real_log_of_product_of_necSuf`（`ClaimRealLogOfProductFromNecSuf.lean`） | `Ising2D.NecSuf.inv_map_mul`（加法を乗法へ移す `f` と、その逆の `L`。順序は効かない。同上） |
| `real_log_of_power` | `Ising2D.real_log_of_power`（`n ≥ 1` の帰納法。`n = 1` の 3 行・2 行と、`n → n+1` の 4 行。`MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/ClaimRealLogOfPower.lean`）。必要十分版からの導出は `Ising2D.real_log_of_power_of_necSuf`（`ClaimRealLogOfPowerFromNecSuf.lean`） | `Ising2D.NecSuf.inv_map_pow`（積の法則と、`P` が積で閉じることだけ。`n log a` は `G` の `n` 倍。同上） |
| `identity_matrix_of_order_two_has_real_entries` / `pauli_x_has_real_entries` / `pauli_z_has_real_entries` | `Ising2D.identity_matrix_two_hasRealEntries` / `pauliX_hasRealEntries` / `pauliZ_hasRealEntries`（人手の 3・2・2 行の鎖は `identity_matrix_two_eq_ofReal` / `pauliX_eq_ofReal` / `pauliZ_eq_ofReal` の `calc`。`PartitionFunction/ProjectionAndJordanWigner/ClaimPauliMatricesHaveRealEntries.lean`） | なし（具体的な 2 次の行列の成分の計算） |
| `def_real_factor_of_pauli_y` / `pauli_y_is_i_times_real_factor` / `real_factor_of_pauli_y_has_real_entries` | `Ising2D.pauliYReal` / `pauliY_eq_I_smul_pauliYReal`（人手の 7 行の鎖と 1 対 1 の `calc`） / `pauliYReal_hasRealEntries`（人手の 2 行の鎖は `pauliYReal_eq_ofReal` の `calc`。`PartitionFunction/ProjectionAndJordanWigner/ClaimPauliMatricesHaveRealEntries.lean`） | なし（具体的な 2 次の行列の計算） |
| `real_scalar_multiple_of_real_entry_matrix_has_real_entries` | `Ising2D.real_smul_hasRealEntries`（人手の成分の鎖の 3 行と 1 対 1 の `calc`。`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimRealScalarMultipleOfRealEntryMatrixHasRealEntries.lean`。必要十分版からの導出は `Ising2D.real_smul_hasRealEntries_of_necSuf`、`ClaimRealScalarMultipleOfRealEntryMatrixFromNecSuf.lean`） | `Ising2D.NecSuf.smul_entries_mem`（係数は `Mul` だけ、実数の像を積で閉じた任意の性質に置き換えた。効いているのは積で閉じることと掛ける数がその性質に入ることだけ。`NecSuf/ScalarMultipleOfClosedEntries.lean`） |
| `sum_of_real_entry_matrices_has_real_entries` / `difference_of_real_entry_matrices_has_real_entries` / `finite_sum_of_real_entry_matrices_has_real_entries` | `Ising2D.matrix_add_hasRealEntries`（人手の成分の鎖の 6 行と 1 対 1 の `calc`） / `matrix_sub_hasRealEntries`（添字 `Fin m`）・`sub_hasRealEntries_tensorPow`（`TensorPow M`。どちらも人手の鎖の 3 行 `matrix_sub_eq_add_real_neg_one_smul`・`sub_eq_add_real_neg_one_smul_tensorPow` と段落の 2 主張） / `finite_sum_hasRealEntries`（`r + 1` 項の帰納法。`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimSumsOfRealEntryMatricesHaveRealEntries.lean`。必要十分版からの導出は `ClaimSumsOfRealEntryMatricesFromNecSuf.lean`） | `Ising2D.NecSuf.add_entries_mem`・`sub_entries_mem`・`finite_sum_entries_mem`（実数の像を任意の性質に置き換えた。和と有限和で効いているのは和で閉じることだけ、差は差が `x + (-y)`・符号反転が `-1` 倍・`-1` が性質に入ること・積と和で閉じること。`NecSuf/SumsOfClosedEntries.lean`） |
| `product_of_real_entry_matrices_has_real_entries` | `Ising2D.matrix_mul_hasRealEntries`（人手の成分の鎖の 4 行と 1 対 1 の `calc`。和を取る添字は人手の `n ≥ 1` に当たる `Nonempty`。`MathematicalTools/KroneckerProductAndMultiFactorBasis/ClaimProductOfRealEntryMatricesHasRealEntries.lean`。必要十分版からの導出は `ClaimProductOfRealEntryMatricesFromNecSuf.lean`） | `Ising2D.NecSuf.mul_entries_mem`（実数の像を任意の性質に置き換えた。効いているのは積で閉じること・和で閉じること・和を取る添字が空でないことで、どれも削れない。空でない有限和は `finset_sum_mem_of_add_closed`。`NecSuf/ProductOfClosedEntries.lean`） |
| `transpose_of_matrix_sum` / `transpose_of_matrix_scalar_multiple` / `transpose_of_matrix_difference` / `transpose_of_finite_sum_of_matrices` | `Ising2D.matrix_transpose_add` / `matrix_transpose_smul` / `matrix_transpose_sub`（人手の成分の鎖の 4 行と 1 対 1 の `calc`） / `finite_sum_transpose_of_matrices`（`r + 1` 項の帰納法。`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiples.lean`。必要十分版からの導出と `TensorPow M` の系 `transpose_smul_tensorPow`・`transpose_sub_tensorPow`・`finite_sum_transpose_tensorPow` は `ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean`） | `Ising2D.NecSuf.transpose_add_matrix'` / `transpose_smul_matrix'` / `transpose_sub_matrix'` / `finite_sum_transpose_matrix'`（係数は和・スカラー倍・差の転置でそれぞれ `Add`・`Mul`・`Sub` だけ、演算の法則は使わない。添字の集合は任意。`NecSuf/TransposeOfMatrixSums.lean`） |
| `transpose_of_matrix_product` | `Ising2D.matrix_transpose_mul_apply`（人手の成分の鎖の 5 行と 1 対 1 の `calc`） / `matrix_transpose_mul`（`MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixProduct.lean`。必要十分版からの導出 `matrix_transpose_mul_of_necSuf` と `TensorPow M` の系 `transpose_mul_tensorPow` は `ClaimTransposeOfMatrixProductFromNecSuf.lean`） | `Ising2D.NecSuf.transpose_mul_matrix_apply'` / `transpose_mul_matrix'`（係数は積の交換律（`CommMagma`）と、積の成分の和に要る `AddCommMonoid` だけ。交換律は削れない。添字は任意、和の添字は有限型。`NecSuf/TransposeOfMatrixProduct.lean`） |
| `def_real_symmetric_complex_matrix` / `real_symmetric_matrix_is_hermitian` / `complex_conjugate_of_real_inclusion` | `Ising2D.MatrixIsRealSymmetric`（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/DefinitionRealSymmetricComplexMatrix.lean`） / `real_symmetric_isHermitian`（人手の成分の鎖の 6 行と 1 対 1 の `calc`） / `complex_conjugate_of_real_inclusion`（人手の 4 行と 1 対 1 の `calc`）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealSymmetricMatrixIsHermitian.lean`。必要十分版は `Ising2D.NecSuf.hermitian_of_star_fixed_symmetric_entries`（`NecSuf/HermitianOfStarFixedSymmetricEntries.lean`）、導出は `Ising2D.real_symmetric_isHermitian_of_necSuf`（`ClaimRealSymmetricMatrixIsHermitianFromNecSuf.lean`）。`complex_conjugate_of_real_inclusion` の必要十分版は置かない（4 段が定義の展開と ℝ の `-0 = 0` だけで、取り払える構造が無い）。`iH_is_real_symmetric` Step 3 の最後の文は `Ising2D.S2_isHermitian_of_real_symmetric`・`S1plus_isHermitian_of_real_symmetric`（`EigenvalueProblem/EigenvaluesOfVPlus/ClaimIHPauliForm.lean`）） |
| `hermitian_and_transpose_invariant_matrix_is_real_symmetric` | `Ising2D.hermitian_and_transpose_invariant_matrix_is_real_symmetric`（人手の 7 行の鎖の 3〜6 行目と 1 対 1 の `calc`）と `Ising2D.exists_real_of_star_eq`（同じ鎖の 1・2・7 行目・`−b = b`・`b = 0` の 4 行・`A_{kl} = a_ℂ` の 3 行と 1 対 1 の `calc`。人手の 1 本の鎖を、必要十分版の仮定を与える補題のために 2 か所に分けた）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetric.lean`。導出は `Ising2D.hermitian_and_transpose_invariant_matrix_is_real_symmetric_of_necSuf`（`ClaimHermitianAndTransposeInvariantMatrixIsRealSymmetricFromNecSuf.lean`）。`ClaimPositiveDefinite.lean` にあった `entries_real_of_isHermitian_of_transpose`（人手の対応ブロックの無い、成分が共役で動かないことまでの向き）は、使う側の `ClaimVPlusRealEntries.lean` を人手の定義へ寄せたときに消した） | `Ising2D.NecSuf.star_fixed_entries_of_hermitian_symmetric`（`NecSuf/StarFixedEntriesOfHermitianSymmetric.lean`。係数は `Star R` だけ。「`ℝ` の像に入る」を「共役で動かない元が入る任意の性質 `S`」に置き換える。`A^* = A`・`A^⊤ = A` はどちらも削れない（反例つき）） |
| `star_preserves_norm_and_limits` | `Ising2D.matrix_conjTranspose_mul`（(1) の第 1 式の 7 行と 1 対 1 の `calc` は `matrix_conjTranspose_mul_apply`）/ `Ising2D.matrix_conjTranspose_add_smul`（(1) の第 2 式の 8 行は `matrix_conjTranspose_add_smul_apply`）/ `Ising2D.matrix_conjTranspose_norm`（(2) の 5 行。ノルムは Frobenius ノルム）/ `Ising2D.matrix_conjTranspose_tendsto`（(3) の準備の 5 行は `matrix_conjTranspose_sub_apply`、各 `N` の 2 行と 1 対 1）（`Mat(n,ℂ)` を添字 `Fin n` で。複素共役の性質は mathlib の `star_sum`・`star_add`・`star_mul'`・`star_sub`・`norm_star`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimStarPreservesNormAndLimits.lean`。導出と `TensorPow M` の系 `conjTranspose_mul_tensorPow`・`conjTranspose_tendsto_tensorPow` は `ClaimStarPreservesNormAndLimitsFromNecSuf.lean`） | `Ising2D.NecSuf.conjTranspose_mul_matrix'`・`NecSuf.conjTranspose_add_smul_matrix'`・`NecSuf.conjTranspose_norm'`・`NecSuf.conjTranspose_sub_matrix'`・`NecSuf.conjTranspose_tendsto'`（共役は `Star` だけで、複素共役の性質は使った形のまま仮定にした。対合性は効かない。(1) の第 1 式は係数の積の交換律が要り（反例つき）、第 2 式は要らない。添字は任意の型。`NecSuf/StarPreservesNormAndLimits.lean`） |
| `transpose_preserves_matrix_norm` / `transpose_preserves_matrix_limits` | `Ising2D.matrix_transpose_norm`（人手の 4 行と 1 対 1 の `calc`。ノルムは Frobenius ノルム）/ `Ising2D.matrix_transpose_tendsto`（各 `N` の 2 行と 1 対 1）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTransposePreservesMatrixNormAndLimits.lean`。必要十分版は `Ising2D.NecSuf.transpose_norm'`・`Ising2D.NecSuf.transpose_tendsto'`（`NecSuf/TransposePreservesMatrixNormAndLimits.lean`。係数は `SeminormedAddCommGroup`、添字は任意の有限型、収束は任意のフィルタ）、導出は `Ising2D.matrix_transpose_norm_of_necSuf`・`Ising2D.matrix_transpose_tendsto_of_necSuf`（`ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf.lean`）） |
| `exp_of_symmetric_is_symmetric` | `Ising2D.matExp_transpose_of_transpose_eq`（`TensorPow M` で述べ、人手の `n` は `2^M` に限る（`matExp` が `TensorPow M` にしか無いため。任意の有限の添字では必要十分版が通る）。冒頭の `I^⊤ = I` の 4 行は `identity_transpose_tensorPow`、準備の 2 つの帰納法は `tensorPow_mul_pow_comm`・`tensorPow_pow_transpose_of_transpose_eq`、部分和の成分の 5 行は `expPartialSum_transpose_apply`、極限の段は `transpose_tendsto_tensorPow` と `tendsto_nhds_unique`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfSymmetricIsSymmetric.lean`。必要十分版からの導出は `ClaimExpOfSymmetricIsSymmetricFromNecSuf.lean`） | `Ising2D.NecSuf.limit_transpose_of_transpose_eq'` ほか（`NecSuf/SeriesOfSymmetricIsSymmetric.lean`。係数の列は任意で `exp` であることは効かない。極限の段 `limit_transpose_of_forall_transpose_eq'` は係数が `NormedAddCommGroup` だけで積は効かない。`SS^m = S^mS` は任意の `Monoid`、`(S^m)^⊤ = S^m` は係数の積の交換律が要る、極限の一意性は `‖x‖ = 0 → x = 0` が要る） |
| `exp_of_hermitian_is_hermitian` | `Ising2D.matExp_conjTranspose_of_conjTranspose_eq`（`TensorPow M` で述べ、人手の `n` は `2^M` に限る（`matExp` が `TensorPow M` にしか無いため。任意の有限の添字では必要十分版が通る）。冒頭の `I^* = I` は人手が引く `identity_matrix_is_positive_definite` のエルミート性の 5 行を `identity_conjTranspose_tensorPow`（3 段目は `star_identity_entry_tensorPow`）に置いた。準備の 2 つの帰納法は `tensorPow_mul_pow_comm`・`tensorPow_pow_conjTranspose_of_conjTranspose_eq`、部分和の成分の 8 行は `expPartialSum_conjTranspose_apply`（係数 `(1/m!)_ℂ` の共役は `star_inv_factorial`）、極限の段は `conjTranspose_tendsto_tensorPow` と `tendsto_nhds_unique`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfHermitianIsHermitian.lean`。必要十分版からの導出は `ClaimExpOfHermitianIsHermitianFromNecSuf.lean`） | `Ising2D.NecSuf.limit_conjTranspose_of_conjTranspose_eq'` ほか（`NecSuf/SeriesOfHermitianIsHermitian.lean`。共役は `Star` だけで、複素共役の性質は使った形のまま仮定にした。対合性は効かない。係数の列は任意で各項が共役で動かないこと `hc` だけが要る（反例つき）。`(S^m)^* = S^m` は係数の積の交換律が要る（反例つき）、極限の段は係数が `NormedAddCommGroup` と `Star` だけ、極限の一意性は `‖x‖ = 0 → x = 0` が要る） |
| `exp_of_real_symmetric_is_real_symmetric` | `Ising2D.exp_of_real_symmetric_is_real_symmetric`（`TensorPow M` で述べ、人手の `n` は `2^M` に限る（引く `exp_of_hermitian_is_hermitian`・`exp_of_symmetric_is_symmetric` の具体版が `TensorPow M` で述べてあるため）。人手の 4 行（`real_symmetric_isHermitian`、`MatrixIsRealSymmetric` の第 2 成分、`matExp_conjTranspose_of_conjTranspose_eq`、`matExp_transpose_of_transpose_eq`）と結論の `hermitian_and_transpose_invariant_matrix_is_real_symmetric` の適用と 1 対 1。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimExpOfRealSymmetricIsRealSymmetric.lean`） | なし（既存の 4 つの主張と定義を並べるだけ。引く 4 つにはそれぞれ必要十分版がある） |
| `power_of_real_symmetric_complex_matrix_is_real_symmetric` | `Ising2D.power_of_real_symmetric_complex_matrix_is_real_symmetric`（`TensorPow M` で述べ、人手の `n` は `2^M` に限る（使う側 `trace_power_upper_bound` の `W` が `TensorPow M` のため）。準備の `A^1 = A` の 4 行は `matrix_pow_one_eq_self_tensorPow`、`p = 0` は `identity_matrix_isRealSymmetric_tensorPow`（成分の 3 行は `identity_matrix_entry_cases_tensorPow`（1・2 行目は `Matrix.one_apply` の 1 段）と `identity_matrix_hasRealEntries_tensorPow`、`(I^⊤)_{kl}` の 4 行は `identity_transpose_tensorPow`）、`p + 1` の転置の 11 行は `matrix_pow_succ_transpose_apply_tensorPow` の `calc` の 11 段と 1 対 1。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetric.lean`。必要十分版からの導出は `Ising2D.power_of_real_symmetric_complex_matrix_is_real_symmetric_of_necSuf`（`ClaimPowerOfRealSymmetricComplexMatrixIsRealSymmetricFromNecSuf.lean`）） | `Ising2D.NecSuf.pow_entries_mem_and_transpose_eq'`（係数は可換半環、「実数」は `0`・`1` を含み積と和で閉じた任意の性質。転置の段に係数の乗法の可換則が効く。`NecSuf/PowerOfSymmetricMatrixWithClosedEntries.lean`） |
| `distinct_site_pauli_matrices_commute` | `Ising2D.siteOp_mul_comm`（`Mat(2,ℂ)^{⊗M}`、`PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`。人手の `σ^a, σ^b` を `A, B ∈ Mat(2,ℂ)` で述べる。必要十分版からの導出は `Ising2D.siteOp_mul_comm_of_necSuf`、`PartitionFunction/ProjectionAndJordanWigner/ClaimDistinctSitePauliMatricesCommuteFromNecSuf.lean`） | `Ising2D.NecSuf.update_sitewise_commute_of_ne` / `NecSuf.update_mul_comm_of_ne`（各サイトの台は単位元を持つ乗法だけ、写像は積を保つことだけ。`NecSuf/SitewiseCommute.lean`） |
| `hatZ_hatY_M_periodicity` | `Ising2D.hatZ_periodic` / `hatY_periodic` / `hatZMinus_M_eq_neg_M` / `hatY_M_eq_neg_M`（複素指数関数。必要十分版からの導出は `Ising2D.hatZ_periodic_of_necSuf` ほか、`RoutesNotAdopted/IntegerMomentum/ClaimHatZHatYPeriodicityFromNecSuf.lean`） | `Ising2D.NecSuf.transform_periodic` / `NecSuf.zpow_mul_add_natCast`（任意の体、`ζ^M = 1` だけ。`NecSuf/DiscreteFourier.lean`） |
| `recover_Z_Y_from_hatZ_hatY` | `Ising2D.inverse_dft` / `recover_Y` / `recover_Z`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.inverse_dft_of_necSuf` / `recover_Y_of_necSuf` / `recover_Z_of_necSuf`、`RoutesNotAdopted/IntegerMomentum/ClaimRecoverZYFromHatZHatYFromNecSuf.lean`） | `Ising2D.NecSuf.inverse_dft_necSuf`（任意の体の 1 の原始 `M` 乗根と、その体上の任意の加群。`NecSuf/DiscreteFourier.lean`） |
| `exp_of_negative_is_left_inverse` | `Ising2D.matrixExp_neg_mul_matrixExp`（`Mat(n,ℂ)` を添字 `Fin n` で。準備の第一の鎖の 8 行は `neg_matrix_mul_self_apply`、第二の鎖の 11 行は `neg_matrix_add_self_apply`、指数の鎖の 3 行は `calc` の 3 段と 1 対 1。`theorem_exp_product`・`theorem_exp_zero` は mathlib の `Matrix.exp_add_of_commute`・`NormedSpace.exp_zero`。`MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfNegativeIsLeftInverse.lean`。必要十分版からの導出は `Ising2D.matrixExp_neg_mul_matrixExp_of_necSuf`、`TensorPow M` の系は `Ising2D.matExp_neg_mul_matExp_tensorPow`（`ClaimExpOfNegativeIsLeftInverseFromNecSuf.lean`）） | `Ising2D.NecSuf.matrixExp_neg_mul_matrixExp'`（係数は非可換でよい完備なノルム環。積の可換律は効かず、`-1` が全ての元と可換であることだけが効く。添字は任意の有限型。`NecSuf/ExpNegMulExp.lean`） |
| `matrix_power_exponent_law` | `Ising2D.matrix_power_exponent_law`（`TensorPow M` で述べ、人手の `n` は `2^M` に限る（使う側 `trace_power_upper_bound`・`power_of_real_symmetric_complex_matrix_is_real_symmetric` が `TensorPow M` のため）。`q = 0` の 3 行と `q + 1` の 5 行は `calc` の段と 1 対 1。`mat_mult_associative` は mathlib の `Matrix.mul_assoc`。`MathematicalTools/MatrixExponentialAndCommutators/ClaimMatrixPowerExponentLaw.lean`。必要十分版からの導出は `Ising2D.matrix_power_exponent_law_of_necSuf`（`ClaimMatrixPowerExponentLawFromNecSuf.lean`）） | `Ising2D.NecSuf.power_exponent_law'`（任意のモノイド。効くのは乗法の結合則と右単位律だけ。`NecSuf/PowerExponentLaw.lean`） |
| `trace_of_positive_definite_is_positive` | `Ising2D.trace_of_positive_definite_is_positive`（`Mat(n,ℂ)` を添字 `Fin n` で、`1 ≤ n`。成分の鎖の 11 行は `conjugate_bilinear_value_basis_eq_diag`、トレースの鎖の 3 行と `Σ r_k ≥ r_1 > 0` の 2 行は `calc` の段と 1 対 1。人手の `x^*Ay`（`def_conjugate_bilinear_value`）は `conjugateBilinearValue`、mathlib の `Matrix.PosDef` との読み替えは `posDef_conjugateBilinearValue_pos`。`real_inclusion_preserves_finite_sum` は mathlib の `Complex.ofReal_sum`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfPositiveDefiniteIsPositive.lean`。必要十分版からの導出は `Ising2D.trace_of_positive_definite_is_positive_of_necSuf`、`TensorPow M` の系は `Ising2D.trace_of_positive_definite_is_positive_tensorPow`（`ClaimTraceOfPositiveDefiniteIsPositiveFromNecSuf.lean`）） | `Ising2D.NecSuf.trace_pos_of_conjBilin_pos'`（係数は共役付きの半環で、積の可換律・符号反転は効かない。正値は和を保つ包含 `S →+ R` の正の元の像として受け渡し、`S` は順序付き加法モノイド。添字は空でない有限型。`NecSuf/TraceOfPositiveDefinite.lean`） |
| `conjugate_bilinear_value_of_congruence` / `congruence_preserves_positive_definite` | `Ising2D.conjugate_bilinear_value_of_congruence`（14 行の鎖と 1 対 1 の `calc`） / `Ising2D.congruence_preserves_positive_definite`（準備の `(B^*)^* = B` の 6 行は `conjTranspose_conjTranspose_apply`、`B'0 = 0` の 5 行は `mulVec_zero_apply`、エルミート性の 5 行は `congruence_isHermitian`、`Bx = 0` を仮定した 5 行は `mulVec_ne_zero_of_left_inverse`、最後の 2 行は `calc` の 2 段）（`Mat(n,ℂ)` を添字 `Fin n` で。`complex_conjugate_of_product`・`complex_conjugate_of_sum` は mathlib の `star_mul'`・`star_sum`、`star_preserves_norm_and_limits` (1) の第 1 式は具体版 `matrix_conjTranspose_mul`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimCongruencePreservesPositiveDefinite.lean`。必要十分版からの導出は `Ising2D.congruence_preserves_positive_definite_of_necSuf`、`TensorPow M` の系は `Ising2D.congruence_preserves_positive_definite_tensorPow`（`ClaimCongruencePreservesPositiveDefiniteFromNecSuf.lean`）） | `Ising2D.NecSuf.conjBilin_congruence'`・`NecSuf.conjTranspose_conjTranspose_apply'`・`NecSuf.mulVec_zero_apply'`・`NecSuf.mulVec_ne_zero_of_left_inverse'`・`NecSuf.congruence_isHermitian'`・`NecSuf.congruence_preserves_pos'`（導出は `Ising2D.conjugate_bilinear_value_of_congruence_of_necSuf`・`congruence_preserves_positive_definite_of_necSuf'`、読み替えは `posDef_of_conjBilin'_pos`。係数は共役付きの可換半環。正値性の段は「正」の中身を使わず任意の述語 `P` で述べ、`A` のエルミート性も効かない。エルミート性の段は積の可換律を使わない。添字は任意の有限型。`NecSuf/CongruencePreservesPositiveDefinite.lean`） |
| `real_multiple_of_hermitian_is_hermitian` | `Ising2D.real_multiple_isHermitian`（成分の鎖の 7 行と 1 対 1 の `calc`。`complex_conjugate_of_product` は mathlib の `star_mul'`。添字は任意の型。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimRealMultipleOfHermitianIsHermitian.lean`。必要十分版からの導出は `Ising2D.real_multiple_isHermitian_of_necSuf`（`ClaimRealMultipleOfHermitianIsHermitianFromNecSuf.lean`）） | `Ising2D.NecSuf.star_fixed_smul_isHermitian`（係数は積と共役が定義された型（`Mul`・`Star`）で、`complex_conjugate_of_product` は `α` を左から掛けた積についての仮定 `hmul`、実数 `α` は共役で動かない元 `star α = α` に置き換える。積の可換性・`star` の対合性・和・零・単位元は効かない。`NecSuf/StarFixedScalarMultipleOfHermitian.lean`） |
| `positive_real_multiple_preserves_positive_definite` | `Ising2D.positive_real_multiple_preserves_positive_definite`（エルミート性は `real_multiple_isHermitian`、正値性の 13 行の鎖は `conjugate_bilinear_value_of_positive_real_multiple` の `calc` の 13 段と 1 対 1、`αr > 0` は `mul_pos`。`Mat(n,ℂ)` を添字 `Fin n` で。分配律は `Finset.mul_sum`。`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimPositiveRealMultiplePreservesPositiveDefinite.lean`。必要十分版からの導出と `TensorPow M` の系 `Ising2D.positive_real_multiple_preserves_positive_definite_tensorPow` は `ClaimPositiveRealMultiplePreservesPositiveDefiniteFromNecSuf.lean`） | `Ising2D.NecSuf.conjBilin_smul'` / `NecSuf.smul_preserves_pos'`（係数は半環と写像 `star`、`ℂ` の可換律の 1 段は `ι(α)` が全ての元と交換する仮定 `hcomm`、`α_ℂr_ℂ = (αr)_ℂ` の 4 行は包含が積を保つ仮定 `hincl`、正値性は `S` の正の元の積が正であることだけ。添字は任意の有限型。`NecSuf/PositiveMultiplePreservesPositiveDefinite.lean`） |
| `real_exp_positive` | `Ising2D.real_exp_positive`（`ℝ`。Step 1 の鎖は `real_exp_mul_exp_neg`・`real_exp_ne_zero`、Step 2 の鎖は `real_exp_nonneg`。`MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpPositive.lean`。人手の `exp : ℝ → ℝ`（`def_scalar_exp`）と、それが引く `scalar_exp_product`・`scalar_exp_zero` は mathlib の `Real.exp`・`Real.exp_add`・`Real.exp_zero` で表し、人手の exp と `Real.exp` の一致は Lean では示していない（状態台帳の「次の一歩」に残した件）。必要十分版からの導出は `Ising2D.real_exp_positive_of_necSuf`（`ClaimRealExpPositiveFromNecSuf.lean`）） | `Ising2D.NecSuf.map_pos`（和を積へ送り `f(0) = 1` の写像。定義域は `AddGroup` でどの元も `y + y` の形、値域は全順序環。補題は `mul_map_neg_eq_one`・`map_ne_zero`・`map_nonneg`。`NecSuf/PositivityOfAdditiveToMultiplicativeMap.lean`） |
| `def_finite_product_of_real_numbers` / `real_exp_of_finite_sum` | `Ising2D.real_exp_of_finite_sum`（`ℝ`。帰納法の `m = 1` の 2 行・`m → m+1` の 4 行と 1 対 1 の `calc`。有限和・有限積は `Finset.sum`・`Finset.prod` で、定義の 2 つの式は `Fin.sum_univ_one`・`Fin.sum_univ_castSucc`・`Fin.prod_univ_one`・`Fin.prod_univ_castSucc`。`scalar_exp_product` は `real_exp_positive` と同じく mathlib の `Real.exp_add` で表す。`MathematicalTools/MatrixExponentialAndCommutators/ClaimRealExpOfFiniteSum.lean`。必要十分版からの導出は `Ising2D.real_exp_of_finite_sum_of_necSuf`、和・積の一致は `real_finset_sum_eq_finSumLeft`・`real_finset_prod_eq_finProdLeft`（`ClaimRealExpOfFiniteSumFromNecSuf.lean`）） | `Ising2D.NecSuf.map_finSumLeft`（和を積へ送る写像。定義域は `Add` だけ、値域は `Mul` だけ。有限和は `NecSuf.finSumLeft`、有限積は `NecSuf.finProdLeft`。`NecSuf/AdditiveToMultiplicativeMapOfFiniteSum.lean`） |
| `trace_of_sum_over_binary_words` / `trace_of_scalar_multiple` | `Ising2D.trace_binaryWordMatrixSum`（準備の鎖の 3 行は `trace_add_matrix`、帰納法の `r = 1` の 3 行・`r → r+1` の 4 行と 1 対 1 の `calc`） / `trace_of_scalar_multiple`（人手の 5 行と 1 対 1 の `calc`）（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/ClaimTraceOfSumOverBinaryWords.lean`。`TensorPow M` の系は `trace_add_tensorPow`・`trace_smul_tensorPow`。必要十分版は `NecSuf.binWordSum_map`（`f := trace`）で、導出と `TensorPow M` の系 `trace_binWordSum_tensorPow` は同じフォルダの `ClaimTraceOfSumOverBinaryWordsFromNecSuf.lean`。`trace_of_scalar_multiple` の必要十分版は置かない） | `009_eigenvalues_of_V.ts` |

必要十分版から得られた知見（本文には持ち込まないが、解説パートの素材になる）:

- `ψ` の反交換関係に効いているのは `hat(Z)^{(-)}, hat(Y)` の 4 本の反交換関係と、
  係数についてのスカラー恒等式 2 本だけである。`hat(Z)`, `hat(Y)` の具体形も、複素行列であることも、
  テンソル冪であることも、`M`・`δ^M_{μ+ν,0}`・`γ_2` も効いていない。

- `exp(X) A exp(-X) = exp(ad X)(A)` に効いているのは、**左乗法 `L_X` と右乗法 `R_X` が
  線型作用素として可換であること**（結合律から出る）と、**`(L_X)^n = L_{X^n}`・`(R_X)^n = R_{X^n}`**
  の 2 つだけである。行列であることも有限次元であることも効いておらず、ℂ 上の完備ノルム環なら成り立つ。
  リー群・リー環はもちろん、`L` が代数準同型であることすら使っていない。
  なお右乗法は反同型だが `(R_X)^n = R_{X^n}` は左乗法と同形なので、反対環を経由する必要がない。

- `H_1^{(±)}, H_2` と `hat(Z)^{(±)}, hat(Y)` の 6 本の交換関係に効いているのは、恒等式
  `[a b, c] = a [b,c]₊ - [a,c]₊ b` と、**反交換子が係数のスカラー倍の `1` になること**
  （`[z_μ,z_ν]₊ = D_z(μ,ν)·1`、`[z_μ,y_ν]₊ = 0`、`[y_μ,y_ν]₊ = D_y(μ,ν)·1`）だけである。
  `hat(Z), hat(Y)` の具体形（離散フーリエ変換）も、行列であることも、
  `D` の中身（`2M δ^M_{μ+ν,0}` や `-4 e^{-i2π(μ+ν)/M}`）も効いていない。
  `hat(Z)^{(±)}` と `hat(Z)^{(∓)}` の違いは `D_z` と `D_{z'}` という**別のスカラー関数**として
  抽象化でき、原文が符号ごとに書き分けている 6 本は必要十分版では
  「積の並びが `y z` か `z y` か」×「交換相手が `z` か `z'` か `y` か」の 6 通りに対応する。

- 原文が `<nesting_of_commutator_of_H_and_Z>`（`n` 重の入れ子交換子の偶奇による場合分け）と
  `<extract_taylor_coefficient_of_Z_Y>`（その係数を cosh/sinh のテイラー級数と突き合わせる）の
  2 段でやっていることは、**「`ad X` が `span{ẑ, ŷ}` を保つ」という 1 つの仮定に集約できる**。
  そこから先は `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y` という閉じた形が自動的に出る。
  入れ子交換子の偶奇は `adCLM_pow_even` / `adCLM_pow_odd_*` に、テイラー係数の抽出は
  `Complex.hasSum_cosh` / `hasSum_sinhc` に、それぞれ 1 対 1 で対応する。
- 原文が「`V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消し合う」と一行で済ませている箇所に
  効いているのは、**任意の ℂ-代数で成り立つ `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`** だけである
  （`NecSuf.conj_smul_eq`）。ノルムも完備性も指数関数も要らない。
- `Z_m, Y_m` の線型独立性に効いているのは、**Clifford 関係 `[e_a,e_b]₊ = 2δ_{ab}·1` と、
  スカラーが台へ忠実に入ること（`s·1 = 0 ⇒ s = 0`）と、`2` が零因子でないこと**の 3 つだけである。
  行列であること・テンソル冪であること・`Z, Y` の具体形（Jordan–Wigner 文字列）・
  有限次元性・係数が体であることは効いていない（係数は任意の可換環でよい）。

- `exp_sum`（指数関数の和とクロネッカーのデルタ）に効いているのは、**位相因子が
  1 の原始 `M` 乗根であること**と、**係数の住む場所で割り算ができること**（等比数列の和）だけである。
  指数関数・円周率・複素数であること・絶対値・偏角は効いていない。
  さらに `M ≠ 0` も証明には不要である（`M = 0` なら両辺とも `0`）。

- `hat(Z), hat(Y)` の 4 本の反交換関係に効いているのは、**`Z, Y` の Clifford 関係**と
  **1 の原始 `M` 乗根の直交性**だけである。加えて `(±)` の重み（原文の `∓1`）については
  **両側の重みの積 `u_j v_j` しか結論に現れない**ので、原文の「複号同順／複号逆」は
  「積が全サイトで `1`」と「`j = 1` でだけ `-1`」の 2 通りに整理できる。
  原文が課している `η^2 = 1` は、積が `1` になるための十分条件にすぎない。

- `Z_μ, Y_ν` の反交換関係 3 式に効いているのは、**サイトごとの積を作る写像が
  「単位的・乗法的・多重線型」であること**（符号 `-1` が積の外へ出る）と、
  **食い違うサイトがちょうど 1 つであること**だけである。テンソル積・クロネッカー積の具体形も、
  成分が 2×2 であることも、複素数であることも、Pauli 行列の成分計算も効いていない
  （使うのは `A σ^x = -σ^x A` 型の関係式だけ）。
  Jordan–Wigner 文字列を書くのに要るのは「サイトの添字に線型順序があること」だけで、
  文字列に使う元が `σ^x` である必要もない（`NecSuf/SiteLocalAnticomm.lean`）。

- `hat(Z), hat(Y)` の `M` 周期性に効いているのは **`ζ^M = 1` の一点のみ**である。
  原始根であることすら要らず、`Z_j, Y_j` の代数的性質も、`hat(Z)^{(±)}` の重みも、
  指数の符号の取り方も効いていない。

- `hat(Z)^{(-)}, hat(Y)` からの復元（離散フーリエ逆変換）に効いているのは、
  **1 の原始 `M` 乗根の直交性**と、**変換される対象が係数体上の加群であること**だけである。
  行列であることも、積があることも、`Z, Y` の反交換関係も効いていない。
  原文が `hat(Z)^{(+)}` で復元を述べていない理由も必要十分版から一意に説明できる:
  必要十分版の仮定は「重みが一様」であり、`hat(Z)^{(+)}` は `j = 1` の重みだけが `-1` だからである。

- 交換子と反交換子の恒等式には、行列であることも複素数であることも効いていない
  （分配法則と結合法則だけで足りる）。
- スカラー倍の恒等行列が全行列と可換であることに効いているのは、スカラー作用と積の
  両立則だけである。次数 `n ≥ 1` は本質的でなく、引き算すら「差が `0`」という述べ方の
  ためにしか使っていない。
- 中心がスカラーであることに効いているのは、添字集合が有限で等号判定可能なことだけである。
  係数が非可換だとスカラーは「係数環の中心の元」に限られ、ℂ の可換性がその条件を消している。

## `Mat(2, ℂ)^{⊗M}` の表現方針（決定事項）

人手証明の `Mat(2, CC)^(times.o M)` は、Lean では次の 2 通りに表せる。

| | 定義 | 実装 |
| --- | --- | --- |
| 抽象テンソル冪 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.AbstractTensorPow` |
| 行列表現（Kronecker） | `Matrix (Fin M → Fin 2) (Fin M → Fin 2) ℂ` | `Ising2D.TensorPow` |

**両者が ℂ-代数として同型であることは `Ising2D.tensorPowAlgEquiv` で証明済み**
（同型写像は `⨂ₜ x ↦ [(s,t) ↦ ∏ᵢ (xᵢ)_{s(i)t(i)}]`、すなわち Kronecker 積）。
したがってどちらで述べた命題も他方へ移送できる。

そのうえで、**以降の証明の土台には行列表現 `TensorPow M` を採用する**。根拠は以下。

1. **行列指数関数が使える（決定的）。** 主対象 `V_1`, `V_2` は `exp` を含むが、
   `AbstractTensorPow M` には `NormedRing` インスタンスが無く `NormedSpace.exp` を適用できない
   （`infer_instance` が失敗することを確認済み）。`TensorPow M` では
   `Mathlib.Analysis.Normed.Algebra.MatrixExponential` の補題群
   （`Matrix.exp_units_conj`, `Matrix.exp_add_of_commute`, `Matrix.exp_diagonal` …）
   がそのまま使える。
2. **中心の決定が既存で済む。** `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`
   の 4 ステップ（行列単位の基底展開 → 積公式 → 係数比較 → 結論）は、
   `Matrix.center_eq_scalar_image` に帰着して数行で終わる。
3. **添字型がスピン配置そのもの。** `Fin M → Fin 2` は「各サイトの 2 準位の値」を表すので、
   サイト局所演算子（`σ^x_k` など）を Kronecker 積の再帰なしに直接書ける。
   なお `Fin (2^M)` を添字にした Kronecker 表現は
   **`TensorPow M` の添字の付け替えにすぎない**（`Ising2D.toFinPowAlgEquiv` で ℂ-代数同型を証明済み）。
   表現力は同じで、`Fin (2^M)` 側は `finFunctionFinEquiv` による添字変換が全体に散らばる分だけ不利。
4. **行列式・跡・固有値・`Matrix.reindex` など行列固有の API が全部使える。**
   対角化（`parts/008_...` の `P_μ`, `D_μ`）で必要になる。

抽象テンソル冪の利点は人手証明の記法に見た目が近いことだけで、
テンソル冪の基底（`<tensor_basis>`）も `Basis.piTensorProduct` 経由で
`Ising2D.tensorPowBasis` として用意してあるため、必要な結果は移送できる。

## 転送行列 `V_1, V_2` の唯一の定義とパウリ行列表示

形式化は部「分配関数」の章「転送行列による表示」のフォルダ `Ising2D/PartitionFunction/TransferMatrixRepresentation/` にある
（`exp_of_diagonal_matrix` だけは部「数学的道具立て」の項目なので `MathematicalTools/MatrixExponentialAndCommutators/` にある）。

人手の本文は `V_1, V_2` を 001 章 `def_transfer_matrix` の成分定義ただ 1 つで定め、パウリ行列による表示は
004 章の主張 `first_transfer_matrix_pauli_form` / `second_transfer_matrix_pauli_form` である。
Lean も同じ構成にしてある。

### 記号の対応

| 人手の記号 | Lean | 備考 |
| --- | --- | --- |
| 列数 `M_col`（1 行のサイト数） | 束縛変数 `M`（列の添字は `Fin M`） | 束縛変数名は `M` のまま。人手の `m ∈ {1,…,M_col}` が Lean の `(m : ℕ) + 1` |
| 行数 `N_row` | 束縛変数 `Nrow`（行の添字は `Fin Nrow`） | |
| `K_1`（同じ行の隣り合うサイト）・`K_2`（隣り合う行の同じ列のサイト） | `K1 K2 : ℝ` | 旧記号 `J, J'` は人手・Lean とも廃止した |
| `K_2^*` | `Ising2D.Kstar K2` | `def_second_dual_coupling_constant` |
| `s_2 = sinh 2K_2` | `Real.sinh (2 * K2)` | `def_indexed_hyperbolic_abbreviations` |
| `Z(K_1, K_2)` | `Ising2D.partitionFunction Nrow M K1 K2` | |
| 周期規約 `μ(M_col+1) := μ(1)`, `σ^z_{M_col+1} := σ^z_1` ほか | 巡回後者 `Ising2D.nextSite` | |
| 行番号 `ord(μ)`（= `ν(ι(μ))`） | 行列の添字 `ι(μ) = configBasisIso M μ : Conf M` | 下記「行列の添字」 |

### 名前の整理

| Lean の名前 | 何か |
| --- | --- |
| `Ising2D.V1 M K1`, `Ising2D.V2 M K2` | **`def_transfer_matrix` の `V_1, V_2`。Lean で `V_1, V_2` の定義はこれだけ** |
| `Ising2D.V1PauliForm M K1` | `first_transfer_matrix_pauli_form` の右辺 `exp(K_1∑σ^z_mσ^z_{m+1})`（`K1 : ℂ` の一般の値。定義ではなく式の名前） |
| `Ising2D.V2PauliForm M s2 K2star` | `second_transfer_matrix_pauli_form` の右辺 `(2s_2)^{M/2}exp(K_2^*∑σ^x_m)`（`s2`, `K2star` は独立な引数） |
| `Ising2D.V2FromJordanWigner` / `Ising2D.V2H2Form` | `V2_in_Z_Y` / `V2_exponential_representation` の右辺（同上） |
| `Ising2D.V1plus M K1` / `V1plusUnits` | `V_1^{(+)}`（`def_V1_plus`）とその単元。`V_1` とは別の行列 |
| `Ising2D.V1plusHalf M K1` / `V1plusHalfUnits` | `(V_1^{(+)})^{1/2}`（`def_V1_plus_square_root`、`PartitionFunction/ProjectionAndJordanWigner/DefinitionV1PlusSquareRoot.lean`）とその単元 |
| `Ising2D.VPlusOfTransfer M K1 K2` | `V^{(+)} = (V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`（`def_V_plus`。`V_2` は `def_transfer_matrix` の `V_2`） |
| `Ising2D.V1pm M K1 η` / `V1pmHalf` / `V1pmUnits` / `V1pmHalfUnits` / `V1pmFromDefinition` | 境界項の係数を `η` にした補助の一般形（`η = -1` が `(+)`）。整数運動量の経路と退避した `(−)` セクターの形式化の記録が使う |
| `Ising2D.V2H2FormUnits` | `V2H2Form` の単元 |
| `Ising2D.V2Units` | `def_transfer_matrix` の `V_2` の単元（`K_2 > 0`） |

旧名との対応（2026-09-26 の改名）: `V1comp → V1`, `V2comp → V2`, `V1pauli → V1PauliForm`,
`V2pauli → V2PauliForm`, 旧 `V1 → V1pm`, `V1half → V1pmHalf`, `V1Units → V1pmUnits`,
`V1halfUnits → V1pmHalfUnits`, `V1FromDefinition → V1pmFromDefinition`, 旧 `V2 → V2H2Form`,
`V2Units → V2H2FormUnits`（これらを名前に含む定理も同じ規則で改名した）。
(−) セクターの退避（同日）に伴う変更: `(+)` の定義 `H1plus` / `V1plus` / `V1plusUnits` /
`V1plusHalf` / `V1plusHalfUnits` / `VPlusOfTransfer` / `epsProjPlus` を新設し、
`V1plusHalf_mul_V2_mul_V1plusHalf → VPlusOfTransfer_eq_VPlus`、
`V1plusHalf_sq`（`Part014`）は `V1_plus_square_root_property`（`DefinitionV1PlusSquareRoot.lean`）へ一本化、
`physicalSymTransferR_map_mul_epsProj_eq_Vsym → symmetrized_transfer_matrix_on_sectors`（`(+)` だけ）、
`EvenSectorBridge.rayleighSup_eq_LambdaM → EvenSectorBridge.rayleighSup_sandwich_LambdaM`（挟み撃ち）、
`rayleighSup_eq_LambdaM_of_input → rayleighSup_sandwich_LambdaM_of_input`
（2026-10-31 に入力の構造 `EvenSectorClosureInput` を消し、`rayleighSup_sandwich_LambdaM_physical` へ改名）。

### 行列の添字

人手は `V_1, V_2 ∈ Mat(2^{M_col}, ℂ)` の成分を行番号 `ord(μ)`（`def_row_configuration_numbering`）で指定する。
Lean の `TensorPow M = Matrix (Conf M) (Conf M) ℂ` は添字型が多重添字の集合 `𝓘 = Conf M` そのもので、
人手の `def_kronecker` の「`I ∈ 𝓘` を行番号 `ν(I)` と同一視する」規約を添字型の選択として実現している。
`config_numbering_equals_kronecker_numbering`（`ord = ν ∘ ι`）により、人手の成分 `A_{ord(μ),ord(μ')}` は
Lean の `A (ι μ) (ι μ')` である。したがって人手の証明中の「`ord(μ)` と `ν(ι(μ))` の読み替え」の段と
「`ord` の全射性により全成分が決まる」段は、Lean ではそれぞれ添字の読み方と `ι` の全射性にあたる。
`ν` 自体が全単射であること（`def_kronecker` の証明）は形式化していない。

### ファイルとラベルの対応

| 人手のラベル | Lean | ファイル |
| --- | --- | --- |
| `def_row_configurations` | `Ising2D.SpinVal` / `SpinConf` | `PartitionFunction/TransferMatrixRepresentation/DefinitionRowConfigurations.lean` |
| `def_row_configuration_numbering` | `Ising2D.spinBit` / `rowConfigOrd` | `PartitionFunction/TransferMatrixRepresentation/DefinitionRowConfigurationNumbering.lean` |
| `row_configuration_numbering_bijective` | `Ising2D.row_configuration_numbering_bijective`（途中は `geom_sum_two` / `rowConfigOrd_mem_Icc` / `rowConfigOrd_sub_pos_of_first_diff` / `rowConfigOrd_injective`） | `PartitionFunction/TransferMatrixRepresentation/ClaimRowConfigurationNumberingBijective.lean` |
| `def_transfer_matrix` | **`Ising2D.V1` / `Ising2D.V2`**（定義式は `V1_apply_configBasisIso` / `V2_apply_configBasisIso`） | `PartitionFunction/TransferMatrixRepresentation/DefinitionTransferMatrix.lean` |
| `def_lattice_size` / `def_partition_function_2d_ising` | `Ising2D.partitionFunction` | `PartitionFunction/TransferMatrixRepresentation/DefinitionPartitionFunction.lean` |
| `partition_function_via_transfer_matrix` | `Ising2D.partition_function_via_transfer_matrix`（`N_row ≥ 1`。途中は `V1_mul_V2_apply` / `rowsToLattice`） | `PartitionFunction/TransferMatrixRepresentation/ClaimPartitionFunctionViaTransferMatrix.lean` |
| `def_config_basis_iso` | `Ising2D.configBasisIso` / `sgn` / `basisVec` | `PartitionFunction/TransferMatrixRepresentation/DefinitionConfigBasisIso.lean` |
| `config_numbering_equals_kronecker_numbering` | `Ising2D.config_numbering_equals_kronecker_numbering`（`ν` は `kroneckerNumbering`） | `PartitionFunction/TransferMatrixRepresentation/ClaimConfigNumberingEqualsKroneckerNumbering.lean` |
| `sigma_z_diagonal_action` | `Ising2D.sigmaZ_eq_diagonal` / `sigmaZ_mulVec_basisVec` ほか | `PartitionFunction/TransferMatrixRepresentation/ClaimSigmaZDiagonalAction.lean` |
| `exp_of_diagonal_matrix` | `Ising2D.matrixExp_diagonal` / `matrixExp_diagonal_apply` | `MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfDiagonalMatrix.lean` |
| `def_site_pauli_periodic_extension` / `first_transfer_matrix_pauli_form` | `Ising2D.sigmaZ_nextSite_of_last` / **`Ising2D.first_transfer_matrix_pauli_form`**（`V1 M K1 = V1PauliForm M K1`） | `PartitionFunction/TransferMatrixRepresentation/ClaimFirstTransferMatrixPauliForm.lean` |
| `def_second_dual_coupling_constant` | `Ising2D.Kstar` | `PartitionFunction/TransferMatrixRepresentation/DefinitionSecondDualCouplingConstant.lean` |
| `second_dual_coupling_relation` | `Ising2D.second_dual_coupling_relation` | `PartitionFunction/ProjectionAndJordanWigner/ClaimSecondDualCouplingRelation.lean`（必要十分版は `NecSuf/DualCouplingRelation.lean` の `Ising2D.NecSuf.dualCouplingProduct_eq_one`、そこからの導出は `PartitionFunction/ProjectionAndJordanWigner/ClaimSecondDualCouplingRelationFromNecSuf.lean` の `Ising2D.second_dual_coupling_relation_of_necSuf`） |
| `two_by_two_transfer_identity` | `Ising2D.two_by_two_transfer_identity`（中間目標「`exp(tσ^x)` の閉じた形」は `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh`） | `PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentity.lean`（その中間目標の必要十分版は `NecSuf/ExpOfInvolution.lean` の `Ising2D.NecSuf.exp_series_sum_of_sq_eq_one`、そこからの導出は `PartitionFunction/TransferMatrixRepresentation/ClaimTwoByTwoTransferIdentityFromNecSuf.lean` の `Ising2D.exp_smul_pauliX_eq_cosh_add_sinh_of_necSuf`） |
| `epsilon_square_identity` | `Ising2D.epsilon_mul_self`（`εε = I`） | `PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`（必要十分版は `NecSuf/EpsilonSquare.lean` の `Ising2D.NecSuf.prefix_terminal_mul_self`、そこからの導出は `PartitionFunction/ProjectionAndJordanWigner/ClaimEpsilonSquareFromNecSuf.lean` の `Ising2D.epsilon_mul_self_of_necSuf`） |
| `global_spin_flip_jordan_wigner_representation` | `Ising2D.zyPrefixProduct_eq_neg_i_pow_smul_xString`（第二の有限帰納法）/ `Ising2D.epsilon_eq_i_pow_smul_zyPrefixProduct`（`ε = (√-1)^M Z_1Y_1⋯Z_MY_M`） | `PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean`（第二の有限帰納法の必要十分版は `NecSuf/ScalarPrefixProduct.lean` の `Ising2D.NecSuf.prefix_eq_pow_smul_of_local_smul`、そこからの導出は `PartitionFunction/ProjectionAndJordanWigner/ClaimGlobalSpinFlipJordanWignerRepresentationFromNecSuf.lean` の `Ising2D.zyPrefixProduct_eq_neg_i_pow_smul_xString_of_necSuf`） |
| `def_second_transfer_matrix_prefactor` / `second_transfer_matrix_pauli_form` | `Ising2D.secondTransferPrefactor` / **`Ising2D.second_transfer_matrix_pauli_form`**（`V2 M K2 = V2PauliForm M (sinh 2K_2) K_2^*`、`K_2 > 0`） | `PartitionFunction/TransferMatrixRepresentation/ClaimSecondTransferMatrixPauliForm.lean` |
| `partition_function_via_pauli_transfer_matrices` | `Ising2D.partition_function_via_pauli_transfer_matrices`（`((Z : ℝ) : ℂ) = tr((V1PauliForm · V2PauliForm)^{N_row})`、人手の `(Z(K_1,K_2))_ℂ`、`K_2 > 0`、`N_row ≥ 1`） | `PartitionFunction/TransferMatrixRepresentation/ClaimPartitionFunctionViaPauliTransferMatrices.lean` |
| `V1_in_Z_Y_epsilon` | `Ising2D.V1_in_Z_Y_epsilon` | `PartitionFunction/ProjectionAndJordanWigner/ClaimV1InZYEpsilon.lean` |
| `V2_in_Z_Y` / `V2_exponential_representation` | `Ising2D.V2_in_Z_Y` / `Ising2D.V2_exponential_representation` | `PartitionFunction/ProjectionAndJordanWigner/ClaimV2InZY.lean` |
| `V_plus_exponential_form` | `Ising2D.V_plus_exponential_form`（`VPlusOfTransfer` の指数表示） | `PartitionFunction/ProjectionAndJordanWigner/ClaimVPlusExponentialForm.lean` |
| `W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`（射影の章の章末の主張） | `Ising2D.W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form` | `PartitionFunction/ProjectionAndJordanWigner/ClaimWPPlusEqVPlusPPlusImageAndVPlusExponentialForm.lean` |

### 下流で `V_2` をどう扱っているか

人手が `V_2` と書く対象は Lean でも `Ising2D.V2` を使い、人手が主張を引く位置で書き換える。

* 010 章（`epsilon_commutes_with_V1`・`epsilon_commutes_with_V2`・`epsilon_commutes_with_V1_plus`・`epsilon_commutes_with_V1_plus_square_root`, `epsilon_projector_commutes_with_epsilon_commuting_matrix`・`epsilon_projector_commutes_with_V1`・`epsilon_projector_commutes_with_V2`・`epsilon_projector_commutes_with_V1_plus`・`epsilon_projector_commutes_with_V1_plus_square_root`,
  `def_V_plus`）と 011 章（`physicalSymTransferC`, `symmetrized_transfer_matrix_on_sectors`,
  `epsilon_commutes_with_W`）は `V1`, `V2` そのものについて述べ、
  `first_transfer_matrix_pauli_form` / `second_transfer_matrix_pauli_form` / `V1_in_Z_Y_epsilon` を
  人手が引く位置で使う（参照用ノートへ退避した `sector_replacement_of_V1`, `sector_replacement_pow`,
  `partition_function_sector_decomposition` の形式化の記録も同じ）。
* 014〜018 章の `VPlus M s2 K1 K2star` / `VPlusUnits` / `TVPlus` と、その上の定理は、
  `V_2` を `V2_exponential_representation` の右辺の式 `V2H2Form`（`s2`, `K2star` を独立な引数とする一般化）で
  書いたまま残してある（補助的な一般形）。人手の `V_2` についての主張は `V2Units` / `isUnit_V2`
  （`V2_invertible`）、`VPlusOfTransfer_eq_VPlus`（`def_V_plus` の `VPlusOfTransfer` との一致）、`TV_V1plusHalfUnits_V2Units`
  （`def_T_V_plus`）、`TConj_V2_checkZ` / `TConj_V2_checkY`（`T_actions_on_check_Z_Y` の第 3・第 4 式）、
  `linearity_of_T_V2` として別に立て、`s2 = sinh 2K_2`, `K2star = K_2^*` で一般形と一致させている。
  014〜018 章の残りの定理を人手の `V_2` の言葉に書き直す作業は行っていない（`lean/docs/ch014-formalization.md`）。
* 008・009 章（整数運動量の経路。本文から参照用ノートへ退避済み）の `Vmat`、`actsBy_TConj_V2H2Form` などは
  `V2H2Form` のまま。

### 人手証明と 1 対 1 にならない箇所

* 行列の添字: 上記「行列の添字」のとおり、`ord` と `ν(ι(·))` の読み替えの段は Lean では添字の読み方になる。
* `second_transfer_matrix_pauli_form` の「1 因子の `exp` をサイト演算子の `exp` にする」段
  （`exp_smul_sigmaX`）は、冪の等式（`siteOp_pow`）・部分和の像（連続線型写像による級数の像）・
  極限の一意性の 3 段で書いた。人手の「成分ごとの極限」は、有限次元の行列空間の位相での極限として扱っている。
* `partition_function_via_transfer_matrix` の中間目標「行列の冪の成分」(*) と「トレースの展開」は、
  必要十分版 `NecSuf.trace_pow_succ`（任意の可換半環上の行列）の系として得ている。
* 人手が仮定する `K_1, K_2 > 0` のうち、`V1`, `V2`, `partitionFunction` の定義、
  `partition_function_via_transfer_matrix`、`first_transfer_matrix_pauli_form` の証明は正値性を使わないので、
  Lean では仮定に置いていない。`K_2 > 0` は `K_2^*` の定義域（`tanh K_2 > 0`）と前係数の正値性のために、
  `second_transfer_matrix_pauli_form` 以降で仮定する。

## 現在形式化済みの命題

この表の人手証明のラベルのうち本文に無いものは、参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した整数運動量の経路のものである（退避の記録はノートの各ブロックの冒頭にある）。

| Lean の名前 | 内容 | 対応する人手証明 |
| --- | --- | --- |
| `Ising2D.tensorPowBasis` | 基底のテンソル冪はテンソル冪の基底 | `<tensor_basis>` |
| `Ising2D.matTensorPowBasis` | 上を `Mat(2,ℂ)` に適用したもの | `<tensor_basis>` の系 |
| `Ising2D.tensorPowAlgEquiv` | 抽象テンソル冪 ≃ₐ[ℂ] 行列表現 | 表現の選択（新規） |
| `Ising2D.toFinPowAlgEquiv` | 行列表現 ≃ₐ[ℂ] `Matrix (Fin (2^M)) (Fin (2^M)) ℂ` | 表現の選択（新規） |
| `Ising2D.E_mul_E` | 行列単位の積公式 `E_IJ E_KL = δ_JK E_IL` | `<centralizer_is_scalar>` Step 2 |
| `Ising2D.one_eq_sum_E` | `I = Σ_P E_PP` | `<centralizer_is_scalar>` Step 2 |
| `Ising2D.scalar_identity_commutes` | `[c·I, A] = O`（`Mat(n, ℂ)`、交換子は `matComm`） | `<scalar_identity_commutes>` |
| `Ising2D.centralizer_is_scalar` | 全元と可換な元はスカラー | `<centralizer_is_scalar>` |
| `Ising2D.centralizer_is_scalar_abstract` | 同上（抽象テンソル冪側） | 同上（移送の例） |
| `Ising2D.matExp_hasSum` | `exp(X) = ∑_k (k!)^{-1}X^k`（Frobenius ノルムでの級数の和） | `def_exp` |
| `Ising2D.Conjugation.conj_mul_matrix` | 共役写像は乗法的（`(Matrix (Fin n) (Fin n) ℂ)ˣ` の単元 `B`、人手の乗法性の鎖の 9 行と 1 対 1 の `calc`。`TensorPow M` での系は `conj_mul_tensorPow`） | `<conjugation_is_ring_homomorphism>` 乗法性 |
| `Ising2D.Conjugation.conj_one_matrix` | 共役写像は単位的（人手の単位性の鎖の 3 行。`TensorPow M` での系は `conj_one_tensorPow`） | `<conjugation_is_ring_homomorphism>` 単位性 |
| `Ising2D.Conjugation.mul_mul_inv_rev_matrix` / `inv_rev_mul_mul_matrix` / `mulUnitOfChains` / `units_mul_inv_rev_matrix` | `(GH)(H^{-1}G^{-1}) = I`・`(H^{-1}G^{-1})(GH) = I`（各 5 行）、2 本から組んだ単元（`GH` は正則。`mulUnitOfChains_eq_mul` で `G * H` と同じ）、`(GH)^{-1} = H^{-1}G^{-1}`（5 行。値が `GH` のどの単元についても） | `<conjugation_is_ring_homomorphism>` 合成則の準備 |
| `Ising2D.Conjugation.conj_comp_matrix` / `conj_comp_matrix_of_chains` | `(T_G ∘ T_H)(X) = T_{GH}(X)`（人手の合成則の鎖の 8 行。`T_{GH}` は値が `GH` の単元の共役、2 本の鎖から組んだ単元で述べたものが `_of_chains`） | `<conjugation_is_ring_homomorphism>` 合成則 |
| `Ising2D.Conjugation.T_mul` | 共役写像は乗法的（一般の環 `R` の単元。人手と 1 対 1 ではない） | `<conjugation_is_ring_homomorphism>` (1) |
| `Ising2D.Conjugation.T_one` | 共役写像は単位的 | `<conjugation_is_ring_homomorphism>` (2) |
| `Ising2D.Conjugation.T_comp` | `T_A ∘ T_B = T_{AB}` | `<conjugation_is_ring_homomorphism>` (3) |
| `Ising2D.Conjugation.TMonoidHom` | `B ↦ T_B` は群準同型 `Rˣ →* RingAut R` | (3) の言い換え |
| `Ising2D.Conjugation.matrix_conj_*` | 一般の環の版を `Matrix.inv` の記法で述べた版（人手と 1 対 1 ではない。1 対 1 は上の `conj_*_matrix`） | 原文の記法に寄せた版 |
| `Ising2D.acomm` / `Ising2D.commutator_via_anticommutators` | `[a b, c] = a [b,c]₊ - [a,c]₊ b`（任意の環） | `<commutator_via_anticommutators>` |
| `Ising2D.matrix_commutator_via_anticommutators` | 同上を `Mat(n, ℂ)` で述べた版 | 同上 |
| `Ising2D.pauliX/pauliY/pauliZ` と積公式 | Pauli 行列とその積・反可換関係 | `<Z_Y_generate_algebra>` Step 1 |
| `Ising2D.siteOp` | `I ⊗ ⋯ ⊗ A(k) ⊗ ⋯ ⊗ I`（`Mat(2,ℂ) →ₗ[ℂ] TensorPow M`） | `<def_transfer_matrix_symbols>` の `σ^a_k` |
| `Ising2D.sigmaX/sigmaY/sigmaZ` | `σ^x_k, σ^y_k, σ^z_k` | 同上 |
| `Ising2D.siteOp_mul_same` / `siteOp_mul_comm` | 同サイトの積・異サイトの可換性 | `<Z_Y_generate_algebra>` Step 1、異サイトの可換性は `distinct_site_pauli_matrices_commute` |
| `Ising2D.Z` / `Ising2D.Y` / `Ising2D.epsilon` | Jordan–Wigner 文字列 `Z_m`, `Y_m` と `ε` | `<def_transfer_matrix_symbols>` |
| `Ising2D.Z_eq_xString_mul` / `Y_eq_xString_mul` | `Z_m = (σ^x_1⋯σ^x_{m-1}) σ^z_m` 等 | 同上 |
| `Ising2D.siteProd_anticomm_of_single_site` | 1 サイトだけ反可換 ⇒ テンソル積は反交換 | `<anticommutator_of_Z_and_Y>` の計算の一般化 |
| `Ising2D.anticomm_Z_Z` | `[Z_μ, Z_ν]₊ = 2 I δ^M_{(μ,ν)}` | `<anticommutator_of_Z_and_Y>` 第 1 式 |
| `Ising2D.anticomm_Z_Y` | `[Z_μ, Y_ν]₊ = 0` | 同 第 2 式（**原文は TODO**） |
| `Ising2D.anticomm_Y_Y` | `[Y_μ, Y_ν]₊ = 2 I δ^M_{(μ,ν)}` | 同 第 3 式（**原文は TODO**） |
| `Ising2D.matrix_two_decomp` | `Mat(2,ℂ)` の元の `{I, σ^x, σ^y, σ^z}` 展開 | `<Z_Y_generate_algebra>` Step 3 の成分比較 |
| `Ising2D.Z_Y_generate_algebra` | `Algebra.adjoin ℂ {Z_m, Y_m} = ⊤` | `<Z_Y_generate_algebra>` |
| `Ising2D.acomm_sum_smul` / `acomm_sum_smul_left` | 反交換子の双線型性（有限線型結合の展開） | 補助（原文は暗黙に使用） |
| `Ising2D.ZY_linearIndependent` | `(Z_1,…,Z_M,Y_1,…,Y_M)` は線型独立 | `004/001`（**原文は TODO**） |
| `Ising2D.ZYSet_linearIndepOn` | 同上を集合 `S` の形で述べた版 | 同上 |
| `Ising2D.expPhase` | 位相因子 `exp(-√-1·2πk/M)`（`k : ℤ`） | `<def_hatZ_pm>` / `<def_hatY>`（中立な先行定義への分離は次の作業単位） |
| `Ising2D.expPhase_eq_one_iff` | `exp(-√-1·2πk/M) = 1 ⟺ M ∣ k` | `<exp_sum>` (a)(b) の場合分け |
| `Ising2D.expPhase_sum` | `∑_{j=1}^M exp(-√-1·2πjk/M) = M δ^M_{k,0}` | `<exp_sum>` |
| `Ising2D.deltaMod` | `δ^M_{(μ,ν)}` の整数添字版 | `parts/004/007_definition_…` |
| `Ising2D.hatZ` / `hatZPlus` / `hatZMinus` | `hat(Z)_μ^{(±)}` | `<def_hatZ_pm>` |
| `Ising2D.hatY` | `hat(Y)_μ` | `<def_hatY>` |
| `Ising2D.hatZMinus_eq` | `hat(Z)^{(-)}` は一様和 | `<recover_Z_Y_from_hatZ_hatY>` 冒頭 |
| `Ising2D.hatZ_periodic` / `hatY_periodic` | `hat(Z)_{μ+M} = hat(Z)_μ` ほか（一般の `μ`） | `<hatZ_hatY_M_periodicity>` の一般化 |
| `Ising2D.hatZMinus_M_eq_neg_M` / `hatY_M_eq_neg_M` | `hat(Z)_M^{(-)} = hat(Z)_{-M}^{(-)}` ほか | `<hatZ_hatY_M_periodicity>` |
| `Ising2D.inverse_dft` | 離散フーリエ逆変換（任意の族に対する形） | `<recover_Z_Y_from_hatZ_hatY>` Step 1/2 の共通部分 |
| `Ising2D.recover_Y` / `recover_Z` | `∑_μ hat(Y)_μ e^{√-1 m 2πμ/M} = M Y_m` ほか | `<recover_Z_Y_from_hatZ_hatY>` |
| `Ising2D.Y_eq_inverse_dft` / `Z_eq_inverse_dft` | `Y_m = (1/M)∑_μ …` ほか | 同 Step 3 |
| `Ising2D.acomm_hatZ_hatZ_same` | `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I` | `<anticommutator_of_hat_Z_and_hat_Y>` 1 |
| `Ising2D.acomm_hatZ_hatZ_opp` | `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊` | 同 2 |
| `Ising2D.acomm_hatZ_hatY` | `[hat(Z)_μ^{(±)}, hat(Y)_ν]₊ = 0` | 同 3（**原文は「同様」で省略**） |
| `Ising2D.acomm_hatY_hatY` | `[hat(Y)_μ, hat(Y)_ν]₊ = 2M δ^M_{μ+ν,0} I` | 同 4（**原文は「同様」で省略**） |
| `Ising2D.nextSite` | site 添字の巡回 `m ↦ m+1`（`M` で巻き戻る） | `Z_{M+1} := Z_1` の規約 |
| `Ising2D.H1plus` / `Ising2D.H2` | `H_1^{(+)}`, `H_2`（`Ising2D.H1 M η` は境界項の係数を `η` にした補助の一般形） | `def_H1_plus` / `def_H2` |
| `Ising2D.I_smul_H2_eq_sum_sigmaX` | `√-1 H_2 = ∑_m σ^x_m`（`Z_mY_m = -√-1 σ^x_m` の有限和） | `V2_in_Z_Y` Step 2 の直後の等式 |
| `Ising2D.V1plus` | `V_1^{(+)}` の有限和を省略しない定義 | `def_V1_plus` |
| `Ising2D.V1plus_exponential_representation` | `V_1^{(+)}=\exp(iK_1H_1^{(+)})` | `V1_plus_exponential_representation` |
| `Ising2D.V1plusHalf` | `(V_1^{(+)})^{1/2} := \exp((i/2)K_1H_1^{(+)})` | `def_V1_plus_square_root` |
| `Ising2D.V1pmFromDefinition` / `V1pm` / `V1pmHalf` / `V1pm_exponential_representation` | 上の 3 つの、境界項の係数を `η` にした補助の一般形 | （補助。整数運動量の経路と退避した `(−)` セクターの記録が使う） |
| `Ising2D.V2FromJordanWigner` | `V2_in_Z_Y` の右辺 `(2s_2)^{M/2}\exp(iK_2^*\sum_m Z_mY_m)`（`s2`, `K2star` は独立な引数） | `V2_in_Z_Y` |
| `Ising2D.V2H2Form` / `Ising2D.V2FromJordanWigner_eq_V2H2Form` | `V2_exponential_representation` の右辺 `(2s_2)^{M/2}\exp(iK_2^*H_2)`（同上） | `V2_exponential_representation` |
| `Ising2D.V2_in_Z_Y` / `Ising2D.V2_exponential_representation` | **`def_transfer_matrix` の `V_2` について** `V_2 = (2s_2)^{M/2}\exp(iK_2^*\sum_m Z_mY_m) = (2s_2)^{M/2}\exp(iK_2^*H_2)`（`s_2 = \sinh 2K_2`, `K_2^*`、`K_2 > 0`） | `V2_in_Z_Y` / `V2_exponential_representation` |
| `Ising2D.V1_plus_square_root_property` | `((V_1^{(+)})^{1/2})^2 = V_1^{(+)}` | `V1_plus_square_root_property` |
| `Ising2D.V1pmHalf_sq` | 上の補助の一般形 | （補助） |
| `Ising2D.matExpUnits` / `smulUnits` | `exp X` と 0 でないスカラー倍の可逆性 | 補助（原文は暗黙に可逆性を使用） |
| `Ising2D.V1plusUnits` / `V1plusHalfUnits` / `V2H2FormUnits` | `V_1^{(+)}`, `(V_1^{(+)})^{1/2}`, `V2H2Form` を単元 `(TensorPow M)ˣ` として（`V1pmUnits` / `V1pmHalfUnits` は補助の一般形） | 同上（`V2H2Form` には `s_2 > 0` が要る） |
| `Ising2D.isUnit_V1plus` / `isUnit_V1plusHalf` / `isUnit_V2H2Form` | 上記の `IsUnit` 版 | 同上（`Ising2D.isUnit_V1plusHalf` は `V1_plus_half_invertible`） |
| `Ising2D.V2Units` / `Ising2D.isUnit_V2` | **`def_transfer_matrix` の `V_2`** の単元と可逆性（`K_2 > 0`。`EigenvalueProblem/ReductionToATheta/DefinitionVPlus.lean`） | `V2_invertible` |
| `Ising2D.H1JordanWigner` / `sum_sigmaZ_sigmaZ_eq_jordanWigner` / `V1PauliForm_eq_jordanWigner` / `V1_in_Z_Y_epsilon` | `V_1 = exp(iK_1(Y_1Z_2+⋯+Y_{M-1}Z_M-εY_MZ_1))`（最後が `def_transfer_matrix` の `V_1` について） | `V1_in_Z_Y_epsilon` |
| `Ising2D.TConj` | `T_g : X ↦ g X g⁻¹` を **ℂ-代数自己同型**として | `def_T_g` |
| `Ising2D.TConj_linear` / `TConj_trans` | `T_g` の ℂ-線型性、`T_g ∘ T_h = T_{gh}` | `linearity_of_T`, `conjugation_is_ring_homomorphism` (3) |
| `Ising2D.TV` | `T_{(V)}(X) = T_{g_1}(T_{g_2}(T_{g_1}(X)))` | `def_T_V` |
| `Ising2D.TV_eq_TConj` | `T_{(V)} = T_{g_1 g_2 g_1}`（合成則の帰結） | `def_T_V` の系（新規） |
| `Ising2D.TV_linear` / `TV_mul` / `TV_one` | `T_{(V)}` の ℂ-線型性・乗法性・単位性 | `linearity_of_T` |
| `Ising2D.ActsBy` | 行ベクトル記法 `(T z, T y) = (z, y) B` | `T_V_hatZ_hatY` の記法 |
| `Ising2D.ActsBy.comp` | 合成則 `Q P`（原文の `B_1 B_2 B_1` の根拠） | `T_V_hatZ_hatY` の証明 |
| `Ising2D.ActsBy.eigen` | **固有ベクトルの移送**（`B v = λ v ⇒ T(v_0 z + v_1 y) = λ(⋯)`） | 整数運動量の経路（`RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean`）が使う一般補題 |
| `Ising2D.rowMul` / `rowApply` / `actsBy_iff_rowApply_eq_rowMul` | 行ベクトルと `2×2` 行列の積 `(z,y)G`、行ベクトルへの作用 `(Tz,Ty)`、`ActsBy` との同値 | `calc_of_TxT_check_Z_Y` の記法（`commutation_V_plus_check_psi` の結合律と Step 1 が使う） |
| `Ising2D.B1mat` / `B2mat` | `B_1(θ)`, `B_2` | `T_V_hatZ_hatY` の証明 |
| `Ising2D.B1_mul_B2_mul_B1_eq_explicit` | `B_1(θ) B_2 B_1(θ)` の 4 成分の明示計算（5 個の複素パラメータで書いた右辺） | 同上（**双対関係 `c_2^* = s_2^* c_2` が必要**） |
| `Ising2D.duality_c2_star_eq_s2_star_c2`（`EigenvalueProblem/ReductionToATheta/ClaimDualityC2StarEqS2StarC2.lean`） | `K_2 > 0` で `c_2^* = s_2^* c_2`（`s2star_eq_inv_s2`・`c2star_eq_c2_div_s2` を経る人手の三つの鎖）。`IsingParam` の上では `IsingParam.c2_mul_s2star_eq_c2star` として、仮定 `hdual` を埋める | `duality_c2_star_eq_s2_star_c2` |
| `Ising2D.B1_mul_B2_mul_B1_eq_AMat` | `B_1(θ) B_2 B_1(θ) = A(θ)`（`AMat` 版。上を実パラメータ・実 `θ` へ cast したもの） | 同上 |
| `Ising2D.TV_hatZ_hatY_of_action` / `TV_hatZ_hatY_of_action'`（`RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`） | `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用（**`B_1`, `B_2` の作用を仮定**。作用行列は `AMat K θ`） | `T_V_hatZ_hatY` |
| `Ising2D.IsingConst` / `Ising2D.thetaMu` | モデル定数 `c_1, s_1, c_2, c_2^*, s_2^*` と `θ_μ := 2πμ/M` | `def_theta_mu`（`008` part1 の `019`） |
| `Ising2D.gamma1` / `Ising2D.gamma2` / `Ising2D.AMat` | `γ_1(θ)`, `γ_2(θ)`, `A(θ)` | `def_A_theta`、`008` part1 の `020` |
| `Ising2D.AMat_eq` | `A(θ) = !![γ_1, γ_2(θ); -γ_2(-θ), γ_1]` | 同上（原文の書き換えの検算） |
| `Ising2D.gamma2_neg_eq_neg_conj` | `γ_2(-θ) = -conj(γ_2(θ))` | `relation_of_gamma_2` |
| `Ising2D.gamma2_mul_gamma2_neg_eq_neg_normSq` | `γ_2(θ)γ_2(-θ) = -|γ_2(θ)|^2` | 同上 |
| `Ising2D.gamma2_neg_eq_zero_iff` | `γ_2(-θ) = 0 ⟺ γ_2(θ) = 0` | 同上の系 |
| `Ising2D.gamma2_add_int_mul_two_pi` | `γ_2` の `2π` 周期性（後段で必須。`DefinitionCheckFermi.lean` が使う） | `periodicity_of_check_fermi` の (1) の `γ_2` 側 |
| `Ising2D.gamma2_thetaMu_of_dvd` | `M ∣ μ+ν ⇒ γ_2(θ_ν) = γ_2(-θ_μ)`（整数運動量の経路の `DefinitionFermiPsi.lean` だけが使う） | 参照用ノート `integer_momentum_route_not_adopted.ts` へ退避した `gamma2_theta_M_periodicity`（`γ_2(θ_M) = γ_2(θ_{-M})`）の一般形 |
| `Ising2D.gamma2_eq_zero_iff` | `γ_2(θ) = 0 ⟺ s_2^* = 0 ∨ (sin θ = 0 ∧ c_1cos θ = s_1c_2)` | `gamma_2_theta_is_0`（**原文は `s_2^* = 0` を落としている**） |
| `Ising2D.sin_thetaMu_eq_zero_iff` | `sin θ_μ = 0 ⟺ M ∣ 2μ` | 同上（**原文の「⟺ μ = ±M」は不足**） |
| `Ising2D.charPoly_expand` / `charPoly_root` / `charPoly_factor` | 特性多項式 `λ^2 - 2γ_1λ + (γ_1^2 + γ_2γ_2(-θ))` とその根 `γ_1 ± s` | `eigenvector_of_A_theta` 前半 |
| `Ising2D.AMat_mulVec_eigen` / `AMat_mulVec_eigen'` | `s^2 = -γ_2(θ)γ_2(-θ)` のとき `(-s, γ_2(-θ))`, `(γ_2(θ), s)` が固有値 `γ_1+s` の固有ベクトル | `eigenvector_of_A_theta` 後半 |
| `Ising2D.AMat_mulVec_col_pos` / `AMat_mulVec_col_neg` | 原文の `v_± = c(±i√(γ_2γ_2(-θ)), γ_2(-θ))` に対応（固有値は `γ_1 ∓ i t`） | 同上（分枝の突き合わせ） |
| `Ising2D.AMat_of_gamma2_eq_zero` | `γ_2(θ) = 0 ⇒ A(θ) = γ_1(θ) I` | `eigenvector_of_A_theta` の場合分け 1) |
| `Ising2D.det_AMat` | `det A(θ) = γ_1^2 + γ_2(θ)γ_2(-θ)`（無条件） | `det_A_theta` |
| `Ising2D.det_AMat_eq_one` | 上が `1` になるのは `c_1^2-s_1^2 = 1`, `(c_2^*)^2-(s_2^*)^2 = 1`, `c_2s_2^* = c_2^*` の下 | `det_A_theta`（**追加関係が必要**） |
| `Ising2D.lambda_mul_lambda` | `λ_+λ_- = det A(θ)` | `det_A_theta` の第 3 式 |
| `Ising2D.Pmat` / `Ising2D.Dmat` | `P_μ`, `D_μ`（平方根は `t^2 = γ_2(θ)γ_2(-θ)` の仮定として持つ） | `diagonalization_P_D` |
| `Ising2D.det_Pmat` / `det_Pmat_ne_zero` | `det P_μ = i t/(2(√M)^2γ_2(-θ)) ≠ 0`（`P_μ` は可逆） | 同上（原文は可逆性を確認していない） |
| `Ising2D.AMat_mul_Pmat` / `AMat_eq_Pmat_mul_Dmat_mul_inv` | `A P = P D` および `A(θ) = P D P⁻¹` | `diagonalization_P_D` |
| `Ising2D.AMat_thetaMu_eq_Pmat_mul_Dmat_mul_inv` | 上を `θ_μ`, `√M = Real.sqrt M`, `M ≠ 0` で具体化した版 | 同上 |
| `Ising2D.acomm_lin2` | 反交換子の双線型性（2 元の線型結合どうし） | `anticommutator_of_psi` の「双線型性より」 |
| `Ising2D.acomm_hatZMinus_hatY_lin2` | `hat(Z)^{(-)}, hat(Y)` の線型結合どうしの反交換子 | 同上（4 つの反交換関係を代入した形） |
| `Ising2D.sqrtM` / `sqrtM_ne_zero` / `sqrtM_sq` | `√M`（`M ∈ ℕ`）を ℂ の元として（定義は本文の `EigenvalueProblem/DiagonalizationAndExponentialForm/DefinitionCheckFermi.lean` にあり、ここから使う） | `def_fermi` の正規化因子 |
| `Ising2D.psiDag` / `Ising2D.psi` | `ψ_μ^†`, `ψ_μ`（`P_μ` の第 0 列・第 1 列） | `def_fermi` |
| `Ising2D.psiDag_eq` / `psi_eq` | 原文の「すなわち」の明示式と一致すること | `def_fermi` の検算 |
| `Ising2D.t_ne_zero` | `γ_2(θ) ≠ 0` なら `t ≠ 0`（`t^2 = γ_2(θ)γ_2(-θ)`） | `anticommutator_of_psi`（原文は暗黙） |
| `Ising2D.gamma2_neg_mul_gamma2_neg_of_dvd` | `M ∣ μ+ν` ⇒ `γ_2(-θ_μ)γ_2(-θ_ν) = γ_2(θ_μ)γ_2(-θ_μ)` | 同上 |
| `Ising2D.t_sq_eq_of_dvd` | `M ∣ μ+ν` ⇒ `t_ν^2 = t_μ^2`（**分枝は決まらない**） | 同上 |
| `Ising2D.acomm_psiDag_psiDag` / `acomm_psi_psi` | `[ψ_μ^†, ψ_ν^†]₊ = 0`, `[ψ_μ, ψ_ν]₊ = 0` | `anticommutator_of_psi`（**同一分枝の仮定が必要**） |
| `Ising2D.acomm_psiDag_psi` | `[ψ_μ^†, ψ_ν]₊ = δ^M_{μ+ν,0} I` | 同上（**同上**） |
| `Ising2D.AMat_mulVec_Pmat_col_zero` / `..._col_one` | `P_μ` の各列は `A(θ_μ)` の固有ベクトル（固有値は `D_μ` の対角成分） | `commutation_V_psi` |
| `Ising2D.TV_psiDag_of_action` / `TV_psi_of_action` | `T(ψ_μ^†) = λ_{+,μ}ψ_μ^†`, `T(ψ_μ) = λ_{-,μ}ψ_μ`（**`T` の作用を仮定**） | `commutation_V_psi` |
| `Ising2D.TV_psiDag_psi_of_action` | 上を `λ_{±,μ} = γ_1 ∓ i t` の明示形で述べた版 | 同上 |
| `Ising2D.NecSuf.acomm_lincomb` / `NecSuf.acomm_lincomb_clifford` | 反交換関係を満たす 4 元の線型結合の反交換子 `= ((pp'+qq')D)·1`（**必要十分版**、任意の ℂ-代数） | `anticommutator_of_psi` |
| `Ising2D.NecSuf.car_of_coeffs` | 必要十分版 CAR（仮定は反交換関係＋係数のスカラー恒等式 2 本だけ） | 同上 |
| `Ising2D.acomm_hatZMinus_hatY_lin2_of_necSuf`（`ClaimAnticommutatorPsiFromNecSuf.lean`） | `acomm_hatZMinus_hatY_lin2` が必要十分版の特殊化であることの確認 | 同上 |
| `Ising2D.acomm_psi_relations_of_car` | `ψ` の反交換関係 3 式を**必要十分版の系として**導出した版（具体版と同じ主張） | 同上 |
| `Ising2D.acomm_psiDag_psiDag_of_opposite_branch` | **逆分枝 `t_ν = -t_μ` では `[ψ_μ^†, ψ_ν^†]₊ = I`**（同一分枝の仮定が必要なことの証明） | 同上 |
| `Ising2D.acomm_psiDag_psi_of_opposite_branch` | **逆分枝では `[ψ_μ^†, ψ_ν]₊ = 0`**（原文第 2 式が破れる） | 同上 |
| `Ising2D.NecSuf.sinhc` | `sinhc(s) = sinh(s)/s`（`s = 0` では `1`）と冪級数 `Σ s^{2k}/(2k+1)!` | 新規（0 割りを避けるため導入） |
| `Ising2D.NecSuf.lmulCLM` / `rmulCLM` / `adCLM` | 左乗法 `L_X`、右乗法 `R_X`、随伴作用 `ad X = L_X - R_X`（連続 ℂ-線型作用素） | `<def_ad_X_matrix>` |
| `Ising2D.NecSuf.commute_lmulCLM_rmulCLM` | **`L_X` と `R_Y` は可換**（級数展開ルートの核） | `<matrix_exp_conjugation>` の証明の骨格 |
| `Ising2D.NecSuf.exp_lmulCLM` / `exp_rmulCLM` | `exp(L_X) = L_{exp X}`, `exp(R_X) = R_{exp X}` | 同上 |
| `Ising2D.NecSuf.exp_adCLM_apply` | `exp(ad X)(A) = exp(X) A exp(-X)`（**必要十分版**） | `<exp_X_Y_exp_-X>` |
| `Ising2D.NecSuf.hasSum_exp_conj` / `exp_conj_eq_tsum` | 級数 `Σ_n (1/n!) ad_X^n(A)` の収束と和 | 同上 |
| `Ising2D.NecSuf.exp_conj_two_dim_z` / `..._y` | `ad X` が `span{z,y}` を保つときの閉じた形 `cosh(s) z + α sinhc(s) y` | `<extract_taylor_coefficient_of_Z_Y>` の cosh/sinh の根拠 |
| `Ising2D.adPow` | `ad_X^n(A)`（`n` 重の入れ子交換子、人手証明の再帰そのまま） | `<ad_binomial>` の再帰定義 |
| `Ising2D.hasSum_matExp_conj` / `matExp_conj_eq_tsum` | `exp(X) A exp(-X) = Σ_n (1/n!) ad_X^n(A)`（**具体版**、`Mat(2,ℂ)^{⊗M}`） | `<exp_X_Y_exp_-X>` |
| `Ising2D.matExpUnits_conj_eq_tsum` | 上を単元 `matExpUnits X` の共役 `Ad_{exp X}` の形で述べた版 | 同 (3) |
| `Ising2D.matExp_conj_two_dim_z` / `..._y` | 2 次元不変部分空間での閉じた形（具体版） | `<extract_taylor_coefficient_of_Z_Y>` |
| `Ising2D.NecSuf.conj_smul_eq` | `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`（スカラー因子は共役で打ち消える。**必要十分版**、任意の ℂ-代数） | `<ホロノミック量子場_p142下段_1>` の「`(2s_2)^{M/2}` は共役で打ち消し合う」 |
| `Ising2D.NecSuf.twoDimConjMat` / `NecSuf.exp_conj_two_dim_actsBy` | exp 共役の `span{z,y}` への作用行列 `!![cosh s, β sinhc s; α sinhc s, cosh s]`（**必要十分版**） | `<ホロノミック量子場_p142下段_1>` |
| `Ising2D.expPhase_eq_exp_neg_thetaMu` / `expPhase_neg_eq_exp_thetaMu` | `exp(-i2πμ/M) = e^{-iθ_μ}`、`exp(i2πμ/M) = e^{iθ_μ}` | `def_theta_mu` との突き合わせ |
| `Ising2D.B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat`（`EigenvalueProblem/ReductionToATheta/ClaimTActionsOnCheckFromNecSuf.lean`） | 原文の `B_1(θ)`, `B_2` が必要十分版の作用行列に一致すること（`α = i K_1 e^{-iθ}`, `s = K_1` 等） | `<extract_taylor_coefficient_of_Z_Y>` の係数の検算（**原文の誤りは無し**） |
| `Ising2D.actsBy_TConj_matExpUnits` / `actsBy_TConj_smulUnits`（同上） | 上を `ActsBy` の形にした具体版と、スカラー倍した単元でも作用行列が変わらないこと | 同上 |
| `Ising2D.ad_V1pmHalf_hatZMinus` / `ad_V1pmHalf_hatY` / `ad_V2H2Form_hatZMinus` / `ad_V2H2Form_hatY` | `ad((1/2)iK_1H_1^{(-)})` と `ad(iK_2^*H_2)` が `span{Ẑ_μ^{(-)}, Ŷ_μ}` を保つこと | `<commutator_of_H_and_Z_Y>` (1)(3)(4)(6) の帰結 |
| `Ising2D.actsBy_TConj_V1pmHalf` / `actsBy_TConj_V2H2Form` | **`T_{(V_1^{(-)})^{1/2}}`, `T_{V_2}` の作用行列が `B_1(θ_μ)`, `B_2` であること（証明済み。以前は仮定）** | `<ホロノミック量子場_p142下段_1>` |
| `Ising2D.TV_hatZ_hatY` | **原文 `T_V_hatZ_hatY` の無条件版**（`ActsBy` の仮定なし。残るのは `IsingConst` と `K_1,K_2^*` の関係と双対関係 `hdual` だけ） | `<T_V_hatZ_hatY>` |
| `Ising2D.TV_psiDag` / `TV_psi` / `TV_psiDag_psi` | **原文 `commutation_V_psi` の無条件版**（`ActsBy` の仮定なし） | `<commutation_V_psi>` |
| `Ising2D.expPhase_congr` / `hatZ_congr` / `hatY_congr`（`ClaimH1H2ViaHatZHatY.lean`） | 添字が `M` を法として合同なら位相因子・`hat(Z)`・`hat(Y)` は等しい（`M` 周期性の一般形） | `<commutator_of_H_and_Z_Y>` の場合分けの代用 |
| `Ising2D.dvd_succ_sub_iff_eq_nextSite` | `M ∣ (k_1 - k_2 + 1) ⟺ k_2 = nextSite k_1`（原文の 2 通りの場合分けの一意性） | `<H1_H2_via_hatZ_hatY>` |
| `Ising2D.firstSign_nextSite` | `hat(Z)^{(±)}` の `j = 1` の係数と `H_1^{(±)}` の `m = M` の係数が同じ `η` で対応すること | 同上 |
| `Ising2D.H1_eq_hat_sum` / `H2_eq_hat_sum` | `H_1^{(±)} = (1/M)∑_j e^{-i2πj/M} hat(Y)_j hat(Z)^{(±)}_{-j}`、`H_2 = (1/M)∑_j hat(Z)^{(-)}_{-j} hat(Y)_j` | `<H1_H2_via_hatZ_hatY>` |
| `Ising2D.sum_deltaMod_select` | `∑_{j=1}^M δ^M_{μ-j,0} F(j) = F(μ)`（`F` が `M` を法として合同不変なら） | `<commutator_of_H_and_Z_Y>` の 3 通りの場合分けの代用 |
| `Ising2D.sum_hatY` / `sum_expPhase_neg_smul_hatY` | `∑_j hat(Y)_j = M Y_M`、`∑_j e^{i2πj/M} hat(Y)_j = M Y_1` | 同上（**原文が `0` と置いた項の正体**） |
| `Ising2D.hatCliffordTriple` | `hat(Z)^{(η)}, hat(Z)^{(-η)}, hat(Y)` を必要十分版の Clifford 3 族として与える橋渡し | 同上 |
| `Ising2D.lie_H1_hatZ_same` | `[H_1^{(±)}, hat(Z)_μ^{(±)}] = 2e^{-iθ_μ}hat(Y)_μ` | `<commutator_of_H_and_Z_Y>` (1) |
| `Ising2D.lie_H1_hatY` | `[H_1^{(±)}, hat(Y)_μ] = -2e^{iθ_μ}hat(Z)_μ^{(±)}` | 同 (3) |
| `Ising2D.lie_H2_hatZMinus` | `[H_2, hat(Z)_μ^{(-)}] = -2 hat(Y)_μ` | 同 (4) |
| `Ising2D.lie_H2_hatY` | `[H_2, hat(Y)_μ] = 2 hat(Z)_μ^{(-)}` | 同 (6) |
| `Ising2D.lie_H1_hatZ_opp` | `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2e^{-iθ_μ}hat(Y)_μ - 4e^{-iθ_μ}Y_M`（**原文 (2) の訂正版**） | 同 (2) |
| `Ising2D.lie_H2_hatZPlus` | `[H_2, hat(Z)_μ^{(+)}] = -2 hat(Y)_μ + 4e^{-iθ_μ}Y_1`（**原文 (5) の訂正版**） | 同 (5) |
| `Ising2D.Y_ne_zero` | `Y_m ≠ 0`（`Y_m^2 = I` より） | 上 2 件の反証に使用 |
| `Ising2D.lie_H1_hatZ_opp_ne_orig` / `lie_H2_hatZPlus_ne_orig` | **原文 (2), (5) が偽であることの証明** | 同上 |

> **`A(θ)` の二重定義（解消済み・2026-07-26）**: 以前は `A(θ)` が `Ising2D.Amat`
> （`Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean`、5 個の複素パラメータ版）と `Ising2D.AMat`
> （`EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean`、`IsingConst` と実 `θ` の版）の二重定義になっており、
> 名前が大文字小文字違いだけで紛らわしかった。**`AMat` に一本化し `Amat` を削除した。**
> 現在 `A(θ)` の定義は `Ising2D.AMat` ただ 1 つである。
>
> 具体的な変更:
>
> - `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean` が `EigenvalueProblem/ReductionToATheta/DefinitionThetaGamma.lean` を import するようにした
>   （`Definition019` は mathlib 以外に依存しないので循環しない）。
> - `Ising2D.Amat` の定義を削除。`B1_mul_B2_mul_B1_eq_Amat` は
>   **`B1_mul_B2_mul_B1_eq_explicit`**（右辺を `Amat` の代わりに同じ内容の `!![…]` リテラルで書いた版。
>   証明は元のまま）と、それを `AMat` へ移す **`B1_mul_B2_mul_B1_eq_AMat`** の 2 本に分けた。
>   重い行列計算（`maxHeartbeats 2000000`）は前者に閉じている。
> - `TV_hatZ_hatY_of_action` / `TV_hatZ_hatY_of_action'` のステートメントを
>   `(K : IsingConst) … (θ : ℝ)` を取り作用行列が `AMat K θ` になる形へ移した。
> - これにより不要になった橋渡し補題（`RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` 末尾の
>   `Amat_eq_AMat` / `B1_mul_B2_mul_B1_eq_AMat'` / `TV_hatZ_hatY_of_action_AMat`）を削除した。
>   `Amat_eq_AMat` の cast の証明（`Complex.ofReal_cos` / `Complex.ofReal_sin` /
>   `Complex.exp_mul_I` による三角関数の cast）は `B1_mul_B2_mul_B1_eq_AMat` の中へ移してある。
> - `scripts/check-no-sorry.sh` の `targets` から `Ising2D.Amat`,
>   `Ising2D.B1_mul_B2_mul_B1_eq_Amat`, `Ising2D.Amat_eq_AMat`,
>   `Ising2D.B1_mul_B2_mul_B1_eq_AMat'`, `Ising2D.TV_hatZ_hatY_of_action_AMat` を削除し、
>   `Ising2D.B1_mul_B2_mul_B1_eq_explicit`, `Ising2D.B1_mul_B2_mul_B1_eq_AMat` を追加した。

## 章 009〜020 の形式化（2026-07-27）— 章ごとの正本は `lean/docs/`

**分配関数の定義から Onsager の厳密解までの経路が、Lean 側で通った。**
結論は `Ising2D.onsager_exact_solution`（`Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/`）である。

章ごとの詳細——形式化した定理の一覧、具体版と必要十分版の対応表、必要十分版で判明した本質、
形式化できなかった主張とその理由——は、**各章のドキュメントが正本**である。
この README に転記せず、そちらを参照すること。

| 章 | 内容 | Lean | ドキュメント |
| --- | --- | --- | --- |
| 009 | 転送行列 `V` の固有値（個数演算子・同時固有空間分解・`c = (2 sinh 2K_2)^{M/2}`） | `RoutesNotAdopted/IntegerMomentum/`（整数運動量の経路。本文から参照用ノートへ退避済みで、Lean は形式化の記録。トレースの定義と基本性質、エルミート性・正定値性は数学的道具立て「トレース・共役転置・正定値性」の項なので `MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/`） | [ch009](docs/ch009-formalization.md) |
| 010 | 偶セクターへの射影 `P^{(+)}`、`(V_1^{(+)})^{1/2}`, `V^{(+)}`、`ε` との可換性（`(−)` セクターとの分解は形式化の記録） | `PartitionFunction/ProjectionAndJordanWigner/`（`(−)` セクターとの分解の形式化の記録は `RoutesNotAdopted/MinusSector/`） | [ch010](docs/ch010-formalization.md) |
| 011 | 最大固有値（Rayleigh 商の上限による分配関数の挟み撃ち、`c_+ ≤ c`、`ε^⊤ = ε`、`εW = Wε`） | `ThermodynamicLimit/RowLimitAndMaxEigenvalue/`（Rayleigh 商の上限 `c(M)` の定義と分配関数の挟み撃ち）・`ThermodynamicLimit/ColumnLimitAndClosedForm/`（`c_+(M)` の定義・`c_+ ≤ c`・`ε^⊤ = ε`・`εW = Wε`・`W` の成分の正値性）。半正定値形式の Cauchy–Schwarz と実行列の双線型形式・ノルムの補助は `MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/`、参照用ノートへ退避した `c(M) = max(c_+, c_-)` の形式化の記録は `RoutesNotAdopted/MinusSector/` | [ch011](docs/ch011-formalization.md) |
| 012 | 自由エネルギーと熱力学極限（Onsager の表式） | `MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/`（等間隔点の平均の積分への収束は数学的道具立て「三角関数の評価・有限和・積分」の項。`N_row → ∞` の極限は `ThermodynamicLimit/RowLimitAndMaxEigenvalue/`、`γ_1` の下界と `γ(θ)` の定義は `EigenvalueProblem/DiagonalizationAndExponentialForm/`、`Λ^{(δ)}_M` の定義と Onsager の表式は `EigenvalueProblem/EigenvaluesOfVPlus/`、`γ` の連続性は `ThermodynamicLimit/ColumnLimitAndClosedForm/`） | [ch012](docs/ch012-formalization.md) |
| 013 | 偶セクターの半整数運動量モード | `RoutesNotAdopted/ClaimsUnusedByChapterGoals/`（参照用ノートへ退避した `H1_H2_via_check_Z_Y` の形式化の記録。`why_008_applies_only_to_minus_sector` は整数運動量の経路の記録なので `RoutesNotAdopted/IntegerMomentum/`、半整数運動量の定義・反周期指数和・`[H, check(Z/Y)]` は `EigenvalueProblem/ReductionToATheta/`、共役添字・`check(Z/Y)` の反交換関係・`Z, Y` の復元は `EigenvalueProblem/DiagonalizationAndExponentialForm/`） | [ch013](docs/ch013-formalization.md) |
| 014 | 偶セクターでの `T` の作用 | `EigenvalueProblem/ReductionToATheta/` | [ch014](docs/ch014-formalization.md) |
| 015 | `A(θ~)` の対角化 | `EigenvalueProblem/DiagonalizationAndExponentialForm/` | [ch015](docs/ch015-formalization.md) |
| 016 | 偶セクターのフェルミオン（`V^{(+)} = c V̌'`） | `EigenvalueProblem/DiagonalizationAndExponentialForm/` | [ch016](docs/ch016-formalization.md) |
| 017 | 偶セクターの固有値 | `EigenvalueProblem/EigenvaluesOfVPlus/`（`V̌'` の固有値と `Λ̌_max` の単純性は `EigenvalueProblem/DiagonalizationAndExponentialForm/`） | [ch017](docs/ch017-formalization.md) |
| 018 | 偶セクターの完結（**`onsager_exact_solution`**） | `EigenvalueProblem/EigenvectorOfMaxEigenvalue/`（`Q̌_ε` のエルミート性と章「M→∞ の極限と閉形式」に当たるファイルは `ThermodynamicLimit/ColumnLimitAndClosedForm/`） | [ch018](docs/ch018-formalization.md) |
| 019 | 最大固有値の所在（`c(M) = c_+(M)`。**章ごと参照用ノートへ退避済み。Lean は形式化の記録**） | `RoutesNotAdopted/MinusSector/` | [ch019](docs/ch019-formalization.md) |
| 020 | 臨界点での比熱の対数発散 | `CriticalPoint/CriticalPointAndLogDivergence/`（`cosh, sinh` の加法定理は数学的道具立て「実数の平方根・指数関数・双曲線関数」の項なので `MathematicalTools/RealSquareRootExponentialAndHyperbolicFunctions/`、正弦およびそれを含む積分の評価は数学的道具立て「三角関数の評価・有限和・積分」の項なので `MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/`） | [ch020](docs/ch020-formalization.md) |

### 2 本立てが出した最大の答え

**整数運動量版（章 004〜009）と半整数運動量版（章 013〜017）は、同じ必要十分版の別の特殊化である。**

- `e^{-iθ~}` は 1 の原始 `2M` 乗根 `ξ` であり、半整数運動量とはその**奇数周波数** `ξ^{j(2μ-1)}`、
  整数運動量とは `ζ = ξ^2` の偶数周波数のことである。本文が「仕組みは 1 つの等式
  `e^{-iMθ~} = -1` に集約される」と書く等式の正体は `ξ^M = -1` で、その証明は
  「`(ξ^M)^2 = 1` かつ原始性から `≠ 1`、体だから `-1`」の 3 行である。
  指数関数も円周率も効いていない（`NecSuf/AntiperiodicFourier.lean`）。
- 対の添字が `μ+ν ≡ 0` から `≡ 1` へずれる理由は `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` の 1 点だけ。
- 章 013・014・017 の大半は、章 004〜009 の必要十分版をそのまま特殊化して得られた
  （逆離散 Fourier 変換だけは新設が必要だったが、骨格は同一）。

### 半整数運動量で消える例外処理

**半整数運動量では `γ_2(θ~_μ) ≠ 0` が常に成り立つ**（`Ising2D.gamma2_thetaTilde_ne_zero`、章 015）。
`sin θ~_μ = 0` となるのは `θ~_μ = π`（`M` 奇数）だけで、そのとき `-c_1 = s_1 c_2 > 0` で矛盾する。
したがって整数運動量にあった臨界点の例外処理（`μ = M` の除外、`m = M-1`）は偶セクターでは不要である。
さらに、章 008 で問題になった**平方根の分枝の一致**（原文の穴）も、半整数運動量では係数が
非負実数 `|γ_2(θ~_μ)|` になるため**生じない**（`lean/docs/ch016-formalization.md`）。

### 実数解析へ移行した箇所（README 2 節の要求）

- 章 012 の `riemann_sum_to_integral` ただ 1 つで、外部から持ち込むのは Heine–Cantor と
  連続関数の Riemann 可積分性の 2 つ（ただし `γ` の連続性を示すのに `cos` / `√` / `log` の
  連続性も使っており、本文の「2 つだけ」という記述は不正確。`docs/tasks/` に記録済み）。
- 章 020（臨界点）は別途 (R3)〜(R6) を持ち込む。うち mathlib に原文の形で無いのは
  **(R5)（連続性だけを仮定した積分記号下の微分）だけ**である。

### 形式化の過程で見つかった人手証明の問題

**本文は一切編集していない**（本文の修正は別セッションの担当）。指摘は
`docs/tasks/2026-07_lean-ch009-013/` に一次情報つきで記録した（13 件）。
結論を覆す誤りは見つかっていない。内訳は、添字指定の誤り（章 011 の `trace_power_sandwich`
Step 2。結論は正しい）、根拠の欠落（章 011 の `c_±(M)` の `sup` が定義できること。
章 019 が `𝓕^{(-)}` 側を埋めた）、記述の不正確さ（章 012 の「外部事実は 2 つだけ」）、
過剰な仮定・冗長な手順（章 011・014・017・018・019・020）である。

## 形式化の過程で見つかった原文の問題

| 箇所 | 問題 | 対応 |
| --- | --- | --- |
| `parts/002_線型空間の一般論/000_theorem_...`（`<tensor_basis>`） | 「各元が基底」「添字 `m` の二重使用」 | `Ising2D/MathematicalTools/KroneckerProductAndMultiFactorBasis/TheoremTensorBasis.lean` 冒頭に修正版を明記 |
| `parts/004_転送行列/000_definition_...`（`<def_transfer_matrix_symbols>`） | `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の `+` は**積の誤り**（`M = 2` で反例） | `Ising2D/PartitionFunction/ProjectionAndJordanWigner/DefinitionTransferMatrixSymbols.lean` 冒頭に記載。`Z_mul_Y_same`（`Z_m Y_m = -√-1 σ^x_m`）と `xString_succ_eq` が積であることの根拠 |
| `parts/006_ZとYの反交換関係/000_claim_...`（`<anticommutator_of_Z_and_Y>`） | `[Z_μ, Y_ν]₊`, `[Y_μ, Y_ν]₊` の証明が TODO のまま | Lean 側で 3 式とも証明済み（`Ising2D/EigenvalueProblem/ReductionToATheta/ClaimAnticommutatorZY.lean`） |
| `parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` | 形式化時点で証明が「TODO: 証明略」のままだった（その後、別経路の人手証明が追記されている）。また線型独立性は**族**の性質なのに集合 `{Z_1,…,Y_M}` で述べている | Lean 側で証明済み（`Ising2D/ThermodynamicLimit/ColumnLimitAndClosedForm/ClaimZYLinearlyIndependent.lean`）。族の形（`ZY_linearIndependent`）と集合の形（`ZYSet_linearIndepOn`）の両方を用意 |
| `parts/007_hatZとhatYの反交換関係/000_claim_...`（`<anticommutator_of_hat_Z_and_hat_Y>`） | `[hat(Z), hat(Y)]₊` と `[hat(Y), hat(Y)]₊` を「同様」として省略（原文自身が省略と明記） | Lean 側で 4 式とも証明済み（`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimAnticommutatorHatZHatY.lean`） |
| `transfer_matrix_001_definition_symbols` と `transfer_matrix_011d_claim_V2_exponential_representation`（`V_2` の 2 つの表式） | （形式化時点）一方は `exp(K_2^*(σ^x_1+⋯+σ^x_M))`、他方は `exp(√-1 K_2^* H_2)` と書かれているが、一致の根拠（`√-1 Z_m Y_m = σ^x_m`）が明示されていなかった | **解消済み**。現在の本文は `V2_in_Z_Y` の Step 2 の直後にこの等式を置き、Step 3 で `second_transfer_matrix_pauli_form` から `V_2` の Jordan--Wigner 表示を導く。Lean は `I_smul_H2_eq_sum_sigmaX`（`PartitionFunction/ProjectionAndJordanWigner/DefinitionH1H2V1V2.lean`）と `V2_in_Z_Y`（`PartitionFunction/ProjectionAndJordanWigner/ClaimV2InZY.lean`） |
| `TV1_hatZ_hatY_017_definition_A_theta`（`def_A_theta`）と `TV1_hatZ_hatY_018_claim_T_V_action`（`T_V_hatZ_hatY`） | `A(θ)` の非対角成分に `c_2` が現れるが、`B_1 B_2 B_1` を計算すると同じ位置に出るのは `c_2^*` である。一致には双対関係から従う等式 `c_2^* = s_2^* c_2` が要るのに、原文はどこにも書いていない | `Ising2D/MathematicalTools/InvertibleMatricesLinearMapCorrespondenceAndConjugation/DefinitionTgAndTV.lean` 冒頭に記載。`B1_mul_B2_mul_B1_eq_explicit` / `B1_mul_B2_mul_B1_eq_AMat` の仮定 `hdual` として明示 |
| `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（`ホロノミック量子場_p142下段_1`） | （かつて）ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）に依存し、本リポジトリでは未形式化だった | **解消済み（2026-07-26）**。`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean` の `actsBy_TConj_V1pmHalf` / `actsBy_TConj_V2H2Form` として証明した。係数を独立に導出して原文の `cosh K_1`, `±i e^{∓iθ_μ} sinh K_1`, `cosh 2K_2^*`, `±i sinh 2K_2^*` と突き合わせた結果、**原文の誤りは無かった**（`B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat`） |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_022`（`gamma_2_theta_is_0`） | 形式化時点の原文は `γ_2(θ_μ) = 0` の同値条件で **`s_2^* = 0` の場合を落としていた**（`γ_2` は `s_2^*` を因子に持つ）。また「`sin θ_μ = 0 ⟺ μ = ±M`」は単独では偽で、正しくは `M ∣ 2μ`（`M` が偶数なら `μ = ±M/2` も該当） | **並行して原文側が修正済み**（現在は `K_1, K_2 ∈ ℝ_{>0}` を前提に置き、`μ = ±M/2` が排除される理由も明記）。Lean 側は `gamma2_eq_zero_iff` と `sin_thetaMu_eq_zero_iff` として機械的裏づけを残した |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_035`（`det_A_theta`） | `det A(θ_μ) = 1` は `A(θ)` の定義からは出ず、**`c_2 s_2^* = c_2^*`（双対関係の帰結）が要る**。原文は `A = B_1B_2B_1` からこれを出しているが、`B_1, B_2` には `c_2^*, s_2^*` しか現れず `c_2` は展開の結果 `c_2^*/s_2^*` として出る。つまり (iii) は `factorization_of_A_theta`（proof が原文では TODO）に埋め込まれた前提 | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimEigenvectorsAndDiagonalizationOfATheta.lean` の `det_AMat`（無条件）と `det_AMat_eq_one`（3 関係を仮定）に分離 |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_027`（`eigenvector_of_A_theta`） | 固有値と固有ベクトルの符号対応（`λ_± = γ_1 ± √(-γ_2γ_2)` と `v_± = c(±i√(γ_2γ_2), γ_2(-θ))`）は、**`arg^{[0,2π)}` 分枝での `√(-1·z) = -√(-1)√z` を使ってはじめて整合する**。原文は proof 中でこの分枝規約を導いているが statement 側に分枝の指定が無い | 検算の結果**原文は正しい**。Lean 側は平方根関数を使わず `t^2 = γ_2(θ)γ_2(-θ)` の仮定形にし、`i t` 側の固有値が `γ_1 - i t` であることを明示（`AMat_mulVec_col_pos`） |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_028`（`diagonalization_P_D`） | `A(θ_μ) = P_μ D_μ P_μ^{-1}` と書くが、**`P_μ` が可逆であること（`det P_μ ≠ 0`）を確認していない** | `det_Pmat` / `det_Pmat_ne_zero` で `det P_μ = i t/(2(√M)^2γ_2(-θ_μ))` を計算し、`γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で非零を証明 |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_032`（`anticommutator_of_psi`） | `M ∣ μ+ν` のとき、原文は `√(γ_2(θ_ν)γ_2(-θ_ν)) = √(γ_2(θ_μ)γ_2(-θ_μ))` を根号の中身が等しいことだけから使っている。**中身が等しいことから従うのは `t_ν = ±t_μ` までで、`μ` と `ν` で分枝が同じであることは自明でない。**検算の結果、逆分枝だと 3 式のうち第 1・第 2 式が偽になる（`t_μ ≠ 0` なので符号は結論に効く） | `Ising2D/RoutesNotAdopted/IntegerMomentum/DefinitionFermiPsi.lean` 冒頭に検算を記載。同一分枝の選択を仮定 `hbr : (M:ℤ) ∣ (μ+ν) → tν = tμ` として明示 |
| `008_TV1_hatZ_hatY_part1.mjs` の `TV1_hatZ_hatY_001`（`commutator_of_H_and_Z_Y`）の第 2 式 | `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2e^{-iθ_μ}hat(Y)_μ` は**偽**。原文自身が最終段で余分な項 `-(4/M)e^{-iθ_μ}∑_{k=1}^M Y_k M δ^M_{(k,0)}` を持ちながら、それを `0` と置いて結論している。`k ∈ {1,…,M}` で `δ^M_{(k,0)} = 1` になるのは `k = M` なので、この項は `-4e^{-iθ_μ}Y_M` であり消えない（原文ブロックの `conversion.notes` にも「正当化が不完全」と記録済み） | `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean` 冒頭に記載。訂正版を `lie_H1_hatZ_opp` として証明し、原文の主張が偽であることを `lie_H1_hatZ_opp_ne_orig` で証明した |
| 同ブロックの第 5 式（`[H_2, hat(Z)_μ^{(+)}]`） | 原文の値 `-2hat(Y)_μ + (1/M)∑_j(-2e^{-i(2π/M)(-j+μ)}hat(Y)_j)` は**偽**。`-[hat(Z)_μ^{(+)}, hat(Z)_{-j}^{(-)}]₊` の展開でマイナス符号を第 1 項にしか分配しておらず（第 2 項の符号が変わっていない）、さらに次の行で係数 `4` が `2` になっている。正しくは `-2hat(Y)_μ + 4e^{-iθ_μ}Y_1`（`hat(Z)^{(+)}_μ = hat(Z)^{(-)}_μ - 2e^{-iθ_μ}Z_1` と `[H_2, Z_1] = -2Y_1` からの独立な検算でも一致） | 同上。訂正版を `lie_H2_hatZPlus`、原文が偽であることを `lie_H2_hatZPlus_ne_orig` で証明した。**後段（`nesting_of_commutator_of_H_and_Z` 以降）が使うのは (1)(3)(4)(6) の 4 本だけ**なので、この誤りは後段の結論には波及しない |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_031`（`commutation_V_psi`） | 原文の証明は `T_V_hatZ_hatY`（かつて未形式化）に依存する | **解消済み（2026-07-26）**。`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean` の `TV_psiDag` / `TV_psi` / `TV_psiDag_psi` が無条件版。`DefinitionFermiPsi.lean` の仮定つき版（`T` が任意の線型写像の一般形）も残してある |

## 今後の方針

- **章 009〜020 は形式化済み（2026-07-27）**。本文の全 20 章のうち、機械証明が無い章は無くなった。
  結論は `Ising2D.onsager_exact_solution`。残っている作業は各章のドキュメント
  （`lean/docs/ch0NN-formalization.md`）の「形式化できなかった主張とその理由」節にまとまっている。
  主なものは、(a) 同時固有空間分解の `DirectSum.IsInternal` 形と「対角化可能」の主張
  （原文に無い `Submodule` 言語への翻訳が必要。後段が使う固有値と重複度は形式化済み）、
  (b) `tr(εV^{(+)})` を配置基底で直接計算する枝（章 018。主鎖とは独立な組合せ論的計算）。
- **次の形式化対象**（人手証明側で自己完結しており依存が浅い順）
  1. ~~`transfer_matrix_012_claim_H1_H2_via_hatZ_hatY`（`<H1_H2_via_hatZ_hatY>`）~~ **形式化済み**
     （`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimH1H2ViaHatZHatY.lean`）
  2. ~~`parts 008` の 001〜005（`exp(X) Y exp(-X)` の級数展開と**ネストした交換子の
     テイラー係数抽出**）、およびそこから `T_V_hatZ_hatY` / `commutation_V_psi` を
     無条件の定理にすること~~ **完了（2026-07-26）**。
     `<exp_X_Y_exp_-X>` と `ad X` が 2 次元部分空間を保つ場合の閉じた形（cosh/sinhc）は
     `Ising2D/NecSuf/ExpConjugation.lean` と `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimExpConjugation.lean`、
     `<commutator_of_H_and_Z_Y>` は `Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimCommutatorHAndHatZHatY.lean`
     （必要十分版は `Ising2D/NecSuf/CommutatorClifford.lean`）。
     この 2 つを `matExp_conj_two_dim_z` / `..._y` に代入して
     `<extract_taylor_coefficient_of_Z_Y>` / `<ホロノミック量子場_p142下段_1>` の
     `B_1(θ_μ)`, `B_2` を導き（`Ising2D/RoutesNotAdopted/IntegerMomentum/ClaimTVActionsOnHatZHatY.lean`、必要十分版は
     `Ising2D/NecSuf/TVAction.lean`）、`Ising2D.TV_hatZ_hatY_of_action` の仮定
     `hT1`, `hT2` と `Ising2D.TV_psiDag_of_action` / `TV_psi_of_action` の仮定 `hT` を
     除去した無条件版 `Ising2D.TV_hatZ_hatY` / `TV_psiDag` / `TV_psi` / `TV_psiDag_psi` を得た。
     **これにより「未形式化に由来する仮定」は本リポジトリから無くなった。**
     残っている非自明な仮定は次の 2 種類だけで、いずれも**数学的に必要**なものである。
     - `ψ` の反交換関係の `hbr`（平方根の分枝の選択）— **原文の穴**に由来
     - `B_1B_2B_1 = A(θ)` の `hdual : s_2^* c_2 = c_2^*`（双対関係の帰結）と、
       `IsingConst` の成分が `K_1, K_2^*` の双曲線関数であること — **原文が明示していない前提**

     いずれも上の「原文の問題」表を参照
  3. ~~`V_1` を `Z, Y, ε` で表す表式（`V1_in_Z_Y_epsilon`）と、`V_2` を `Z, Y` で表す表式
     （`V2_in_Z_Y`）~~ **形式化済み**。前者は `Ising2D/PartitionFunction/ProjectionAndJordanWigner/ClaimV1InZYEpsilon.lean`、後者は
     `Ising2D/PartitionFunction/ProjectionAndJordanWigner/ClaimV2InZY.lean`（いずれも `def_transfer_matrix` の `V_1, V_2` についての主張）。
  4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。
     現状は再帰形 `xString_succ_eq` まで。順序つき積（`List.prod` / `Finset.noncommProd`）の
     整備が要る
- **mathlib に無いことが分かっているもの**
  - ~~`Real.arccosh`（自前定義が必要）~~ **これは誤りだった（2026-07-27 に訂正）**。
    現行 mathlib（v4.32.1）には `Real.arcosh`（`arccosh` ではない綴り）が同じ定義式で存在する。
    章 012 の形式化で確認済み（`Ising2D/NecSuf/Arcosh.lean`, `lean/docs/ch012-formalization.md`）。
  - **等分割リーマン和から積分への収束**（`(1/M)∑ g(t_μ) → (1/(b-a))∫g`）。
    これは本当に無い（章 012 で grep により確認）。自前に証明した
    （`Ising2D/NecSuf/RiemannSum.lean` の `tendsto_riemann_sum`）。
    使う外部事実は Heine–Cantor と連続関数の可積分性だけで、いずれも mathlib にある。
  - **連続性だけを仮定した積分記号下の微分**（章 020 が持ち込む (R5)）。
    mathlib にあるのは可測性・優関数の仮定つきの形で、原文が宣言する形そのままは無い
    （`lean/docs/ch020-formalization.md`）。
  - **トレースが「閉じた道の総和」であること**（`tr(A^{n+1}) = ∑ ...`）。無いので自前に証明した
    （`Ising2D/NecSuf/*`、章 010）。
  - `sinh t ≤ t cosh t`（章 020 で使う初等評価。他の初等評価はすべて mathlib にある）。
  - 一般の `Ad(exp X) = exp(ad X)`。ただし本プロジェクトは級数展開ルート
    （`parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003, 007`）を持つので回避可能。
    **回避済み**: `Ising2D/NecSuf/ExpConjugation.lean` で、リー環を使わず
    「`L_X` と `R_X` が可換」＋「可換な作用素の指数法則 `NormedSpace.exp_add_of_commute`」
    だけから証明した。
  - `sinhc`（`sinh s / s` を `s = 0` へ延長したもの）。自前定義した
    （`Ising2D.NecSuf.sinhc`）。`Complex.hasSum_cosh` / `Complex.hasSum_sinh` は
    `Mathlib.Analysis.SpecialFunctions.Trigonometric.Series` にある。
- **leanblueprint の導入検討**: 人手証明（Typst / 構造化TeX）と Lean の対応を機械的に追跡し、
  未形式化箇所を可視化する。導入の前提として、`docs/tasks/2026-07_toolchain-and-rigor` の
  Phase 2（構造化TeX への全面移行）の完了状況を確認する必要がある
  （leanblueprint は LaTeX ベースなので、移行後のソースに対して張るのが自然）。
