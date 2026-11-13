/-
「頂点単純閉路の位相因子はトーラスの巻き付き二次符号に等しい」の導出版。
必要十分版 `vertex_simple_orbit_quadratic_sign_necSuf` を、係数の住処を `Qbar`、
切断線偶奇を実際の閉歩道の `decide (· = 1)`、回転数を循環総回転数として特殊化し、具体版と同じ結論を得る。
二つの含意は具体版と同じく `claim_vertex_simple_cycle_turning_by_seam_parity` の具体版から得る。
-/
import Ising2DLambda.KacWard.VertexSimpleOrbitQuadraticSign
import Ising2DLambda.KacWard.TorusQuadraticSignFromNecSuf
import Ising2DLambda.NecSuf.KacWard.VertexSimpleOrbitQuadraticSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem vertexSimpleOrbit_quadraticSign_from_necSuf {L m : ℕ} [NeZero L]
    (s : SpinStructure) {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    -((-1 : Qbar) ^ (s.1.toNat * (edgeSequenceSeamParities (List.ofFn γ)).1 +
          s.2.toNat * (edgeSequenceSeamParities (List.ofFn γ)).2)) *
        z ^ cyclicTotalTurning γ hγ =
      ((torusQuadraticSign s.1 s.2
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).1 = 1))
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).2 = 1)) : ℤ) : Qbar) := by
  have hturn := vertexSimpleCycle_cyclicTotalTurning_by_seamParity γ hγ hcontact
  set p := edgeSequenceSeamParities (List.ofFn γ) with hp
  have hlt1 : p.1 < 2 := by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)
  have hlt2 : p.2 < 2 := by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)
  have hpb : p = ((decide (p.1 = 1)).toNat, (decide (p.2 = 1)).toNat) :=
    Prod.ext (natLtTwo_eq_decide_toNat _ hlt1) (natLtTwo_eq_decide_toNat _ hlt2)
  have hzero : (decide (p.1 = 1), decide (p.2 = 1)) = (false, false) →
      cyclicTotalTurning γ hγ = 4 ∨ cyclicTotalTurning γ hγ = -4 := by
    intro h0
    apply hturn.1
    obtain ⟨h1, h2⟩ := Prod.mk.inj h0
    rw [hpb, h1, h2]
    rfl
  have hnonzero : (decide (p.1 = 1), decide (p.2 = 1)) ≠ (false, false) →
      cyclicTotalTurning γ hγ = 0 := by
    intro h0
    apply hturn.2
    intro hp0
    apply h0
    rw [hp0]
    rfl
  have hres := Ising2DLambda.NecSuf.KacWard.vertex_simple_orbit_quadratic_sign_necSuf
    z hz4 s.1 s.2 (decide (p.1 = 1)) (decide (p.2 = 1)) (cyclicTotalTurning γ hγ)
    hzero hnonzero
  rw [torusQuadraticSign_from_necSuf, ← torusQuadraticParity_from_necSuf]
  rw [← torusQuadraticParity_from_necSuf] at hres
  conv_lhs => rw [hpb]
  exact hres

end Ising2DLambda.KacWard
