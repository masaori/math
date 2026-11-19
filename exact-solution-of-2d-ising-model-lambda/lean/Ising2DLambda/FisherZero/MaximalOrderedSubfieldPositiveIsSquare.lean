import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldIsMaximal
import Ising2DLambda.FisherZero.PositiveConeElementQbarSquareRoot
import Ising2DLambda.FisherZero.SquareRootAdjoinedPositiveConeExtension
import Ising2DLambda.FisherZero.QuadraticPositiveConeSubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 極大な正錐付き部分体では、正錐の元の代数的平方根は部分体を離れない。 -/
theorem maximalOrderedSubfield_positive_isSquare
    (R : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone R C)
    (hmax : ∀ (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone R E C D → E = R)
    (a : Qbar) (ha : a ∈ C) :
    ∃ b : Qbar, b ∈ R ∧ b ≠ 0 ∧ b * b = a := by
  -- 本文の第一段: Qbar 内で零でない平方根を取る。
  obtain ⟨b, hb0, hb⟩ := positiveConeElement_hasQbarSquareRoot R C hC a ha
  by_cases hbR : b ∈ R
  · exact ⟨b, hbR, hb0, hb⟩
  -- 本文の背理法: R(b) 上の正錐は極大性と矛盾する。
  obtain ⟨CE, hCE⟩ := squareRootAdjoined_positiveCone_extension R C hC a b ha hb hbR
  have hER := hmax _ CE hCE
  have hbE : b ∈ Subfield.closure ((R : Set Qbar) ∪ ({b} : Set Qbar)) :=
    Subfield.subset_closure (Set.mem_union_right _ (Set.mem_singleton b))
  exact False.elim (hbR (hER ▸ hbE))

/-- 二次体から作った極大な組では、固定した平方根 `s` も正の平方である。 -/
theorem maximalOrderedSubfield_sqrtTwo_isSquare
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    ∃ (R : Subfield Qbar) (C : Set Qbar) (b : Qbar),
      ExtendsPositiveCone (quadraticFieldSubfield s hs) R
        (quadraticPositiveConeAmbient s) C ∧
      b ∈ R ∧ b ≠ 0 ∧ b * b = s := by
  obtain ⟨R, C, hbase, hmax⟩ := enumeratedOrderedSubfield_isMaximal s hs
  have hsQs : s ∈ quadraticFieldSet s := by
    change ∃ a b : ℚ, s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
    refine ⟨0, 1, ?_⟩
    simp
  have hsP : s ∈ quadraticPositiveConeAmbient s := by
    exact ⟨hsQs, quadraticGenerator_mem_positiveCone s hs⟩
  have hsC : s ∈ C := (hbase.inter_eq s).2 hsP |>.1
  obtain ⟨b, hbR, hb0, hb⟩ :=
    maximalOrderedSubfield_positive_isSquare R C hbase.cone_E hmax s hsC
  exact ⟨R, C, b, hbase, hbR, hb0, hb⟩

end Ising2DLambda.FisherZero
