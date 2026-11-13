import Ising2DLambda.KacWard.ShortPairRotationPhaseNonzero

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

theorem vertexPort_bijective {L : ℕ} [NeZero L] (v : Vertex L) :
    Function.Bijective
      (fun e : {e : OrientedEdge L // orientedSource e = v} => directionNumber e.1) := by
  constructor
  · intro e f hdir
    apply Subtype.ext
    apply sourceDirection_bijective.1
    exact Prod.ext (e.2.trans f.2.symm) hdir
  · intro d
    obtain ⟨e, he⟩ := sourceDirection_bijective.2 (v, d)
    exact ⟨⟨e, congrArg Prod.fst he⟩, congrArg Prod.snd he⟩

theorem selectedVertexPort_bijective {L : ℕ} [NeZero L]
    (v : Vertex L) (P : Finset (Edge L)) :
    Set.BijOn directionNumber
      {e : OrientedEdge L | orientedSource e = v ∧ e.1 ∈ P}
      {d : ZMod 4 | ∃ e : OrientedEdge L,
        orientedSource e = v ∧ e.1 ∈ P ∧ directionNumber e = d} := by
  constructor
  · intro e he
    exact ⟨e, he.1, he.2, rfl⟩
  constructor
  · intro e he f hf hdir
    apply sourceDirection_bijective.1
    exact Prod.ext (he.1.trans hf.1.symm) hdir
  · intro d hd
    obtain ⟨e, hsource, hselected, hdir⟩ := hd
    exact ⟨e, ⟨hsource, hselected⟩, hdir⟩

end Ising2DLambda.KacWard
