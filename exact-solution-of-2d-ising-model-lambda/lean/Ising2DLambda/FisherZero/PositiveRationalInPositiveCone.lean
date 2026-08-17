/-
「正の有理数は正錐の元である」の具体版。
本文と同じく、表示 (q, 0) を証人にして Q_s への所属を示し、
表示の一意性から rep_s(q) = (q, 0) を読み、正錐の第一条件で閉じる。
-/
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_positive_rational_in_positive_cone` の所属部分。表示 (q, 0) が証人である。 -/
theorem positiveRational_mem_quadraticFieldSet (s : Qbar) (q : ℚ) :
    algebraMap ℚ Qbar q ∈ quadraticFieldSet s := by
  refine ⟨q, 0, ?_⟩
  -- 本文の鎖: q = q + 0 = q + 0·s（加法単位元と零元の乗法）
  simp

/-- 有理数 `q` を `Q_s` の元として持ち上げる。 -/
noncomputable def positiveRationalElement (s : Qbar) (q : ℚ) : QuadraticFieldElement s :=
  ⟨algebraMap ℚ Qbar q, positiveRational_mem_quadraticFieldSet s q⟩

/-- 本文どおり `rep_s(q) = (q, 0)` である（表示の一意性）。 -/
theorem positiveRational_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) :
    quadraticRepresentation s (positiveRationalElement s q) = (q, 0) := by
  apply quadraticRepresentation_eq s hs (positiveRationalElement s q) q 0
  change algebraMap ℚ Qbar q = algebraMap ℚ Qbar q + algebraMap ℚ Qbar 0 * s
  simp

/-- `claim_positive_rational_in_positive_cone` の具体版。
    表示 (q, 0) は正錐の第一条件（0 ≤ q、0 ≤ 0、(q, 0) ≠ (0, 0)）を満たす。 -/
theorem positiveRational_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) (hq : 0 < q) :
    positiveRationalElement s q ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (positiveRationalElement s q))
  rw [positiveRational_representation s hs q]
  refine Or.inl ⟨le_of_lt hq, le_rfl, ?_⟩
  -- (q, 0) ≠ (0, 0): 第一成分 q が 0 でない（0 < q の非反射性）
  intro h
  rw [Prod.mk.injEq] at h
  exact absurd h.1 (ne_of_gt hq)

end Ising2DLambda.FisherZero
