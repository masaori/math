/- 具体版が必要十分版の有限路の座標評価の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ParallelStaircaseTransverseWidth

namespace Ising2DLambda.KacWard

/-- `claim_parallel_staircase_transverse_width_bound` の幅を必要十分版から導いたもの。 -/
theorem windingParallelStaircase_transverse_width_bound_from_necSuf
    (L : ℕ) (wh wv : ℤ) (Q : ℤ × ℤ) (s : ℕ)
    (hs : s ≤ L * wh.natAbs + L * wv.natAbs) :
    -(L : ℤ) * |wh * wv| ≤
        windingTransverseCoordinate wh wv (Q + windingParallelStaircase L wh wv s) -
          windingTransverseCoordinate wh wv Q ∧
      windingTransverseCoordinate wh wv (Q + windingParallelStaircase L wh wv s) -
          windingTransverseCoordinate wh wv Q ≤ 0 :=
  windingParallelStaircase_transverse_width_bound L wh wv Q s hs

/-- `claim_parallel_staircase_transverse_width_bound` の帯外条件を必要十分版から導いたもの。 -/
theorem windingParallelStaircase_above_band_avoids_periodicPlaneLift_from_necSuf
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wh wv : ℤ) (Q : ℤ × ℤ) (Kmax : ℤ)
    (hbase : Kmax < windingTransverseCoordinate wh wv Q - (L : ℤ) * |wh * wv|)
    (hupper : ∀ k : ℤ, windingTransverseCoordinate wh wv
      (periodicPlaneLift m base L wv wh k) ≤ Kmax)
    (s : ℕ) (hs : s ≤ L * wh.natAbs + L * wv.natAbs) (k : ℤ) :
    Q + windingParallelStaircase L wh wv s ≠ periodicPlaneLift m base L wv wh k :=
  windingParallelStaircase_above_band_avoids_periodicPlaneLift
    m L base wh wv Q Kmax hbase hupper s hs k

end Ising2DLambda.KacWard
