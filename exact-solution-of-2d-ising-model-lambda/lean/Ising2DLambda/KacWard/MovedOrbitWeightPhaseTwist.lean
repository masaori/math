/-
章「トーラス上の Kac--Ward 行列式」の
「動く軌道の遷移成分積は切断線偶奇の符号と回転位相の冪へ分かれる」
（`claim_moved_orbit_weight_phase_twist`）の具体版。

軌道列を一つ進める置換による添字替え、遷移成分のねじれ因子と位相因子への分離、
辺列に沿うねじれ符号積、閉歩道の回転位相積を、人手証明と同じ順に結ぶ。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.KacWard.ClosedWalkRotationPhase
import Ising2DLambda.NecSuf.KacWard.MovedOrbitWeightPhaseTwist

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.NecSuf.KacWard

/-- 動く軌道の成分積を切断線偶奇の符号と循環総回転数の冪へ分ける。 -/
theorem movedOrbitWeight_phase_twist {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L))
    (σ : OrientedEdge L → OrientedEdge L) (entry phase : OrientedEdge L → OrientedEdge L → Qbar)
    (turns : List Turn) (closing : Turn) {z : Qbar} (hz4 : z ^ 4 = -1)
    (hentry : ∀ e ∈ walk,
      entry e (σ e) =
        (twistSign a b horizontal vertical (σ e) : Qbar) * phase e (σ e))
    (hperm : (walk.map σ).Perm walk)
    (hphase : (walk.map fun e => phase e (σ e)).prod =
      (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing) :
    (walk.map fun e => entry e (σ e)).prod =
      (boolSign (Bool.xor (a && parity horizontal walk) (b && parity vertical walk)) : Qbar) *
        z ^ ((turns.map turnValue).sum + turnValue closing) := by
  have htwistInt := walkTwistSign_product a b horizontal vertical walk
  have htwistQbar :
      (walk.map fun e => (twistSign a b horizontal vertical e : Qbar)).prod =
        (boolSign (Bool.xor (a && parity horizontal walk) (b && parity vertical walk)) : Qbar) := by
    have hcast :
        (walk.map fun e => (twistSign a b horizontal vertical e : Qbar)).prod =
          ((walk.map (twistSign a b horizontal vertical)).prod : Qbar) := by
      clear hentry hperm hphase htwistInt
      induction walk with
      | nil => simp
      | cons head tail ih => simp [ih]
    rw [hcast]
    exact_mod_cast htwistInt
  have hphaseTotal :
      (walk.map fun e => phase e (σ e)).prod =
        z ^ ((turns.map turnValue).sum + turnValue closing) := by
    rw [hphase, closed_walk_rotation_phase hz4 turns closing]
  exact orbitEntryProduct_phase_twist_necSuf walk σ entry phase
    (fun e => (twistSign a b horizontal vertical e : Qbar)) _ _
    hentry hperm htwistQbar hphaseTotal

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem movedOrbitWeight_phase_twist_from_necSuf {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L))
    (σ : OrientedEdge L → OrientedEdge L) (entry phase : OrientedEdge L → OrientedEdge L → Qbar)
    (turns : List Turn) (closing : Turn) {z : Qbar} (hz4 : z ^ 4 = -1)
    (hentry : ∀ e ∈ walk,
      entry e (σ e) =
        (twistSign a b horizontal vertical (σ e) : Qbar) * phase e (σ e))
    (hperm : (walk.map σ).Perm walk)
    (hphase : (walk.map fun e => phase e (σ e)).prod =
      (turns.map (phaseOfTurn z)).prod * phaseOfTurn z closing) :
    (walk.map fun e => entry e (σ e)).prod =
      (boolSign (Bool.xor (a && parity horizontal walk) (b && parity vertical walk)) : Qbar) *
        z ^ ((turns.map turnValue).sum + turnValue closing) :=
  movedOrbitWeight_phase_twist a b horizontal vertical walk σ entry phase
    turns closing hz4 hentry hperm hphase

end Ising2DLambda.KacWard
