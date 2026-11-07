/-
章「Onsager 閉形式への接続」の
「持ち上げ点が相異なる閉路の内側セル集合の補集合は辺連結である」
（`claim_exterior_cell_set_edge_connected`）の具体版。

人手証明と同じく、外接長方形の外側と歩道沿いの外側帯を交わる二つの連結な核とし、
任意の外側セルから同じ行を進んでその合併へ至る有限列をつなぐ。
-/
import Ising2DLambda.KacWard.WalkSideExteriorBandConnected
import Ising2DLambda.KacWard.InteriorCellSetEdgeConnected

namespace Ising2DLambda.KacWard

/-- 右半直線交差数が偶数であるセル、すなわち内側セル集合の補集合。 -/
def exteriorCells (n : ℕ) (row col : ℕ → ℤ) : Set (ℤ × ℤ) :=
  (oddRayInteriorCells n row col)ᶜ

/-- 外接長方形の四辺より外にある整数格子セル。 -/
def outsideBoundingRectangle
    (rMin rMax cMin cMax : ℤ) : Set (ℤ × ℤ) :=
  {p | p.1 < rMin ∨ rMax ≤ p.1 ∨ p.2 < cMin ∨ cMax ≤ p.2}

/-- 横の有限区間に奇数回通過した縦辺がなければ、外側セルのまま進める。 -/
theorem exteriorCells_horizontalPath_of_even_vertical_edges
    (n : ℕ) (row col : ℕ → ℤ) (r c d : ℤ)
    (hcd : c ≤ d) (hstart : (r, c) ∈ exteriorCells n row col)
    (heven : ∀ j : ℤ, c < j → j ≤ d →
      Even (verticalEdgeTraversalCount n row col r j)) :
    Relation.ReflTransGen
      (fun a b => a ∈ exteriorCells n row col ∧
        b ∈ exteriorCells n row col ∧ CellEdgeAdjacent a b)
      (r, c) (r, d) := by
  let step := fun a b => a ∈ exteriorCells n row col ∧
    b ∈ exteriorCells n row col ∧ CellEdgeAdjacent a b
  have hpath (z : ℤ) (hcz : c ≤ z)
      (hevenZ : ∀ j : ℤ, c < j → j ≤ z →
        Even (verticalEdgeTraversalCount n row col r j)) :
      Relation.ReflTransGen step (r, c) (r, z) ∧
        (r, z) ∈ exteriorCells n row col := by
    induction z, hcz using Int.leInduction with
    | base => exact ⟨Relation.ReflTransGen.refl, hstart⟩
    | succ z hcz ih =>
      have hprevious := ih (fun j hcj hjz => hevenZ j hcj (by omega))
      have hcurrent : Even (rightRayCrossingCount n row col r z) :=
        Nat.not_odd_iff_even.mp hprevious.2
      have hcross : Even (verticalEdgeTraversalCount n row col r (z + 1)) :=
        hevenZ (z + 1) (by omega) (by omega)
      have hnext : (r, z + 1) ∈ exteriorCells n row col := by
        change ¬ Odd (rightRayCrossingCount n row col r (z + 1))
        apply Nat.not_odd_iff_even.mpr
        have hsplit := rightRayCrossingCount_adjacent n row col r z
        rcases hcurrent with ⟨q, hq⟩
        rcases hcross with ⟨t, ht⟩
        exact ⟨q - t, by omega⟩
      exact ⟨hprevious.1.tail ⟨hprevious.2, hnext,
        Or.inl ⟨rfl, Or.inr (by omega)⟩⟩, hnext⟩
  exact (hpath d hcd heven).1

/-- 長方形の上側または下側の固定行では、任意の二セルを列方向の有限路で結べる。 -/
theorem outsideBoundingRectangle_horizontalPath
    (rMin rMax cMin cMax r c d : ℤ)
    (hr : r < rMin ∨ rMax ≤ r) :
    Relation.ReflTransGen
      (fun a b => a ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
        b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧ CellEdgeAdjacent a b)
      (r, c) (r, d) := by
  let step := fun a b => a ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
    b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧ CellEdgeAdjacent a b
  have hmem (z : ℤ) : (r, z) ∈ outsideBoundingRectangle rMin rMax cMin cMax := by
    change r < rMin ∨ rMax ≤ r ∨ z < cMin ∨ cMax ≤ z
    rcases hr with h | h
    · exact Or.inl h
    · exact Or.inr (Or.inl h)
  have hforward (a b : ℤ) (hab : a ≤ b) :
      Relation.ReflTransGen step (r, a) (r, b) := by
    induction b, hab using Int.leInduction with
    | base => exact Relation.ReflTransGen.refl
    | succ b _ ih =>
      exact ih.tail ⟨hmem b, hmem (b + 1),
        Or.inl ⟨rfl, Or.inr (by omega)⟩⟩
  rcases le_total c d with hcd | hdc
  · exact hforward c d hcd
  · have hreverse : Relation.ReflTransGen (Function.swap step) (r, c) (r, d) :=
      (Relation.ReflTransGen.swap (r := step) (r, c) (r, d))
        (hforward d c hdc)
    apply Relation.ReflTransGen.mono (r := Function.swap step) ?_ _ _ hreverse
    intro a b hab
    rcases hab.2.2 with h | h
    · rcases h with ⟨hrEq, hc⟩
      exact ⟨hab.2.1, hab.1,
        Or.inl ⟨hrEq.symm, hc.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩
    · rcases h with ⟨hcEq, hrStep⟩
      exact ⟨hab.2.1, hab.1,
        Or.inr ⟨hcEq.symm, hrStep.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩

/-- 長方形の左側または右側の固定列では、任意の二セルを行方向の有限路で結べる。 -/
theorem outsideBoundingRectangle_verticalPath
    (rMin rMax cMin cMax c r s : ℤ)
    (hc : c < cMin ∨ cMax ≤ c) :
    Relation.ReflTransGen
      (fun a b => a ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
        b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧ CellEdgeAdjacent a b)
      (r, c) (s, c) := by
  let step := fun a b => a ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
    b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧ CellEdgeAdjacent a b
  have hmem (z : ℤ) : (z, c) ∈ outsideBoundingRectangle rMin rMax cMin cMax := by
    change z < rMin ∨ rMax ≤ z ∨ c < cMin ∨ cMax ≤ c
    rcases hc with h | h
    · exact Or.inr (Or.inr (Or.inl h))
    · exact Or.inr (Or.inr (Or.inr h))
  have hforward (a b : ℤ) (hab : a ≤ b) :
      Relation.ReflTransGen step (a, c) (b, c) := by
    induction b, hab using Int.leInduction with
    | base => exact Relation.ReflTransGen.refl
    | succ b _ ih =>
      exact ih.tail ⟨hmem b, hmem (b + 1),
        Or.inr ⟨rfl, Or.inr (by omega)⟩⟩
  rcases le_total r s with hrs | hsr
  · exact hforward r s hrs
  · have hreverse : Relation.ReflTransGen (Function.swap step) (r, c) (s, c) :=
      (Relation.ReflTransGen.swap (r := step) (r, c) (s, c))
        (hforward s r hsr)
    apply Relation.ReflTransGen.mono (r := Function.swap step) ?_ _ _ hreverse
    intro a b hab
    rcases hab.2.2 with h | h
    · rcases h with ⟨hrEq, hcStep⟩
      exact ⟨hab.2.1, hab.1,
        Or.inl ⟨hrEq.symm, hcStep.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩
    · rcases h with ⟨hcEq, hrStep⟩
      exact ⟨hab.2.1, hab.1,
        Or.inr ⟨hcEq.symm, hrStep.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩

/-- 外接長方形外の各セルを左下の基準セルへ結び、二セル間の有限路を得る。 -/
theorem outsideBoundingRectangle_edgeConnected
    (rMin rMax cMin cMax : ℤ) :
    EdgeConnectedCellSet (outsideBoundingRectangle rMin rMax cMin cMax) := by
  let S := outsideBoundingRectangle rMin rMax cMin cMax
  let step := fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b
  let base : ℤ × ℤ := (rMin - 1, cMin - 1)
  have hleft : cMin - 1 < cMin := by omega
  have hbelow : rMin - 1 < rMin := by omega
  have hreach (p : ℤ × ℤ) (hp : p ∈ S) :
      Relation.ReflTransGen step p base := by
    rcases p with ⟨r, c⟩
    change r < rMin ∨ rMax ≤ r ∨ c < cMin ∨ cMax ≤ c at hp
    rcases hp with hr | hr | hc | hc
    · exact (outsideBoundingRectangle_horizontalPath
        rMin rMax cMin cMax r c (cMin - 1) (Or.inl hr)).trans
        (outsideBoundingRectangle_verticalPath
          rMin rMax cMin cMax (cMin - 1) r (rMin - 1) (Or.inl hleft))
    · exact (outsideBoundingRectangle_horizontalPath
        rMin rMax cMin cMax r c (cMin - 1) (Or.inr hr)).trans
        (outsideBoundingRectangle_verticalPath
          rMin rMax cMin cMax (cMin - 1) r (rMin - 1) (Or.inl hleft))
    · exact (outsideBoundingRectangle_verticalPath
        rMin rMax cMin cMax c r (rMin - 1) (Or.inl hc)).trans
        (outsideBoundingRectangle_horizontalPath
          rMin rMax cMin cMax (rMin - 1) c (cMin - 1) (Or.inl hbelow))
    · exact (outsideBoundingRectangle_verticalPath
        rMin rMax cMin cMax c r (rMin - 1) (Or.inr hc)).trans
        (outsideBoundingRectangle_horizontalPath
          rMin rMax cMin cMax (rMin - 1) c (cMin - 1) (Or.inl hbelow))
  intro x hx y hy
  have hreverse : Relation.ReflTransGen (Function.swap step) base y :=
    (Relation.ReflTransGen.swap (r := step) base y) (hreach y hy)
  have hsymm : (Function.swap step) ≤ step := by
    intro a b hab
    rcases hab.2.2 with h | h
    · rcases h with ⟨hrEq, hcStep⟩
      exact ⟨hab.2.1, hab.1,
        Or.inl ⟨hrEq.symm, hcStep.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩
    · rcases h with ⟨hcEq, hrStep⟩
      exact ⟨hab.2.1, hab.1,
        Or.inr ⟨hcEq.symm, hrStep.elim (fun h => Or.inr (by omega))
          (fun h => Or.inl (by omega))⟩⟩
  exact (hreach x hx).trans ((Relation.ReflTransGen.mono hsymm base y) hreverse)

/-- 最大列を持つ持ち上げ点の右側のセルは、外側帯と長方形の外側の双方に属する。 -/
theorem outsideBoundingRectangle_inter_walkSideExteriorBand
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ)
    (hmax : ∃ k < n, col k = cMax)
    (houtsideSubset : outsideBoundingRectangle rMin rMax cMin cMax ⊆
      exteriorCells n row col) :
    ∃ p, p ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
      p ∈ walkSideExteriorBand n row col := by
  obtain ⟨k, hk, hcol⟩ := hmax
  refine ⟨(row k, cMax), ?_, ?_⟩
  · change row k < rMin ∨ rMax ≤ row k ∨ cMax < cMin ∨ cMax ≤ cMax
    exact Or.inr (Or.inr (Or.inr le_rfl))
  · refine ⟨k, hk, ?_⟩
    constructor
    · exact Or.inr (Or.inr (Or.inl (by rw [hcol])))
    · exact houtsideSubset (Or.inr (Or.inr (Or.inr le_rfl)))

/-- 交わる外側の二つの核を、辺隣接の有限路で一つにつなぐ。 -/
theorem exteriorCores_nonempty_edgeConnected
    (S firstCore secondCore : Set (ℤ × ℤ))
    (hfirstSubset : firstCore ⊆ S) (hsecondSubset : secondCore ⊆ S)
    (hfirstConnected : EdgeConnectedCellSet firstCore)
    (hsecondConnected : EdgeConnectedCellSet secondCore)
    (hoverlap : ∃ p, p ∈ firstCore ∧ p ∈ secondCore)
    (hreaches : ∀ x ∈ S, ∃ b ∈ firstCore ∪ secondCore,
      Relation.ReflTransGen
        (fun a b => a ∈ S ∧ b ∈ S ∧ CellEdgeAdjacent a b) x b) :
    S.Nonempty ∧ EdgeConnectedCellSet S := by
  have hcoreNonempty : (firstCore ∪ secondCore).Nonempty := by
    obtain ⟨p, hp, -⟩ := hoverlap
    exact ⟨p, Or.inl hp⟩
  have hcoreConnected : EdgeConnectedCellSet (firstCore ∪ secondCore) := by
    intro x hx y hy
    obtain ⟨p, hpFirst, hpSecond⟩ := hoverlap
    have liftFirst :
        (fun a b => a ∈ firstCore ∧ b ∈ firstCore ∧ CellEdgeAdjacent a b) ≤
        (fun a b => a ∈ firstCore ∪ secondCore ∧
          b ∈ firstCore ∪ secondCore ∧ CellEdgeAdjacent a b) := by
      intro a b hab
      exact ⟨Or.inl hab.1, Or.inl hab.2.1, hab.2.2⟩
    have liftSecond :
        (fun a b => a ∈ secondCore ∧ b ∈ secondCore ∧ CellEdgeAdjacent a b) ≤
        (fun a b => a ∈ firstCore ∪ secondCore ∧
          b ∈ firstCore ∪ secondCore ∧ CellEdgeAdjacent a b) := by
      intro a b hab
      exact ⟨Or.inr hab.1, Or.inr hab.2.1, hab.2.2⟩
    rcases hx with hxFirst | hxSecond
    · rcases hy with hyFirst | hySecond
      · exact (Relation.ReflTransGen.mono liftFirst x y)
          (hfirstConnected hxFirst hyFirst)
      · exact ((Relation.ReflTransGen.mono liftFirst x p)
          (hfirstConnected hxFirst hpFirst)).trans
          ((Relation.ReflTransGen.mono liftSecond p y)
            (hsecondConnected hpSecond hySecond))
    · rcases hy with hyFirst | hySecond
      · exact ((Relation.ReflTransGen.mono liftSecond x p)
          (hsecondConnected hxSecond hpSecond)).trans
          ((Relation.ReflTransGen.mono liftFirst p y)
            (hfirstConnected hpFirst hyFirst))
      · exact (Relation.ReflTransGen.mono liftSecond x y)
          (hsecondConnected hxSecond hySecond)
  exact edgeConnected_of_band_reaches S (firstCore ∪ secondCore)
    hcoreNonempty (Set.union_subset hfirstSubset hsecondSubset)
    hcoreConnected hreaches

/-- 外側帯・外接長方形外・行方向到達を合成する局所版。 -/
theorem exteriorCellSet_nonempty_edgeConnected_local
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ) (hn : 0 < n)
    (houtsideSubset : outsideBoundingRectangle rMin rMax cMin cMax ⊆
      exteriorCells n row col)
    (houtsideConnected : EdgeConnectedCellSet
      (outsideBoundingRectangle rMin rMax cMin cMax))
    (hbandNonempty : ∀ k < n, (surroundingExteriorCells n row col k).Nonempty)
    (hbandLocal : ∀ k < n,
      EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbandBridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1))
    (hoverlap : ∃ p,
      p ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
      p ∈ walkSideExteriorBand n row col)
    (hreaches : ∀ x ∈ exteriorCells n row col,
      ∃ b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∪
          walkSideExteriorBand n row col,
        Relation.ReflTransGen
          (fun a b =>
            a ∈ exteriorCells n row col ∧
            b ∈ exteriorCells n row col ∧
            CellEdgeAdjacent a b)
          x b) :
    (exteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (exteriorCells n row col) := by
  have hband := walkSideExteriorBand_nonempty_edgeConnected_local
    n row col hn hbandNonempty hbandLocal hbandBridge
  have hbandSubset : walkSideExteriorBand n row col ⊆ exteriorCells n row col := by
    rintro p ⟨k, hk, hp⟩
    change p ∉ oddRayInteriorCells n row col
    exact hp.2
  exact exteriorCores_nonempty_edgeConnected
    (exteriorCells n row col)
    (outsideBoundingRectangle rMin rMax cMin cMax)
    (walkSideExteriorBand n row col)
    houtsideSubset hbandSubset houtsideConnected hband.2 hoverlap hreaches

/-- `claim_exterior_cell_set_edge_connected` の具体版。 -/
theorem exteriorCellSet_nonempty_edgeConnected
    (n : ℕ) (row col : ℕ → ℤ) (rMin rMax cMin cMax : ℤ) (hn : 0 < n)
    (hclosedRow : row n = row 0) (hclosedCol : col n = col 0)
    (hunit : IsUnitGridWalk n row col)
    (hdistinct : ∀ k l, k < n → l < n →
      row k = row l → col k = col l → k = l)
    (hedgeSimple : ∀ k, k < n →
      verticalEdgeTraversalCount n row col (row k - 1) (col k) ≤ 1 ∧
      verticalEdgeTraversalCount n row col (row k) (col k) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k - 1) ≤ 1 ∧
      horizontalEdgeTraversalCount n row col (row k) (col k) ≤ 1)
    (houtsideSubset : outsideBoundingRectangle rMin rMax cMin cMax ⊆
      exteriorCells n row col)
    (houtsideConnected : EdgeConnectedCellSet
      (outsideBoundingRectangle rMin rMax cMin cMax))
    (hbandLocal : ∀ k < n,
      EdgeConnectedCellSet (surroundingExteriorCells n row col k))
    (hbandBridge : ∀ k, k + 1 < n → ∃ p,
      p ∈ surroundingExteriorCells n row col k ∧
      p ∈ surroundingExteriorCells n row col (k + 1))
    (hoverlap : ∃ p,
      p ∈ outsideBoundingRectangle rMin rMax cMin cMax ∧
      p ∈ walkSideExteriorBand n row col)
    (hreaches : ∀ x ∈ exteriorCells n row col,
      ∃ b ∈ outsideBoundingRectangle rMin rMax cMin cMax ∪
          walkSideExteriorBand n row col,
        Relation.ReflTransGen
          (fun a b =>
            a ∈ exteriorCells n row col ∧
            b ∈ exteriorCells n row col ∧
            CellEdgeAdjacent a b)
          x b) :
    (exteriorCells n row col).Nonempty ∧
      EdgeConnectedCellSet (exteriorCells n row col) := by
  have hband := walkSideExteriorBand_nonempty_edgeConnected n row col hn
    hclosedRow hclosedCol hunit hdistinct hedgeSimple hbandLocal hbandBridge
  have hbandSubset : walkSideExteriorBand n row col ⊆ exteriorCells n row col := by
    rintro p ⟨k, hk, hp⟩
    change p ∉ oddRayInteriorCells n row col
    exact hp.2
  exact exteriorCores_nonempty_edgeConnected
    (exteriorCells n row col)
    (outsideBoundingRectangle rMin rMax cMin cMax)
    (walkSideExteriorBand n row col)
    houtsideSubset hbandSubset houtsideConnected hband.2 hoverlap hreaches

end Ising2DLambda.KacWard
