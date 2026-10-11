/-
「非負係数条件と負の第一係数条件の和」の必要十分版。
環・乗法の結合則・分配則は要求しない。係数 2 は非負の指定元へ替え、
同じ場合分けと片因子ずつの比較に使う零元則と順序の法則だけを受け取る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_negativeFirst_necSuf
    {A : Type} (zero weight : A) (add mul : A → A → A)
    (le lt : A → A → Prop) (a b ap bp : A)
    (ha : le zero a) (hb : le zero b)
    (hap : lt ap zero) (hbp : lt zero bp)
    (hSq : lt (mul ap ap) (mul weight (mul bp bp)))
    (hWeight : le zero weight)
    (hZeroAdd : ∀ x, add zero x = x)
    (hLeOfLt : ∀ x y, lt x y → le x y)
    (hNeOfLt : ∀ x y, lt x y → x ≠ y)
    (hNegOfNotNonneg : ∀ x, ¬ le zero x → lt x zero)
    (hLeTrans : ∀ x y z, le x y → le y z → le x z)
    (hLeLtTrans : ∀ x y z, le x y → lt y z → lt x z)
    (hLtLeTrans : ∀ x y z, lt x y → le y z → lt x z)
    (hAddNonnegPos : ∀ x y, le zero x → lt zero y → lt zero (add x y))
    (hAddRight : ∀ x y z, le x y → le (add x z) (add y z))
    (hMulNonnegRight : ∀ x y z, le x y → le zero z → le (mul x z) (mul y z))
    (hMulNonnegLeft : ∀ x y z, le x y → le zero z → le (mul z x) (mul z y))
    (hMulNonposRight : ∀ x y z, le x y → le z zero → le (mul y z) (mul x z))
    (hMulNonposLeft : ∀ x y z, le x y → le z zero → le (mul z y) (mul z x)) :
    (le zero (add a ap) ∧ le zero (add b bp) ∧
      (add a ap, add b bp) ≠ (zero, zero)) ∨
      (lt (add a ap) zero ∧ lt zero (add b bp) ∧
        lt (mul (add a ap) (add a ap)) (mul weight (mul (add b bp) (add b bp)))) := by
  classical
  let firstSum := add a ap
  by_cases hA : le zero firstSum
  · have hBpos : lt zero (add b bp) := hAddNonnegPos b bp hb hbp
    have hBnonneg : le zero (add b bp) := hLeOfLt _ _ hBpos
    have hPair : (firstSum, add b bp) ≠ (zero, zero) := by
      intro hZero
      have hB0 : add b bp = zero := congrArg Prod.snd hZero
      exact (hNeOfLt _ _ hBpos) hB0.symm
    exact Or.inl ⟨hA, hBnonneg, hPair⟩
  · have hAneg : lt firstSum zero := hNegOfNotNonneg firstSum hA
    have hapZero : ap = add zero ap := (hZeroAdd ap).symm
    have hapAdd : le (add zero ap) (add a ap) := hAddRight zero a ap ha
    have hSumA : add a ap = firstSum := rfl
    have hapA : le ap firstSum := (congrArg₂ le hapZero.symm hSumA).mp hapAdd
    have hAAp : le (mul firstSum firstSum) (mul ap firstSum) :=
      hMulNonposRight ap firstSum firstSum hapA (hLeOfLt _ _ hAneg)
    have hApAp : le (mul ap firstSum) (mul ap ap) :=
      hMulNonposLeft ap firstSum ap hapA (hLeOfLt _ _ hap)
    have hAsq : le (mul firstSum firstSum) (mul ap ap) := hLeTrans _ _ _ hAAp hApAp
    have hbpZero : bp = add zero bp := (hZeroAdd bp).symm
    have hbpAdd : le (add zero bp) (add b bp) := hAddRight zero b bp hb
    have hbpB : le bp (add b bp) := (congrArg (fun x => le x (add b bp)) hbpZero).mpr hbpAdd
    have hBpos : lt zero (add b bp) := hLtLeTrans _ _ _ hbp hbpB
    have hFirstFactor : le (mul bp bp) (mul (add b bp) bp) :=
      hMulNonnegRight bp (add b bp) bp hbpB (hLeOfLt _ _ hbp)
    have hSecondFactor : le (mul (add b bp) bp) (mul (add b bp) (add b bp)) :=
      hMulNonnegLeft bp (add b bp) (add b bp) hbpB (hLeOfLt _ _ hBpos)
    have hBsq : le (mul bp bp) (mul (add b bp) (add b bp)) :=
      hLeTrans _ _ _ hFirstFactor hSecondFactor
    have hMiddle : lt (mul firstSum firstSum) (mul weight (mul bp bp)) :=
      hLeLtTrans _ _ _ hAsq hSq
    have hScale : le (mul weight (mul bp bp)) (mul weight (mul (add b bp) (add b bp))) :=
      hMulNonnegLeft _ _ weight hBsq hWeight
    have hSumSq : lt (mul firstSum firstSum) (mul weight (mul (add b bp) (add b bp))) :=
      hLtLeTrans _ _ _ hMiddle hScale
    exact Or.inr ⟨hAneg, hBpos, hSumSq⟩

end Ising2DLambda.NecSuf.FisherZero
