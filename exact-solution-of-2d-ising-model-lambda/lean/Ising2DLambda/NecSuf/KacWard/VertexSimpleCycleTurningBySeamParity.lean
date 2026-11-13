/-
「頂点単純閉路の循環総回転数は切断線偶奇で決まる」
（`claim_vertex_simple_cycle_turning_by_seam_parity`）の必要十分版。

具体版と同じ二場合に分ける。切断線偶奇 `seam` が零なら、巻き付き `wind` が零であること（`hzero`）と
持ち上げ点の相異性 `distinct` から、回転数 `turn` は二値 `upper`・`lower` のどちらか（`hpolygon`）。
零でないなら、巻き付きが零だと `seam = red wind = red 0 = 0` となって矛盾するので巻き付きは零でなく、
回転数は零（`hnonzero`）。

切断線偶奇・巻き付き・回転数の住処には零元だけを仮定する（加法も順序も使わない）。
巻き付きから切断線偶奇への写像 `red` については、零を零へ送ること（`hred`）だけを使う。
`hred` は削れない: 零を零へ送らない `red` では、巻き付きが零でも切断線偶奇が零でなくなりうるので、
第二の場合で巻き付きが零でないことを導けない。
-/
import Mathlib.Algebra.Group.Defs

namespace Ising2DLambda.NecSuf.KacWard

theorem vertex_simple_cycle_turning_by_seam_parity_necSuf {S N G : Type*}
    [Zero S] [Zero N] [Zero G]
    (seam : S) (wind : N) (turn upper lower : G) (red : N → S) (distinct : Prop)
    (hred : red 0 = 0) (hparity : seam = red wind) (hdistinct : distinct)
    (hzero : seam = 0 → wind = 0)
    (hpolygon : wind = 0 → distinct → turn = upper ∨ turn = lower)
    (hnonzero : wind ≠ 0 → turn = 0) :
    (seam = 0 → turn = upper ∨ turn = lower) ∧ (seam ≠ 0 → turn = 0) := by
  constructor
  · intro hseam
    exact hpolygon (hzero hseam) hdistinct
  · intro hseam
    apply hnonzero
    intro hwind
    apply hseam
    rw [hparity, hwind, hred]

end Ising2DLambda.NecSuf.KacWard
