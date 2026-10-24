/-
「正の根の特定」の具体版。
本文と同じ表示の構成、正錐三条件の判定、二根の場合分けを順に実装する。
-/
import Ising2DLambda.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_self_dual_root_plus_mem` の具体版。 -/
theorem selfDualRootPlus_mem (s : Qbar) :
    -1 + s ∈ quadraticFieldSet s := by
  refine ⟨-1, 1, ?_⟩
  calc
    -1 + s = (-(1 : Qbar)) + s := rfl
    _ = (-(algebraMap ℚ Qbar 1)) + s :=
      congrArg (fun x : Qbar => -x + s) (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + s :=
      congrArg (fun x : Qbar => x + s) (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm
    _ = algebraMap ℚ Qbar (-1) + 1 * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x) (one_mul s).symm
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar 1 * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x * s)
        (map_one (algebraMap ℚ Qbar)).symm

/-- 根 `-1+s` を `Q_s` の元として持ち上げる。 -/
noncomputable def selfDualRootPlus (s : Qbar) : QuadraticFieldElement s :=
  ⟨-1 + s, selfDualRootPlus_mem s⟩

/-- `claim_self_dual_root_plus_representation` の具体版。 -/
theorem selfDualRootPlus_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootPlus s) = (-1, 1) := by
  let p : ℚ × ℚ := quadraticRepresentation s (selfDualRootPlus s)
  have hvalue : algebraMap ℚ Qbar p.1 + algebraMap ℚ Qbar p.2 * s =
      algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar 1 * s := calc
    _ = -1 + s := (quadraticRepresentation_spec s (selfDualRootPlus s)).symm
    _ = (-(algebraMap ℚ Qbar 1)) + s :=
      congrArg (fun x : Qbar => -x + s) (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + s :=
      congrArg (fun x : Qbar => x + s) (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm
    _ = algebraMap ℚ Qbar (-1) + 1 * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x) (one_mul s).symm
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar 1 * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x * s)
        (map_one (algebraMap ℚ Qbar)).symm
  have hcoeff := quadraticRepresentationUnique s hs p.1 p.2 (-1) 1 hvalue
  exact Prod.ext hcoeff.1 hcoeff.2

/-- `claim_self_dual_root_minus_mem` の具体版。 -/
theorem selfDualRootMinus_mem (s : Qbar) :
    -1 - s ∈ quadraticFieldSet s := by
  refine ⟨-1, -1, ?_⟩
  calc
    -1 - s = -1 + (-s) := sub_eq_add_neg _ _
    _ = (-(algebraMap ℚ Qbar 1)) + (-s) :=
      congrArg (fun x : Qbar => -x + (-s)) (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + (-s) :=
      congrArg (fun x : Qbar => x + (-s)) (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm
    _ = algebraMap ℚ Qbar (-1) + (-(1 * s)) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + (-x)) (one_mul s).symm
    _ = algebraMap ℚ Qbar (-1) + ((-1) * s) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x) (neg_mul (1 : Qbar) s).symm
    _ = algebraMap ℚ Qbar (-1) + ((-(algebraMap ℚ Qbar 1)) * s) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + (-x) * s)
        (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar (-1) * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x * s)
        (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm

/-- 根 `-1-s` を `Q_s` の元として持ち上げる。 -/
noncomputable def selfDualRootMinus (s : Qbar) : QuadraticFieldElement s :=
  ⟨-1 - s, selfDualRootMinus_mem s⟩

/-- `claim_self_dual_root_minus_representation` の具体版。 -/
theorem selfDualRootMinus_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootMinus s) = (-1, -1) := by
  let p : ℚ × ℚ := quadraticRepresentation s (selfDualRootMinus s)
  have hvalue : algebraMap ℚ Qbar p.1 + algebraMap ℚ Qbar p.2 * s =
      algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar (-1) * s := calc
    _ = -1 - s := (quadraticRepresentation_spec s (selfDualRootMinus s)).symm
    _ = -1 + (-s) := sub_eq_add_neg _ _
    _ = (-(algebraMap ℚ Qbar 1)) + (-s) :=
      congrArg (fun x : Qbar => -x + (-s)) (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + (-s) :=
      congrArg (fun x : Qbar => x + (-s)) (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm
    _ = algebraMap ℚ Qbar (-1) + (-(1 * s)) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + (-x)) (one_mul s).symm
    _ = algebraMap ℚ Qbar (-1) + ((-1) * s) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x) (neg_mul (1 : Qbar) s).symm
    _ = algebraMap ℚ Qbar (-1) + ((-(algebraMap ℚ Qbar 1)) * s) :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + (-x) * s)
        (map_one (algebraMap ℚ Qbar)).symm
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar (-1) * s :=
      congrArg (fun x : Qbar => algebraMap ℚ Qbar (-1) + x * s)
        (map_neg (algebraMap ℚ Qbar) (1 : ℚ)).symm
  have hcoeff := quadraticRepresentationUnique s hs p.1 p.2 (-1) (-1) hvalue
  exact Prod.ext hcoeff.1 hcoeff.2

/-- `claim_self_dual_root_plus_positive` の具体版。 -/
theorem selfDualRootPlus_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootPlus s ∈ quadraticPositiveCone s := by
  -- 本文の三所属は根の部分型、表示対の型、二つの射影の型で担う。
  let root : QuadraticFieldElement s := selfDualRootPlus s
  let p : ℚ × ℚ := quadraticRepresentation s root
  let a : ℚ := p.1
  let b : ℚ := p.2
  have hrep : p = (-1, 1) := selfDualRootPlus_representation s hs
  have ha : a = -1 := congrArg Prod.fst hrep
  have hb : b = 1 := congrArg Prod.snd hrep
  -- 本文の二つの符号比較。
  have haNeg : a < 0 := calc
    a = -1 := ha
    _ < 0 := by norm_num
  have hbPos : 0 < b := calc
    (0 : ℚ) < 1 := by norm_num
    _ = b := hb.symm
  -- 本文の平方比較。負号の積と単位元の積を別々の行にする。
  have hSquare : a * a < (2 * b) * b := calc
    a * a = (-1) * (-1) := congrArg (fun x : ℚ => x * x) ha
    _ = 1 * 1 := neg_mul_neg (1 : ℚ) 1
    _ = 1 := one_mul (1 : ℚ)
    _ < 2 := by norm_num
    _ = 2 * 1 := (mul_one (2 : ℚ)).symm
    _ = 2 * (1 * 1) := congrArg (fun x : ℚ => 2 * x) (one_mul (1 : ℚ)).symm
    _ = 2 * (b * b) := congrArg (fun x : ℚ => 2 * (x * x)) hb.symm
    _ = (2 * b) * b := (mul_assoc (2 : ℚ) b b).symm
  -- 正錐の第三条件への挿入。
  exact Or.inr (Or.inr ⟨haNeg, hbPos, hSquare⟩)

/-- `claim_self_dual_root_minus_not_positive` の具体版。 -/
theorem selfDualRootMinus_not_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootMinus s ∉ quadraticPositiveCone s := by
  -- 所属は根の部分型、表示対と射影の型で担う。
  let root : QuadraticFieldElement s := selfDualRootMinus s
  let p : ℚ × ℚ := quadraticRepresentation s root
  let a : ℚ := p.1
  let b : ℚ := p.2
  have hrep : p = (-1, -1) := selfDualRootMinus_representation s hs
  have ha : a = -1 := congrArg Prod.fst hrep
  have hb : b = -1 := congrArg Prod.snd hrep
  have haNeg : a < 0 := calc
    a = -1 := ha
    _ < 0 := by norm_num
  have hbNeg : b < 0 := calc
    b = -1 := hb
    _ < 0 := by norm_num
  have haNotNonneg : ¬ 0 ≤ a := not_le_of_gt haNeg
  have haNotPos : ¬ 0 < a := not_lt_of_ge (le_of_lt haNeg)
  have hbNotPos : ¬ 0 < b := not_lt_of_ge (le_of_lt hbNeg)
  -- 正錐の三条件を、それぞれの必要な符号から否定する。
  have hFirst : ¬ (0 ≤ a ∧ 0 ≤ b ∧ p ≠ (0, 0)) := fun h => haNotNonneg h.1
  have hSecond : ¬ (0 < a ∧ b < 0 ∧ 2 * b * b < a * a) := fun h => haNotPos h.1
  have hThird : ¬ (a < 0 ∧ 0 < b ∧ a * a < 2 * b * b) := fun h => hbNotPos h.2.1
  intro hPositive
  rcases hPositive with hfirst | hsecond | hthird
  · exact hFirst hfirst
  · exact hSecond hsecond
  · exact hThird hthird

/-- `claim_self_dual_positive_root_unique` の具体版。 -/
theorem selfDualPositiveRoot_unique {s xi : Qbar}
    (hs : s * s = algebraMap ℚ Qbar 2)
    (hxiMem : xi ∈ quadraticFieldSet s)
    (hquadratic : xi ^ 2 + 2 * xi - 1 = 0)
    (hpositive : (⟨xi, hxiMem⟩ : QuadraticFieldElement s) ∈ quadraticPositiveCone s) :
    xi = -1 + s := by
  rcases (selfDualQuadratic_roots hs).mp hquadratic with hplus | hminus
  · exact hplus
  · have hSubtype : (⟨xi, hxiMem⟩ : QuadraticFieldElement s) = selfDualRootMinus s := by
      apply Subtype.ext
      exact hminus
    have : selfDualRootMinus s ∈ quadraticPositiveCone s := by
      rw [← hSubtype]
      exact hpositive
    exact (selfDualRootMinus_not_mem_positiveCone s hs this).elim

/-- `def_critical_point` の具体版。 -/
noncomputable def criticalPoint (s : Qbar) : QuadraticFieldElement s := selfDualRootPlus s

end Ising2DLambda.FisherZero
