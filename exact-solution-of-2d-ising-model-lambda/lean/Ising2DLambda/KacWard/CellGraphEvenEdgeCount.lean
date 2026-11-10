import Ising2DLambda.KacWard.CellGraphEdgeSubsetCorrespondence
import Ising2DLambda.KacWard.CellVertexGraphConnected
import Ising2DLambda.Tools.EvenEdgeSetCount
import Mathlib.Tactic

namespace Ising2DLambda.KacWard

private theorem even_incidence_iff_parity (n : ℕ)
    (A : Finset (Sym2 (Fin n))) (v : Fin n) :
    Even (A.filter (fun edge => v ∈ edge)).card ↔
      Ising2DLambda.Tools.edgeParity n A v = 0 := by
  have hsum : Ising2DLambda.Tools.edgeParity n A v =
      ((A.filter (fun edge => v ∈ edge)).card : ZMod 2) := by
    unfold Ising2DLambda.Tools.edgeParity
    calc
      (∑ edge : Sym2 (Fin n), if edge ∈ A ∧ v ∈ edge then (1 : ZMod 2) else 0) =
          ∑ edge ∈ A, if v ∈ edge then (1 : ZMod 2) else 0 := by
            have hset : (Finset.univ.filter (fun edge : Sym2 (Fin n) =>
                v ∈ edge ∧ edge ∈ A)) = A.filter (fun edge => v ∈ edge) := by
              ext edge
              simp [and_comm]
            simpa [Finset.sum_ite, Finset.sum_filter, hset, and_comm]
      _ = ((A.filter (fun edge => v ∈ edge)).card : ZMod 2) := by
            rw [Finset.card_filter]
            norm_cast
  rw [hsum, CharP.cast_eq_zero_iff (ZMod 2) 2]
  exact even_iff_two_dvd

/-- Count the even subsets of the actual cell-corner graph by enumerating its
vertices and applying the concrete spanning-tree count. -/
theorem cellVertexGraph_evenEdgeSubset_count
    (cells : Finset GridCell) (hnonempty : cells.Nonempty)
    (hconnected : EdgeConnectedCellSet (cells : Set GridCell)) :
    Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
      IsEvenCellGraphEdgeSet cells B} =
      2 ^ ((cellVertexGraph cells).edgeFinset.card + 1 -
        (cellVertices cells).card) := by
  classical
  let G := cellVertexGraph cells
  let n := Fintype.card (cellVertices cells)
  let e : cellVertices cells ≃ Fin n := Fintype.equivFin (cellVertices cells)
  let H : SimpleGraph (Fin n) := G.comap e.symm
  let iso : G ≃g H := (SimpleGraph.Iso.comap e.symm G).symm
  have hG : G.Connected := edgeConnectedCellSet_actualVertexGraphConnected
    cells hnonempty hconnected
  have hH : Ising2DLambda.Tools.FiniteGraphConnected H := by
    constructor
    · exact ⟨e (Classical.choice hG.nonempty)⟩
    · intro u v
      have hw := hG.preconnected (e.symm u) (e.symm v)
      have hwH : H.Reachable u v := by
        obtain ⟨w⟩ := hw
        have h := w.map iso.toHom
        simpa [iso, H] using h.reachable
      exact ⟨hwH.some.toPath, hwH.some.toPath.isPath⟩
  let edgeEquiv : Sym2 (cellVertices cells) ≃ Sym2 (Fin n) :=
    { toFun := Sym2.map e
      invFun := Sym2.map e.symm
      left_inv := by intro edge; induction edge using Sym2.ind; simp
      right_inv := by intro edge; induction edge using Sym2.ind; simp }
  let subsetEquiv := edgeEquiv.finsetCongr
  have hEdge (edge : Sym2 (cellVertices cells)) :
      edge ∈ G.edgeFinset ↔ edgeEquiv edge ∈ H.edgeFinset := by
    induction edge using Sym2.ind with
    | _ u v =>
      simp [G, H, edgeEquiv, SimpleGraph.mem_edgeFinset,
        SimpleGraph.mem_edgeSet]
  have hIncident (edge : Sym2 (cellVertices cells))
      (v : cellVertices cells) :
      v ∈ edge ↔ e v ∈ edgeEquiv edge := by
    simp [edgeEquiv, Sym2.mem_map]
  have hmem (A : Finset (Sym2 (cellVertices cells)))
      (edge : Sym2 (cellVertices cells)) :
      edgeEquiv edge ∈ subsetEquiv A ↔ edge ∈ A := by
    simp [subsetEquiv]
  have hSubset (A : Finset (Sym2 (cellVertices cells))) :
      A ⊆ G.edgeFinset ↔ subsetEquiv A ⊆ H.edgeFinset := by
    constructor
    · intro h edge hedge
      have hprior : edgeEquiv.symm edge ∈ A := by
        apply (hmem A (edgeEquiv.symm edge)).mp
        simpa using hedge
      have he := (hEdge (edgeEquiv.symm edge)).mp (h hprior)
      simpa using he
    · intro h edge hedge
      apply (hEdge edge).mpr
      apply h
      exact (hmem A edge).mpr hedge
  have hIncCard (A : Finset (Sym2 (cellVertices cells)))
      (v : cellVertices cells) :
      (A.filter (fun edge => v ∈ edge)).card =
        ((subsetEquiv A).filter (fun edge => e v ∈ edge)).card := by
    have hfilter :
        (A.filter (fun edge => v ∈ edge)).map edgeEquiv.toEmbedding =
          (subsetEquiv A).filter (fun edge => e v ∈ edge) := by
      change (A.filter (fun edge => v ∈ edge)).map edgeEquiv.toEmbedding =
        (A.map edgeEquiv.toEmbedding).filter (fun edge => e v ∈ edge)
      rw [Finset.filter_map]
      congr 1
      ext edge
      simp only [Finset.mem_filter, Function.comp_apply, Equiv.toEmbedding_apply]
      exact Iff.rfl.and (hIncident edge v)
    rw [← hfilter, Finset.card_map]
  have hPredicate (A : Finset (Sym2 (cellVertices cells))) :
      (A ⊆ G.edgeFinset ∧
        ∀ v : cellVertices cells, Even (A.filter (fun edge => v ∈ edge)).card) ↔
        Ising2DLambda.Tools.IsEvenEdgeSubsetOf n H (subsetEquiv A) := by
    constructor
    · intro h
      constructor
      · exact (hSubset A).mp h.1
      · intro w
        have hv := h.2 (e.symm w)
        rw [hIncCard] at hv
        exact (even_incidence_iff_parity n (subsetEquiv A) w).mp (by simpa using hv)
    · intro h
      constructor
      · exact (hSubset A).mpr h.1
      · intro v
        rw [hIncCard]
        exact (even_incidence_iff_parity n (subsetEquiv A) (e v)).mpr (h.2 (e v))
  have hcard := Nat.card_congr (Equiv.subtypeEquiv subsetEquiv hPredicate)
  have hcount := Ising2DLambda.Tools.finiteConnectedGraph_evenEdgeSet_count H hH
  calc
    Nat.card {B : Finset (cellVertexGraph cells).edgeFinset //
        IsEvenCellGraphEdgeSet cells B} =
      Nat.card {A : Finset (Sym2 (cellVertices cells)) //
        A ⊆ G.edgeFinset ∧
          ∀ v : cellVertices cells, Even (A.filter (fun edge => v ∈ edge)).card} :=
        cellGraphEdgeSubset_even_card cells
    _ = Nat.card {A : Finset (Sym2 (Fin n)) //
          Ising2DLambda.Tools.IsEvenEdgeSubsetOf n H A} := hcard
    _ = 2 ^ (H.edgeFinset.card + 1 - n) := hcount
    _ = 2 ^ ((cellVertexGraph cells).edgeFinset.card + 1 -
          (cellVertices cells).card) := by
            rw [← iso.card_edgeFinset_eq]
            simp only [G, n, Fintype.card_coe]

end Ising2DLambda.KacWard
