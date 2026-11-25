/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の「反転は方向番号を二だけ進める」
（`claim_reversal_direction_shift`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                    このファイル
  方向番号の四つの場合の表                     `directionNumber` の入れ子の if
  横向き ↔ 縦向きの場合分け                    `by_cases hk : e.val < L ^ 2`
  d = 0 / d = 1 の場合分け                     `cases d`
  Z/4Z の計算（2 = 0 + 2, 3 = 1 + 2,
    0 = 2 + 2, 1 = 3 + 2）                     各分岐の `decide`

住処: 人手証明のこのブロックは Z（Z/4Z）を宣言している。ℝ / ℂ は現れない。
-/
import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.KacWard

/-- 向き付き辺の方向番号（`def_oriented_edge_direction` の四つの場合の表）。
`Edge L = Fin (2 * L ^ 2)` の前半 `e.val < L ^ 2` が横向き、後半が縦向きである。 -/
def directionNumber {L : ℕ} (e : OrientedEdge L) : ZMod 4 :=
  if e.1.val < L ^ 2 then (if e.2 then 2 else 0) else (if e.2 then 3 else 1)

/-- 人手証明と同じ四つの場合分けで、反転が方向番号を二だけ進めることを示す。 -/
theorem directionNumber_reversal {L : ℕ} (e : OrientedEdge L) :
    directionNumber (reversal e) = directionNumber e + 2 := by
  rcases e with ⟨edge, d⟩
  by_cases hk : edge.val < L ^ 2 <;> cases d <;>
    simp [directionNumber, reversal, hk] <;>
    decide

end Ising2DLambda.KacWard
