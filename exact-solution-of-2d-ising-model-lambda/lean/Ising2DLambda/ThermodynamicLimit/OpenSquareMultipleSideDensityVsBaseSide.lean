/-
人手証明「倍数辺の密度と基準辺の密度の差の評価（q は 1 以下）」
（`claim_open_square_multiple_side_density_vs_base_side_le_one`）の具体版。

`a,k ≥ 1`、`0 < q ≤ 1` について
`(2/a)·ι(log q) + Ψ^op_a(q) ≤_{Λ_ℚ} Ψ^op_{ka}(q) ≤_{Λ_ℚ} Ψ^op_a(q)`。

準備の第一: ℚ の係数の比較 `2(k−1)/(ka) ≤ 2k/(ka) = 2/a`。
準備の第二: 符号 `ι(log q) ≤ 0`（`claim_rational_embedded_log_order_iff` を `q' := 1` で読み、
`log 1 = 0`・`ι(0) = 0`。誤差評価の補助定理 `rationalLogOrderLE_toRational_logRat_nonpos_of_le_one`）。
準備の第三: 非正の元の有理数倍を係数の大小で比較する。
本体: 加法単調性と推移律で左は二段。右はブロック敷き詰め密度の右そのもの。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareBlockTilingDensity
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideSubsquareDensityErrorBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第一: `2(k−1)/(ka) ≤ 2/a`。 -/
theorem blockTiling_lower_coefficient_le_two_div (a k : ℕ) [NeZero a] [NeZero k] :
    (2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a) ≤ (2 : ℚ) / (a : ℚ) := by
  have ha : (0 : ℚ) < (a : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne a)
  have hk : (0 : ℚ) < (k : ℚ) := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne k)
  have hka : (0 : ℚ) < (k : ℚ) * a := mul_pos hk ha
  -- k − 1 ≤ k（ℕ の順序）に正数 2/(ka) を掛ける
  have hn : ((k - 1 : ℕ) : ℚ) ≤ (k : ℚ) := by exact_mod_cast Nat.sub_le k 1
  calc (2 * ((k - 1 : ℕ) : ℚ)) / ((k : ℚ) * a)
      ≤ (2 * (k : ℚ)) / ((k : ℚ) * a) :=
        div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_left hn (by norm_num)) hka.le
    _ = (2 : ℚ) / (a : ℚ) := by
        -- k ≠ 0 による約分
        field_simp

/-- 主張。 -/
theorem rationalLogOrderLE_openSquareMultipleSideDensity_vs_baseSide_of_le_one
    (a k : ℕ) [NeZero a] [NeZero k] {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE
        (((2 : ℚ) / (a : ℚ)) • toRational (logRat q) + openScaledFreeEntropy a q)
        (openScaledFreeEntropy (k * a) q) ∧
      rationalLogOrderLE (openScaledFreeEntropy (k * a) q) (openScaledFreeEntropy a q) := by
  -- ブロック敷き詰め密度（claim_open_square_block_tiling_density の 0<q≤1 の場合）
  obtain ⟨hlow, hup⟩ := rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one a k hq0 hq1
  -- 準備の第一・第二・第三
  have hc := blockTiling_lower_coefficient_le_two_div a k
  have hs := rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1
  have hm := rationalLogOrderLE_ratSmul_le_ratSmul_of_le_of_nonpos hc hs   -- (2/a)·ι(log q) ≤ (2(k−1)/(ka))·ι(log q)
  refine ⟨?_, hup⟩
  -- 左: 加法単調性で第一項を取り替え、ブロック敷き詰め密度の左へ推移律
  exact rationalLogOrderLE_trans (rationalLogOrderLE_add_right hm _) hlow

end Ising2DLambda.ThermodynamicLimit
