/-
人手証明「倍数でない辺の密度の基準辺の密度による下からの評価（q は 1 以下）」
（`claim_open_square_non_multiple_side_density_lower_vs_base_side_le_one`）の具体版。

`a,k ≥ 1`、`ka < L ≤ ka + a`、`0 < q ≤ 1` について
`(2/L)·ι(log q) + (2/a)·ι(log q) + Ψ^op_a(q) + (−(2a/L)·C) ≤_{Λ_ℚ} Ψ^op_L(q)`、
`C := ι(ℓ_2) + 2·ι(log(1+q))`。

準備の第一: ℚ の係数 `(ka)²/L² + (L²−(ka)²)/L² = 1`、`0 ≤ (L²−(ka)²)/L² ≤ 2a/L`
（`claim_square_difference_from_multiple_side_bound`、`L² > 0` で割る）。
準備の第二: 符号 `0 ≤ C`（`0 = 2·0 ≤ 2·ι(log(1+q)) = 0 + 2·ι(log(1+q)) ≤ ι(ℓ_2) + 2·ι(log(1+q))`）。
準備の第三: `(L²−(ka)²)/L²·Ψ_{ka} ≤ (L²−(ka)²)/L²·C ≤ (2a/L)·C`
（上からの評価を `L := ka` で読む、非負有理数倍の順序保存、非負の元の係数の大小による比較、推移律）。
本体 (1): `Ψ_{ka} = 1·Ψ_{ka} = (c+d)·Ψ_{ka} = c·Ψ_{ka} + d·Ψ_{ka} ≤ c·Ψ_{ka} + e·C`（加法単調性。交換則で寄せる）。
本体 (2): 両辺に `−e·C` を足し、結合則・逆元・単位元で `Ψ_{ka} + (−e·C) ≤ c·Ψ_{ka}`。
本体 (3): 主張の左辺を結合則で組み直し、倍数辺の差の評価の左に `−e·C` と `(2/L)·ι(log q)` を足したもの、
(2) に `(2/L)·ι(log q)` を足したもの、誤差評価の左へ推移律。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityUpperBound
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideDensityVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第二: `0 ≤_{Λ_ℚ} C := ι(ℓ_2) + 2·ι(log(1+q))`。 -/
theorem rationalLogOrderLE_zero_openSquareUpperBoundConstant {q : ℚ} (hq0 : 0 < q) :
    rationalLogOrderLE 0
      (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  have h2 := rationalLogOrderLE_zero_toRational_generator_two
  have h3 := rationalLogOrderLE_zero_toRational_logRat_one_add hq0
  -- 0 = 2·0 ≤ 2·ι(log(1+q))（非負有理数倍の順序保存を c := 2、λ := 0、μ := ι(log(1+q)) で読む）
  have hs : rationalLogOrderLE 0 ((2 : ℚ) • toRational (logRat (1 + q))) := by
    have h := rationalLogOrderLE_ratSmul_of_nonneg (by norm_num : (0 : ℚ) ≤ 2) h3
    rwa [smul_zero] at h
  -- 0 + 2·ι(log(1+q)) ≤ ι(ℓ_2) + 2·ι(log(1+q))（加法単調性）、単位元
  have ha := rationalLogOrderLE_add_right h2 ((2 : ℚ) • toRational (logRat (1 + q)))
  rw [zero_add] at ha
  exact rationalLogOrderLE_trans hs ha

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareNonMultipleSideDensity_lower_vs_baseSide_of_le_one
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
  -- 誤差評価の左（claim_open_square_multiple_side_subsquare_density_error_bound）
  obtain ⟨hlow, _⟩ :=
    rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one a k L h1 h2 hq0 hq1
  -- 準備の第一: ℚ の係数
  have hsq : (k * a) ^ 2 ≤ L ^ 2 := Nat.pow_le_pow_left h1.le 2
  have hsum : c + d = 1 := by
    rw [hc, hd, Nat.cast_sub hsq]
    push_cast
    rw [← add_div, div_eq_one_iff_eq hL2.ne']
    ring
  have hd0 : (0 : ℚ) ≤ d := by rw [hd]; positivity
  have hde : d ≤ e := by
    -- claim_square_difference_from_multiple_side_bound、L² > 0 で割る、2aL/L² = 2a/L
    have hn : ((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) ≤ ((2 * a * L : ℕ) : ℚ) := by
      exact_mod_cast sq_sub_multiple_sq_le_two_mul_nat a k L h1.le h2
    rw [hd, he]
    calc (((L ^ 2 - (k * a) ^ 2 : ℕ) : ℚ) / ((L : ℚ) ^ 2))
        ≤ ((2 * a * L : ℕ) : ℚ) / ((L : ℚ) ^ 2) := div_le_div_of_nonneg_right hn hL2.le
      _ = (2 * (a : ℚ)) / (L : ℚ) := by
        push_cast; field_simp
  -- 準備の第二: 符号 0 ≤ C
  have hC0 : rationalLogOrderLE 0 C := rationalLogOrderLE_zero_openSquareUpperBoundConstant hq0
  -- 準備の第三: Ψ_{ka} ≤ C（上からの評価を L := ka で読む）、d·Ψ_{ka} ≤ d·C ≤ e·C
  have hup : rationalLogOrderLE Ψ C := rationalLogOrderLE_openScaledFreeEntropy_upperBound (k * a) hq0
  have hm1 := rationalLogOrderLE_ratSmul_of_nonneg hd0 hup
  have hm2 := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hde hC0
  have hm : rationalLogOrderLE (d • Ψ) (e • C) := rationalLogOrderLE_trans hm1 hm2
  -- 本体 (1): Ψ_{ka} = 1·Ψ = (c+d)·Ψ = c·Ψ + d·Ψ ≤ c·Ψ + e·C
  have hsplit : Ψ = c • Ψ + d • Ψ := by
    calc Ψ = (1 : ℚ) • Ψ := (one_smul ℚ Ψ).symm
      _ = (c + d) • Ψ := by rw [hsum]
      _ = c • Ψ + d • Ψ := add_smul c d Ψ
  have h1' : rationalLogOrderLE Ψ (c • Ψ + e • C) := by
    have h := rationalLogOrderLE_add_right hm (c • Ψ)
    rw [add_comm (d • Ψ) (c • Ψ), add_comm (e • C) (c • Ψ), ← hsplit] at h
    exact h
  -- 本体 (2): 両辺に −e·C を足す。結合則・逆元・単位元
  have hshift : rationalLogOrderLE (Ψ + -(e • C)) (c • Ψ) := by
    have h := rationalLogOrderLE_add_right h1' (-(e • C))
    rw [add_assoc, add_neg_cancel, add_zero] at h
    exact h
  -- 本体 (3)
  obtain ⟨hka, _⟩ := rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one a k hq0 hq1
  -- 倍数辺の差の評価の左に −e·C を足し、さらに (2/L)·ι(log q) を足す（交換則で先頭へ寄せる）
  have h3 := rationalLogOrderLE_add_right (rationalLogOrderLE_add_right hka (-(e • C)))
    (((2 : ℚ) / (L : ℚ)) • toRational (logRat q))
  rw [add_comm _ (((2 : ℚ) / (L : ℚ)) • toRational (logRat q)),
    add_comm (Ψ + -(e • C)) (((2 : ℚ) / (L : ℚ)) • toRational (logRat q))] at h3
  -- (2) に (2/L)·ι(log q) を足す（交換則で先頭へ寄せる）
  have h4 := rationalLogOrderLE_add_right hshift (((2 : ℚ) / (L : ℚ)) • toRational (logRat q))
  rw [add_comm (Ψ + -(e • C)) (((2 : ℚ) / (L : ℚ)) • toRational (logRat q)),
    add_comm (c • Ψ) (((2 : ℚ) / (L : ℚ)) • toRational (logRat q))] at h4
  -- 推移律で誤差評価の左へ。主張の左辺は結合則（二回）で組み直す
  have h5 := rationalLogOrderLE_trans h3 (rationalLogOrderLE_trans h4 hlow)
  rw [← add_assoc, ← add_assoc] at h5
  exact h5

end Ising2DLambda.ThermodynamicLimit
