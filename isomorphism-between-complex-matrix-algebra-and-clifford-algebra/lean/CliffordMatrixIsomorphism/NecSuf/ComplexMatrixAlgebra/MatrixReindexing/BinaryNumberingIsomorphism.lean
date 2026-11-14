/-
章「複素行列環」の、2 進の番号付けによる、部分集合全体で添字づけた行列環と番号で添字づけた行列環の同型の必要十分版。
具体版 `ComplexMatrixAlgebra/MatrixReindexing/BinaryNumberingIsomorphism.lean` と同じ def と同じ行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                    このファイル                          使う K の性質
  theorem_binary_numbering_gives_isomorphism_of_matrix_algebras   binaryReindexMatrix・                 なし（K の演算も使わない）
                                                                  binaryInverseReindexMatrix
                                                                  binaryReindex_isomorphism             二つの代数を作る L・乗法の交換法則・a · 0 = 0
                                                                                                        （準同型であることの部分だけ）
                                                                  binaryReindexMatrix_injective・       なし（K の演算も使わない）
                                                                  binaryReindexMatrix_surjective・
                                                                  binaryReindexMatrix_eq_iff

分かったこと: ν_{e_M} が全単射で逆写像が μ_{e_M} であることは、係数について何も使わない（P_M の 2 進の番号付けが番号付けであることだけを使う）。
K の性質が現れるのは、二つの行列の集合を代数にする `matricesAlgebra` を通して「準同型である」と述べる部分だけである。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixReindexing.Reindexing
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.PowerSetNumbering.BinaryNumbering

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet twoPower binaryNumbering
  binaryNumbering_isNumbering isFiniteSet_powerSet)

universe uK

variable {K : Type uK}

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の ν_{e_M} の必要十分版。 -/
def binaryReindexMatrix (M : ℕ) : Mat K (PowerSet M) → Mat K (Idx (twoPower M)) :=
  reindexMatrix (binaryNumbering M)

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の μ_{e_M} の必要十分版。 -/
noncomputable def binaryInverseReindexMatrix (M : ℕ) : Mat K (Idx (twoPower M)) → Mat K (PowerSet M) :=
  inverseReindexMatrix (binaryNumbering_isNumbering M)

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の列挙した二つの主張の必要十分版。
L・hcomm・hmul0 は二つの代数を作るためだけに要る。 -/
theorem binaryReindex_isomorphism [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (M : ℕ) :
    IsAlgebraHomomorphism (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M))
        (matricesAlgebra L hcomm hmul0 (isFiniteSet_idx (twoPower M))) (binaryReindexMatrix M)
      ∧ IsAlgebraHomomorphism (matricesAlgebra L hcomm hmul0 (isFiniteSet_idx (twoPower M)))
        (matricesAlgebra L hcomm hmul0 (isFiniteSet_powerSet M)) (binaryInverseReindexMatrix M)
      ∧ (∀ F : Mat K (PowerSet M), binaryInverseReindexMatrix M (binaryReindexMatrix M F) = F)
      ∧ (∀ G : Mat K (Idx (twoPower M)), binaryReindexMatrix M (binaryInverseReindexMatrix M G) = G) :=
  ⟨reindexMatrix_isAlgebraHomomorphism L hcomm hmul0 (isFiniteSet_powerSet M)
      (binaryNumbering_isNumbering M),
    inverseReindexMatrix_isAlgebraHomomorphism L hcomm hmul0 (isFiniteSet_powerSet M)
      (binaryNumbering_isNumbering M),
    inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M),
    reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M)⟩

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の証明の「単射であること」の必要十分版。 -/
theorem binaryReindexMatrix_injective (M : ℕ) (F F' : Mat K (PowerSet M))
    (h : binaryReindexMatrix M F = binaryReindexMatrix M F') : F = F' := calc
  F = binaryInverseReindexMatrix M (binaryReindexMatrix M F) :=
      (inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M) F).symm
  -- ν_{e_M}(F) = ν_{e_M}(F')
  _ = binaryInverseReindexMatrix M (binaryReindexMatrix M F') := by rw [h]
  _ = F' := inverseReindexMatrix_reindexMatrix (binaryNumbering_isNumbering M) F'

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の証明の「全射であること」の必要十分版。 -/
theorem binaryReindexMatrix_surjective (M : ℕ) (G : Mat K (Idx (twoPower M))) :
    ∃ F : Mat K (PowerSet M), binaryReindexMatrix M F = G :=
  ⟨binaryInverseReindexMatrix M G, reindexMatrix_inverseReindexMatrix (binaryNumbering_isNumbering M) G⟩

/-- 本文 `theorem_binary_numbering_gives_isomorphism_of_matrix_algebras` の必要十分版：ν_{e_M} の逆写像は μ_{e_M} である。 -/
theorem binaryReindexMatrix_eq_iff (M : ℕ) (F : Mat K (PowerSet M)) (G : Mat K (Idx (twoPower M))) :
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

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
