/-
「Kac--Ward 行列式は符号付き偶部分グラフ多項式の平方に等しい」
（`claim_determinant_signed_even_subgraph_square`）の具体版。実際の反対称行列 `K^as`
（`gaugedTerminalMatrix L z s`）を介して

  `D^{a,b}_L(x) = (Q^{a,b}_L)^2`（右辺は `ℤ[x]` の多項式を係数の包含 `ℤ ↪ Qbar` で送ったもの）

を、本文の式鎖の順に示す。

  人手証明                                               このファイル・引く具体版
  準備（K^as は零対角反対称）                            `gaugedTerminalMatrix_diagonal_zero`・
                                                          `gaugedTerminalMatrix_skew`
  一行目（claim_gauged_terminal_matrix_determinant）     `gaugedTerminalMatrix_determinant`
  二行目（claim_qbar_polynomial_pfaffian_square_
    determinant）                                        `qbarPolynomialPfaffian_sq_eq_det`
  三行目（claim_pfaffian_signed_even_subgraph）          `gaugedPfaffian_eq_signedEvenSubgraphPolynomial`

本文の `(a,b) ∈ 𝒮` は `SpinStructure = Bool × Bool` で持ち、`Q^{a,b}_L` の側の `Fin 2` とは
`spinComponentFin` で結ぶ。本文の `ζ_8` は `z ^ 4 = -1` を満たす `z : Qbar` で受ける。
住処は有限集合・`ℤ`・`Qbar`・`Qbar[X]` で、ℝ / ℂ は現れない。必要十分版を呼ばない。
-/
import Ising2DLambda.KacWard.PfaffianSignedEvenSubgraph
import Ising2DLambda.KacWard.GaugedTerminalMatrixDeterminant
import Ising2DLambda.KacWard.GaugedTerminalSkew
import Ising2DLambda.AlgebraicEigenvalue.PfaffianDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
open scoped Classical

variable {L : ℕ} [NeZero L]

/-- 準備: `K^as` は零対角反対称行列である（`claim_gauged_terminal_matrix_skew`）。 -/
theorem gaugedTerminalMatrix_isZeroDiagonalSkew (z : Qbar) (hz : z ^ (4 : ℕ) = -1)
    (s : SpinStructure) :
    IsZeroDiagonalSkewQbarPolynomialMatrix (gaugedTerminalMatrix L z s) :=
  ⟨fun e => gaugedTerminalMatrix_diagonal_zero L z s e,
    fun e f => gaugedTerminalMatrix_skew L z hz s f e⟩

/-- `claim_determinant_signed_even_subgraph_square` の具体版: `D^{a,b}_L = (Q^{a,b}_L)^2`。 -/
theorem kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    kacWardDeterminant (kacWardTransitionMatrix L z s) =
      ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) ^ 2 := by
  calc kacWardDeterminant (kacWardTransitionMatrix L z s)
      = Matrix.det (gaugedTerminalMatrix L z s) :=
        -- 一行目: `claim_gauged_terminal_matrix_determinant`
        (gaugedTerminalMatrix_determinant L z hz s).symm
    _ = qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) ^ 2 :=
        -- 二行目: `claim_qbar_polynomial_pfaffian_square_determinant`
        (qbarPolynomialPfaffian_sq_eq_det _ (gaugedTerminalMatrix_isZeroDiagonalSkew z hz s)).symm
    _ = ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
          (Int.castRingHom Qbar)) ^ 2 := by
        -- 三行目: `claim_pfaffian_signed_even_subgraph`
        rw [gaugedPfaffian_eq_signedEvenSubgraphPolynomial z hz s]

end Ising2DLambda.KacWard
