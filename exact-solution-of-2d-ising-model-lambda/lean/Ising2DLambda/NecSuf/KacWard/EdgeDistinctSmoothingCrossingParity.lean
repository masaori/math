/-
「辺の重複がない閉歩道の平滑化で横断数の偶奇は交差形式に分かれる」
（`claim_edge_distinct_smoothing_crossing_parity`）の合成の必要十分版。
閉歩道・格子・横断は使わず、人手証明が合成する五つの等式だけを仮定に置く。

人手証明と同じ手順:
- 第一段の `n_{v,0} = n_{v,1} = 1`: `haxisZero`・`haxisOne`。
- `c(γ) + 1 = c_sm + n_{v,0} + n_{v,1}`: `hupdate`。
- `c(γ_A) + c(γ_B) + c_× = c_sm`: `hpartition`。
- 自然数の加法の消去律で `c(γ) = c(γ_A) + c(γ_B) + c_× + 1`（`omega`）。
- `c_× = c_mut(γ_A, γ_B)`: `hmutual`。`c_mut` の像は交差数: `hintersection`。
- 自然数の等式の像を取って代入する: `Nat.cast_add`。

仮定の検査: 値の側 `R` に要るのは自然数からの像が加法を保つこと（`AddMonoidWithOne`）だけである。
`R = 𝔽₂` の標数二も加法の可換性も使わない（消去は ℕ の中で済ませ、像は一度だけ取る）。
-/
import Mathlib.Data.Nat.Cast.Defs

namespace Ising2DLambda.NecSuf.KacWard

/-- 五つの等式から、横断数の像は二本の横断数と一の和の像に交差数を足したものになる。 -/
theorem edge_distinct_smoothing_crossing_parity_necSuf {R : Type*} [AddMonoidWithOne R]
    (crossing smoothed crossingA crossingB splitMutual walkMutual axisZero axisOne : ℕ)
    (intersection : R)
    (haxisZero : axisZero = 1) (haxisOne : axisOne = 1)
    (hupdate : crossing + 1 = smoothed + axisZero + axisOne)
    (hpartition : crossingA + crossingB + splitMutual = smoothed)
    (hmutual : splitMutual = walkMutual)
    (hintersection : (walkMutual : R) = intersection) :
    (crossing : R) = ((crossingA + crossingB + 1 : ℕ) : R) + intersection := by
  have hcancel : crossing = crossingA + crossingB + 1 + splitMutual := by omega
  rw [hcancel, Nat.cast_add, hmutual, hintersection]

end Ising2DLambda.NecSuf.KacWard
