/-
章「トーラス上の Kac--Ward 行列式」の「接続の組み替えの回転差は −4, 0, 4 に限る」
（`claim_reconnection_turning_difference`）の必要十分版。

人手証明の最終段が使うのは次の二つだけである。
- 差 `D` が 4 の倍数であること（π₄ による合同から得る。ここでは整除の仮定として置く）。
- 差 `D` が整数の順序で `-4 ≤ D ≤ 4` に収まること（一歩の回転数が {0,1,-1} の元であることから）。

辺・トーラス・ℤ/4ℤ・回転の型は具体側のデータであり、この整数計算そのものには現れない。
整数の線型算術（順序・加法・整除の場合分け）だけで閉じる。
-/
import Mathlib.Algebra.Field.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 4 の倍数で `-4 ≤ D ≤ 4` の整数は `-4, 0, 4` に限る
（`claim_reconnection_turning_difference` の最終段の骨格）。
人手証明と同じく、`D = 4k` と書いて `k ∈ {-1,0,1}` の場合を尽くす
（`omega` は整数の順序・加法・数値による整除のこの場合分けを決定する）。 -/
theorem dvd_four_bounded_mem_necSuf {D : ℤ} (hdvd : (4 : ℤ) ∣ D)
    (hlow : -4 ≤ D) (hhigh : D ≤ 4) : D = -4 ∨ D = 0 ∨ D = 4 := by
  omega

end Ising2DLambda.NecSuf.KacWard
