/-
「横断数は頂点ごとの横断数の和である」
（`claim_crossing_number_vertex_decomposition`）の具体版。
閉歩道の添字を `Fin m`、横断関係を `IndexCrossing`、頂点の有限集合を `Fintype V` に固定し、
横断対の頂点を第一添字の通過の頂点 `vertex p.1` で読む
（横断対では `vertex p.1 = vertex p.2` なのでどちらで読んでも同じ）。
-/
import Mathlib.Data.Fintype.Basic
import Ising2DLambda.KacWard.CrossingNumberDouble
import Ising2DLambda.NecSuf.KacWard.CrossingNumberVertexDecomposition

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 横断数（`k < l` の横断対の個数）は、頂点ごとの横断数
（頂点 `v` を通る横断対の個数）のすべての頂点にわたる和である（具体版）。
人手証明と同じ二段: 各横断対の頂点は `V` の元（被覆）、一つの対の頂点は一つに定まる（互いに素）。 -/
theorem crossing_number_vertex_decomposition {m : ℕ} {V : Type} [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = ∑ v : V, (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
            fun p => vertex p.1 = v).card := by
  let C := (Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
    p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2
  let Cᵥ (v : V) := C.filter fun p => vertex p.1 = v
  have hcover : (Finset.univ.biUnion Cᵥ) = C := by
    ext p
    simp only [Finset.mem_biUnion, Finset.mem_univ, true_and, Cᵥ, Finset.mem_filter]
    constructor
    · rintro ⟨v, hp, _⟩
      exact hp
    · intro hp
      exact ⟨vertex p.1, hp, rfl⟩
  have hdisj : ∀ v ∈ (Finset.univ : Finset V), ∀ w ∈ Finset.univ, v ≠ w →
      Disjoint (Cᵥ v) (Cᵥ w) := by
    intro v _ w _ hvw
    apply Finset.disjoint_left.mpr
    intro p hpv hpw
    exact hvw ((Finset.mem_filter.mp hpv).2.symm.trans (Finset.mem_filter.mp hpw).2)
  change C.card = ∑ v : V, (Cᵥ v).card
  calc
    C.card = (Finset.univ.biUnion Cᵥ).card := by rw [hcover]
    _ = ∑ v : V, (Cᵥ v).card := Finset.card_biUnion hdisj

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem crossing_number_vertex_decomposition_from_necSuf
    {m : ℕ} {V : Type} [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit : Fin m → LocalVisit) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card
      = ∑ v : V, (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
            fun p => vertex p.1 = v).card :=
  crossing_number_vertex_decomposition vertex visit

end Ising2DLambda.KacWard
