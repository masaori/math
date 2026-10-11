/-
「非負係数条件と負の第二係数条件の和」の必要十分版。
環・乗法の結合則・分配則は要求しない。係数 2 は非負の指定元へ替え、
同じ場合分けと片因子ずつの比較に使う零元則と順序の法則だけを受け取る。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_negativeSecond_necSuf
    {A : Type} (zero weight : A) (add mul : A → A → A)
    (le lt : A → A → Prop) (a b ap bp : A)
    (ha : le zero a) (hb : le zero b)
    (hap : lt zero ap) (hbp : lt bp zero)
    (hSq : lt (mul weight (mul bp bp)) (mul ap ap))
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
      (lt zero (add a ap) ∧ lt (add b bp) zero ∧
        lt (mul weight (mul (add b bp) (add b bp))) (mul (add a ap) (add a ap))) := by
  classical
  let B := add b bp
  by_cases hB : le zero B
  · have hApos : lt zero (add a ap) := hAddNonnegPos a ap ha hap
    have hAnonneg : le zero (add a ap) := hLeOfLt _ _ hApos
    have hPair : (add a ap, B) ≠ (zero, zero) := by
      intro hZero
      have hA0 : add a ap = zero := congrArg Prod.fst hZero
      exact (hNeOfLt _ _ hApos) hA0.symm
    exact Or.inl ⟨hAnonneg, hB, hPair⟩
  · have hBneg : lt B zero := hNegOfNotNonneg B hB
    -- 第二係数の三行と、負数の左右乗法を分けた平方比較。
    have hbpZero : bp = add zero bp := (hZeroAdd bp).symm
    have hbpAdd : le (add zero bp) (add b bp) := hAddRight zero b bp hb
    have hSumB : add b bp = B := rfl
    have hbpB : le bp B := (congrArg₂ le hbpZero.symm hSumB).mp hbpAdd
    have hBBp : le (mul B B) (mul bp B) :=
      hMulNonposRight bp B B hbpB (hLeOfLt _ _ hBneg)
    have hBpBp : le (mul bp B) (mul bp bp) :=
      hMulNonposLeft bp B bp hbpB (hLeOfLt _ _ hbp)
    have hBsq : le (mul B B) (mul bp bp) := hLeTrans _ _ _ hBBp hBpBp
    -- 第一係数の零元則・加法単調性と、片因子ずつの平方比較。
    have hApZero : ap = add zero ap := (hZeroAdd ap).symm
    have hApAdd : le (add zero ap) (add a ap) := hAddRight zero a ap ha
    have hApA : le ap (add a ap) := (congrArg (fun x => le x (add a ap)) hApZero).mpr hApAdd
    have hApos : lt zero (add a ap) := hLtLeTrans _ _ _ hap hApA
    have hFirstFactor : le (mul ap ap) (mul (add a ap) ap) :=
      hMulNonnegRight ap (add a ap) ap hApA (hLeOfLt _ _ hap)
    have hSecondFactor : le (mul (add a ap) ap) (mul (add a ap) (add a ap)) :=
      hMulNonnegLeft ap (add a ap) (add a ap) hApA (hLeOfLt _ _ hApos)
    have hAsq : le (mul ap ap) (mul (add a ap) (add a ap)) :=
      hLeTrans _ _ _ hFirstFactor hSecondFactor
    have hScale : le (mul weight (mul B B)) (mul weight (mul bp bp)) :=
      hMulNonnegLeft _ _ weight hBsq hWeight
    have hMiddle : lt (mul weight (mul B B)) (mul ap ap) := hLeLtTrans _ _ _ hScale hSq
    have hSumSq : lt (mul weight (mul B B)) (mul (add a ap) (add a ap)) :=
      hLtLeTrans _ _ _ hMiddle hAsq
    exact Or.inr ⟨hApos, hBneg, hSumSq⟩

end Ising2DLambda.NecSuf.FisherZero
