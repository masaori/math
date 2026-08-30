/-
「平滑化後の横断数は二本の閉歩道の横断数と混合横断数の和である」の具体版。
人手証明と同じく、平滑化後の横断対の集合（添字対 r < s と横断述語の filter）を
「両方が区間 (k,l] に属する」「両方が属さない」「一方だけが属する」の三つに分け、
互いに素な分割で個数の和を得る。二つの帰属条件の排他性は r の帰属の矛盾から従う。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingPartition

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

theorem smoothing_split_crossing_partition {L : ℕ}
    (crossing : OrientedEdge L → OrientedEdge L → Bool) (edge : ℕ → OrientedEdge L)
    (m k l : ℕ) :
    ((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).card
    = (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => rs.1 ∈ Finset.Ioc k l ∧ rs.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => ¬ rs.1 ∈ Finset.Ioc k l ∧ ¬ rs.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => ¬(rs.1 ∈ Finset.Ioc k l ∧ rs.2 ∈ Finset.Ioc k l)
          ∧ ¬(¬ rs.1 ∈ Finset.Ioc k l ∧ ¬ rs.2 ∈ Finset.Ioc k l))).card := by
  exact three_way_filter_card_necSuf _
    (fun rs : ℕ × ℕ => rs.1 ∈ Finset.Ioc k l ∧ rs.2 ∈ Finset.Ioc k l)
    (fun rs : ℕ × ℕ => ¬ rs.1 ∈ Finset.Ioc k l ∧ ¬ rs.2 ∈ Finset.Ioc k l)
    (fun rs _ h => h.2.1 h.1.1)

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_split_crossing_partition_from_necSuf {L : ℕ}
    (crossing : OrientedEdge L → OrientedEdge L → Bool) (edge : ℕ → OrientedEdge L)
    (m k l : ℕ) :
    ((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).card
    = (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => rs.1 ∈ Finset.Ioc k l ∧ rs.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => ¬ rs.1 ∈ Finset.Ioc k l ∧ ¬ rs.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
          (fun rs => rs.1 < rs.2 ∧ crossing (edge rs.1) (edge rs.2) = true)).filter
        (fun rs => ¬(rs.1 ∈ Finset.Ioc k l ∧ rs.2 ∈ Finset.Ioc k l)
          ∧ ¬(¬ rs.1 ∈ Finset.Ioc k l ∧ ¬ rs.2 ∈ Finset.Ioc k l))).card :=
  smoothing_split_crossing_partition crossing edge m k l

end Ising2DLambda.KacWard
