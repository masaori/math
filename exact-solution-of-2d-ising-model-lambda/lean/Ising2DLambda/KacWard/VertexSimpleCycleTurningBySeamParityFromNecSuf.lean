/-
「頂点単純閉路の循環総回転数は切断線偶奇で決まる」の導出版。
必要十分版 `vertex_simple_cycle_turning_by_seam_parity_necSuf` を、切断線偶奇の住処を `ZMod 2 × ZMod 2`、
巻き付きの住処を `ℤ × ℤ`、`red` を成分ごとの二を法とした剰余、回転数の二値を `4`・`-4` として特殊化し、
具体版と同じ結論を得る。前提は具体版と同じ補題から得る。
-/
import Ising2DLambda.KacWard.VertexSimpleCycleTurningBySeamParity
import Ising2DLambda.NecSuf.KacWard.VertexSimpleCycleTurningBySeamParity

namespace Ising2DLambda.KacWard

theorem vertexSimpleCycle_cyclicTotalTurning_by_seamParity_from_necSuf {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    (edgeSequenceSeamParities (List.ofFn γ) = (0, 0) →
        cyclicTotalTurning γ hγ = 4 ∨ cyclicTotalTurning γ hγ = -4) ∧
      (edgeSequenceSeamParities (List.ofFn γ) ≠ (0, 0) →
        cyclicTotalTurning γ hγ = 0) := by
  set p := edgeSequenceSeamParities (List.ofFn γ) with hp
  let seam : ZMod 2 × ZMod 2 := ((p.1 : ZMod 2), (p.2 : ZMod 2))
  let wind : ℤ × ℤ := (horizontalDirectedWindingNumber γ, verticalDirectedWindingNumber γ)
  let red : ℤ × ℤ → ZMod 2 × ZMod 2 := fun w => ((w.1 : ZMod 2), (w.2 : ZMod 2))
  have hparity : seam = red wind :=
    Prod.ext (horizontalDirectedWindingNumber_parity γ hγ).symm
      (verticalDirectedWindingNumber_parity γ hγ).symm
  have hzero : seam = 0 → wind = 0 := by
    intro hs
    have h1 := natLtTwo_eq_zero_of_cast_zmod_two_eq_zero p.1
      (by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num))
      (congrArg Prod.fst hs)
    have h2 := natLtTwo_eq_zero_of_cast_zmod_two_eq_zero p.2
      (by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num))
      (congrArg Prod.snd hs)
    have hh : (∑ k : Fin (m + 1), horizontalSeamParity (γ k)) % 2 = 0 := by
      rw [hp, edgeSequenceSeamParities] at h1
      simp only [List.map_ofFn, List.sum_ofFn] at h1
      exact h1
    have hv : (∑ k : Fin (m + 1), verticalSeamParity (γ k)) % 2 = 0 := by
      rw [hp, edgeSequenceSeamParities] at h2
      simp only [List.map_ofFn, List.sum_ofFn] at h2
      exact h2
    obtain ⟨hwh, hwv⟩ := vertexSimple_zero_seam_winding L m γ hγ hcontact hh hv
    exact Prod.ext hwh hwv
  have hres := Ising2DLambda.NecSuf.KacWard.vertex_simple_cycle_turning_by_seam_parity_necSuf
    seam wind (cyclicTotalTurning γ hγ) 4 (-4) red
    (Function.Injective (fun i : Fin (m + 1) => planeLift γ i.castSucc))
    (by simp [red]) hparity (vertexSimplePlaneLift_points_distinct γ hγ hcontact) hzero
    (fun hw hd => vertexSimpleWalk_cyclicTotalTurning_four γ hγ
      (congrArg Prod.fst hw) (congrArg Prod.snd hw) hd)
    (fun hw => nonzeroWindingSimpleCycle_cyclicTotalTurning_zero γ hγ hcontact hw)
  constructor
  · intro h0
    apply hres.1
    simp [seam, h0]
  · intro hne
    apply hres.2
    intro hs
    apply hne
    exact Prod.ext
      (natLtTwo_eq_zero_of_cast_zmod_two_eq_zero p.1
        (by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num))
        (congrArg Prod.fst hs))
      (natLtTwo_eq_zero_of_cast_zmod_two_eq_zero p.2
        (by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num))
        (congrArg Prod.snd hs))

end Ising2DLambda.KacWard
