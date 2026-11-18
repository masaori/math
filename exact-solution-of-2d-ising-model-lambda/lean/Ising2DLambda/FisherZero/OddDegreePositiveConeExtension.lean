/-
節「奇数次の元を付け足しても正錐は延長できる」の具体版。

  人手証明                                                  このファイル
  主張（`claim_odd_degree_positive_cone_extension`）        `oddDegree_positiveCone_extension`
    E := Val_F(α)、F ⊆ E                                    `E`・`hFE`
    T := Sq(C_F; E) は前錐（`claim_positive_weighted_square_sums_is_precone`）
                                                            `hT`
    -1 ∉ T（`claim_odd_degree_weighted_square_sum_avoids_minus_one`）
                                                            `hneg`
    全射 ξ（`claim_algebraic_numbers_enumeration`）          `ξ`・`hξ`
    T_∞ の三つの結論（`claim_enumerated_precone_chain_covers_signs`）
                                                            `hT'`・`hneg'`・`hcov`
    C_α := T_∞ から零元を除いた集合が延長
    （`claim_covering_precone_gives_positive_cone_extension`）
                                                            最後の段

本文の「ある j で deg_F(α) = 2j+1」は `Odd (degreeOverSubfield F α)`（定義が同じ）。
本文の `Val_F(α)` は `subfieldPolynomialValuesSubfield F α` で読む。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.OddDegreeWeightedSquareSumAvoidsMinusOne
import Ising2DLambda.FisherZero.PositiveWeightedSquareSums
import Ising2DLambda.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.FisherZero.CoveringPreconePositiveCone
import Ising2DLambda.AlgebraicEigenvalue.AlgebraicNumbersEnumeration

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_odd_degree_positive_cone_extension` の具体版。`deg_F(α)` が奇数なら、`Val_F(α)` には
`C_F` を延長する正錐がある。 -/
theorem oddDegree_positiveCone_extension (F : Subfield Qbar) (CF : Set Qbar)
    (hCF : IsSubfieldPositiveCone F CF) (α : Qbar) (hodd : Odd (degreeOverSubfield F α)) :
    ∃ Cα : Set Qbar, ExtendsPositiveCone F (subfieldPolynomialValuesSubfield F α) CF Cα := by
  -- E := Val_F(α)。F ⊆ E。
  set E : Subfield Qbar := subfieldPolynomialValuesSubfield F α with hE
  have hFE : ∀ z : Qbar, z ∈ F → z ∈ E := fun z hz =>
    subfield_subset_subfieldPolynomialValues F α z hz
  -- T := Sq(C_F; E) は (F, C_F) に従う E の前錐。
  have hT : IsSubfieldPrecone F E CF (positiveWeightedSquareSums E CF) :=
    positiveWeightedSquareSums_isSubfieldPrecone F E CF hFE hCF
  -- -1 ∉ T。
  have hneg : (-1 : Qbar) ∉ positiveWeightedSquareSums E CF :=
    oddDegree_weightedSquareSum_ne_neg_one F CF hCF _ α rfl hodd
  -- 全射 ξ : ℕ → Qbar。
  obtain ⟨ξ, hξ⟩ := algebraicNumbersEnumeration
  -- T_∞ の三つの結論。
  obtain ⟨hT', hneg', hcov⟩ :=
    preconeChainUnion_covers_signs F E CF (positiveWeightedSquareSums E CF) hT hneg ξ hξ
  -- C_α := {z | z ∈ T_∞ かつ z ≠ 0} が C_F を延長する E の正錐。
  exact ⟨preconeNonzeroPart (preconeChainUnion E (positiveWeightedSquareSums E CF) ξ),
    coveringPrecone_extendsPositiveCone F E CF _ hT' hneg' hcov⟩

end Ising2DLambda.FisherZero
