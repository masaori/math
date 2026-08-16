/-
人手証明「倍数でない辺の密度の基準辺の密度による上からの評価（q は 1 以下）」
（`claim_open_square_non_multiple_side_density_upper_vs_base_side_le_one`）の具体版。

`a,k ≥ 1`、`ka < L ≤ ka + a`、`0 < q ≤ 1` について
`Ψ^op_L(q) ≤_{Λ_ℚ} (2a/L)·ι(ℓ_2) + (4a/L)·ι(log(1+q)) + Ψ^op_a(q)`。

準備の第一: ℚ の係数の比較 `(ka)²/L² ≤ 1`（`ka < L` から `(ka)² ≤ L²`（ℕ の冪の単調性）、`L² > 0` で割る）。
準備の第二: 符号 `0 ≤ Ψ^op_{ka}(q)`（`claim_open_square_free_entropy_density_nonnegative` を `L := ka` で読む）。
準備の第三: 非負の元の有理数倍を係数の大小で比較し（`(ka)²/L²·Ψ_{ka} ≤ 1·Ψ_{ka} = Ψ_{ka}`）、
倍数辺の密度と基準辺の密度の差の評価の右（`Ψ_{ka} ≤ Ψ_a`）へ推移律でつなぐ。
本体: 誤差評価の右で始め、加法単調性（交換則で末尾の項を先頭へ寄せてから当てる）と推移律で二段。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityNonnegative
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideDensityVsBaseSide

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第一: `(ka)²/L² ≤ 1`。 -/
theorem multipleSide_square_ratio_le_one (a k L : ℕ) [NeZero L] (h1 : k * a < L) :
    ((((k * a : ℕ) : ℚ) ^ 2) / ((L : ℚ) ^ 2)) ≤ (1 : ℚ) := by
  have hL : (0 : ℚ) < (L : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne L)
  have hL2 : (0 : ℚ) < (L : ℚ) ^ 2 := pow_pos hL 2
  -- (ka)² ≤ L²（ℕ の冪の単調性）
  have hsq : (((k * a : ℕ) : ℚ)) ^ 2 ≤ (L : ℚ) ^ 2 := by
    exact_mod_cast Nat.pow_le_pow_left h1.le 2
  exact (div_le_one hL2).mpr hsq

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareNonMultipleSideDensity_upper_vs_baseSide_of_le_one
    (a k L : ℕ) [NeZero a] [NeZero k] [NeZero L] (h1 : k * a < L) (h2 : L ≤ k * a + a)
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE (openScaledFreeEntropy L q)
      (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
        ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)) +
        openScaledFreeEntropy a q) := by
  -- 誤差評価の右（claim_open_square_multiple_side_subsquare_density_error_bound）
  obtain ⟨_, hup⟩ :=
    rationalLogOrderLE_openSquareMultipleSideSubsquareDensity_error_bounds_of_le_one a k L h1 h2 hq0 hq1
  -- 準備の第一・第二
  have hc := multipleSide_square_ratio_le_one a k L h1
  have hn := rationalLogOrderLE_zero_openScaledFreeEntropy (k * a) hq0
  -- 準備の第三: (ka)²/L²·Ψ_{ka} ≤ 1·Ψ_{ka} = Ψ_{ka} ≤ Ψ_a
  have hm := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hc hn
  rw [one_smul] at hm
  obtain ⟨_, hka⟩ := rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one a k hq0 hq1
  have hstep := rationalLogOrderLE_trans hm hka
  -- 本体: 加法単調性（末尾の項を交換則で先頭へ寄せてから当てる）と推移律
  have h3 := rationalLogOrderLE_add_right hstep
    (((2 * (a : ℚ)) / (L : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
      ((4 * (a : ℚ)) / (L : ℚ)) • toRational (logRat (1 + q)))
  rw [add_comm _ (_ + _), add_comm (openScaledFreeEntropy a q) (_ + _)] at h3
  exact rationalLogOrderLE_trans hup h3

end Ising2DLambda.ThermodynamicLimit
