/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の内側セル集合は辺連結である」
（`claim_interior_cell_set_edge_connected`）の具体版。

人手証明の最後の合成と同じく、歩道沿いの内側帯を連結な核とし、任意の内側セルから
同じ行を進んで帯へ至る有限列を前後につなぐ。
-/
import Ising2DLambda.KacWard.WalkSideInteriorBandConnected
import Ising2DLambda.KacWard.InteriorCellReachesWalkSideBand

namespace Ising2DLambda.KacWard


/-- 内側帯へ届く二セルを、帯の中の道でつなぐ。 -/
theorem edgeConnected_of_band_reaches
    (S band : Set (ℤ × ℤ))
    (hbandNonempty : band.Nonempty)
    (hbandSubset : band ⊆ S)
    (hbandConnected : EdgeConnectedCellSet band)
    (hreaches : ∀ x ∈ S, ∃ b ∈ band,
      Relation.ReflTransGen
        (fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b) x b) :
    S.Nonempty ∧ EdgeConnectedCellSet S := by
  obtain ⟨base, hbase⟩ := hbandNonempty
  refine ⟨⟨base, hbandSubset hbase⟩, ?_⟩
  intro x hx y hy
  obtain ⟨bx, hbx, hxbx⟩ := hreaches x hx
  obtain ⟨bridgeY, hbridgeY, hyBridgeY⟩ := hreaches y hy
  let step := fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b
  have hbandPath := hbandConnected hbx hbridgeY
  have hcorePath : Relation.ReflTransGen step bx bridgeY :=
    (Relation.ReflTransGen.mono
      (r := fun a b => a ∈ band ∧ b ∈ band ∧ CellEdgeAdjacent a b)
      (fun _ _ h => ⟨hbandSubset h.1, hbandSubset h.2.1, h.2.2⟩)
      bx bridgeY) hbandPath
  have hreverse : Relation.ReflTransGen (Function.swap step) bridgeY y :=
    (Relation.ReflTransGen.swap (r := step) bridgeY y) hyBridgeY
  have hswap : Function.swap step ≤ step := by
    intro a b hab
    rcases hab.2.2 with h | h
    · rcases h with ⟨hr, hc⟩
      exact ⟨hab.2.1, hab.1, Or.inl ⟨hr.symm, hc.elim (fun h => Or.inr (by omega))
        (fun h => Or.inl (by omega))⟩⟩
    · rcases h with ⟨hc, hr⟩
      exact ⟨hab.2.1, hab.1, Or.inr ⟨hc.symm, hr.elim (fun h => Or.inr (by omega))
        (fun h => Or.inl (by omega))⟩⟩
  have hbyy : Relation.ReflTransGen step bridgeY y :=
    (Relation.ReflTransGen.mono (r := Function.swap step) hswap bridgeY y) hreverse
  exact hxbx.trans (hcorePath.trans hbyy)

/-- 内側帯と行方向到達を合成する局所版。 -/
theorem interiorCellSet_nonempty_edgeConnected_local
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hnonempty : ∀ k < n, (surroundingInteriorCells n row col k).Nonempty)
    (hlocal : ∀ k < n, EdgeConnectedCellSet (surroundingInteriorCells n row col k))
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1))
    (hreaches : ∀ x ∈ oddRayInteriorCells n row col, ∃ b ∈ walkSideInteriorBand n row col,
      Relation.ReflTransGen
        (fun a b =>
          a ∈ oddRayInteriorCells n row col ∧
          b ∈ oddRayInteriorCells n row col ∧
          CellEdgeAdjacent a b)
        x b) :
    (oddRayInteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (oddRayInteriorCells n row col) := by
  have hband := walkSideInteriorBand_nonempty_edgeConnected_local
    n row col hn hnonempty hlocal hbridge
  apply edgeConnected_of_band_reaches
    (oddRayInteriorCells n row col) (walkSideInteriorBand n row col)
    hband.1
  · rintro p ⟨k, hk, hp⟩
    exact hp.2
  · exact hband.2
  · exact hreaches

/-- `claim_interior_cell_set_edge_connected` の具体版。 -/
theorem interiorCellSet_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (hn : 0 < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hedgeSimple : ∀ k, k < n →
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1)
    (hbridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingInteriorCells n row col k ∧
      p ∈ surroundingInteriorCells n row col (k + 1))
    (hreaches : ∀ x ∈ oddRayInteriorCells n row col, ∃ b ∈ walkSideInteriorBand n row col,
      Relation.ReflTransGen
        (fun a b =>
          a ∈ oddRayInteriorCells n row col ∧
          b ∈ oddRayInteriorCells n row col ∧
          CellEdgeAdjacent a b)
        x b) :
    (oddRayInteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (oddRayInteriorCells n row col) := by
  have hband := walkSideInteriorBand_nonempty_edgeConnected n row col hn
    hclosedRow hclosedCol hunit hdistinct hedgeSimple
  apply edgeConnected_of_band_reaches
    (oddRayInteriorCells n row col) (walkSideInteriorBand n row col)
    hband.1
  · rintro p ⟨k, hk, hp⟩
    exact hp.2
  · exact hband.2
  · exact hreaches

/-- 実際の閉歩道では、内側帯と各セルから帯への有限路が内側全体をつなぐ。 -/
theorem interiorCellSetOfWalk_nonempty_edgeConnected {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hh : horizontalDirectedWindingNumber γ = 0)
    (hv : verticalDirectedWindingNumber γ = 0)
    (hdistinct : Function.Injective
      (fun i : Fin (m + 1) => planeLift γ i.castSucc)) :
    (oddRayInteriorCellsOfWalk γ hγ hh hv).Nonempty ∧
      EdgeConnectedCellSet (oddRayInteriorCellsOfWalk γ hγ hh hv) := by
  have hband := walkSideInteriorBandFromWalk_nonempty_edgeConnected
    γ hγ hh hv hdistinct
  apply edgeConnected_of_band_reaches
    (oddRayInteriorCellsOfWalk γ hγ hh hv)
    (walkSideInteriorBandFromWalk γ hγ hh hv) hband.1
  · intro p hp
    exact hp.1
  · exact hband.2
  · rintro ⟨r, c⟩ hinside
    exact interiorCellOfWalk_reaches_band γ hγ hh hv r c hinside

/-- The projected edge sequence of a one-sided closure has a nonempty,
edge-connected interior cell set, using one cut point for simplicity and zero winding. -/
theorem oneSidedClosureProjectionFromWalk_interior_nonempty_edgeConnected
    {L m : ℕ} [NeZero L]
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0)
    (hwind : (horizontalDirectedWindingNumber γ,
      verticalDirectedWindingNumber γ) ≠ (0, 0)) :
    ∃ k₀ : ℤ, ∀ t c : ℕ, 0 < t → 0 < c →
      let W := oneSidedClosurePoint (m + 1) L (planeLiftIntegerBase γ)
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) k₀ t c
      let N := oneSidedClosureLength (m + 1) L
        (verticalDirectedWindingNumber γ) (horizontalDirectedWindingNumber γ) t c
      let Γ : Fin (N - 1 + 1) → OrientedEdge L := fun j =>
        projectedUnitStep L (W j.val) (W (j.val + 1) - W j.val)
      ∃ (hΓ : closedNonbacktrackingWalk Γ)
        (hh : horizontalDirectedWindingNumber Γ = 0)
        (hv : verticalDirectedWindingNumber Γ = 0),
        (oddRayInteriorCellsOfWalk Γ hΓ hh hv).Nonempty ∧
          EdgeConnectedCellSet (oddRayInteriorCellsOfWalk Γ hΓ hh hv) := by
  obtain ⟨k₀, hsimpleZero⟩ :=
    oneSidedClosureProjectionFromWalk_simple_zero_winding γ hγ hcontact hwind
  refine ⟨k₀, ?_⟩
  intro t c ht hc
  have hp := hsimpleZero t c ht hc
  dsimp only at hp ⊢
  exact ⟨hp.2.1, hp.2.2.2, hp.2.2.1,
    interiorCellSetOfWalk_nonempty_edgeConnected _ hp.2.1 hp.2.2.2 hp.2.2.1 hp.1⟩

end Ising2DLambda.KacWard
