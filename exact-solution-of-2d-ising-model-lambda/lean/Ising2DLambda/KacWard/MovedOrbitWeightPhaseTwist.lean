/-
参照用ノート「不採用経路: 動く軌道の遷移成分積の位相とねじれへの分解」
（`note_moved_orbit_weight_phase_twist_archived`）に保存した主張の具体版。

軌道列を一つ進める置換による添字替え、遷移成分のねじれ因子と位相因子への分離、
辺列に沿うねじれ符号積（`walkTwistSign_product`）、閉歩道の回転位相積を、人手証明と同じ順に結ぶ。
ねじれ符号は本文の整数のねじれ符号 `twistSign`（`def_spin_structures`）である。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.KacWard.ClosedWalkRotationPhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 動く軌道の成分積を切断線偶奇の符号と循環総回転数の冪へ分ける。 -/
theorem movedOrbitWeight_phase_twist {L : ℕ} (s : SpinStructure)
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
  -- 人手証明: 各成分をねじれ因子と位相因子の積へ分ける
  have hsplit :
      (walk.map fun e => entry e (σ e)).prod =
        (walk.map fun e => (twistSign s (σ e) : Qbar)).prod *
          (walk.map fun e => phase e (σ e)).prod := by
    clear hperm hphase
    induction walk with
    | nil => simp
    | cons e es ih =>
        rw [List.map_cons, List.prod_cons, hentry e (by simp),
          List.map_cons, List.prod_cons, List.map_cons, List.prod_cons,
          ih (fun f hf => hentry f (by simp [hf]))]
        ac_rfl
  -- 人手証明: 軌道列を一つ進める置換で添字を付け替える
  have htwistReindex :
      (walk.map fun e => (twistSign s (σ e) : Qbar)).prod =
        (walk.map fun e => (twistSign s e : Qbar)).prod := by
    change (walk.map ((fun e => (twistSign s e : Qbar)) ∘ σ)).prod = _
    simpa [List.map_map] using
      List.Perm.prod_eq (hperm.map fun e => (twistSign s e : Qbar))
  -- 人手証明: 辺列に沿うねじれ符号の積（`claim_walk_twist_sign_product`）
  have htwistQbar :
      (walk.map fun e => (twistSign s e : Qbar)).prod =
        (((-1 : ℤ) ^ (s.1.toNat * ((walk.map horizontalSeamParity).sum % 2) +
          s.2.toNat * ((walk.map verticalSeamParity).sum % 2)) : ℤ) : Qbar) := by
    have hcast :
        (walk.map fun e => (twistSign s e : Qbar)).prod =
          ((walk.map (twistSign s)).prod : Qbar) := by
      clear hentry hperm hphase hsplit htwistReindex
      induction walk with
      | nil => simp
      | cons head tail ih => simp [ih]
    rw [hcast, walkTwistSign_product s walk]
  -- 人手証明: 閉歩道の回転位相の積
  have hphaseTotal :
      (walk.map fun e => phase e (σ e)).prod =
        z ^ ((turns.map turnValue).sum + turnValue closing) := by
    rw [hphase, closed_walk_rotation_phase hz4 turns closing]
  rw [hsplit, htwistReindex, htwistQbar, hphaseTotal]

end Ising2DLambda.KacWard
