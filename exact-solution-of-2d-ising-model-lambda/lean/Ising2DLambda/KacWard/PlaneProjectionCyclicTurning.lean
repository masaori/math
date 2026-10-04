/- 射影辺の種類と向きから回転数を読み、歩ベクトルの循環隣接和へ移す。 -/
import Ising2DLambda.KacWard.ReversalDirectionShift
import Ising2DLambda.KacWard.ReversedParallelStaircaseTurning
import Ising2DLambda.TransferMatrix.Basic

namespace Ising2DLambda.KacWard

open Ising2DLambda.TransferMatrix Ising2DLambda.NecSuf.KacWard

/-- `def_plane_unit_path_torus_projection`。負向きの辺番号は終点から作る。 -/
def projectedUnitStep (L : ℕ) [NeZero L] (p u : ℤ × ℤ) : OrientedEdge L :=
  if u = (0, 1) then (edgeOfRow L false p.1 p.2, false)
  else if u = (1, 0) then (edgeOfRow L true p.1 p.2, false)
  else if u = (0, -1) then
    (edgeOfRow L false (p.1 + u.1) (p.2 + u.2), true)
  else (edgeOfRow L true (p.1 + u.1) (p.2 + u.2), true)

def unitStepDirection (u : ℤ × ℤ) : ZMod 4 :=
  if u = (0, 1) then 0 else if u = (1, 0) then 1
  else if u = (0, -1) then 2 else 3

/-- 有効な非後退接続では `def_step_turning` の表。逆向きの対への拡張値は零。 -/
def directionPairTurning (a b : ZMod 4) : ℤ :=
  if b - a = 1 then 1 else if b - a = -1 then -1 else 0

theorem directionPairTurning_eq_turnValue (a : ZMod 4) (turn : Turn) :
    directionPairTurning a (a + (turnValue turn : ZMod 4)) = turnValue turn := by
  fin_cases a <;> cases turn <;> decide

theorem projectedUnitStep_direction (L : ℕ) [NeZero L] (p u : ℤ × ℤ) :
    directionNumber (projectedUnitStep L p u) = unitStepDirection u := by
  have horizontal (i j : ZMod L) : (edgeOfRow L false i j).val < L ^ 2 := by
    simpa [edgeOfRow] using rowColumnIndex_lt L i j
  have vertical (i j : ZMod L) : ¬(edgeOfRow L true i j).val < L ^ 2 := by
    simp [edgeOfRow]
  unfold projectedUnitStep unitStepDirection
  split <;> (try split) <;> (try split) <;>
    simp [directionNumber, horizontal, vertical]

theorem unitStepDirection_turning (u v : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0))
    (hv : v = (0, 1) ∨ v = (1, 0) ∨ v = (0, -1) ∨ v = (-1, 0)) :
    directionPairTurning (unitStepDirection u) (unitStepDirection v) =
      latticeStepTurning u v := by
  rcases hu with rfl | rfl | rfl | rfl <;>
    rcases hv with rfl | rfl | rfl | rfl <;>
    norm_num [directionPairTurning, unitStepDirection, latticeStepTurning] <;> decide

theorem projectedUnitStep_turning (L : ℕ) [NeZero L] (p q u v : ℤ × ℤ)
    (hu : u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0))
    (hv : v = (0, 1) ∨ v = (1, 0) ∨ v = (0, -1) ∨ v = (-1, 0)) :
    directionPairTurning (directionNumber (projectedUnitStep L p u))
      (directionNumber (projectedUnitStep L q v)) = latticeStepTurning u v := by
  rw [projectedUnitStep_direction, projectedUnitStep_direction]
  exact unitStepDirection_turning u v hu hv

/-- `claim_plane_projection_cyclic_turning`。射影が閉じた非後退辺列なら左辺が循環総回転数。
数値の表は逆向きの対も零で定義しているため、恒等式自体は全単位路で成立する。 -/
theorem planeProjection_cyclicTurning (L : ℕ) [NeZero L] (n : ℕ) (hn : 0 < n)
    (W : ℕ → ℤ × ℤ)
    (hunit : ∀ j < n, let u := W (j + 1) - W j
      u = (0, 1) ∨ u = (1, 0) ∨ u = (0, -1) ∨ u = (-1, 0)) :
    cyclicAdjacentSum (fun e f => directionPairTurning (directionNumber e) (directionNumber f))
      n (fun j => projectedUnitStep L (W j) (W (j + 1) - W j)) =
    cyclicAdjacentSum latticeStepTurning n (fun j => W (j + 1) - W j) := by
  unfold cyclicAdjacentSum
  congr 1
  · apply Finset.sum_congr rfl
    intro j hj
    have hj' := Finset.mem_range.mp hj
    exact projectedUnitStep_turning L _ _ _ _ (hunit j (by omega))
      (hunit (j + 1) (by omega))
  · exact projectedUnitStep_turning L _ _ _ _ (hunit (n - 1) (by omega)) (hunit 0 hn)

end Ising2DLambda.KacWard
