/-
章「トーラス上の Kac--Ward 行列式」の「反転は方向番号を二だけ進める」
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
import Ising2DLambda.NecSuf.KacWard.ReversalDirectionShift

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
    simp [directionNumber, reversal, Ising2DLambda.NecSuf.KacWard.reverseBool, hk] <;>
    decide

/-- 具体版が必要十分版の特殊化として得られることの記録。基底値を辺の種類から、
反転の寄与を `c = 2`（`2 + 2 = 0` in Z/4Z）と取れば、必要十分版がこの主張を与える。 -/
theorem directionNumber_reversal_from_necSuf {L : ℕ} (e : OrientedEdge L) :
    directionNumber (reversal e) = directionNumber e + 2 := by
  rcases e with ⟨edge, d⟩
  have h : (2 : ZMod 4) + 2 = 0 := by decide
  have key := Ising2DLambda.NecSuf.KacWard.offset_reverse_necSuf
    (if edge.val < L ^ 2 then (0 : ZMod 4) else 1) 2 h d
  -- 表による定義が「基底値 + 向きの寄与」と一致することを場合ごとに確かめる。
  have table : ∀ d' : Bool, directionNumber (edge, d') =
      (if edge.val < L ^ 2 then (0 : ZMod 4) else 1) + (if d' then 2 else 0) := by
    intro d'
    by_cases hk : edge.val < L ^ 2 <;> cases d' <;>
      simp [directionNumber, hk] <;> decide
  calc directionNumber (reversal (edge, d))
      = directionNumber (edge, Ising2DLambda.NecSuf.KacWard.reverseBool d) := rfl
    _ = (if edge.val < L ^ 2 then (0 : ZMod 4) else 1)
        + (if Ising2DLambda.NecSuf.KacWard.reverseBool d then 2 else 0) := table _
    _ = (if edge.val < L ^ 2 then (0 : ZMod 4) else 1) + (if d then 2 else 0) + 2 := key
    _ = directionNumber (edge, d) + 2 := by rw [table d]

end Ising2DLambda.KacWard
