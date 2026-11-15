/-
章「複素行列環」の、番号 1 を最上位の桁にする番号付けによる行列の添字の付け替えと、番号で添字づけたクロネッカー積の具体版。
人手証明と 1 対 1 に対応させる。mathlib の `Matrix`・`Matrix.kronecker`・`Finset.prod` は使わない。

  本文のラベル                                                                              このファイル
  def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit                  firstSiteHighestReindexMatrix（ν_{r_M}）
  def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit       firstSiteHighestInverseReindexMatrix（μ_{r_M}）
  def_kronecker_product_indexed_by_numbers                                                  numberedKroneckerFactor・numberedKroneckerProduct・
                                                                                            numberedKroneckerProduct_entry（定義の式）
  claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit       firstSiteHighestReindexMatrix_kroneckerProduct
  claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal        numberedKroneckerProduct_congr

ν_{r_M}・μ_{r_M} は、`MatrixReindexing/Reindexing.lean` の ν_e・μ_e を (n, e) := (2^M, r_M) に当てたもの。
本文の ⊠̂ の定義は、成分を (num_M(I), num_M(J)) の位置で与え、num_M が全単射であることから各 (k, l) の成分が一つに決まるとする。
Lean では、num_M の逆写像 `tupleNumberInv`（`TupleNumber.lean`）で (k, l) を (I, J) に戻して成分を定め、本文の定義の式
「(⊠̂ A_t)_{num_M(I), num_M(J)} = Π_{ℂ,t=1}^{M} (A_t)_{I(t), J(t)}」を `numberedKroneckerProduct_entry` として示す。
番号順の積の因子は番号 t ∈ ℕ を受け取るので、I(t) は I を {1,…,M} の外で値 1 に延ばした族 `extendFamily I idxOne` の値で書く。

本文のクロネッカー積の定義と二つの主張は M ≥ 1 を前提に置くが、証明は M ≥ 1 を使わない（M = 0 でも同じ式で成り立つ）ので、任意の M で書く。

本文が引くほかのブロックは、次の宣言を引く。
  def_kronecker_product_indexed_by_power_set                         kroneckerProduct・kroneckerFactor
  claim_kronecker_products_of_factorwise_equal_families_are_equal    kroneckerProduct_congr
  def_reindexing_of_matrices_by_numbering                            reindexMatrix
  def_reindexing_of_matrices_by_inverse_numbering                    inverseReindexMatrix

必要十分版は `NecSuf/ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/NumberedKroneckerProduct.lean`、
導出版は `FirstSiteHighestDigitNumberingFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.TupleNumber
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixReindexing.Reindexing

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

/-- 本文 `def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit`：
ν_{r_M}(F)_{k,l} = F_{r_M(k), r_M(l)}（ν_e を X := P_M、(n, e) := (2^M, r_M) に当てた写像）。 -/
def firstSiteHighestReindexMatrix (M : ℕ) : Mat (PowerSet M) → Mat (Idx (twoPower M)) :=
  reindexMatrix (firstSiteHighestNumbering M)

/-- 本文 `def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit`：
μ_{r_M}(G)_{S,T} = G_{r_M^{-1}(S), r_M^{-1}(T)}（μ_e を X := P_M、(n, e) := (2^M, r_M) に当てた写像）。 -/
noncomputable def firstSiteHighestInverseReindexMatrix (M : ℕ) : Mat (Idx (twoPower M)) → Mat (PowerSet M) :=
  inverseReindexMatrix (firstSiteHighestNumbering_isNumbering M)

/-- 本文 `def_kronecker_product_indexed_by_numbers` の番号順の積の因子：t に (A_t)_{I(t), J(t)} を与える族。 -/
noncomputable def numberedKroneckerFactor {M : ℕ} (A : ℕ → Mat (Idx 2)) (I J : OneTwoTuple M) (t : ℕ) : ℂ :=
  Mat.entry (A t) (extendFamily I idxOne t) (extendFamily J idxOne t)

/-- 本文 `def_kronecker_product_indexed_by_numbers`：⊠̂_{t=1}^{M} A_t ∈ Mat_{1,…,2^M}(ℂ)。
(k, l) の成分は、num_M(I) = k、num_M(J) = l を満たすただ一つの (I, J) について Π_{ℂ,t=1}^{M} (A_t)_{I(t), J(t)}。 -/
noncomputable def numberedKroneckerProduct (M : ℕ) (A : ℕ → Mat (Idx 2)) : Mat (Idx (twoPower M)) :=
  fun p => orderedProduct M (numberedKroneckerFactor A (tupleNumberInv M p.1) (tupleNumberInv M p.2))

/-- 本文 `def_kronecker_product_indexed_by_numbers` の定義の式：
(⊠̂_{t=1}^{M} A_t)_{num_M(I), num_M(J)} = Π_{ℂ,t=1}^{M} (A_t)_{I(t), J(t)}。 -/
theorem numberedKroneckerProduct_entry (M : ℕ) (A : ℕ → Mat (Idx 2)) (I J : OneTwoTuple M) :
    Mat.entry (numberedKroneckerProduct M A) (tupleNumberIdx M I) (tupleNumberIdx M J)
      = orderedProduct M (numberedKroneckerFactor A I J) := by
  show orderedProduct M (numberedKroneckerFactor A (tupleNumberInv M (tupleNumberIdx M I))
      (tupleNumberInv M (tupleNumberIdx M J))) = _
  rw [tupleNumberInv_tupleNumberIdx, tupleNumberInv_tupleNumberIdx]

/-- 本文 `claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit`：
ν_{r_M}(⊠_{t=1}^{M} A_t) = ⊠̂_{t=1}^{M} A_t。 -/
theorem firstSiteHighestReindexMatrix_kroneckerProduct (M : ℕ) (A : ℕ → Mat (Idx 2)) :
    firstSiteHighestReindexMatrix M (kroneckerProduct M A) = numberedKroneckerProduct M A :=
  -- 両辺は Mat_{1,…,2^M}(ℂ) の元なので、k, l を任意に固定して成分を比べる（def_matrices_indexed_by_finite_set）
  Mat.ext fun k l => by
    -- I := ō_M(r_M(k))、J := ō_M(r_M(l))（def_tuple_of_membership_indices）
    let I := membershipTuple (firstSiteHighestNumbering M k)
    let J := membershipTuple (firstSiteHighestNumbering M l)
    -- claim_number_of_membership_tuple_after_numbering_with_first_site_as_highest_digit から num_M(I) = k、num_M(J) = l
    have hI : tupleNumberIdx M I = k := Subtype.ext (by
      have h : tupleNumber M I = (k.1 : ℤ) := tupleNumber_membershipTuple_firstSiteHighestNumbering M k
      show (tupleNumber M I).toNat = k.1
      omega)
    have hJ : tupleNumberIdx M J = l := Subtype.ext (by
      have h : tupleNumber M J = (l.1 : ℤ) := tupleNumber_membershipTuple_firstSiteHighestNumbering M l
      show (tupleNumber M J).toNat = l.1
      omega)
    calc Mat.entry (firstSiteHighestReindexMatrix M (kroneckerProduct M A)) k l
        -- def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit
        = Mat.entry (kroneckerProduct M A) (firstSiteHighestNumbering M k) (firstSiteHighestNumbering M l) := rfl
      -- def_kronecker_product_indexed_by_power_set
      _ = orderedProduct M (kroneckerFactor A (firstSiteHighestNumbering M k) (firstSiteHighestNumbering M l)) := rfl
      -- def_tuple_of_membership_indices（各 t で I(t) = o_{M,r_M(k)}(t)、J(t) = o_{M,r_M(l)}(t)）
      _ = orderedProduct M (numberedKroneckerFactor A I J) :=
          congrArg (orderedProduct M) (funext fun t => by
            show Mat.entry (A t) (membershipIndex (firstSiteHighestNumbering M k) t)
                (membershipIndex (firstSiteHighestNumbering M l) t)
              = Mat.entry (A t) (extendFamily I idxOne t) (extendFamily J idxOne t)
            rw [extendFamily_membershipTuple, extendFamily_membershipTuple])
      -- def_kronecker_product_indexed_by_numbers
      _ = Mat.entry (numberedKroneckerProduct M A) (tupleNumberIdx M I) (tupleNumberIdx M J) :=
          (numberedKroneckerProduct_entry M A I J).symm
      -- num_M(I) = k、num_M(J) = l
      _ = Mat.entry (numberedKroneckerProduct M A) k l := by rw [hI, hJ]

/-- 本文 `claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal`：
すべての t ∈ {1,…,M} で A_t = A'_t なら ⊠̂_{t=1}^{M} A_t = ⊠̂_{t=1}^{M} A'_t。 -/
theorem numberedKroneckerProduct_congr (M : ℕ) (A A' : ℕ → Mat (Idx 2))
    (h : ∀ t : ℕ, 1 ≤ t → t ≤ M → A t = A' t) :
    numberedKroneckerProduct M A = numberedKroneckerProduct M A' := calc
  numberedKroneckerProduct M A
      -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit
      = firstSiteHighestReindexMatrix M (kroneckerProduct M A) :=
        (firstSiteHighestReindexMatrix_kroneckerProduct M A).symm
  -- claim_kronecker_products_of_factorwise_equal_families_are_equal
  _ = firstSiteHighestReindexMatrix M (kroneckerProduct M A') := by rw [kroneckerProduct_congr M A A' h]
  -- claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit で A → A'
  _ = numberedKroneckerProduct M A' := firstSiteHighestReindexMatrix_kroneckerProduct M A'

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
