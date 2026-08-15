/-
章「熱力学極限」の「開境界正方形のブロック敷き詰め評価（正の有理点）」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_open_square_block_tiling_rational` である。

  人手証明の段                                          このファイル
  準備: 正の底の自然数冪は順序を保つ（帰納法）           pow_le_pow_of_pos_of_le_by_induction_rat
  第一座標方向の反復接合評価（b = a）                    openPartitionValueRat_iteratedGlueFirst_bounds_of_*
  その両辺の k 乗                                        hlowerPow / hupperPow
  第二座標方向の反復接合評価（第一座標の長さ ka）        openPartitionValueRat_iteratedGlueSecond_bounds_of_*
  合成の鎖（正数 q^{(k-1)(ka)} の乗法と推移律）          calc

住処: Q。使うのは有理数体の順序体の性質・自然数冪・有限積だけであり、実数体は現れない
（実数版 `OpenSquareBlockTiling.lean` の合成を ℚ で書き直したもの。二方向の反復接合評価は
`OpenRectangleIteratedGluingFirstRational.lean`・`OpenRectangleIteratedGluingSecondRational.lean` の ℚ 版を引く）。
-/
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingFirstRational
import Ising2DLambda.ThermodynamicLimit.OpenRectangleIteratedGluingSecondRational

namespace Ising2DLambda.ThermodynamicLimit

open NecSuf.ThermodynamicLimit

/-- `claim_open_square_block_tiling_rational` の `0 < q ≤ 1` の場合。 -/
theorem openPartitionValueRat_squareBlockTiling_bounds_of_le_one
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k ≤
        openPartitionValueRat (k * a) (k * a) q ∧
      openPartitionValueRat (k * a) (k * a) q ≤
        (openPartitionValueRat a a q ^ k) ^ k := by
  -- 第一座標方向の反復接合評価（b = a）と第二座標方向の反復接合評価（第一座標の長さ ka）
  have hfirst := openPartitionValueRat_iteratedGlueFirst_bounds_of_le_one a a ha hq0 hq1 k hk
  have hsecond := openPartitionValueRat_iteratedGlueSecond_bounds_of_le_one
    (k * a) a ha hq0 hq1 k hk
  -- 準備: 底は正
  have hlower0 : 0 < q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k := by
    exact mul_pos (pow_pos_by_induction hq0 _)
      (pow_pos_by_induction (openPartitionValueRat_pos a a hq0) _)
  -- 準備: 正の底の自然数冪は順序を保つ（両辺の k 乗）
  have hlowerPow := pow_le_pow_of_pos_of_le_by_induction_rat hlower0 hfirst.1 k
  have hupperPow := pow_le_pow_of_pos_of_le_by_induction_rat
    (openPartitionValueRat_pos (k * a) a hq0) hfirst.2 k
  constructor
  · calc q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k
        ≤ q ^ ((k - 1) * (k * a)) * openPartitionValueRat (k * a) a q ^ k :=
          mul_le_mul_of_nonneg_left hlowerPow (pow_pos_by_induction hq0 _).le
      _ ≤ openPartitionValueRat (k * a) (k * a) q := hsecond.1
  · calc openPartitionValueRat (k * a) (k * a) q
        ≤ openPartitionValueRat (k * a) a q ^ k := hsecond.2
      _ ≤ (openPartitionValueRat a a q ^ k) ^ k := hupperPow

/-- `claim_open_square_block_tiling_rational` の `1 ≤ q` の場合。 -/
theorem openPartitionValueRat_squareBlockTiling_bounds_of_one_le
    (a k : ℕ) (ha : 0 < a) (hk : 1 ≤ k) {q : ℚ} (hq : 1 ≤ q) :
    (openPartitionValueRat a a q ^ k) ^ k ≤ openPartitionValueRat (k * a) (k * a) q ∧
      openPartitionValueRat (k * a) (k * a) q ≤
        q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k := by
  have hq0 : 0 < q := lt_of_lt_of_le zero_lt_one hq
  have hfirst := openPartitionValueRat_iteratedGlueFirst_bounds_of_one_le a a ha hq k hk
  have hsecond := openPartitionValueRat_iteratedGlueSecond_bounds_of_one_le
    (k * a) a ha hq k hk
  have hbase0 : 0 < openPartitionValueRat a a q ^ k :=
    pow_pos_by_induction (openPartitionValueRat_pos a a hq0) _
  have hstrip0 : 0 < openPartitionValueRat (k * a) a q := openPartitionValueRat_pos _ _ hq0
  have hlowerPow := pow_le_pow_of_pos_of_le_by_induction_rat hbase0 hfirst.1 k
  have hupperPow := pow_le_pow_of_pos_of_le_by_induction_rat hstrip0 hfirst.2 k
  constructor
  · calc (openPartitionValueRat a a q ^ k) ^ k
        ≤ openPartitionValueRat (k * a) a q ^ k := hlowerPow
      _ ≤ openPartitionValueRat (k * a) (k * a) q := hsecond.1
  · calc openPartitionValueRat (k * a) (k * a) q
        ≤ q ^ ((k - 1) * (k * a)) * openPartitionValueRat (k * a) a q ^ k := hsecond.2
      _ ≤ q ^ ((k - 1) * (k * a)) *
          (q ^ ((k - 1) * a) * openPartitionValueRat a a q ^ k) ^ k :=
          mul_le_mul_of_nonneg_left hupperPow (pow_pos_by_induction hq0 _).le

end Ising2DLambda.ThermodynamicLimit
