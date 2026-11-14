/-
章「複素行列環」の、2 進の番号付けによる、部分集合全体で添字づけた行列環と番号で添字づけた行列環の同型の具体版。
人手証明と 1 対 1 に対応させる。

  本文のラベル                                                    このファイル
  theorem_binary_numbering_gives_isomorphism_of_matrix_algebras   binaryReindexMatrix（ν_{e_M}）・binaryInverseReindexMatrix（μ_{e_M}）・
                                                                  binaryReindex_isomorphism（列挙した二つの主張）・
                                                                  binaryReindexMatrix_injective（単射であること）・
                                                                  binaryReindexMatrix_surjective（全射であること）・
                                                                  binaryReindexMatrix_eq_iff（ν_{e_M}(F) = G を満たすただ一つの F は μ_{e_M}(G)）

X := P_M が有限集合であることは `isFiniteSet_powerSet M`、(2^M, e_M) が P_M の番号付けであることは
`binaryNumbering_isNumbering M`（どちらも `PowerSetNumbering/BinaryNumbering.lean`）である。
P_M の単位行列の δ_{S,T} は `PowerSet.lean` の等号の判定（`Classical.decEq`）を使う。

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixReindexing/BinaryNumberingIsomorphism.lean`、導出版は `MatrixReindexingFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixReindexing.Reindexing
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M}：
ν_e を X := P_M、(n, e) := (2^M, e_M) に当てた写像。 -/
def binaryReindexMatrix (M : ℕ) : Mat (PowerSet M) → Mat (Idx (twoPower M)) :=
  reindexMatrix (binaryNumbering M)

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の μ_{e_M}：
μ_e を X := P_M、(n, e) := (2^M, e_M) に当てた写像。 -/
noncomputable def binaryInverseReindexMatrix (M : ℕ) : Mat (Idx (twoPower M)) → Mat (PowerSet M) :=
  inverseReindexMatrix (binaryNumbering_isNumbering M)

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の列挙した二つの主張：
ν_{e_M} と μ_{e_M} はどちらも ℂ-代数の準同型であり、μ_{e_M}(ν_{e_M}(F)) = F、ν_{e_M}(μ_{e_M}(G)) = G である。 -/
theorem binaryReindex_isomorphism (M : ℕ) :
    IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_powerSet M))
        (matricesComplexAlgebra (isFiniteSet_idx (twoPower M))) (binaryReindexMatrix M)
      ∧ IsComplexAlgebraHomomorphism (matricesComplexAlgebra (isFiniteSet_idx (twoPower M)))
        (matricesComplexAlgebra (isFiniteSet_powerSet M)) (binaryInverseReindexMatrix M)
      ∧ (∀ F : Mat (PowerSet M), binaryInverseReindexMatrix M (binaryReindexMatrix M F) = F)
      ∧ (∀ G : Mat (Idx (twoPower M)), binaryReindexMatrix M (binaryInverseReindexMatrix M G) = G) :=
  ⟨reindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet M) (binaryNumbering_isNumbering M),
    inverseReindexMatrix_isComplexAlgebraHomomorphism (isFiniteSet_powerSet M)
      (binaryNumbering_isNumbering M),
    inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M),
    reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M)⟩

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の証明の「単射であること」。 -/
theorem binaryReindexMatrix_injective (M : ℕ) (F F' : Mat (PowerSet M))
    (h : binaryReindexMatrix M F = binaryReindexMatrix M F') : F = F' := calc
  F = binaryInverseReindexMatrix M (binaryReindexMatrix M F) :=
      (inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M) F).symm
  -- ν_{e_M}(F) = ν_{e_M}(F')
  _ = binaryInverseReindexMatrix M (binaryReindexMatrix M F') := by rw [h]
  _ = F' := inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M) F'

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の証明の「全射であること」：
μ_{e_M}(G) は ν_{e_M}(μ_{e_M}(G)) = G を満たす。 -/
theorem binaryReindexMatrix_surjective (M : ℕ) (G : Mat (Idx (twoPower M))) :
    ∃ F : Mat (PowerSet M), binaryReindexMatrix M F = G :=
  ⟨binaryInverseReindexMatrix M G, reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M) G⟩

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras`：ν_{e_M} の逆写像は μ_{e_M} である。
すなわち ν_{e_M}(F) = G を満たす F は μ_{e_M}(G) ただ一つである。 -/
theorem binaryReindexMatrix_eq_iff (M : ℕ) (F : Mat (PowerSet M)) (G : Mat (Idx (twoPower M))) :
    binaryReindexMatrix M F = G ↔ F = binaryInverseReindexMatrix M G := by
  constructor
  · -- 単射であることを F と μ_{e_M}(G) に当てる（ν_{e_M}(μ_{e_M}(G)) = G）
    intro h
    apply binaryReindexMatrix_injective M F (binaryInverseReindexMatrix M G)
    rw [h]
    exact (reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M) G).symm
  · intro h
    rw [h]
    exact reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M) G

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
