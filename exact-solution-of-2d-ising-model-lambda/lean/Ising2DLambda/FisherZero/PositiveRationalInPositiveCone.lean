import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 有理数の包含と二種類の零を明示した、本文冒頭の三等号。 -/
theorem positiveRational_value_representation (s : Qbar) (q : ℚ) :
    algebraMap ℚ Qbar q = algebraMap ℚ Qbar q + algebraMap ℚ Qbar 0 * s := by
  calc
    algebraMap ℚ Qbar q = algebraMap ℚ Qbar q + 0 := (add_zero _).symm
    _ = algebraMap ℚ Qbar q + (0 : Qbar) * s :=
      congrArg (algebraMap ℚ Qbar q + ·) (zero_mul s).symm
    _ = algebraMap ℚ Qbar q + algebraMap ℚ Qbar 0 * s :=
      congrArg (fun z : Qbar => algebraMap ℚ Qbar q + z * s)
        (map_zero (algebraMap ℚ Qbar)).symm

/-- 本文の所属の行。表示 (q, 0) を証人にする。 -/
theorem positiveRational_mem_quadraticFieldSet (s : Qbar) (q : ℚ) :
    algebraMap ℚ Qbar q ∈ quadraticFieldSet s := by
  exact ⟨q, 0, positiveRational_value_representation s q⟩

/-- 有理数を台集合の元として持ち上げる。 -/
noncomputable def positiveRationalElement (s : Qbar) (q : ℚ) : QuadraticFieldElement s :=
  ⟨algebraMap ℚ Qbar q, positiveRational_mem_quadraticFieldSet s q⟩

/-- 冒頭の表示に一意性を適用する、本文の表示写像の行。 -/
theorem positiveRational_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) :
    quadraticRepresentation s (positiveRationalElement s q) = (q, 0) := by
  exact quadraticRepresentation_eq s hs (positiveRationalElement s q) q 0
    (positiveRational_value_representation s q)

/-- claim_positive_rational_in_positive_cone の係数二行と順序・非零・所属の五行。 -/
theorem positiveRational_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) (hq : 0 < q) :
    positiveRationalElement s q ∈ quadraticPositiveCone s := by
  have hrep := positiveRational_representation s hs q
  let a : ℚ := q
  let b : ℚ := 0
  have ha : a = q := rfl
  have hb : b = 0 := rfl
  have ha_nonneg : 0 ≤ a := ha.symm ▸ le_of_lt hq
  have hb_nonneg : 0 ≤ b := hb.symm ▸ (le_rfl : (0 : ℚ) ≤ 0)
  have hq_ne : q ≠ 0 := ne_of_gt hq
  have hab_ne : (a, b) ≠ (0, 0) := by
    intro hab
    exact hq_ne (ha.symm.trans (congrArg Prod.fst hab))
  change quadraticCoefficientPositive (quadraticRepresentation s (positiveRationalElement s q))
  rw [hrep]
  exact Or.inl ⟨ha_nonneg, hb_nonneg, hab_ne⟩

end Ising2DLambda.FisherZero
