/- 必要十分版を実閉部分体の具体的なデータへ特殊化する導出。住処: Q と Qbar。 -/
import Ising2DLambda.FisherZero.RealAlgebraicOrder
import Ising2DLambda.NecSuf.FisherZero.RealAlgebraicOrder

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 有理数の所属の具体版を、閉性だけを使う必要十分版から導く。 -/
theorem rational_mem_realClosedCarrier_from_necSuf
    (data : RealClosedSubfieldData) (q : ℚ) :
    (q : Qbar) ∈ data.carrier := by
  apply Ising2DLambda.NecSuf.FisherZero.rational_mem_of_closure_necSuf
    (fun x : Qbar => x ∈ data.carrier)
  · exact data.carrier.zero_mem
  · exact data.carrier.one_mem
  · exact fun ha hb => data.carrier.add_mem ha hb
  · exact fun ha => data.carrier.neg_mem ha
  · exact fun ha hb => data.carrier.mul_mem ha hb
  · exact fun ha _ => data.carrier.inv_mem ha

/-- `-1` が非零元の平方でないことを、三分法の排他性から導く。 -/
theorem negOne_not_square_realClosedCarrier_from_necSuf
    (data : RealClosedSubfieldData) (w : data.carrier) (hw : w ≠ 0) :
    w * w ≠ -1 := by
  intro hsquare
  apply Ising2DLambda.NecSuf.FisherZero.positive_negative_exclusive_necSuf
    (p := ((1 : data.carrier) = 0))
    (q := ∃ v : data.carrier, v ≠ 0 ∧ (1 : data.carrier) = v * v)
    (r := ∃ v : data.carrier, v ≠ 0 ∧ -(1 : data.carrier) = v * v)
  · exact data.squareTrichotomy 1
  · exact ⟨1, one_ne_zero, by simp⟩
  · exact ⟨w, hw, hsquare.symm⟩

/-- 狭義順序の三分法を、差の三分法の必要十分版から導く。 -/
theorem realAlgebraicLt_trichotomy_from_necSuf
    (data : RealClosedSubfieldData) (a b : data.carrier) :
    ExactlyOneOfThree
      (realAlgebraicLt data a b)
      (a = b)
      (realAlgebraicLt data b a) := by
  change Ising2DLambda.NecSuf.FisherZero.ExactlyOneOfThree
    (realAlgebraicLt data a b) (a = b) (realAlgebraicLt data b a)
  simpa [realAlgebraicLt,
    Ising2DLambda.NecSuf.FisherZero.strictOrderOfDifference] using
    Ising2DLambda.NecSuf.FisherZero.strictOrderOfDifference_trichotomy_necSuf
      (fun x y : data.carrier => x - y) Neg.neg
      (fun z : data.carrier => ∃ v : data.carrier, v ≠ 0 ∧ z = v * v)
      0 a b
      (data.squareTrichotomy (b - a))
      (by constructor
          · intro h; exact (sub_eq_zero.mp h).symm
          · intro h; exact sub_eq_zero.mpr h.symm)
      (by exact neg_sub b a)

end Ising2DLambda.FisherZero
