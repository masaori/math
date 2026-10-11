/-
「正錐の非負係数条件どうしの積」の必要十分版。
部分順序は非負係数の正値性と非零性の同値、および不等式の推移に使う。
加法零元、非負和・非負積・正積、非負加数を足す単調性だけを使い、
環・全順序・演算の結合則・可換則・分配則は要求しない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_necSuf
    {R : Type*} [PartialOrder R]
    (zero weight : R) (add mul : R → R → R) (a b ap bp : R)
    (ha : zero ≤ a) (hb : zero ≤ b) (hap : zero ≤ ap) (hbp : zero ≤ bp)
    (hab : (a, b) ≠ (zero, zero)) (hapbp : (ap, bp) ≠ (zero, zero))
    (hWeight : zero < weight)
    (hAddZero : ∀ x, add x zero = x) (hZeroAdd : ∀ x, add zero x = x)
    (hAddNonneg : ∀ x y, zero ≤ x → zero ≤ y → zero ≤ add x y)
    (hMulNonneg : ∀ x y, zero ≤ x → zero ≤ y → zero ≤ mul x y)
    (hMulPos : ∀ x y, zero < x → zero < y → zero < mul x y)
    (hAddRight : ∀ x y, zero ≤ y → add x zero ≤ add x y)
    (hAddLeft : ∀ x y, zero ≤ x → add zero y ≤ add x y) :
    zero ≤ add (mul a ap) (mul weight (mul b bp)) ∧
    zero ≤ add (mul a bp) (mul b ap) ∧
    (add (mul a ap) (mul weight (mul b bp)), add (mul a bp) (mul b ap)) ≠
      (zero, zero) := by
  let first := add (mul a ap) (mul weight (mul b bp))
  let second := add (mul a bp) (mul b ap)
  -- 本文の五つの非負積と、二係数の非負性の二行ずつの鎖。
  have hAA : zero ≤ mul a ap := hMulNonneg a ap ha hap
  have hBB : zero ≤ mul b bp := hMulNonneg b bp hb hbp
  have hWBB : zero ≤ mul weight (mul b bp) :=
    hMulNonneg weight (mul b bp) (le_of_lt hWeight) hBB
  have hAB : zero ≤ mul a bp := hMulNonneg a bp ha hbp
  have hBA : zero ≤ mul b ap := hMulNonneg b ap hb hap
  have hFirst : zero ≤ first := calc
    zero ≤ add (mul a ap) (mul weight (mul b bp)) := hAddNonneg _ _ hAA hWBB
    _ = first := rfl
  have hSecond : zero ≤ second := calc
    zero ≤ add (mul a bp) (mul b ap) := hAddNonneg _ _ hAB hBA
    _ = second := rfl
  have hpos (x : R) (hx : zero ≤ x) : zero < x ↔ x ≠ zero := by
    constructor
    · intro h
      exact ne_of_gt h
    · intro h
      exact lt_of_le_of_ne hx (Ne.symm h)
  -- 本文の各四行の同値鎖。入力の非零性から正係数を選ぶ。
  have hLeft : zero < a ∨ zero < b := by
    have hchain : (zero < a ∨ zero < b) ↔ True := calc
      (zero < a ∨ zero < b) ↔ (a ≠ zero ∨ b ≠ zero) :=
        or_congr (hpos a ha) (hpos b hb)
      _ ↔ ¬ (a = zero ∧ b = zero) := not_and_or.symm
      _ ↔ (a, b) ≠ (zero, zero) := not_congr (Prod.mk_inj).symm
      _ ↔ True := iff_true_intro hab
    exact hchain.mpr trivial
  have hRight : zero < ap ∨ zero < bp := by
    have hchain : (zero < ap ∨ zero < bp) ↔ True := calc
      (zero < ap ∨ zero < bp) ↔ (ap ≠ zero ∨ bp ≠ zero) :=
        or_congr (hpos ap hap) (hpos bp hbp)
      _ ↔ ¬ (ap = zero ∧ bp = zero) := not_and_or.symm
      _ ↔ (ap, bp) ≠ (zero, zero) := not_congr (Prod.mk_inj).symm
      _ ↔ True := iff_true_intro hapbp
    exact hchain.mpr trivial
  -- 本文の四場合。正積、加法零元、単調性、係数の表示の順にたどる。
  have hAny : zero < first ∨ zero < second := by
    rcases hLeft with haPos | hbPos <;> rcases hRight with hapPos | hbpPos
    · left
      calc
        zero < mul a ap := hMulPos a ap haPos hapPos
        _ = add (mul a ap) zero := (hAddZero _).symm
        _ ≤ add (mul a ap) (mul weight (mul b bp)) := hAddRight _ _ hWBB
        _ = first := rfl
    · right
      calc
        zero < mul a bp := hMulPos a bp haPos hbpPos
        _ = add (mul a bp) zero := (hAddZero _).symm
        _ ≤ add (mul a bp) (mul b ap) := hAddRight _ _ hBA
        _ = second := rfl
    · right
      calc
        zero < mul b ap := hMulPos b ap hbPos hapPos
        _ = add zero (mul b ap) := (hZeroAdd _).symm
        _ ≤ add (mul a bp) (mul b ap) := hAddLeft _ _ hAB
        _ = second := rfl
    · left
      have hBBpos : zero < mul b bp := hMulPos b bp hbPos hbpPos
      calc
        zero < mul weight (mul b bp) := hMulPos weight (mul b bp) hWeight hBBpos
        _ = add zero (mul weight (mul b bp)) := (hZeroAdd _).symm
        _ ≤ add (mul a ap) (mul weight (mul b bp)) := hAddLeft _ _ hAA
        _ = first := rfl
  -- 本文の末尾四行。出力の正係数を組の非零性へ戻す。
  have hPair : (first, second) ≠ (zero, zero) := by
    have hchain : ((first, second) ≠ (zero, zero)) ↔ True := calc
      ((first, second) ≠ (zero, zero)) ↔ ¬ (first = zero ∧ second = zero) :=
        not_congr Prod.mk_inj
      _ ↔ (first ≠ zero ∨ second ≠ zero) := not_and_or
      _ ↔ (zero < first ∨ zero < second) :=
        (or_congr (hpos first hFirst) (hpos second hSecond)).symm
      _ ↔ True := iff_true_intro hAny
    exact hchain.mpr trivial
  exact ⟨hFirst, hSecond, hPair⟩

end Ising2DLambda.NecSuf.FisherZero
