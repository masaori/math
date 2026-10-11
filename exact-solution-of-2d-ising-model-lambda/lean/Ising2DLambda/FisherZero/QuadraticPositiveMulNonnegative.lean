/-
「正錐の非負係数条件どうしの積」の独立な具体版。
本文の積の表示、非負性、正係数の選択、四場合、非零性と所属に対応する。
-/
import Ising2DLambda.FisherZero.QuadraticMultiplication

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticPositive_mul_of_nonnegativeCoefficients
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 ≤ (quadraticRepresentation s xi).1 ∧
      0 ≤ (quadraticRepresentation s xi).2 ∧
      quadraticRepresentation s xi ≠ (0, 0))
    (heta : 0 ≤ (quadraticRepresentation s eta).1 ∧
      0 ≤ (quadraticRepresentation s eta).2 ∧
      quadraticRepresentation s eta ≠ (0, 0)) :
    quadraticMulElement s hs xi eta ∈ quadraticPositiveCone s := by
  let a : ℚ := (quadraticRepresentation s xi).1
  let b : ℚ := (quadraticRepresentation s xi).2
  let ap : ℚ := (quadraticRepresentation s eta).1
  let bp : ℚ := (quadraticRepresentation s eta).2
  let A : ℚ := (quadraticRepresentation s (quadraticMulElement s hs xi eta)).1
  let B : ℚ := (quadraticRepresentation s (quadraticMulElement s hs xi eta)).2
  -- 本文の積の表示の二行。
  have hRep := quadraticRepresentation_mul s hs xi eta
  have hA : A = a * ap + 2 * (b * bp) := congrArg Prod.fst hRep
  have hB : B = a * bp + b * ap := congrArg Prod.snd hRep
  -- 五つの積の非負性と、二係数の非負性。
  have hAA : 0 ≤ a * ap := mul_nonneg hxi.1 heta.1
  have hBB : 0 ≤ b * bp := mul_nonneg hxi.2.1 heta.2.1
  have hWBB : 0 ≤ 2 * (b * bp) := mul_nonneg (by norm_num) hBB
  have hAB : 0 ≤ a * bp := mul_nonneg hxi.1 heta.2.1
  have hBA : 0 ≤ b * ap := mul_nonneg hxi.2.1 heta.1
  have hANonneg : 0 ≤ A := calc
    0 ≤ a * ap + 2 * (b * bp) := add_nonneg hAA hWBB
    _ = A := hA.symm
  have hBNonneg : 0 ≤ B := calc
    0 ≤ a * bp + b * ap := add_nonneg hAB hBA
    _ = B := hB.symm
  have hpos (x : ℚ) (hx : 0 ≤ x) : 0 < x ↔ x ≠ 0 := by
    constructor
    · intro h
      exact ne_of_gt h
    · intro h
      exact lt_of_le_of_ne hx (Ne.symm h)
  -- 本文の各四行の同値鎖。
  have hLeft : 0 < a ∨ 0 < b := by
    have hchain : (0 < a ∨ 0 < b) ↔ True := calc
      (0 < a ∨ 0 < b) ↔ (a ≠ 0 ∨ b ≠ 0) :=
        or_congr (hpos a hxi.1) (hpos b hxi.2.1)
      _ ↔ ¬ (a = 0 ∧ b = 0) := not_and_or.symm
      _ ↔ (a, b) ≠ (0, 0) := not_congr (Prod.mk_inj).symm
      _ ↔ True := iff_true_intro hxi.2.2
    exact hchain.mpr trivial
  have hRight : 0 < ap ∨ 0 < bp := by
    have hchain : (0 < ap ∨ 0 < bp) ↔ True := calc
      (0 < ap ∨ 0 < bp) ↔ (ap ≠ 0 ∨ bp ≠ 0) :=
        or_congr (hpos ap heta.1) (hpos bp heta.2.1)
      _ ↔ ¬ (ap = 0 ∧ bp = 0) := not_and_or.symm
      _ ↔ (ap, bp) ≠ (0, 0) := not_congr (Prod.mk_inj).symm
      _ ↔ True := iff_true_intro heta.2.2
    exact hchain.mpr trivial
  -- 四場合を本文と同じ下界の鎖で示す。
  have hAny : 0 < A ∨ 0 < B := by
    rcases hLeft with haPos | hbPos <;> rcases hRight with hapPos | hbpPos
    · left
      calc
        0 < a * ap := mul_pos haPos hapPos
        _ = a * ap + 0 := (add_zero _).symm
        _ ≤ a * ap + 2 * (b * bp) := _root_.add_le_add (le_refl _) hWBB
        _ = A := hA.symm
    · right
      calc
        0 < a * bp := mul_pos haPos hbpPos
        _ = a * bp + 0 := (add_zero _).symm
        _ ≤ a * bp + b * ap := _root_.add_le_add (le_refl _) hBA
        _ = B := hB.symm
    · right
      calc
        0 < b * ap := mul_pos hbPos hapPos
        _ = 0 + b * ap := (zero_add _).symm
        _ ≤ a * bp + b * ap := _root_.add_le_add hAB (le_refl _)
        _ = B := hB.symm
    · left
      have hBBpos : 0 < b * bp := mul_pos hbPos hbpPos
      calc
        0 < 2 * (b * bp) := mul_pos (by norm_num) hBBpos
        _ = 0 + 2 * (b * bp) := (zero_add _).symm
        _ ≤ a * ap + 2 * (b * bp) := _root_.add_le_add hAA (le_refl _)
        _ = A := hA.symm
  -- 末尾の四行と正錐の非負係数条件による所属。
  have hPair : (A, B) ≠ (0, 0) := by
    have hchain : ((A, B) ≠ (0, 0)) ↔ True := calc
      ((A, B) ≠ (0, 0)) ↔ ¬ (A = 0 ∧ B = 0) := not_congr Prod.mk_inj
      _ ↔ (A ≠ 0 ∨ B ≠ 0) := not_and_or
      _ ↔ (0 < A ∨ 0 < B) := (or_congr (hpos A hANonneg) (hpos B hBNonneg)).symm
      _ ↔ True := iff_true_intro hAny
    exact hchain.mpr trivial
  change quadraticCoefficientPositive (A, B)
  exact Or.inl ⟨hANonneg, hBNonneg, hPair⟩

end Ising2DLambda.FisherZero
