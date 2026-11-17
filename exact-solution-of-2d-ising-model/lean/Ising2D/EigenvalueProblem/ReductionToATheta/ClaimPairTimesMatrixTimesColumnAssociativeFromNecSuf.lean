/-
# 行列の組と 2×2 行列と数の列の積の結合律（具体版を必要十分版から導く）

具体版 `ClaimPairTimesMatrixTimesColumnAssociative.lean` の主張を、必要十分版
`Ising2D/NecSuf/PairTimesMatrixTimesColumnAssociative.lean` の `NecSuf.rowMul2Col_rowMul2_assoc` の
係数 `R := ℂ`、加群 `α := Matrix ι ι ℂ` の特殊化として得る（具体版の `rowMulCol`・`rowMul` は、必要十分版の `rowMul2Col`・`rowMul2` を
この特殊化に取ったものと定義の展開で一致する）。人手のラベルは
`pair_of_matrices_times_matrix_times_column_associative`。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.ClaimPairTimesMatrixTimesColumnAssociative
import Ising2D.NecSuf.PairTimesMatrixTimesColumnAssociative

namespace Ising2D

open Matrix

/-- `pair_of_matrices_times_matrix_times_column_associative` を `NecSuf.rowMul2Col_rowMul2_assoc`
（`R := ℂ`、`α := Matrix ι ι ℂ`）の特殊化として得る。 -/
theorem rowMulCol_rowMul_assoc_of_necSuf {ι : Type*} (A B : Matrix ι ι ℂ)
    (P : Matrix (Fin 2) (Fin 2) ℂ) (v : Fin 2 → ℂ) :
    rowMulCol (rowMul (A, B) P) v = rowMulCol (A, B) (P *ᵥ v) :=
  NecSuf.rowMul2Col_rowMul2_assoc (R := ℂ) A B P v

end Ising2D
