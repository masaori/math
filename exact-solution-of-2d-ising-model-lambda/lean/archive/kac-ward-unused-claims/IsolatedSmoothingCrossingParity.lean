/-
「孤立した一つの横断を平滑化すると横断数が一つ減る」
（`claim_isolated_smoothing_crossing_number_update`）の具体版。
閉歩道の添字を `Fin m`、横断関係を `IndexCrossing` に固定する。
-/
import Ising2DLambda.KacWard.CrossingNumberDouble
import Ising2DLambda.NecSuf.KacWard.IsolatedSmoothingCrossingParity

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 選択した順序なし横断対だけを除いた、孤立横断の平滑化後の横断関係。 -/
def IsolatedSmoothingCrossing {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) (a b i j : Fin m) : Prop :=
  removeUnorderedPair (IndexCrossing vertex visit) a b i j

instance {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) (a b : Fin m) :
    DecidableRel (IsolatedSmoothingCrossing vertex visit a b) := by
  intro i j
  unfold IsolatedSmoothingCrossing
  infer_instance

/-- 孤立した横断 `a < b` を一つ平滑化すると、横断数は一つ減る（具体版）。 -/
theorem isolated_smoothing_crossing_number_update {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit)
    (a b : Fin m) (hab : a < b) (hcross : IndexCrossing vertex visit a b) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IsolatedSmoothingCrossing vertex visit a b p.1 p.2).card + 1 := by
  exact remove_unordered_pair_card_add_one_necSuf Finset.univ
    (IndexCrossing vertex visit) a b (Finset.mem_univ _) (Finset.mem_univ _) hab hcross

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem isolated_smoothing_crossing_number_update_from_necSuf
    {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit)
    (a b : Fin m) (hab : a < b) (hcross : IndexCrossing vertex visit a b) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IsolatedSmoothingCrossing vertex visit a b p.1 p.2).card + 1 :=
  isolated_smoothing_crossing_number_update vertex visit a b hab hcross

end Ising2DLambda.KacWard
