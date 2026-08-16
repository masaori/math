/-
人手証明「開境界正方形の密度の差の評価の核」（`def_open_square_density_difference_bound_core`）と
「差の一様な評価に現れる量は核の基準辺分の一倍である」
（`claim_open_square_density_difference_bound_is_core_over_base_side`）の具体版。

核 `Γ(q) := (2·ι(ℓ_2) + 4·ι(log(1+q))) + (−(4·ι(log q))) + 2·(ι(ℓ_2) + 2·ι(log(1+q))) ∈ Λ_ℚ`
（`q` だけで決まり、辺 `a, L, M` によらない）。
主張: `a ≥ 1` について `(1/a)·Γ(q) = ((2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))) + (−((4/a)·ι(log q))) + (2/a)·(ι(ℓ_2) + 2·ι(log(1+q)))`
（差の上からの評価の右辺・下からの評価の左辺の逆元の中身と同じ元）。

  人手証明の段                                                このファイル
  準備の第一 r·(−λ) = −(r·λ)（素数ごとに五段）                 ratSmul_neg_eq_neg_ratSmul
  準備の第二 (1/a)·X = (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))       hX（分配則・結合則・ℚ の四則）
  準備の第三 (1/a)·(−Y) = −((4/a)·ι(log q))                   hY（第一・結合則・ℚ の四則）
  準備の第四 (1/a)·(2·C) = (2/a)·C                             hC（結合則・ℚ の四則）
  本体（分配則二段、第二・第三・第四で読み替え）                one_div_smul_openSquareDensityDifferenceBoundCore

`Λ_ℚ` の有理数倍は `Finsupp` のスカラー倍で、分配則 `smul_add` と結合則 `mul_smul` は
`def_rational_log_order_group` に書いてある性質そのものである。順序は使わない。
住処は ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareLargeSidesDensityDifferenceLower

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_open_square_density_difference_bound_core`。開境界正方形の密度の差の評価の核 `Γ(q)`。 -/
noncomputable def openSquareDensityDifferenceBoundCore (q : ℚ) : RationalLogOrderGroup :=
  (((2 : ℚ) • toRational (generator ⟨2, Nat.prime_two⟩) + (4 : ℚ) • toRational (logRat (1 + q))) +
    -((4 : ℚ) • toRational (logRat q))) +
  (2 : ℚ) • (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q)))

/-- 準備の第一: `r·(−λ) = −(r·λ)` を素数ごとに五段で示す（人手証明の準備の第一の鎖と 1 対 1）。 -/
theorem ratSmul_neg_eq_neg_ratSmul (r : ℚ) (l : RationalLogOrderGroup) :
    r • (-l) = -(r • l) := by
  ext p
  calc (r • (-l)) p
      = r * (-l) p := Finsupp.smul_apply _ _ _        -- 有理数倍の定義
    _ = r * (-(l p)) := by rw [Finsupp.neg_apply]     -- 逆元の定義
    _ = -(r * l p) := by ring                          -- ℚ の四則 r(−u) = −(ru)
    _ = -((r • l) p) := by rw [Finsupp.smul_apply, smul_eq_mul]    -- 有理数倍の定義
    _ = (-(r • l)) p := by rw [Finsupp.neg_apply]     -- 逆元の定義

/-- 主張。 -/
theorem one_div_smul_openSquareDensityDifferenceBoundCore (a : ℕ) [NeZero a] (q : ℚ) :
    ((1 : ℚ) / (a : ℚ)) • openSquareDensityDifferenceBoundCore q =
      ((((2 : ℚ) / (a : ℚ)) • toRational (generator ⟨2, Nat.prime_two⟩) +
          ((4 : ℚ) / (a : ℚ)) • toRational (logRat (1 + q))) +
        -(((4 : ℚ) / (a : ℚ)) • toRational (logRat q))) +
      ((2 : ℚ) / (a : ℚ)) •
        (toRational (generator ⟨2, Nat.prime_two⟩) + (2 : ℚ) • toRational (logRat (1 + q))) := by
  -- 略記（この証明の中だけ）
  set g2 := toRational (generator ⟨2, Nat.prime_two⟩) with hg2
  set l1q := toRational (logRat (1 + q)) with hl1q
  set lq := toRational (logRat q) with hlq
  set X : RationalLogOrderGroup := (2 : ℚ) • g2 + (4 : ℚ) • l1q with hXdef
  set Y : RationalLogOrderGroup := (4 : ℚ) • lq with hYdef
  set C : RationalLogOrderGroup := g2 + (2 : ℚ) • l1q with hCdef
  -- ℚ の四則
  have hq2 : (1 : ℚ) / (a : ℚ) * 2 = (2 : ℚ) / (a : ℚ) := by ring
  have hq4 : (1 : ℚ) / (a : ℚ) * 4 = (4 : ℚ) / (a : ℚ) := by ring
  -- 準備の第二: (1/a)·X = (2/a)·ι(ℓ_2) + (4/a)·ι(log(1+q))
  have hX : ((1 : ℚ) / (a : ℚ)) • X =
      ((2 : ℚ) / (a : ℚ)) • g2 + ((4 : ℚ) / (a : ℚ)) • l1q := by
    calc ((1 : ℚ) / (a : ℚ)) • X
        = ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • g2 + (4 : ℚ) • l1q) := by rw [hXdef]   -- X の置き方
      _ = ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • g2) + ((1 : ℚ) / (a : ℚ)) • ((4 : ℚ) • l1q) :=
          smul_add _ _ _                                                           -- 分配則
      _ = ((1 : ℚ) / (a : ℚ) * 2) • g2 + ((1 : ℚ) / (a : ℚ) * 4) • l1q := by
          rw [← mul_smul, ← mul_smul]                                              -- 結合則（右から左へ、二箇所）
      _ = ((2 : ℚ) / (a : ℚ)) • g2 + ((4 : ℚ) / (a : ℚ)) • l1q := by rw [hq2, hq4]  -- ℚ の四則
  -- 準備の第三: (1/a)·(−Y) = −((4/a)·ι(log q))
  have hY : ((1 : ℚ) / (a : ℚ)) • (-Y) = -(((4 : ℚ) / (a : ℚ)) • lq) := by
    calc ((1 : ℚ) / (a : ℚ)) • (-Y)
        = -(((1 : ℚ) / (a : ℚ)) • Y) := ratSmul_neg_eq_neg_ratSmul _ _              -- 準備の第一
      _ = -(((1 : ℚ) / (a : ℚ)) • ((4 : ℚ) • lq)) := by rw [hYdef]                  -- Y の置き方
      _ = -(((1 : ℚ) / (a : ℚ) * 4) • lq) := by rw [← mul_smul]                     -- 結合則（右から左へ）
      _ = -(((4 : ℚ) / (a : ℚ)) • lq) := by rw [hq4]                                 -- ℚ の四則
  -- 準備の第四: (1/a)·(2·C) = (2/a)·C
  have hC : ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C) = ((2 : ℚ) / (a : ℚ)) • C := by
    calc ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C)
        = ((1 : ℚ) / (a : ℚ) * 2) • C := by rw [← mul_smul]                          -- 結合則（右から左へ）
      _ = ((2 : ℚ) / (a : ℚ)) • C := by rw [hq2]                                     -- ℚ の四則
  -- 本体
  calc ((1 : ℚ) / (a : ℚ)) • openSquareDensityDifferenceBoundCore q
      = ((1 : ℚ) / (a : ℚ)) • ((X + -Y) + (2 : ℚ) • C) := rfl                       -- 核の定義と置き方
    _ = ((1 : ℚ) / (a : ℚ)) • (X + -Y) + ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C) :=
        smul_add _ _ _                                                               -- 分配則
    _ = (((1 : ℚ) / (a : ℚ)) • X + ((1 : ℚ) / (a : ℚ)) • (-Y)) +
          ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C) := by rw [smul_add]                    -- 分配則
    _ = ((((2 : ℚ) / (a : ℚ)) • g2 + ((4 : ℚ) / (a : ℚ)) • l1q) + ((1 : ℚ) / (a : ℚ)) • (-Y)) +
          ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C) := by rw [hX]                          -- 準備の第二
    _ = ((((2 : ℚ) / (a : ℚ)) • g2 + ((4 : ℚ) / (a : ℚ)) • l1q) + -(((4 : ℚ) / (a : ℚ)) • lq)) +
          ((1 : ℚ) / (a : ℚ)) • ((2 : ℚ) • C) := by rw [hY]                          -- 準備の第三
    _ = ((((2 : ℚ) / (a : ℚ)) • g2 + ((4 : ℚ) / (a : ℚ)) • l1q) + -(((4 : ℚ) / (a : ℚ)) • lq)) +
          ((2 : ℚ) / (a : ℚ)) • C := by rw [hC]                                      -- 準備の第四と C の置き方

end Ising2DLambda.ThermodynamicLimit
