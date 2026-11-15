/-
章「Onsager 閉形式への接続」の「基点の平行座標が幅を超えて離れた二つの反復横断階段は交わらない」
（`claim_parallel_separated_staircases_disjoint`）の具体版。

人手証明と同じく、二つの反復階段の平行座標を各基点から同じ整数区間へ評価し、
基点の座標差がその幅を超えるという仮定に反することを示す。住処は ℤ だけである。
-/
import Ising2DLambda.KacWard.IteratedStaircaseParallelWidth
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

/-- `claim_parallel_separated_staircases_disjoint`。 -/
theorem parallelSeparatedIteratedTransverseStaircases_ne
    (wh wv : ℤ) (hwind : (wh, wv) ≠ (0, 0))
    (leftBase rightBase : ℤ × ℤ) (t t' s s' : ℕ)
    (_ht : 1 ≤ t) (_ht' : 1 ≤ t')
    (_hs : s ≤ t * (wh.natAbs + wv.natAbs))
    (_hs' : s' ≤ t' * (wh.natAbs + wv.natAbs))
    (hseparated :
      |windingParallelCoordinate wv wh leftBase -
        windingParallelCoordinate wv wh rightBase| > |wh * wv|) :
    iteratedTransverseStaircase wh wv leftBase s ≠
      iteratedTransverseStaircase wh wv rightBase s' := by
  intro heq
  have hleft := iteratedTransverseStaircase_parallel_width_bound wh wv leftBase hwind s
  have hright := iteratedTransverseStaircase_parallel_width_bound wh wv rightBase hwind s'
  have hcoordinate := congrArg (windingParallelCoordinate wv wh) heq
  have hwidth : max 0 (wh * wv) - min 0 (wh * wv) = |wh * wv| := by
    simpa using (max_sub_min_eq_abs (0 : ℤ) (wh * wv))
  have hbound :
      |windingParallelCoordinate wv wh leftBase -
        windingParallelCoordinate wv wh rightBase| ≤
          max 0 (wh * wv) - min 0 (wh * wv) := by
    rw [abs_le]
    constructor <;> omega
  omega

end Ising2DLambda.KacWard
