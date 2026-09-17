import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

def PairCompatible {R C : Type} (rowCompatible : R → Prop)
    (columnCompatible : C → Prop) (start : R × C) : Prop :=
  rowCompatible start.1 ∧ columnCompatible start.2

def PairRecovered {R C : Type} (rowRecovered : R → Prop)
    (columnRecovered : C → Prop) (start : R × C) : Prop :=
  rowRecovered start.1 ∧ columnRecovered start.2

def LiftCandidate {R C I : Type} (compatible : R × C → Prop)
    (lift : R × C → I) (candidate : I) : Prop :=
  ∃ start, compatible start ∧ candidate = lift start

def BoundaryCandidate {R C O : Type} (compatible : R × C → Prop)
    (boundary : R × C → O) (option : O) : Prop :=
  ∃ start, compatible start ∧ option = boundary start

/--
The essential two-coordinate step is the independent conjunction of the two
one-coordinate recovery equivalences.
-/
theorem pairCompatible_iff_pairRecovered
    {R C : Type} (rowCompatible rowRecovered : R → Prop)
    (columnCompatible columnRecovered : C → Prop)
    (hrow : ∀ r, rowCompatible r ↔ rowRecovered r)
    (hcolumn : ∀ c, columnCompatible c ↔ columnRecovered c)
    (start : R × C) :
    PairCompatible rowCompatible columnCompatible start ↔
      PairRecovered rowRecovered columnRecovered start := by
  constructor
  · rintro ⟨hr, hc⟩
    exact ⟨(hrow start.1).mp hr, (hcolumn start.2).mp hc⟩
  · rintro ⟨hr, hc⟩
    exact ⟨(hrow start.1).mpr hr, (hcolumn start.2).mpr hc⟩

/-- Replacing compatibility by its recovered form neither loses nor adds lifts. -/
theorem liftCandidate_iff_recovered
    {R C I : Type} (compatible recovered : R × C → Prop)
    (lift : R × C → I)
    (hrecover : ∀ start, compatible start ↔ recovered start)
    (candidate : I) :
    LiftCandidate compatible lift candidate ↔
      LiftCandidate recovered lift candidate := by
  constructor
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (hrecover start).mp hstart, rfl⟩
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (hrecover start).mpr hstart, rfl⟩

/-- Replacing compatibility by its recovered form preserves every boundary option. -/
theorem boundaryCandidate_iff_recovered
    {R C O : Type} (compatible recovered : R × C → Prop)
    (boundary : R × C → O)
    (hrecover : ∀ start, compatible start ↔ recovered start)
    (option : O) :
    BoundaryCandidate compatible boundary option ↔
      BoundaryCandidate recovered boundary option := by
  constructor
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (hrecover start).mp hstart, rfl⟩
  · rintro ⟨start, hstart, rfl⟩
    exact ⟨start, (hrecover start).mpr hstart, rfl⟩

end Ising2DLambda.NecSuf.KacWard
