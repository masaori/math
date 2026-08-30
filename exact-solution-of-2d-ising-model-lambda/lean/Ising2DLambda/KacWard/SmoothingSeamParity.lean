/-
「平滑化は二つの切断線偶奇を保つ」の具体版。
平滑化後の出辺族は巡回後続族の二点交換であり、巡回後続写像は添字の全単射である。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.NecSuf.KacWard.SmoothingSeamParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard
open scoped BigOperators

/-- 平滑化後の出辺族と元の辺族は、任意の二つの辺指示関数について同じ偶奇を持つ。 -/
theorem smoothing_seam_parity_invariance {L m : ℕ}
    (horizontal vertical : OrientedEdge L → ℕ)
    (edge out : Fin m → OrientedEdge L) (σ : Fin m ≃ Fin m)
    (a b : Fin m) (hab : a ≠ b)
    (ha : out a = edge (σ b)) (hb : out b = edge (σ a))
    (hother : ∀ r, r ≠ a → r ≠ b → out r = edge (σ r)) :
    ((∑ r : Fin m, horizontal (out r)) % 2,
      (∑ r : Fin m, vertical (out r)) % 2) =
    ((∑ r : Fin m, horizontal (edge r)) % 2,
      (∑ r : Fin m, vertical (edge r)) % 2) := by
  have hh : (∑ r : Fin m, horizontal (out r)) = ∑ r : Fin m, horizontal (edge r) :=
    two_point_swap_reindex_sum_necSuf
      (fun r => horizontal (edge r)) (fun r => horizontal (out r)) σ a b hab
      (by rw [ha]) (by rw [hb]) (fun r hra hrb => by rw [hother r hra hrb])
  have hv : (∑ r : Fin m, vertical (out r)) = ∑ r : Fin m, vertical (edge r) :=
    two_point_swap_reindex_sum_necSuf
      (fun r => vertical (edge r)) (fun r => vertical (out r)) σ a b hab
      (by rw [ha]) (by rw [hb]) (fun r hra hrb => by rw [hother r hra hrb])
  rw [hh, hv]

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_seam_parity_invariance_from_necSuf {L m : ℕ}
    (horizontal vertical : OrientedEdge L → ℕ)
    (edge out : Fin m → OrientedEdge L) (σ : Fin m ≃ Fin m)
    (a b : Fin m) (hab : a ≠ b)
    (ha : out a = edge (σ b)) (hb : out b = edge (σ a))
    (hother : ∀ r, r ≠ a → r ≠ b → out r = edge (σ r)) :
    ((∑ r : Fin m, horizontal (out r)) % 2,
      (∑ r : Fin m, vertical (out r)) % 2) =
    ((∑ r : Fin m, horizontal (edge r)) % 2,
      (∑ r : Fin m, vertical (edge r)) % 2) :=
  smoothing_seam_parity_invariance horizontal vertical edge out σ a b hab ha hb hother

end Ising2DLambda.KacWard
