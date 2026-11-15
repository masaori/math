/-
章「複素行列環」の、番号 1 を最上位の桁にする番号付けによる行列の添字の付け替えと、番号で添字づけたクロネッカー積の必要十分版。
具体版 `ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/NumberedKroneckerProduct.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。
ϱ_M・r_M・𝓘_M・ō_M・pos_M・整数の番号順の和・num_M（`FirstSiteHighestDigitNumbering/` の ℂ を含まない 4 ファイル）は、具体版と同じものを引く。

  本文のラベル                                                                              このファイル                                    使う K の性質
  def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit                  firstSiteHighestReindexMatrix                   なし（K の演算も使わない）
  def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit       firstSiteHighestInverseReindexMatrix            なし（K の演算も使わない）
  def_kronecker_product_indexed_by_numbers                                                  numberedKroneckerFactor・                       なし（乗法と 1 の記号だけ）
                                                                                            numberedKroneckerProduct・
                                                                                            numberedKroneckerProduct_entry
  claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit       firstSiteHighestReindexMatrix_kroneckerProduct  なし
  claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal        numberedKroneckerProduct_congr                  なし

分かったこと: 番号で添字づけたクロネッカー積と、それが部分集合全体で添字づけたクロネッカー積の付け替えであることは、
係数の性質を一つも使わない。使うのは、num_M が全単射で ō_M ∘ r_M の逆写像であること（ℂ を含まない番号の計算）だけである。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.TupleNumber
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.KroneckerProduct.KroneckerProduct
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixReindexing.Reindexing

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra (PowerSet twoPower idxOne membershipIndex OneTwoTuple
  membershipTuple extendFamily_membershipTuple firstSiteHighestNumbering firstSiteHighestNumbering_isNumbering
  tupleNumber tupleNumberIdx tupleNumberInv tupleNumberInv_tupleNumberIdx
  tupleNumber_membershipTuple_firstSiteHighestNumbering)

universe uK

variable {K : Type uK}

/-- 本文 `def_reindexing_of_matrices_by_numbering_with_first_site_as_highest_digit` の必要十分版：
ν_{r_M}(F)_{k,l} = F_{r_M(k), r_M(l)}（ν_e を X := P_M、(n, e) := (2^M, r_M) に当てた写像）。 -/
def firstSiteHighestReindexMatrix (M : ℕ) : Mat K (PowerSet M) → Mat K (Idx (twoPower M)) :=
  reindexMatrix (firstSiteHighestNumbering M)

/-- 本文 `def_reindexing_of_matrices_by_inverse_of_numbering_with_first_site_as_highest_digit` の必要十分版：
μ_{r_M}(G)_{S,T} = G_{r_M^{-1}(S), r_M^{-1}(T)}（μ_e を X := P_M、(n, e) := (2^M, r_M) に当てた写像）。 -/
noncomputable def firstSiteHighestInverseReindexMatrix (M : ℕ) : Mat K (Idx (twoPower M)) → Mat K (PowerSet M) :=
  inverseReindexMatrix (firstSiteHighestNumbering_isNumbering M)

/-- 本文 `def_kronecker_product_indexed_by_numbers` の番号順の積の因子：t に (A_t)_{I(t), J(t)} を与える族。 -/
noncomputable def numberedKroneckerFactor {M : ℕ} (A : ℕ → Mat K (Idx 2)) (I J : OneTwoTuple M) (t : ℕ) : K :=
  Mat.entry (A t) (extendFamily I idxOne t) (extendFamily J idxOne t)

/-- 本文 `def_kronecker_product_indexed_by_numbers` の必要十分版：⊠̂_{t=1}^{M} A_t ∈ Mat_{1,…,2^M}(K)。
(k, l) の成分は、num_M(I) = k、num_M(J) = l を満たすただ一つの (I, J) について Π_{K,t=1}^{M} (A_t)_{I(t), J(t)}。 -/
noncomputable def numberedKroneckerProduct [Mul K] [One K] (M : ℕ) (A : ℕ → Mat K (Idx 2)) : Mat K (Idx (twoPower M)) :=
  fun p => orderedProduct M (numberedKroneckerFactor A (tupleNumberInv M p.1) (tupleNumberInv M p.2))

/-- 本文 `def_kronecker_product_indexed_by_numbers` の定義の式：
(⊠̂_{t=1}^{M} A_t)_{num_M(I), num_M(J)} = Π_{K,t=1}^{M} (A_t)_{I(t), J(t)}。 -/
theorem numberedKroneckerProduct_entry [Mul K] [One K] (M : ℕ) (A : ℕ → Mat K (Idx 2)) (I J : OneTwoTuple M) :
    Mat.entry (numberedKroneckerProduct M A) (tupleNumberIdx M I) (tupleNumberIdx M J)
      = orderedProduct M (numberedKroneckerFactor A I J) := by
  show orderedProduct M (numberedKroneckerFactor A (tupleNumberInv M (tupleNumberIdx M I))
      (tupleNumberInv M (tupleNumberIdx M J))) = _
  rw [tupleNumberInv_tupleNumberIdx, tupleNumberInv_tupleNumberIdx]

/-- 本文 `claim_reindexing_of_kronecker_product_by_numbering_with_first_site_as_highest_digit` の必要十分版：
ν_{r_M}(⊠_{t=1}^{M} A_t) = ⊠̂_{t=1}^{M} A_t。 -/
theorem firstSiteHighestReindexMatrix_kroneckerProduct [Mul K] [One K] (M : ℕ) (A : ℕ → Mat K (Idx 2)) :
    firstSiteHighestReindexMatrix M (kroneckerProduct M A) = numberedKroneckerProduct M A :=
  -- 両辺は Mat_{1,…,2^M}(K) の元なので、k, l を任意に固定して成分を比べる（def_matrices_indexed_by_finite_set）
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

/-- 本文 `claim_kronecker_products_indexed_by_numbers_of_factorwise_equal_families_are_equal` の必要十分版：
すべての t ∈ {1,…,M} で A_t = A'_t なら ⊠̂_{t=1}^{M} A_t = ⊠̂_{t=1}^{M} A'_t。 -/
theorem numberedKroneckerProduct_congr [Mul K] [One K] (M : ℕ) (A A' : ℕ → Mat K (Idx 2))
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

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
