/-
章「トーラス上の Kac--Ward 行列式」の「反転は方向番号を二だけ進める」
（`claim_reversal_direction_shift`）の必要十分版。

人手証明の四つの場合分けのうち、辺の種類（横か縦か）は方向番号の基底値 `base` を
変えるだけで、証明が実際に使うのは「向きの反転が加える量 `c` が `c + c = 0` を
満たすこと」（Z/4Z では 2 + 2 = 0）だけである。そこで加法可換モノイドと
`c + c = 0` だけを仮定する。加法群である必要すらない（引き算を使わないため）。
-/
import Ising2DLambda.NecSuf.KacWard.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 方向番号を「種類ごとの基底値 + 向きの寄与」と読んだとき、向きの反転は
方向番号へ `c` を足す。仮定 `h : c + c = 0` が人手証明の `2 + 2 = 4 = 0` に当たる。 -/
theorem offset_reverse_necSuf {M : Type*} [AddCommMonoid M] (base c : M)
    (h : c + c = 0) (d : Bool) :
    base + (if reverseBool d then c else 0) = base + (if d then c else 0) + c := by
  cases d
  · -- d = 0 の場合: 左辺 base + c、右辺 base + 0 + c。
    simp [reverseBool]
  · -- d = 1 の場合: 左辺 base + 0、右辺 base + c + c で c + c = 0 を使う。
    simp [reverseBool, add_assoc, h]

end Ising2DLambda.NecSuf.KacWard
