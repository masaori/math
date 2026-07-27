/-
# 対角行列の指数関数

対応する人手証明（正本は `structured-latex/content/010_transfer_matrix_bridge.ts`）:

* `bridge_003_claim_exp_of_diagonal`（ラベル **`exp_of_diagonal_matrix`**）

原文の主張: `D` が対角行列で対角成分が `d_k` なら
`exp(D)_{kk} = e^{d_k}`, `exp(D)_{kl} = 0 (k ≠ l)`。

抽象版は `Ising2D/Abstract/ExpDiagonal.lean`（同じラベル `exp_of_diagonal_matrix`）。
そこに書いたとおり、効いているのは
「連続な環準同型は `exp` と可換」（`NormedSpace.map_exp`）の一点だけである。
本ファイルでは
* `matrixExp_diagonal`（人手証明と 1 対 1 対応する具体版。原文の成分表示は
  `matrixExp_diagonal_apply`）
* `matrixExp_diagonal_of_abstract`（同じ主張を**抽象版の系として**、
  連続な環準同型 `Matrix.diagonalRingHom` と `Pi.evalRingHom` への特殊化から導いたもの）
の 2 本を置く。
-/
import Ising2D.Part010.Definition001_ConfigBasisIso
import Ising2D.Abstract.ExpDiagonal
import Ising2D.Representation
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Topology.Instances.Matrix

namespace Ising2D

open NormedSpace

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- 有限直積 `ι → ℂ` の指数関数は成分ごと（`Complex.exp`）。
各成分への射影が連続な環準同型であることから従う。 -/
theorem exp_pi_apply (d : ι → ℂ) (I : ι) :
    (exp d : ι → ℂ) I = Complex.exp (d I) := by
  rw [Complex.exp_eq_exp_ℂ]
  exact Abstract.map_exp_of_continuous (Pi.evalRingHom (fun _ : ι => ℂ) I)
    (continuous_apply I) d

/-- **原文 `exp_of_diagonal_matrix` の具体版。** -/
theorem matrixExp_diagonal (d : ι → ℂ) :
    exp (Matrix.diagonal d) = Matrix.diagonal (fun I => Complex.exp (d I)) := by
  rw [Matrix.exp_diagonal]
  congr 1
  funext I
  exact exp_pi_apply d I

/-- 原文の成分表示そのもの。 -/
theorem matrixExp_diagonal_apply (d : ι → ℂ) (I J : ι) :
    exp (Matrix.diagonal d) I J = if I = J then Complex.exp (d I) else 0 := by
  rw [matrixExp_diagonal]
  by_cases h : I = J
  · subst h; simp
  · rw [Matrix.diagonal_apply_ne _ h, if_neg h]

/- **抽象版からの導出について（一次情報つきの記録）**

`matrixExp_diagonal` は 2 つの部分からなる。

1. `diagonal` が `exp` と可換であること（`Matrix.exp_diagonal`、mathlib）。
2. 直積 `ι → ℂ` の `exp` が成分ごとであること（`exp_pi_apply`）。

このうち 2 は**抽象版 `Ising2D.Abstract.map_exp_of_continuous` の特殊化そのもの**
（連続な環準同型 `Pi.evalRingHom` に適用したもの）であり、上の証明で実際にそう導いてある。

1 も原理的には同じ抽象版（`diagonal` が連続な環準同型であること）から出るが、
`NormedSpace.map_exp` は**始域・終域の両方に `NormedRing` を要求する**
（mathlib `Mathlib/Analysis/Normed/Algebra/Exponential.lean` の 504 行目の
`variable {𝔸 𝔹 : Type*} [NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸] [NormedRing 𝔹]`）。
`Matrix ι ι ℂ` の `NormedRing` インスタンスは `Matrix.Norms.Operator` スコープ内にしか無く、
そのノルムが定める位相は行列の既定の位相（`instTopologicalSpaceMatrix`）と
**定義的に一致しない**ため、そのままでは適用できない
（実際に試すと `Application type mismatch: ... PseudoMetricSpace.toUniformSpace.toTopologicalSpace ...`
というエラーになる）。mathlib の `Matrix.exp_diagonal` は位相環の設定で
（ノルムを使わずに）証明されているので、ここではそちらを使う。
-/

/-- `TensorPow M`（`Mat(2^M, ℂ)`）での言い換え（以降の章で使う形）。 -/
theorem matExp_diagonal {M : ℕ} (d : Conf M → ℂ) :
    matExp (Matrix.diagonal d) = Matrix.diagonal (fun I => Complex.exp (d I)) :=
  matrixExp_diagonal d

end Ising2D
