/-
「負の第二係数条件どうしの積」の必要十分版。
二次体・除法・順序の全比較を外す。可換環の積の並べ替えと分配、差の移項、
半順序の加法による保存・正の因子による厳密比較だけを使う。
正の二を得る単位元、負号と差を作る加法逆元は本文の同じ論法に必要である。
平方差や積の正値を追加の仮定にせず、元の六つの条件から導く。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_negativeSecond_negativeSecond_necSuf
    {α : Type} [CommRing α] [PartialOrder α] [IsStrictOrderedRing α]
    (a u ap up : α)
    (ha : 0 < a) (hu : 0 < u) (hSq : 2 * (u * u) < a * a)
    (hap : 0 < ap) (hup : 0 < up) (hSqp : 2 * (up * up) < ap * ap) :
    0 < a * ap + 2 * (u * up) ∧
      -(a * up + u * ap) < 0 ∧
      2 * ((-(a * up + u * ap)) * (-(a * up + u * ap))) <
        (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up)) := by
  let b := -u
  let bp := -up
  have hbEq : b = -u := rfl
  have hbpEq : bp = -up := rfl
  let A := a * ap + 2 * (b * bp)
  let B := a * bp + b * ap
  let V := a * up + u * ap
  let D := a * a - 2 * (u * u)
  have hTwo : (0 : α) < 2 := by norm_num
  -- 本文「四因子の並べ替え」の五つの等号。
  have hRegroup (p q r t : α) : (p * q) * (r * t) = (p * r) * (q * t) := by
    calc
      (p * q) * (r * t) = p * (q * (r * t)) := by simp only [mul_assoc]
      _ = p * ((q * r) * t) := by simp only [mul_assoc]
      _ = p * ((r * q) * t) := by rw [mul_comm q r]
      _ = p * (r * (q * t)) := by simp only [mul_assoc]
      _ = (p * r) * (q * t) := by simp only [mul_assoc]
  -- 本文「第一係数の表示」「第二係数の表示」。
  have hA : A = a * ap + 2 * (u * up) := by
    calc
      A = a * ap + 2 * (b * bp) := rfl
      _ = a * ap + 2 * ((-u) * (-up)) := by rw [hbEq, hbpEq]
      _ = a * ap + 2 * (u * up) := by rw [neg_mul_neg]
  have hB : B = -V := by
    calc
      B = a * bp + b * ap := rfl
      _ = a * (-up) + (-u) * ap := by rw [hbEq, hbpEq]
      _ = -(a * up) + (-u) * ap := by rw [mul_neg]
      _ = -(a * up) + -(u * ap) := by rw [neg_mul]
      _ = -(a * up + u * ap) := by rw [neg_add]
      _ = -V := rfl
  have hFirst : 0 < a * ap := mul_pos ha hap
  have hUU : 0 < u * up := mul_pos hu hup
  have hSecond : 0 < 2 * (u * up) := mul_pos hTwo hUU
  have hAPos : 0 < A := by
    calc
      0 < a * ap + 2 * (u * up) := add_pos hFirst hSecond
      _ = A := hA.symm
  have hLeft : 0 < a * up := mul_pos ha hup
  have hRight : 0 < u * ap := mul_pos hu hap
  have hVPos : 0 < V := by
    calc
      0 < a * up + u * ap := add_pos hLeft hRight
      _ = V := rfl
  have hBNeg : B < 0 := by
    calc
      B = -V := hB
      _ < 0 := neg_neg_of_pos hVPos
  -- 本文「正因子を掛けた比較」と移項。
  have hD : 0 < D := by
    calc
      0 < a * a - 2 * (u * u) := sub_pos.mpr hSq
      _ = D := rfl
  have hMiddle : D * (2 * (up * up)) < D * (ap * ap) :=
    mul_lt_mul_of_pos_left hSqp hD
  have hChain :
      (a * a) * (2 * (up * up)) - (2 * (u * u)) * (2 * (up * up)) <
      (a * a) * (ap * ap) - (2 * (u * u)) * (ap * ap) := by
    calc
      (a * a) * (2 * (up * up)) - (2 * (u * u)) * (2 * (up * up)) = (a * a - 2 * (u * u)) * (2 * (up * up)) := by rw [sub_mul]
      _ = D * (2 * (up * up)) := rfl
      _ < D * (ap * ap) := hMiddle
      _ = (a * a - 2 * (u * u)) * (ap * ap) := rfl
      _ = (a * a) * (ap * ap) - (2 * (u * u)) * (ap * ap) := sub_mul _ _ _
  have hMoved :
      (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) <
      (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) := by
    exact sub_lt_sub_iff.mp hChain
  -- 本文「第一係数の平方の展開」。
  have hASq : A * A =
      (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) +
      4 * ((a * ap) * (u * up)) := by
    calc
      A * A = (a * ap + 2 * (u * up)) * (a * ap + 2 * (u * up)) := by rw [hA]
      _ = (a * ap) * (a * ap + 2 * (u * up)) + (2 * (u * up)) * (a * ap + 2 * (u * up)) := add_mul _ _ _
      _ = ((a * ap) * (a * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * (u * up)) * (2 * (u * up))) := by simp only [mul_add]
      _ = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * up) * (u * up))) := by rw [hRegroup a ap a ap, hRegroup 2 (u * up) 2 (u * up)]
      _ = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * 2) * ((u * u) * (up * up))) := by rw [hRegroup u up u up]
      _ = ((a * a) * (ap * ap) + (a * ap) * (2 * (u * up))) + ((2 * (u * up)) * (a * ap) + (2 * (u * u)) * (2 * (up * up))) := by rw [hRegroup 2 (u * u) 2 (up * up)]
      _ = ((a * a) * (ap * ap) + ((a * ap) * 2) * (u * up)) + (2 * ((u * up) * (a * ap)) + (2 * (u * u)) * (2 * (up * up))) := by simp only [mul_assoc]
      _ = ((a * a) * (ap * ap) + (2 * (a * ap)) * (u * up)) + (2 * ((a * ap) * (u * up)) + (2 * (u * u)) * (2 * (up * up))) := by rw [mul_comm (a * ap) 2, mul_comm (u * up) (a * ap)]
      _ = ((a * a) * (ap * ap) + 2 * ((a * ap) * (u * up))) + (2 * ((a * ap) * (u * up)) + (2 * (u * u)) * (2 * (up * up))) := by simp only [mul_assoc]
      _ = ((a * a) * (ap * ap) + (2 * ((a * ap) * (u * up)) + 2 * ((a * ap) * (u * up)))) + (2 * (u * u)) * (2 * (up * up)) := by simp only [add_assoc]
      _ = ((a * a) * (ap * ap) + (2 + 2) * ((a * ap) * (u * up))) + (2 * (u * u)) * (2 * (up * up)) := by rw [add_mul]
      _ = ((a * a) * (ap * ap) + 4 * ((a * ap) * (u * up))) + (2 * (u * u)) * (2 * (up * up)) := by norm_num
      _ = (a * a) * (ap * ap) + (4 * ((a * ap) * (u * up)) + (2 * (u * u)) * (2 * (up * up))) := by simp only [add_assoc]
      _ = (a * a) * (ap * ap) + ((2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up))) := by rw [add_comm (4 * ((a * ap) * (u * up))) ((2 * (u * u)) * (2 * (up * up)))]
      _ = (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) := by simp only [add_assoc]
  -- 本文の最終比較。各等号・不等号は本文と同じ中間式を持つ。
  have hFinal : 2 * (B * B) < A * A := by
    calc
      2 * (B * B) = 2 * ((-V) * (-V)) := by rw [hB]
      _ = 2 * (V * V) := by rw [neg_mul_neg]
      _ = 2 * ((a * up + u * ap) * (a * up + u * ap)) := rfl
      _ = 2 * ((a * up) * (a * up + u * ap) + (u * ap) * (a * up + u * ap)) := by rw [add_mul]
      _ = 2 * (((a * up) * (a * up) + (a * up) * (u * ap)) + ((u * ap) * (a * up) + (u * ap) * (u * ap))) := by simp only [mul_add]
      _ = 2 * (((a * a) * (up * up) + (a * u) * (up * ap)) + ((u * a) * (ap * up) + (u * u) * (ap * ap))) := by rw [hRegroup a up a up, hRegroup a up u ap, hRegroup u ap a up, hRegroup u ap u ap]
      _ = 2 * (((a * a) * (up * up) + (a * u) * (ap * up)) + ((a * u) * (ap * up) + (u * u) * (ap * ap))) := by rw [mul_comm up ap, mul_comm u a]
      _ = 2 * (((a * a) * (up * up) + (a * ap) * (u * up)) + ((a * ap) * (u * up) + (u * u) * (ap * ap))) := by rw [hRegroup a u ap up]
      _ = 2 * ((a * a) * (up * up) + (a * ap) * (u * up)) + 2 * ((a * ap) * (u * up) + (u * u) * (ap * ap)) := mul_add _ _ _
      _ = (2 * ((a * a) * (up * up)) + 2 * ((a * ap) * (u * up))) + (2 * ((a * ap) * (u * up)) + 2 * ((u * u) * (ap * ap))) := by simp only [mul_add]
      _ = (2 * ((a * a) * (up * up)) + (2 * ((a * ap) * (u * up)) + 2 * ((a * ap) * (u * up)))) + 2 * ((u * u) * (ap * ap)) := by simp only [add_assoc]
      _ = (2 * ((a * a) * (up * up)) + (2 + 2) * ((a * ap) * (u * up))) + 2 * ((u * u) * (ap * ap)) := by rw [add_mul]
      _ = (2 * ((a * a) * (up * up)) + 4 * ((a * ap) * (u * up))) + 2 * ((u * u) * (ap * ap)) := by norm_num
      _ = (((2 * (a * a)) * (up * up)) + 4 * ((a * ap) * (u * up))) + (2 * (u * u)) * (ap * ap) := by simp only [mul_assoc]
      _ = ((((a * a) * 2) * (up * up)) + 4 * ((a * ap) * (u * up))) + (2 * (u * u)) * (ap * ap) := by rw [mul_comm 2 (a * a)]
      _ = ((a * a) * (2 * (up * up)) + 4 * ((a * ap) * (u * up))) + (2 * (u * u)) * (ap * ap) := by simp only [mul_assoc]
      _ = (a * a) * (2 * (up * up)) + (4 * ((a * ap) * (u * up)) + (2 * (u * u)) * (ap * ap)) := by simp only [add_assoc]
      _ = (a * a) * (2 * (up * up)) + ((2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up))) := by rw [add_comm (4 * ((a * ap) * (u * up))) ((2 * (u * u)) * (ap * ap))]
      _ = (a * a) * (2 * (up * up)) + (2 * (u * u)) * (ap * ap) + 4 * ((a * ap) * (u * up)) := by simp only [add_assoc]
      _ < (a * a) * (ap * ap) + (2 * (u * u)) * (2 * (up * up)) + 4 * ((a * ap) * (u * up)) := add_lt_add_of_lt_of_le hMoved le_rfl
      _ = A * A := hASq.symm
  refine ⟨?_, ?_, ?_⟩
  · simpa only [hA] using hAPos
  · simpa only [hB, V] using hBNeg
  · simpa only [hA, hB, V] using hFinal

end Ising2DLambda.NecSuf.FisherZero
