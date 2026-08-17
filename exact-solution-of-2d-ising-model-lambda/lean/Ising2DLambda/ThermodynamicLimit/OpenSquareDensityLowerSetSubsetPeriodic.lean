/-
章「熱力学極限」の「開境界正方形の密度の下組は周期境界の密度の下組に含まれる（Archimedes 性。q は 1 以下）」
（`claim_open_square_density_lower_set_subset_periodic_le_one`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  準備の第一: ε' := (1/2)·ε
    ε' + ε' = ε（分配則・1/2 + 1/2 = 1・1·λ = λ）                  `half_add_half_eq`
    0 = 0·ε ≤ (1/2)·ε（claim_rational_log_order_group_scalar_compare_nonneg）
                                                                 `rationalLogOrderLE_zero_half_of_nonneg`
    ε' ≠ 0（ε' = 0 なら ε = ε' + ε' = 0）                          `half_ne_zero_of_ne_zero`
  準備の第二: δ := −ι(log q)
    ι(log q) ≤ ι(log 1) = ι(0) = 0                                 `rationalLogOrderLE_toRational_logRat_nonpos_of_le_one`（既存）
    0 = −0 ≤ −ι(log q) = δ（claim_rational_log_order_group_neg_reverses_order）
                                                                 `rationalLogOrderLE_zero_neg_toRational_logRat_of_le_one`
    0 = 0·δ ≤ 2·δ（scalar_compare_nonneg）                          本体の中の `h2δ`
  準備の第三: Archimedes 性の倍率 n（2·δ ≤ n·ε'）、N' := N + n     本体の中の `obtain ⟨n, hn⟩`・`N + n`
  準備の第四: N' ≤ L で (1/L)·(2·δ) ≤ ε'（claim_rational_log_order_group_div_ge_multiplier_le）と一続き五段
    −ε' ≤ −((1/L)·(2·δ)) = −(((1/L)·2)·δ) = −((2/L)·δ) = −((2/L)·(−ι(log q))) = (2/L)·ι(log q)
                                                                 `rationalLogOrderLE_neg_le_scaled_toRational_logRat`
  本体: N' ≤ L で一続き八段
    μ+ε' = (μ+ε')+0 = (μ+ε')+(ε'+(−ε')) = ((μ+ε')+ε')+(−ε') = (μ+(ε'+ε'))+(−ε') = (μ+ε)+(−ε')
         ≤ Ψ^op_L(q)+(−ε')（add_monotone。証人の性質）
         ≤ Ψ^op_L(q)+(2/L)·ι(log q)（add_monotone。準備の第四）
         ≤ Ψ_L(q)（claim_periodic_open_boundary_comparison_density_le_one の左）
                                                                 `openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one`

住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.PeriodicDensityLowerSet
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupArchimedean
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupDivGeMultiplierLe
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNegReversesOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備の第一（第一の等式）: `(1/2)·ε + (1/2)·ε = ε`。分配則（右から左）・`1/2 + 1/2 = 1`（ℚ の四則）・`1·λ = λ`。 -/
theorem half_add_half_eq (ε : RationalLogOrderGroup) :
    ((1 : ℚ) / 2) • ε + ((1 : ℚ) / 2) • ε = ε := by
  calc ((1 : ℚ) / 2) • ε + ((1 : ℚ) / 2) • ε
      = ((1 : ℚ) / 2 + (1 : ℚ) / 2) • ε := (add_smul _ _ _).symm      -- 分配則（右辺から左辺）
    _ = (1 : ℚ) • ε := by norm_num                                       -- 1/2 + 1/2 = 1（ℚ の四則）
    _ = ε := one_smul _ _                                                -- 1·λ = λ

/-- 準備の第一（第二）: `0 ≤ ε` なら `0 = 0·ε ≤ (1/2)·ε`（`claim_rational_log_order_group_scalar_compare_nonneg`
を `r := 0`、`s := 1/2`、`ν := ε` で）。 -/
theorem rationalLogOrderLE_zero_half_of_nonneg {ε : RationalLogOrderGroup}
    (hε : rationalLogOrderLE 0 ε) : rationalLogOrderLE 0 (((1 : ℚ) / 2) • ε) := by
  have h : rationalLogOrderLE ((0 : ℚ) • ε) (((1 : ℚ) / 2) • ε) :=
    rationalLogOrderLE_ratSmul_le_ratSmul_of_le (by norm_num) hε      -- 0 ≤ 1/2（ℚ の順序）
  rw [zero_smul] at h                                                   -- 0·ε = 0（素数ごとに読む）
  exact h

/-- 準備の第一（第三）: `ε ≠ 0` なら `(1/2)·ε ≠ 0`（`ε' = 0` なら `ε = ε' + ε' = 0 + 0 = 0`）。 -/
theorem half_ne_zero_of_ne_zero {ε : RationalLogOrderGroup} (hne : ε ≠ 0) :
    ((1 : ℚ) / 2) • ε ≠ 0 := by
  intro h0
  apply hne
  calc ε = ((1 : ℚ) / 2) • ε + ((1 : ℚ) / 2) • ε := (half_add_half_eq ε).symm   -- 第一の等式（右から左）
    _ = 0 + 0 := by rw [h0]                                                     -- ε' = 0
    _ = 0 := add_zero 0                                                         -- 零写像は単位元

/-- 準備の第二: `0 < q ≤ 1` なら `0 = −0 ≤ −ι(log q)`（`claim_rational_log_order_group_neg_reverses_order` を
`λ := ι(log q)`、`μ := 0` で。`ι(log q) ≤ 0` は既存の `rationalLogOrderLE_toRational_logRat_nonpos_of_le_one`）。 -/
theorem rationalLogOrderLE_zero_neg_toRational_logRat_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    rationalLogOrderLE 0 (-toRational (logRat q)) := by
  have h := rationalLogOrderLE_neg_le_neg
    (rationalLogOrderLE_toRational_logRat_nonpos_of_le_one hq0 hq1)   -- −0 ≤ −ι(log q)
  rw [neg_zero] at h                                                    -- 0 = −0（素数ごとに読む）
  exact h

/-- 準備の第四: `0 ≤ ε'`、`2·(−ι(log q)) ≤ n·ε'`、`1 ≤ L`、`n ≤ L` から
`−ε' ≤ (2/L)·ι(log q)`。`claim_rational_log_order_group_div_ge_multiplier_le` で `(1/L)·(2·δ) ≤ ε'` を得て、
一続き五段（逆元の順序反転・結合則（右から左）・`(1/L)·2 = 2/L`・`δ` の定義・`−(r·(−λ)) = r·λ`）。 -/
theorem rationalLogOrderLE_neg_le_scaled_toRational_logRat {q : ℚ} {ε' : RationalLogOrderGroup}
    (hε' : rationalLogOrderLE 0 ε') {n L : ℕ} (hL : 1 ≤ L) (hnL : n ≤ L)
    (hn : rationalLogOrderLE ((2 : ℚ) • (-toRational (logRat q))) ((n : ℚ) • ε')) :
    rationalLogOrderLE (-ε') (((2 : ℚ) / (L : ℚ)) • toRational (logRat q)) := by
  -- (1/L)·(2·δ) ≤ ε'（claim_rational_log_order_group_div_ge_multiplier_le を μ := 2·δ、ε := ε'、n、a := L で）
  have hdiv : rationalLogOrderLE (((1 : ℚ) / (L : ℚ)) • ((2 : ℚ) • (-toRational (logRat q)))) ε' :=
    rationalLogOrderLE_inv_natSmul_le_of_le_natSmul hε' hL hnL hn
  -- 一段目: −ε' ≤ −((1/L)·(2·δ))（claim_rational_log_order_group_neg_reverses_order）
  have h1 := rationalLogOrderLE_neg_le_neg hdiv
  -- 二〜五段目: 等式で右辺を (2/L)·ι(log q) へ整える
  have h2 : -(((1 : ℚ) / (L : ℚ)) • ((2 : ℚ) • (-toRational (logRat q))))
      = ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) := by
    calc -(((1 : ℚ) / (L : ℚ)) • ((2 : ℚ) • (-toRational (logRat q))))
        = -((((1 : ℚ) / (L : ℚ)) * 2) • (-toRational (logRat q))) := by
            rw [mul_smul]                                              -- (rs)·λ = r·(s·λ)（右辺から左辺）
      _ = -(((2 : ℚ) / (L : ℚ)) • (-toRational (logRat q))) := by
            congr 2; ring                                              -- (1/L)·2 = 2/L（ℚ の四則）
      _ = ((2 : ℚ) / (L : ℚ)) • toRational (logRat q) := by
            rw [smul_neg, neg_neg]                                     -- −(r·(−λ)) = r·λ（素数ごとに読む）
  rw [h2] at h1
  exact h1

/-- `claim_open_square_density_lower_set_subset_periodic_le_one`。
`0 < q ≤ 1` のとき `A^op(q) ⊆ A^per(q)`。 -/
theorem openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    openSquareDensityLowerSet q ⊆ periodicDensityLowerSet q := by
  intro μ hμ
  -- μ の証人 ε, N を取る
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  -- 準備の第一: ε' := (1/2)·ε
  set ε' : RationalLogOrderGroup := ((1 : ℚ) / 2) • ε with hε'def
  have hsum : ε' + ε' = ε := half_add_half_eq ε
  have hε'0 : rationalLogOrderLE 0 ε' := rationalLogOrderLE_zero_half_of_nonneg hε0
  have hε'ne : ε' ≠ 0 := half_ne_zero_of_ne_zero hεne
  -- 準備の第二: δ := −ι(log q)、0 ≤ δ、0 = 0·δ ≤ 2·δ
  set δ : RationalLogOrderGroup := -toRational (logRat q) with hδdef
  have hδ : rationalLogOrderLE 0 δ := rationalLogOrderLE_zero_neg_toRational_logRat_of_le_one hq0 hq1
  have h2δ : rationalLogOrderLE 0 ((2 : ℚ) • δ) := by
    have h : rationalLogOrderLE ((0 : ℚ) • δ) ((2 : ℚ) • δ) :=
      rationalLogOrderLE_ratSmul_le_ratSmul_of_le (by norm_num) hδ   -- 0 ≤ 2（ℚ の順序）
    rw [zero_smul] at h                                                -- 0·δ = 0
    exact h
  -- 準備の第三: Archimedes 性の倍率 n、N' := N + n
  obtain ⟨n, hn⟩ := rationalLogOrderLE_natSmul_of_pos ((2 : ℚ) • δ) ε' h2δ hε'0 hε'ne
  -- 証人 ε', N' で A^per(q) の所属を示す
  refine ⟨ε', hε'0, hε'ne, N + n, Nat.le_add_right_of_le hN1, ?_⟩
  intro L hL
  have hLN : N ≤ L := le_trans (Nat.le_add_right N n) hL
  have hLn : n ≤ L := le_trans (Nat.le_add_left n N) hL
  have hL1 : 1 ≤ L := le_trans hN1 hLN
  haveI : NeZero L := ⟨by omega⟩
  -- 準備の第四: −ε' ≤ (2/L)·ι(log q)
  have herr : rationalLogOrderLE (-ε') (((2 : ℚ) / (L : ℚ)) • toRational (logRat q)) :=
    rationalLogOrderLE_neg_le_scaled_toRational_logRat hε'0 hL1 hLn hn
  -- 本体: 一続き八段
  rw [periodicDensitySequence_of_ne_zero]
  -- 一〜五段目（等式）: μ + ε' = (μ + ε) + (−ε')
  have heq : μ + ε' = (μ + ε) + (-ε') := by
    calc μ + ε' = (μ + ε') + 0 := (add_zero _).symm                            -- 単位元
      _ = (μ + ε') + (ε' + (-ε')) := by rw [add_neg_cancel]                    -- 逆元（右辺から左辺）
      _ = ((μ + ε') + ε') + (-ε') := (add_assoc _ _ _).symm                    -- 結合則
      _ = (μ + (ε' + ε')) + (-ε') := by rw [add_assoc μ ε' ε']                 -- 結合則
      _ = (μ + ε) + (-ε') := by rw [hsum]                                      -- 準備の第一
  -- 六段目: (μ + ε) + (−ε') ≤ Ψ^op_L(q) + (−ε')（add_monotone。証人の性質。N ≤ L）
  have h6 : rationalLogOrderLE ((μ + ε) + (-ε')) (openScaledFreeEntropy L q + (-ε')) := by
    have h := hN L hLN
    rw [openSquareDensitySequence_of_ne_zero] at h
    exact rationalLogOrderLE_add_right h (-ε')
  -- 七段目: Ψ^op_L(q) + (−ε') ≤ Ψ^op_L(q) + (2/L)·ι(log q)（add_monotone を λ := −ε'、ν := Ψ^op_L(q) で読み、可換則）
  have h7 : rationalLogOrderLE (openScaledFreeEntropy L q + (-ε'))
      (openScaledFreeEntropy L q + ((2 : ℚ) / (L : ℚ)) • toRational (logRat q)) := by
    have h := rationalLogOrderLE_add_right herr (openScaledFreeEntropy L q)
    rw [add_comm (-ε'), add_comm (((2 : ℚ) / (L : ℚ)) • toRational (logRat q))] at h
    exact h
  -- 八段目: Ψ^op_L(q) + (2/L)·ι(log q) ≤ Ψ_L(q)（claim_periodic_open_boundary_comparison_density_le_one の左）
  have h8 := (rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one L hq0 hq1).1
  -- 推移律（claim_rational_log_order_group_linear_order）
  rw [heq]
  exact rationalLogOrderLE_trans h6 (rationalLogOrderLE_trans h7 h8)

end Ising2DLambda.ThermodynamicLimit
