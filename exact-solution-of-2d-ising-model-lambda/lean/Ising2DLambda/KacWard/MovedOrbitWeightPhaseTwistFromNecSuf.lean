/- 動く軌道の成分積の分解の具体版が、必要十分版の積の分離の特殊化として得られることの記録。 -/
import Ising2DLambda.KacWard.MovedOrbitWeightPhaseTwist
import Ising2DLambda.NecSuf.KacWard.MovedOrbitWeightPhaseTwist

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem movedOrbitWeight_phase_twist_from_necSuf {L : ℕ} (s : SpinStructure)
    (walk : List (OrientedEdge L))
    (σ : OrientedEdge L → OrientedEdge L) (entry phase : OrientedEdge L → OrientedEdge L → Qbar)
    (turns : List Turn) (closing : Turn) {z : Qbar} (hz4 : z ^ 4 = -1)
    (hentry : ∀ e ∈ walk, entry e (σ e) = (twistSign s (σ e) : Qbar) * phase e (σ e))
    (hperm : (walk.map σ).Perm walk)
    (hphase : (walk.map fun e => phase e (σ e)).prod =
      (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing) :
    (walk.map fun e => entry e (σ e)).prod =
      (((-1 : ℤ) ^ (s.1.toNat * ((walk.map horizontalSeamParity).sum % 2) +
        s.2.toNat * ((walk.map verticalSeamParity).sum % 2)) : ℤ) : Qbar) *
        z ^ ((turns.map turnValue).sum + turnValue closing) := by
  have htwist :
      (walk.map fun e => (twistSign s e : Qbar)).prod =
        (((-1 : ℤ) ^ (s.1.toNat * ((walk.map horizontalSeamParity).sum % 2) +
          s.2.toNat * ((walk.map verticalSeamParity).sum % 2)) : ℤ) : Qbar) := by
    have hcast :
        (walk.map fun e => (twistSign s e : Qbar)).prod =
          ((walk.map (twistSign s)).prod : Qbar) := by
      clear hentry hperm hphase
      induction walk with
      | nil => simp
      | cons head tail ih => simp [ih]
    rw [hcast, walkTwistSign_product s walk]
  have hphaseTotal :
      (walk.map fun e => phase e (σ e)).prod =
        z ^ ((turns.map turnValue).sum + turnValue closing) := by
    rw [hphase, closed_walk_rotation_phase hz4 turns closing]
  exact Ising2DLambda.NecSuf.KacWard.orbitEntryProduct_phase_twist_necSuf walk σ entry phase
    (fun e => (twistSign s e : Qbar)) _ _ hentry hperm htwist hphaseTotal

end Ising2DLambda.KacWard
