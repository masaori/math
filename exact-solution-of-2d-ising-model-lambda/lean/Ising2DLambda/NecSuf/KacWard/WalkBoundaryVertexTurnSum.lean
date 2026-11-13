import Ising2DLambda.NecSuf.KacWard.CyclicTotalTurning
import Mathlib.Tactic

/-!
必要十分版: 出発辺の回転数和と境界頂点の局所回転数和の同定。

具体版 `vertexSimpleWalk_cyclicTotalTurning_eq_boundary_turn_sum_left` /
`..._right` と同じ手順
（循環総回転数を巡回の後続への回転数の全歩にわたる和に書く → 各歩を境界頂点の局所回転数へ書き換える →
巡回の後続 `next` で再添字付けする → 出発位置と境界頂点の全単射 `pos` で再添字付けする →
部分型の和を有限集合の和へ戻す）を、辺の型 `E`・頂点の型 `V`・回転数 `turn`・局所回転数 `localTurn`
を任意に取って述べる。
-/

open scoped BigOperators

namespace Ising2DLambda.NecSuf.KacWard

private theorem finRotate_castSucc_eq_succ' (m : ℕ) (k : Fin m) :
    finRotate (m + 1) k.castSucc = k.succ := by
  apply Fin.ext
  rw [coe_finRotate_of_ne_last (Fin.castSucc_lt_last k).ne]
  simp

/-- The cyclic total is the sum over all steps of the turn into the cyclic successor.
Nothing about `turn` is used. -/
theorem cyclic_turning_eq_sum_finRotate {E : Type*} {m : ℕ}
    (turn : E → E → ℤ) (γ : Fin (m + 1) → E) :
    cyclicTotalTurning turn γ =
      ∑ j : Fin (m + 1), turn (γ j) (γ (finRotate (m + 1) j)) := by
  rw [Fin.sum_univ_castSucc, finRotate_last]
  simp only [finRotate_castSucc_eq_succ']
  rfl

/-- Reindexing a sum over steps by a permutation `next` of the steps and a bijection `pos`
from the steps to a finite set of vertices. Only that `next` and `pos` are bijections is used. -/
theorem boundary_turn_sum_reindex
    {I V : Type*} [Fintype I] (next : I ≃ I) (boundary : Finset V)
    (pos : I ≃ {v // v ∈ boundary}) (stepTurn : I → ℤ) (localTurn : V → ℤ)
    (hmatch : ∀ j, stepTurn j = localTurn (pos (next j)).val) :
    ∑ j, stepTurn j = ∑ v ∈ boundary, localTurn v := by
  calc
    ∑ j, stepTurn j = ∑ j, localTurn (pos (next j)).val :=
      Finset.sum_congr rfl (fun j _ => hmatch j)
    _ = ∑ j, localTurn (pos j).val :=
      Equiv.sum_comp next (fun j => localTurn (pos j).val)
    _ = ∑ x : {v // v ∈ boundary}, localTurn x.val :=
      Equiv.sum_comp pos (fun x => localTurn x.val)
    _ = ∑ v ∈ boundary, localTurn v := Finset.sum_coe_sort boundary localTurn

/-- Interior on the left: the cyclic total turning is the sum of the local turns
over the boundary vertices. -/
theorem cyclic_turning_eq_boundary_turn_sum_left
    {E V : Type*} {m : ℕ} (turn : E → E → ℤ) (γ : Fin (m + 1) → E)
    (boundary : Finset V) (pos : Fin (m + 1) ≃ {v // v ∈ boundary})
    (localTurn : V → ℤ)
    (hmatch : ∀ j, turn (γ j) (γ (finRotate (m + 1) j)) =
      localTurn (pos (finRotate (m + 1) j)).val) :
    cyclicTotalTurning turn γ = ∑ v ∈ boundary, localTurn v := by
  rw [cyclic_turning_eq_sum_finRotate]
  exact boundary_turn_sum_reindex (finRotate (m + 1)) boundary pos _ localTurn hmatch

/-- Interior on the right: the cyclic total turning is minus the sum of the local turns
over the boundary vertices. -/
theorem cyclic_turning_eq_neg_boundary_turn_sum_right
    {E V : Type*} {m : ℕ} (turn : E → E → ℤ) (γ : Fin (m + 1) → E)
    (boundary : Finset V) (pos : Fin (m + 1) ≃ {v // v ∈ boundary})
    (localTurn : V → ℤ)
    (hmatch : ∀ j, turn (γ j) (γ (finRotate (m + 1) j)) =
      -localTurn (pos (finRotate (m + 1) j)).val) :
    cyclicTotalTurning turn γ = -∑ v ∈ boundary, localTurn v := by
  rw [cyclic_turning_eq_sum_finRotate, ← Finset.sum_neg_distrib]
  exact boundary_turn_sum_reindex (finRotate (m + 1)) boundary pos _
    (fun v => -localTurn v) hmatch

end Ising2DLambda.NecSuf.KacWard
