/-
「二つの混合符号条件の和」の独立具体版。
本文の有理係数の準備、交差積比較、三場合の計算を同じ順で行う。
-/
import Ising2DLambda.FisherZero.QuadraticAddition
import Ising2DLambda.FisherZero.RationalSquareLtImpliesLt

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

set_option maxHeartbeats 1600000 in
theorem quadraticPositive_add_mixedSigns_coefficients
    (a b ap bp : ℚ)
    (ha : 0 < a) (hb : b < 0) (hSq : 2 * b * b < a * a)
    (hap : ap < 0) (hbp : 0 < bp) (hSqp : ap * ap < 2 * bp * bp) :
    (0 ≤ a + ap ∧ 0 ≤ b + bp ∧ (a + ap, b + bp) ≠ (0, 0)) ∨
      (0 < a + ap ∧ b + bp < 0 ∧
        2 * (b + bp) * (b + bp) < (a + ap) * (a + ap)) ∨
      (a + ap < 0 ∧ 0 < b + bp ∧
        (a + ap) * (a + ap) < 2 * (b + bp) * (b + bp)) := by
  let c := -ap
  let u := -b
  let A := a + ap
  let B := b + bp
  -- 本文「和の係数の書き換え」。
  have hAeq : A = a - c := by
    calc
      A = a + ap := rfl
      _ = a - (-ap) := (sub_neg_eq_add a ap).symm
      _ = a - c := rfl
  have hBeq : B = bp - u := by
    calc
      B = b + bp := rfl
      _ = bp + b := add_comm _ _
      _ = bp - (-b) := (sub_neg_eq_add bp b).symm
      _ = bp - u := rfl
  -- 本文「準備の符号と平方条件」。
  have hc : 0 < c := neg_pos.mpr hap
  have hu : 0 < u := neg_pos.mpr hb
  have huSquare : u * u = b * b := by
    calc
      u * u = (-b) * (-b) := rfl
      _ = b * b := neg_mul_neg _ _
  have hcSquare : c * c = ap * ap := by
    calc
      c * c = (-ap) * (-ap) := rfl
      _ = ap * ap := neg_mul_neg _ _
  have hSqLeft : 2 * (u * u) < a * a := by
    calc
      2 * (u * u) = 2 * (b * b) := by rw [huSquare]
      _ < a * a := by simpa only [mul_assoc] using hSq
  have hSqRight : c * c < 2 * (bp * bp) := by
    calc
      c * c = ap * ap := hcSquare
      _ < 2 * (bp * bp) := by simpa only [mul_assoc] using hSqp
  have huSq : 0 < u * u := mul_pos hu hu
  have hbpSq : 0 < bp * bp := mul_pos hbp hbp
  have hcu : 0 < c * u := mul_pos hc hu
  have hcuNonneg : 0 ≤ c * u := le_of_lt hcu
  have habp : 0 < a * bp := mul_pos ha hbp
  have habpNonneg : 0 ≤ a * bp := le_of_lt habp
  -- 本文「交差積の平方比較」。結合則と可換則を別々の行で使う。
  have hCrossSquare : (c * u) * (c * u) < (a * bp) * (a * bp) := by
    calc
      (c * u) * (c * u) = (c * (u * c)) * u := by simp only [mul_assoc]
      _ = (c * (c * u)) * u := by rw [mul_comm u c]
      _ = (c * c) * (u * u) := by simp only [mul_assoc]
      _ < (2 * (bp * bp)) * (u * u) :=
        mul_lt_mul_of_pos_right hSqRight huSq
      _ = 2 * ((bp * bp) * (u * u)) := by simp only [mul_assoc]
      _ = 2 * ((u * u) * (bp * bp)) := by rw [mul_comm (bp * bp) (u * u)]
      _ = (2 * (u * u)) * (bp * bp) := by simp only [mul_assoc]
      _ < (a * a) * (bp * bp) := mul_lt_mul_of_pos_right hSqLeft hbpSq
      _ = (a * (a * bp)) * bp := by simp only [mul_assoc]
      _ = (a * (bp * a)) * bp := by rw [mul_comm a bp]
      _ = (a * bp) * (a * bp) := by simp only [mul_assoc]
  have hCross : c * u < a * bp := by
    exact rationalSquareLtImpliesLt (c * u) (a * bp) hcuNonneg habpNonneg hCrossSquare
  by_cases hA : 0 ≤ A
  · by_cases hB : 0 ≤ B
    · -- 本文「二係数とも非負」の場合。同時零を交差積の比較で排除する。
      have hNonzero : (A, B) ≠ (0, 0) := by
        intro hPair
        have hA0 : A = 0 := congrArg Prod.fst hPair
        have hB0 : B = 0 := congrArg Prod.snd hPair
        have hca : c = a := (sub_eq_zero.mp (hAeq.symm.trans hA0)).symm
        have hubp : u = bp := (sub_eq_zero.mp (hBeq.symm.trans hB0)).symm
        have hCrossEq : c * u = a * bp := by
          calc
            c * u = a * u := by rw [hca]
            _ = a * bp := by rw [hubp]
        exact (ne_of_lt hCross) hCrossEq
      exact Or.inl ⟨hA, hB, hNonzero⟩
    · -- 本文「第二係数が負」の場合。
      have hBneg : B < 0 := lt_of_not_ge hB
      have hbpU : bp < u := sub_neg.mp (hBeq ▸ hBneg)
      have hApos : 0 < A := by
        rcases hA.eq_or_lt with hA0 | hApos
        · have hca : c = a := (sub_eq_zero.mp (hAeq.symm.trans hA0.symm)).symm
          have hOpposite : a * bp < c * u := by
            calc
              a * bp < a * u := mul_lt_mul_of_pos_left hbpU ha
              _ = c * u := by rw [hca]
          exact False.elim ((not_lt_of_ge (le_of_lt hCross)) hOpposite)
        · exact hApos
      let U := u - bp
      have hUNeg : U = -B := by
        calc
          U = u - bp := rfl
          _ = -(bp - u) := (neg_sub _ _).symm
          _ = -B := by rw [hBeq]
      have hU : 0 < U := sub_pos.mpr hbpU
      have hRatio : a * U < u * A := by
        calc
          a * U = a * (u - bp) := rfl
          _ = a * u - a * bp := mul_sub _ _ _
          _ < a * u - c * u := sub_lt_sub_left hCross _
          _ = (a - c) * u := (sub_mul _ _ _).symm
          _ = u * (a - c) := mul_comm _ _
          _ = u * A := by rw [hAeq]
      have haU : 0 < a * U := mul_pos ha hU
      have huA : 0 < u * A := mul_pos hu hApos
      have hUSq : 0 < U * U := mul_pos hU hU
      have hRatioSquare : (a * U) * (a * U) < (u * A) * (u * A) := by
        calc
          (a * U) * (a * U) < (u * A) * (a * U) :=
            mul_lt_mul_of_pos_right hRatio haU
          _ < (u * A) * (u * A) := mul_lt_mul_of_pos_left hRatio huA
      have hScaled : (u * u) * (2 * (U * U)) < (u * u) * (A * A) := by
        calc
          (u * u) * (2 * (U * U)) = ((u * u) * 2) * (U * U) :=
            (mul_assoc _ _ _).symm
          _ = (2 * (u * u)) * (U * U) := by rw [mul_comm (u * u) 2]
          _ < (a * a) * (U * U) := mul_lt_mul_of_pos_right hSqLeft hUSq
          _ = (a * (a * U)) * U := by simp only [mul_assoc]
          _ = (a * (U * a)) * U := by rw [mul_comm a U]
          _ = (a * U) * (a * U) := by simp only [mul_assoc]
          _ < (u * A) * (u * A) := hRatioSquare
          _ = (u * (A * u)) * A := by simp only [mul_assoc]
          _ = (u * (u * A)) * A := by rw [mul_comm A u]
          _ = (u * u) * (A * A) := by simp only [mul_assoc]
      have hFinal : 2 * (U * U) < A * A :=
        lt_of_mul_lt_mul_left hScaled (le_of_lt huSq)
      have hUSquare : U * U = B * B := by
        calc
          U * U = (-B) * (-B) := by rw [hUNeg]
          _ = B * B := neg_mul_neg _ _
      have hSumSquare : 2 * (B * B) < A * A := by
        calc
          2 * (B * B) = 2 * (U * U) := by rw [hUSquare]
          _ < A * A := hFinal
      exact Or.inr (Or.inl ⟨hApos, hBneg, by simpa only [mul_assoc] using hSumSquare⟩)
  · -- 本文「第一係数が負」の場合。
    have hAneg : A < 0 := lt_of_not_ge hA
    have haC : a < c := sub_neg.mp (hAeq ▸ hAneg)
    have hBpos : 0 < B := by
      by_contra hNot
      have hBnonpos : B ≤ 0 := le_of_not_gt hNot
      have hbpU : bp ≤ u := sub_nonpos.mp (hBeq ▸ hBnonpos)
      have hOpposite : a * bp < c * u := by
        calc
          a * bp < c * bp := mul_lt_mul_of_pos_right haC hbp
          _ ≤ c * u := mul_le_mul_of_nonneg_left hbpU (le_of_lt hc)
      exact (not_lt_of_ge (le_of_lt hCross)) hOpposite
    let C := c - a
    have hCNeg : C = -A := by
      calc
        C = c - a := rfl
        _ = -(a - c) := (neg_sub _ _).symm
        _ = -A := by rw [hAeq]
    have hC : 0 < C := sub_pos.mpr haC
    have hRatio : bp * C < c * B := by
      calc
        bp * C = bp * (c - a) := rfl
        _ = bp * c - bp * a := mul_sub _ _ _
        _ = c * bp - a * bp := by rw [mul_comm bp c, mul_comm bp a]
        _ < c * bp - c * u := sub_lt_sub_left hCross _
        _ = c * (bp - u) := (mul_sub _ _ _).symm
        _ = c * B := by rw [hBeq]
    have hbpC : 0 < bp * C := mul_pos hbp hC
    have hcB : 0 < c * B := mul_pos hc hBpos
    have hBSq : 0 < B * B := mul_pos hBpos hBpos
    have hRatioSquare : (bp * C) * (bp * C) < (c * B) * (c * B) := by
      calc
        (bp * C) * (bp * C) < (c * B) * (bp * C) :=
          mul_lt_mul_of_pos_right hRatio hbpC
        _ < (c * B) * (c * B) := mul_lt_mul_of_pos_left hRatio hcB
    have hScaled : (bp * bp) * (C * C) < (bp * bp) * (2 * (B * B)) := by
      calc
        (bp * bp) * (C * C) = (bp * (bp * C)) * C := by simp only [mul_assoc]
        _ = (bp * (C * bp)) * C := by rw [mul_comm bp C]
        _ = (bp * C) * (bp * C) := by simp only [mul_assoc]
        _ < (c * B) * (c * B) := hRatioSquare
        _ = (c * (B * c)) * B := by simp only [mul_assoc]
        _ = (c * (c * B)) * B := by rw [mul_comm B c]
        _ = (c * c) * (B * B) := by simp only [mul_assoc]
        _ < (2 * (bp * bp)) * (B * B) := mul_lt_mul_of_pos_right hSqRight hBSq
        _ = ((bp * bp) * 2) * (B * B) := by rw [mul_comm 2 (bp * bp)]
        _ = (bp * bp) * (2 * (B * B)) := mul_assoc _ _ _
    have hFinal : C * C < 2 * (B * B) :=
      lt_of_mul_lt_mul_left hScaled (le_of_lt hbpSq)
    have hCSquare : C * C = A * A := by
      calc
        C * C = (-A) * (-A) := by rw [hCNeg]
        _ = A * A := neg_mul_neg _ _
    have hSumSquare : A * A < 2 * (B * B) := by
      calc
        A * A = C * C := hCSquare.symm
        _ < 2 * (B * B) := hFinal
    exact Or.inr (Or.inr ⟨hAneg, hBpos, by simpa only [mul_assoc] using hSumSquare⟩)

theorem quadraticPositive_add_of_mixedSigns
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi eta : QuadraticFieldElement s)
    (hxi : 0 < (quadraticRepresentation s xi).1 ∧
      (quadraticRepresentation s xi).2 < 0 ∧
      2 * (quadraticRepresentation s xi).2 * (quadraticRepresentation s xi).2 <
        (quadraticRepresentation s xi).1 * (quadraticRepresentation s xi).1)
    (heta : (quadraticRepresentation s eta).1 < 0 ∧
      0 < (quadraticRepresentation s eta).2 ∧
      (quadraticRepresentation s eta).1 * (quadraticRepresentation s eta).1 <
        2 * (quadraticRepresentation s eta).2 * (quadraticRepresentation s eta).2) :
    quadraticAddElement s xi eta ∈ quadraticPositiveCone s := by
  -- 本文「和の表示」を係数の計算へ渡し、得られた三条件から所属を結論する。
  have hRep := quadraticRepresentation_add s hs xi eta
  change quadraticCoefficientPositive (quadraticRepresentation s (quadraticAddElement s xi eta))
  rw [hRep]
  exact quadraticPositive_add_mixedSigns_coefficients
    (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2
    (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2
    hxi.1 hxi.2.1 hxi.2.2 heta.1 heta.2.1 heta.2.2

end Ising2DLambda.FisherZero
