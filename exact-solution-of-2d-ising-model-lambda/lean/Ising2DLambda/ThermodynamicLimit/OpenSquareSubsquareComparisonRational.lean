/-
章「熱力学極限」の「開境界正方形と部分正方形の値の比較（正の有理点、q は 1 以下）」
（`claim_open_square_subsquare_comparison_rational_le_one`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明の段                                          Lean
  c := L − a、L = a + c                                 Nat.exists_eq_add_of_le
  ac + cL = L² − a²                                     hexp
  値はすべて正                                          openPartitionValueRat_pos
  下側: q^{a+L}Z_{a,a} = q^L (q^a Z_{a,a})              pow_add
        ≤ q^L (q^a Z_{a,a} Z_{a,c})（1 ≤ Z_{a,c}）      one_le_openPartitionValueRat
        ≤ q^L Z_{a,a+c}（第二座標方向の接合の下側）      openPartitionValueRat_glueSecond_bounds_of_le_one
        ≤ q^L Z_{a,L} Z_{c,L}（1 ≤ Z_{c,L}）            one_le_openPartitionValueRat
        ≤ Z_{a+c,L}（第一座標方向の接合の下側）          openPartitionValueRat_glueFirst_bounds_of_le_one
  上側: Z_{L,L} ≤ Z_{a,L}Z_{c,L}                        openPartitionValueRat_glueFirst_bounds_of_le_one
        ≤ Z_{a,a}Z_{a,c}Z_{c,L}                         openPartitionValueRat_glueSecond_bounds_of_le_one
        ≤ Z_{a,a}·B_{a,c}·Z_{c,L} ≤ Z_{a,a}·B_{a,c}·B_{c,L}   openPartitionValueRat_le_upperBound
          （B_{a,b} := 2^{ab}(1+q)^{2ab}）
        = 2^{L²−a²}(1+q)^{2(L²−a²)}Z_{a,a}              hexp・冪の指数法則
住処は ℕ・ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequalityRational
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueGeOneRational
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueUpperBoundRational

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

/-- `claim_open_square_subsquare_comparison_rational_le_one` の具体版。 -/
theorem openPartitionValueRat_square_subsquare_bounds_of_le_one
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ (a + L) * openPartitionValueRat a a q ≤ openPartitionValueRat L L q ∧
      openPartitionValueRat L L q ≤
        ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * (L ^ 2 - a ^ 2)) *
          openPartitionValueRat a a q := by
  -- c := L − a、L = a + c
  obtain ⟨c, rfl⟩ := Nat.exists_eq_add_of_le haL.le
  have hc : 0 < c := by omega
  -- ac + cL = L² − a²
  have hexp : (a + c) ^ 2 - a ^ 2 = a * c + c * (a + c) :=
    Nat.sub_eq_of_eq_add (by ring)
  -- 値はすべて正
  have hZaa := (openPartitionValueRat_pos a a hq0).le
  have hZaL := (openPartitionValueRat_pos a (a + c) hq0).le
  have hZcL := (openPartitionValueRat_pos c (a + c) hq0).le
  have hpL : 0 ≤ q ^ (a + c) := (pow_pos_by_induction hq0 _).le
  have hpa : 0 ≤ q ^ a := (pow_pos_by_induction hq0 _).le
  have hBac : 0 ≤ ((2 ^ (a * c) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * c)) :=
    mul_nonneg (Nat.cast_nonneg _) (pow_pos_by_induction (by linarith) _).le
  have h1ac := one_le_openPartitionValueRat a c hq0
  have h1cL := one_le_openPartitionValueRat c (a + c) hq0
  obtain ⟨hsecond_lo, hsecond_hi⟩ :=
    openPartitionValueRat_glueSecond_bounds_of_le_one (a := a) (b := a) (c := c) ha hc hq0 hq1
  obtain ⟨hfirst_lo, hfirst_hi⟩ :=
    openPartitionValueRat_glueFirst_bounds_of_le_one (a := a) (b := a + c) (c := c) ha hc hq0 hq1
  have hUac := openPartitionValueRat_le_upperBound a c hq0
  have hUcL := openPartitionValueRat_le_upperBound c (a + c) hq0
  constructor
  · calc
      q ^ (a + (a + c)) * openPartitionValueRat a a q
          = q ^ (a + c) * (q ^ a * openPartitionValueRat a a q) := by
            rw [pow_add]; ring
      _ ≤ q ^ (a + c) * (q ^ a * (openPartitionValueRat a a q * openPartitionValueRat a c q)) :=
            mul_le_mul_of_nonneg_left
              (mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaa h1ac) hpa) hpL
      _ ≤ q ^ (a + c) * openPartitionValueRat a (a + c) q :=
            mul_le_mul_of_nonneg_left hsecond_lo hpL
      _ ≤ q ^ (a + c) * (openPartitionValueRat a (a + c) q * openPartitionValueRat c (a + c) q) :=
            mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaL h1cL) hpL
      _ ≤ openPartitionValueRat (a + c) (a + c) q := hfirst_lo
  · calc
      openPartitionValueRat (a + c) (a + c) q
          ≤ openPartitionValueRat a (a + c) q * openPartitionValueRat c (a + c) q := hfirst_hi
      _ ≤ (openPartitionValueRat a a q * openPartitionValueRat a c q) *
            openPartitionValueRat c (a + c) q :=
            mul_le_mul_of_nonneg_right hsecond_hi hZcL
      _ ≤ (openPartitionValueRat a a q * (((2 ^ (a * c) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * c)))) *
            openPartitionValueRat c (a + c) q :=
            mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hUac hZaa) hZcL
      _ ≤ (openPartitionValueRat a a q * (((2 ^ (a * c) : ℕ) : ℚ) * (1 + q) ^ (2 * (a * c)))) *
            (((2 ^ (c * (a + c)) : ℕ) : ℚ) * (1 + q) ^ (2 * (c * (a + c)))) :=
            mul_le_mul_of_nonneg_left hUcL (mul_nonneg hZaa hBac)
      _ = ((2 ^ ((a + c) ^ 2 - a ^ 2) : ℕ) : ℚ) * (1 + q) ^ (2 * ((a + c) ^ 2 - a ^ 2)) *
            openPartitionValueRat a a q := by
            rw [hexp]; push_cast; ring

end Ising2DLambda.ThermodynamicLimit
