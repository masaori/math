/-
章「Kac--Ward 行列式の置換展開」の
「反転対を含まない非後退置換の台は偶部分グラフである」
（`claim_reversal_free_moved_support_even`）の具体版。

人手証明と同じく、動く向き付き辺から台の辺への一対一対応を作り、置換による
入辺と出辺の全単射で端点数を二倍の形へする。住処は有限集合と ℕ である。
-/
import Mathlib.Tactic
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum
import Ising2DLambda.KacWard.Basic

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.PartitionPolynomial Ising2DLambda.FisherZero

/-- 向き付き辺の始点。 -/
def orientedSource {L : ℕ} (e : OrientedEdge L) : Vertex L :=
  if e.2 then boundary1 L e.1 else boundary0 L e.1

/-- 向き付き辺の終点。 -/
def orientedTarget {L : ℕ} (e : OrientedEdge L) : Vertex L :=
  if e.2 then boundary0 L e.1 else boundary1 L e.1

/-- 置換が動かす向き付き辺の有限集合 `M(φ)`。 -/
def movedOrientedEdges {L : ℕ} (σ : Equiv.Perm (OrientedEdge L)) : Finset (OrientedEdge L) :=
  Finset.univ.filter (fun e ↦ σ e ≠ e)

/-- 動く向き付き辺を載せる無向辺の台 `E_supp(φ)`。 -/
def movedEdgeSupport {L : ℕ} (σ : Equiv.Perm (OrientedEdge L)) : Finset (Edge L) :=
  (movedOrientedEdges σ).image Prod.fst

private lemma moved_map {L : ℕ} (σ : Equiv.Perm (OrientedEdge L)) {e : OrientedEdge L}
    (he : e ∈ movedOrientedEdges σ) : σ e ∈ movedOrientedEdges σ := by
  rw [movedOrientedEdges, Finset.mem_filter] at he ⊢
  refine ⟨Finset.mem_univ _, ?_⟩
  intro h
  exact he.2 (σ.injective h)

private lemma moved_symm_map {L : ℕ} (σ : Equiv.Perm (OrientedEdge L))
    {e : OrientedEdge L} (he : e ∈ movedOrientedEdges σ) :
    σ.symm e ∈ movedOrientedEdges σ := by
  rw [movedOrientedEdges, Finset.mem_filter] at he ⊢
  refine ⟨Finset.mem_univ _, ?_⟩
  intro h
  apply he.2
  simpa using congrArg σ h

/-- 動く向き付き辺上の置換。 -/
def movedPermutation {L : ℕ} (σ : Equiv.Perm (OrientedEdge L)) :
    Equiv.Perm {e // e ∈ movedOrientedEdges σ} where
  toFun e := ⟨σ e, moved_map σ e.property⟩
  invFun e := ⟨σ.symm e, moved_symm_map σ e.property⟩
  left_inv e := Subtype.ext (σ.symm_apply_apply e)
  right_inv e := Subtype.ext (σ.apply_symm_apply e)

private lemma same_base_or_reversal {L : ℕ} {e f : OrientedEdge L}
    (hbase : e.1 = f.1) : e = f ∨ reversal e = f := by
  rcases e with ⟨e, false | true⟩ <;> rcases f with ⟨f, false | true⟩ <;>
    change e = f at hbase <;> subst f <;>
    simp [reversal]

/-- 反転対を含まなければ、台の各辺には動く向き付き辺がちょうど一つ載る。 -/
noncomputable def movedSupportEquiv {L : ℕ} (σ : Equiv.Perm (OrientedEdge L))
    (hfree : ∀ e, e ∈ movedOrientedEdges σ → reversal e ∉ movedOrientedEdges σ) :
    {e // e ∈ movedEdgeSupport σ} ≃ {e // e ∈ movedOrientedEdges σ} := by
  let project : {e // e ∈ movedOrientedEdges σ} → {e // e ∈ movedEdgeSupport σ} :=
    fun e ↦ ⟨e.1.1, by
      rw [movedEdgeSupport, Finset.mem_image]
      exact ⟨e.1, e.property, rfl⟩⟩
  have hinj : Function.Injective project := by
    intro e f h
    have hbase : e.1.1 = f.1.1 := congrArg Subtype.val h
    rcases same_base_or_reversal hbase with hef | href
    · exact Subtype.ext hef
    · exact False.elim (hfree e e.property (href.symm ▸ f.property))
  have hsurj : Function.Surjective project := by
    rintro ⟨e, he⟩
    rw [movedEdgeSupport, Finset.mem_image] at he
    obtain ⟨o, ho, rfl⟩ := he
    exact ⟨⟨o, ho⟩, rfl⟩
  exact (Equiv.ofBijective project ⟨hinj, hsurj⟩).symm

/-- `claim_reversal_free_moved_support_even` の具体版。 -/
theorem reversalFreeMovedSupport_even (L : ℕ) [NeZero L]
    (σ : Equiv.Perm (OrientedEdge L))
    (hfree : ∀ e, e ∈ movedOrientedEdges σ → reversal e ∉ movedOrientedEdges σ)
    (hnext : ∀ e, e ∈ movedOrientedEdges σ → orientedSource (σ e) = orientedTarget e) :
    IsEvenEdgeSubset L (movedEdgeSupport σ) := by
  intro v
  let lift := movedSupportEquiv σ hfree
  let cycle := movedPermutation σ
  let incoming : ℕ := ∑ o : {e // e ∈ movedOrientedEdges σ},
    if orientedTarget o.1 = v then 1 else 0
  have h : Even (∑ e : {e // e ∈ movedEdgeSupport σ},
      ((if boundary0 L e.1 = v then 1 else 0) +
        (if boundary1 L e.1 = v then 1 else 0))) := by
    refine ⟨incoming, ?_⟩
    calc
      ∑ e : {e // e ∈ movedEdgeSupport σ},
          ((if boundary0 L e.1 = v then 1 else 0) +
            (if boundary1 L e.1 = v then 1 else 0)) =
          ∑ o : {e // e ∈ movedOrientedEdges σ},
            ((if orientedSource o.1 = v then 1 else 0) +
              (if orientedTarget o.1 = v then 1 else 0)) := by
        apply Fintype.sum_equiv lift
        intro e
        have hproject := lift.symm_apply_apply e
        have hbase : (lift e).1.1 = e.1 := congrArg Subtype.val hproject
        cases hdirection : (lift e).1.2 <;>
          simp [orientedSource, orientedTarget, hdirection, hbase, Nat.add_comm]
      _ = (∑ o : {e // e ∈ movedOrientedEdges σ},
            if orientedSource o.1 = v then 1 else 0) + incoming := by
        simp only [incoming, Finset.sum_add_distrib]
      _ = (∑ o : {e // e ∈ movedOrientedEdges σ},
            if orientedSource (cycle o).1 = v then 1 else 0) + incoming := by
        congr 1
        exact (Fintype.sum_equiv cycle
          (fun o : {e // e ∈ movedOrientedEdges σ} =>
            if orientedSource (cycle o).1 = v then 1 else 0)
          (fun o : {e // e ∈ movedOrientedEdges σ} =>
            if orientedSource o.1 = v then 1 else 0) (fun _ => rfl)).symm
      _ = incoming + incoming := by
        congr 1
        apply Finset.sum_congr rfl
        intro o _
        exact congrArg (fun w : Vertex L => if w = v then 1 else 0) (hnext o.1 o.property)
  rw [edgeSubsetIncidenceCount]
  have sum_support (f : Edge L → ℕ) :
      (∑ e : {e // e ∈ movedEdgeSupport σ}, f e.1) = ∑ e ∈ movedEdgeSupport σ, f e := by
    rw [show (Finset.univ : Finset {e // e ∈ movedEdgeSupport σ}) =
        (movedEdgeSupport σ).attach by ext; simp, Finset.sum_attach]
  rw [Finset.sum_add_distrib] at h
  rw [sum_support (fun e ↦ if boundary0 L e = v then 1 else 0),
    sum_support (fun e ↦ if boundary1 L e = v then 1 else 0)] at h
  simpa only [Finset.sum_add_distrib] using h

end Ising2DLambda.KacWard
