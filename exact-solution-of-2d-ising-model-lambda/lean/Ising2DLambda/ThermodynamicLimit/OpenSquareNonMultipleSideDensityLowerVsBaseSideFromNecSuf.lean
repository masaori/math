/-
「倍数でない辺の密度の基準辺の密度による下からの評価（q は 1 以下）」の具体版を、
必要十分版 `lower_bound_split_and_shift_necSuf` の特殊化として導く。
準備の第一〜第三（ℚ の係数・符号・有理数倍の比較と推移律）と分配則による分割は具体版と同じで、
本体（加法単調性・交換則・結合則・逆元・単位元・推移律の組み合わせ）だけを必要十分版へ委ねる。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareNonMultipleSideDensityLowerVsBaseSide
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenSquareNonMultipleSideDensityLowerVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_openSquareNonMultipleSideDensity_lower_vs_baseSide_of_le_one_from_necSuf
    (a k L : ℕ) [NeZero a] [NeZero k] [NeZero L] (h1 : k * a < L) (h2 : L ≤ k * a + a)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
      (((2 : ℚ) / (L : ℚ)) • toRational (logRat q) +
        ((2 : ℚ) / (a : ℚ)) • toRational (logRat q) +
        openScaledFreeEntropy a q +
        -(((2 * (a : ℚ)) / (L : ℚ)) •
          (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))))
      (openScaledFreeEntropy L q) := by
  have hL : (0 : ℚ) < (L : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne L)
  have hL2 : (0 : ℚ) < (L : ℚ) ^ 2 := by positivity
  set C : RationalLogOrderGroup :=
    toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)) with hC
  set Ψ : RationalLogOrderGroup := openScaledFreeEntropy (k * a) q with hΨ
  set c : ℚ := (((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2) with hc
  set d : ℚ := ((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2) with hd
  set e : ℚ := (2 * (a : ℚ)) / (L : ℚ) with he
  obtain ⟨hlow, _⟩ :=
    rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one a k L h1 h2 hq0 hq1
  have hsq : (k * a) ^ 2 ≤ L ^ 2 := Nat.pow_le_pow_left h1.le 2
  have hsum : c + d = 1 := by
    rw [hc, hd, Nat.cast_sub hsq]
    push_cast
    rw [← add_div, div_eq_one_iff_eq hL2.ne']
    ring
  have hd0 : (0 : ℚ) ≤ d := by rw [hd]; positivity
  have hde : d ≤ e := by
    have hn : ((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) ≤ ((2 * a * L : ℕ) : ℚ) := by
      exact_mod_cast sq_sub_multiple_sq_le_two_mul_nat a k L h1.le h2
    rw [hd, he]
    calc (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((2 * a * L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 * (a : ℚ)) / (L : ℚ) := by
        push_cast; field_simp
  have hC0 : rationalLogOrderLE 0 C := rationalLogOrderLE_zero_openSquareUpperBoundConstant hq0
  have hup : rationalLogOrderLE Ψ C := rationalLogOrderLE_openScaledFreeEntropy_upperBound (k * a) hq0
  have hm : rationalLogOrderLE (d • Ψ) (e • C) :=
    rationalLogOrderLE_trans (rationalLogOrderLE_ratSmul_of_nonneg hd0 hup)
      (rationalLogOrderLE_ratSmul_le_ratSmul_of_le hde hC0)
  have hsplit : Ψ = c • Ψ + d • Ψ := by
    calc Ψ = (1 : ℚ) • Ψ := (one_smul ℚ Ψ).symm
      _ = (c + d) • Ψ := by rw [hsum]
      _ = c • Ψ + d • Ψ := add_smul c d Ψ
  obtain ⟨hka, _⟩ := rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one a k hq0 hq1
  have h := NecSuf.ThermodynamicLimit.lower_bound_split_and_shift_necSuf rationalLogOrderLE
    (fun h1 h2 => rationalLogOrderLE_trans h1 h2)
    (fun z h => rationalLogOrderLE_add_right h z)
    (fun x => add_neg_cancel x)
    Ψ (c • Ψ) (d • Ψ) (e • C)
    (((2 : ℚ) / (a : ℚ)) • toRational (logRat q) + openScaledFreeEntropy a q)
    (((2 : ℚ) / (L : ℚ)) • toRational (logRat q)) (openScaledFreeEntropy L q)
    hsplit hm hka hlow
  rw [← add_assoc, ← add_assoc] at h
  exact h

end Ising2DLambda.ThermodynamicLimit
