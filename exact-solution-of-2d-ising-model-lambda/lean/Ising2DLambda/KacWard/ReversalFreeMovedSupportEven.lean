/-
章「トーラス上の Kac--Ward 行列式」の
「反転対を含まない非後退置換の台は偶部分グラフである」
（`claim_reversal_free_moved_support_even`）の具体版。

人手証明と同じく、動く向き付き辺から台の辺への一対一対応を作り、置換による
入辺と出辺の全単射で端点数を二倍の形へする。住処は有限集合と ℕ である。
-/
import Mathlib.Tactic
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.NecSuf.KacWard.ReversalFreeMovedSupportEven

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
    simp [reversal, Ising2DLambda.NecSuf.KacWard.reverseBool]

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
  have h := Ising2DLambda.NecSuf.KacWard.supportIncidence_even_necSuf
    (E := {e // e ∈ movedEdgeSupport σ})
    (O := {e // e ∈ movedOrientedEdges σ})
    (fun e ↦ boundary0 L e.1) (fun e ↦ boundary1 L e.1)
    (fun e ↦ orientedSource e.1) (fun e ↦ orientedTarget e.1)
    (movedSupportEquiv σ hfree) (movedPermutation σ) (by
      intro e
      rcases e with ⟨e, he⟩
      let o := movedSupportEquiv σ hfree ⟨e, he⟩
      have hproject := (movedSupportEquiv σ hfree).symm_apply_apply ⟨e, he⟩
      have hbase : o.1.1 = e := congrArg Subtype.val hproject
      change (boundary0 L e, boundary1 L e) =
          (orientedSource o.1, orientedTarget o.1) ∨
        (boundary0 L e, boundary1 L e) =
          (orientedTarget o.1, orientedSource o.1)
      cases hdirection : o.1.2 <;>
        simp [orientedSource, orientedTarget, hdirection, hbase]) (by
        intro e
        exact hnext e e.property) v
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
