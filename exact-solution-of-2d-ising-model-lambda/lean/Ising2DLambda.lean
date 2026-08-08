/-
2次元 Ising 模型の厳密解（Λ・Fisher 零点の立場）の形式検証の入口。

人手証明の正本は `structured-latex/content/`。ここに置く証明は次の 2 本立てにする。
  具体版      : `Ising2DLambda.<章名>`        人手証明と 1 対 1 に対応させる
  必要十分版  : `Ising2DLambda.NecSuf.<章名>` 同じ手順のまま仮定だけ必要十分にする
規約は `lean/README.md` を正本とする。

住処の規約: 人手証明のブロックが可算な住処を宣言しているなら、対応する具体版に
`ℝ` / `ℂ` を出さない（数え上げは `ℕ`、分配多項式は `Polynomial ℤ`）。
非可算を宣言したブロックの証明だけが `ℝ` / `ℂ` を使ってよく、
その場合はファイル冒頭に人手証明の `realEscape` と同じ理由を書く。

現状: 章「分配多項式」の定義 4 件と主張 3 件
（人手証明のラベル `claim_configuration_partition`・`claim_coefficient_representation`・
`claim_coefficient_sum`）、および章「有限系の自由エントロピー」の定義 4 件と主張 2 件
（`claim_rational_exponent_well_defined`・`claim_value_at_rational_is_positive`）を形式化済み。
-/
import Ising2DLambda.PartitionPolynomial.Basic
import Ising2DLambda.PartitionPolynomial.CoefficientSum
import Ising2DLambda.NecSuf.PartitionPolynomial.CoefficientSum
import Ising2DLambda.PartitionPolynomial.CoefficientSumFromNecSuf
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation
import Ising2DLambda.NecSuf.PartitionPolynomial.CoefficientRepresentation
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentationFromNecSuf
import Ising2DLambda.FreeEntropy.Basic
import Ising2DLambda.FreeEntropy.RationalExponent
import Ising2DLambda.NecSuf.FreeEntropy.RationalExponent
import Ising2DLambda.FreeEntropy.RationalExponentFromNecSuf
import Ising2DLambda.FreeEntropy.ValuePositive
import Ising2DLambda.NecSuf.FreeEntropy.ValuePositive
import Ising2DLambda.FreeEntropy.ValuePositiveFromNecSuf
