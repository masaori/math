/-
本文「短い対に現れる回転位相は零でない」の具体版。
四方向の辺の構成と個数比較が `sourceDirection_surjective` と
`shortPair_direction_ne`、三方向の場合分けが `shortPairRotationPhase_three_values`、
原始八乗根の非零性と三値の零でなさが最後の二定理に対応する。
住処は有限集合、ℤ/4ℤ、Qbar である。
-/
import Ising2DLambda.KacWard.TerminalMatrix
import Ising2DLambda.TransferMatrix.Basic
import Ising2DLambda.NecSuf.KacWard.ShortPairRotationPhaseNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

private theorem sourceDirection_surjective {L : ℕ} [NeZero L] :
    Function.Surjective (fun e : OrientedEdge L => (orientedSource e, directionNumber e)) := by
  rintro ⟨⟨i, j⟩, d⟩
  fin_cases d
  · refine ⟨(edgeOfRow L false i j, false), ?_⟩
    have h := rowColumnIndex_lt L i j
    change (boundary0 L (edgeOfRow L false i j),
      directionNumber (edgeOfRow L false i j, false)) = _
    apply Prod.ext
    · exact edgeOfRow_boundary0 L false i j
    · simp [directionNumber, edgeOfRow, h]
      rfl
  · refine ⟨(edgeOfRow L true i j, false), ?_⟩
    change (boundary0 L (edgeOfRow L true i j),
      directionNumber (edgeOfRow L true i j, false)) = _
    apply Prod.ext
    · exact edgeOfRow_boundary0 L true i j
    · simp [directionNumber, edgeOfRow]
      rfl
  · refine ⟨(edgeOfRow L false i (j - 1), true), ?_⟩
    have h := rowColumnIndex_lt L i (j - 1)
    change (boundary1 L (edgeOfRow L false i (j - 1)),
      directionNumber (edgeOfRow L false i (j - 1), true)) = _
    apply Prod.ext
    · rw [edgeOfRow_boundary1_horizontal]
      simp
    · simp [directionNumber, edgeOfRow, h]
      rfl
  · refine ⟨(edgeOfRow L true (i - 1) j, true), ?_⟩
    change (boundary1 L (edgeOfRow L true (i - 1) j),
      directionNumber (edgeOfRow L true (i - 1) j, true)) = _
    apply Prod.ext
    · rw [edgeOfRow_boundary1_vertical]
      simp
    · simp [directionNumber, edgeOfRow]
      rfl

/-- At a fixed source, the direction identifies the oriented edge. -/
theorem shortPair_direction_ne {L : ℕ} [NeZero L] (e f : OrientedEdge L)
    (hsource : orientedSource e = orientedSource f) (hne : e ≠ f) :
    directionNumber e ≠ directionNumber f := by
  have hcard : Fintype.card (OrientedEdge L) =
      Fintype.card (Vertex L × ZMod 4) := by
    rw [show Fintype.card (OrientedEdge L) = Fintype.card (Edge L) * 2 by
      change Fintype.card (Edge L × Bool) = Fintype.card (Edge L) * 2
      rw [Fintype.card_prod, Fintype.card_bool],
      show Fintype.card (Vertex L × ZMod 4) = L ^ 2 * 4 by
        simp [Fintype.card_prod, card_vertex, ZMod.card], card_edge]
    ring
  have hinj := (Fintype.bijective_iff_surjective_and_card
    (fun e : OrientedEdge L => (orientedSource e, directionNumber e))).mpr
    ⟨sourceDirection_surjective, hcard⟩
  intro hdir
  apply hne
  apply hinj.1
  exact Prod.ext hsource hdir

/-- The finite direction table excludes the fourth, zero-valued case. -/
theorem shortPairRotationPhase_three_values {L : ℕ} (z : Qbar)
    (e f : OrientedEdge L) (hdir : directionNumber f ≠ directionNumber e) :
    rotationPhase z (reversal e) f = 1 ∨
      rotationPhase z (reversal e) f = z ∨
    rotationPhase z (reversal e) f = z⁻¹ := by
  have hcases : directionNumber f = directionNumber (reversal e) ∨
      directionNumber f = directionNumber (reversal e) + 1 ∨
      directionNumber f = directionNumber (reversal e) - 1 := by
    rw [directionNumber_reversal]
    have htable : ∀ x y : ZMod 4, x ≠ y →
        y = x + 2 ∨ y = x + 2 + 1 ∨ y = x + 2 - 1 := by decide
    exact htable (directionNumber e) (directionNumber f) (Ne.symm hdir)
  have hdistinct : ∀ x : ZMod 4,
      x + 1 ≠ x ∧ x - 1 ≠ x ∧ x - 1 ≠ x + 1 := by decide
  rcases hcases with h | h | h
  · left
    simp [rotationPhase, h]
  · right; left
    have hn := (hdistinct (directionNumber (reversal e))).1
    simp [rotationPhase, h, hn]
  · right; right
    have hn := (hdistinct (directionNumber (reversal e))).2.1
    have hn' := (hdistinct (directionNumber (reversal e))).2.2
    simp [rotationPhase, h, hn, hn']

/-- The algebraic phase is nonzero once the geometric direction distinction is supplied. -/
theorem shortPairRotationPhase_ne_zero_of_direction_ne {L : ℕ} (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (e f : OrientedEdge L)
    (hdir : directionNumber f ≠ directionNumber e) :
    rotationPhase z (reversal e) f ≠ 0 := by
  have hz0 : z ≠ 0 := by
    intro h
    simp [h] at hz
  exact Ising2DLambda.NecSuf.KacWard.three_value_phase_ne_zero z
    (rotationPhase z (reversal e) f) hz0
    (shortPairRotationPhase_three_values z e f hdir)

/-- The two actual oriented edges have a nonzero rotation phase. -/
theorem shortPairRotationPhase_ne_zero {L : ℕ} [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (e f : OrientedEdge L)
    (hsource : orientedSource e = orientedSource f) (hne : e ≠ f) :
    rotationPhase z (reversal e) f ≠ 0 := by
  have hdir : directionNumber f ≠ directionNumber e :=
    (shortPair_direction_ne e f hsource hne).symm
  exact shortPairRotationPhase_ne_zero_of_direction_ne z hz e f hdir

/-- Specialization of the abstract three-value argument. -/
theorem shortPairRotationPhase_ne_zero_from_necSuf {L : ℕ} [NeZero L] (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (e f : OrientedEdge L)
    (hsource : orientedSource e = orientedSource f) (hne : e ≠ f) :
    rotationPhase z (reversal e) f ≠ 0 := by
  have hz0 : z ≠ 0 := by
    intro h
    simp [h] at hz
  have hdir : directionNumber f ≠ directionNumber e :=
    (shortPair_direction_ne e f hsource hne).symm
  exact Ising2DLambda.NecSuf.KacWard.three_value_phase_ne_zero z
    (rotationPhase z (reversal e) f) hz0
    (shortPairRotationPhase_three_values z e f hdir)

end Ising2DLambda.KacWard
