/-
人手証明「開境界正方形と部分正方形の値の比較（t は 1 以下）」の具体版。

  人手証明の段                                          Lean
  c := L - a、L = a + c                                 Nat.exists_eq_add_of_le
  ac + cL = L² − a²                                     hexp
  値はすべて正                                          openPartitionValue_pos
  下側: t^{a+L}Z_{a,a} = t^L t^a Z_{a,a}                pow_add
        ≤ t^L t^a Z_{a,a} Z_{a,c}（1 ≤ Z_{a,c}）        one_le_openPartitionValue
        ≤ t^L Z_{a,a+c}（第二座標方向の接合の下側）      openPartitionValue_glueSecond_bounds_of_le_one
        ≤ t^L Z_{a,L} Z_{c,L}（1 ≤ Z_{c,L}）            one_le_openPartitionValue
        ≤ Z_{a+c,L}（第一座標方向の接合の下側）          openPartitionValue_glueFirst_bounds_of_le_one
  上側: Z_{L,L} ≤ Z_{a,L}Z_{c,L}                        openPartitionValue_glueFirst_bounds_of_le_one
        ≤ Z_{a,a}Z_{a,c}Z_{c,L}                         openPartitionValue_glueSecond_bounds_of_le_one
        ≤ Z_{a,a}2^{ac}Z_{c,L} ≤ Z_{a,a}2^{ac}2^{cL}    openPartitionValue_le_configurationCount_of_le_one
        = 2^{L²−a²}Z_{a,a}                              hexp
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleGluingInequality
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueAtLeastOne
import Ising2DLambda.ThermodynamicLimit.OpenRectangleValueUpperBound

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_open_square_subsquare_comparison_le_one` の具体版。 -/
theorem openPartitionValue_square_subsquare_bounds_of_le_one
    (a L : ℕ) (ha : 0 < a) (haL : a < L) {t : ℝ} (ht0 : 0 < t) (ht1 : t ≤ 1) :
    t ^ (a + L) * openPartitionValue a a t ≤ openPartitionValue L L t ∧
      openPartitionValue L L t ≤
        ((2 ^ (L ^ 2 - a ^ 2) : ℕ) : ℝ) * openPartitionValue a a t := by
  -- c := L − a、L = a + c
  obtain ⟨c, rfl⟩ := Nat.exists_eq_add_of_le haL.le
  have hc : 0 < c := by omega
  -- ac + cL = L² − a²
  have hexp : (a + c) ^ 2 - a ^ 2 = a * c + c * (a + c) :=
    Nat.sub_eq_of_eq_add (by ring)
  -- 値はすべて正
  have hZaa := (openPartitionValue_pos a a ht0).le
  have hZaL := (openPartitionValue_pos a (a + c) ht0).le
  have hZcL := (openPartitionValue_pos c (a + c) ht0).le
  have hpL : 0 ≤ t ^ (a + c) := (pow_pos_by_induction ht0 _).le
  have hpa : 0 ≤ t ^ a := (pow_pos_by_induction ht0 _).le
  have h1ac := one_le_openPartitionValue a c ht0
  have h1cL := one_le_openPartitionValue c (a + c) ht0
  obtain ⟨hsecond_lo, hsecond_hi⟩ :=
    openPartitionValue_glueSecond_bounds_of_le_one (a := a) (b := a) (c := c) ha hc ht0 ht1
  obtain ⟨hfirst_lo, hfirst_hi⟩ :=
    openPartitionValue_glueFirst_bounds_of_le_one (a := a) (b := a + c) (c := c) ha hc ht0 ht1
  have hBac := openPartitionValue_le_configurationCount_of_le_one a c ht0 ht1
  have hBcL := openPartitionValue_le_configurationCount_of_le_one c (a + c) ht0 ht1
  constructor
  · calc
      t ^ (a + (a + c)) * openPartitionValue a a t
          = t ^ (a + c) * (t ^ a * openPartitionValue a a t) := by
            rw [pow_add]; ring
      _ ≤ t ^ (a + c) * (t ^ a * (openPartitionValue a a t * openPartitionValue a c t)) :=
            mul_le_mul_of_nonneg_left
              (mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaa h1ac) hpa) hpL
      _ ≤ t ^ (a + c) * openPartitionValue a (a + c) t :=
            mul_le_mul_of_nonneg_left hsecond_lo hpL
      _ ≤ t ^ (a + c) * (openPartitionValue a (a + c) t * openPartitionValue c (a + c) t) :=
            mul_le_mul_of_nonneg_left (le_mul_of_one_le_right hZaL h1cL) hpL
      _ ≤ openPartitionValue (a + c) (a + c) t := hfirst_lo
  · calc
      openPartitionValue (a + c) (a + c) t
          ≤ openPartitionValue a (a + c) t * openPartitionValue c (a + c) t := hfirst_hi
      _ ≤ (openPartitionValue a a t * openPartitionValue a c t) * openPartitionValue c (a + c) t :=
            mul_le_mul_of_nonneg_right hsecond_hi hZcL
      _ ≤ (openPartitionValue a a t * ((2 ^ (a * c) : ℕ) : ℝ)) * openPartitionValue c (a + c) t :=
            mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hBac hZaa) hZcL
      _ ≤ (openPartitionValue a a t * ((2 ^ (a * c) : ℕ) : ℝ)) * ((2 ^ (c * (a + c)) : ℕ) : ℝ) :=
            mul_le_mul_of_nonneg_left hBcL
              (mul_nonneg hZaa (Nat.cast_nonneg _))
      _ = ((2 ^ ((a + c) ^ 2 - a ^ 2) : ℕ) : ℝ) * openPartitionValue a a t := by
            rw [hexp]; push_cast; ring

end Ising2DLambda.ThermodynamicLimit
