import Ising2DLambda.NecSuf.KacWard.VertexSimpleIncidentEdges

namespace Ising2DLambda.NecSuf.KacWard

/-- At a vertex visited once, every incident traversal is one of the two passages. -/
theorem vertexSimple_only_pass_edges {m : ℕ} {E V : Type*}
    [DecidableEq V] (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ k.castSucc) = source (γ k.succ))
    (hclose : target (γ (Fin.last m)) = source (γ 0))
    (hinj : Function.Injective (target ∘ γ))
    (k next : Fin (m + 1)) (hnext : source (γ next) = target (γ k))
    (j : Fin (m + 1))
    (hincident : source (γ j) = target (γ k) ∨ target (γ j) = target (γ k)) :
    γ j = γ k ∨ γ j = γ next := by
  classical
  have htargets :
      (∑ i : Fin (m + 1), if target (γ i) = target (γ k) then 1 else 0) = 1 := by
    have heq (i : Fin (m + 1)) : target (γ i) = target (γ k) ↔ i = k :=
      hinj.eq_iff
    simp_rw [heq]
    simp
  have hsources :
      (∑ i : Fin (m + 1), if source (γ i) = target (γ k) then 1 else 0) = 1 := by
    rw [← closedWalk_source_target_count γ source target hstep hclose]
    exact htargets
  rcases hincident with hs | ht
  · have hcard :
        (Finset.univ.filter (fun i : Fin (m + 1) =>
          source (γ i) = target (γ k))).card = 1 := by
      simpa [Finset.sum_boole] using hsources
    obtain ⟨i, hi⟩ := Finset.card_eq_one.mp hcard
    have hj : j ∈ Finset.univ.filter (fun i : Fin (m + 1) =>
        source (γ i) = target (γ k)) := by simp [hs]
    have hn : next ∈ Finset.univ.filter (fun i : Fin (m + 1) =>
        source (γ i) = target (γ k)) := by simp [hnext]
    rw [hi] at hj hn
    simp only [Finset.mem_singleton] at hj hn
    exact Or.inr (congrArg γ (hj.trans hn.symm))
  · exact Or.inl (congrArg γ (hinj (by simpa only [Function.comp_apply] using ht)))

/-- A coefficient supported on a simple closed walk has no third incident edge at a passage.
Target injectivity identifies the incoming passage; closure and the known outgoing passage
identify the only source. Support is needed to turn a nonzero coefficient into a traversal,
and incidence is needed to connect that traversal to the passage vertex. -/
theorem vertexSimple_other_edge_contribution_zero {m : ℕ} {E V B : Type*}
    [DecidableEq V] (γ : Fin (m + 1) → E) (source target : E → V)
    (hstep : ∀ k : Fin m, target (γ k.castSucc) = source (γ k.succ))
    (hclose : target (γ (Fin.last m)) = source (γ 0))
    (hinj : Function.Injective (target ∘ γ))
    (k next : Fin (m + 1)) (hnext : source (γ next) = target (γ k))
    (base : E → B) (coeff incidence : B → ℤ)
    (hsupport : ∀ b, coeff b ≠ 0 → ∃ j, base (γ j) = b)
    (hincident : ∀ e, incidence (base e) ≠ 0 →
      source e = target (γ k) ∨ target e = target (γ k))
    (b : B) (hfirst : b ≠ base (γ k)) (hsecond : b ≠ base (γ next)) :
    coeff b * incidence b = 0 := by
  by_cases hc : coeff b = 0
  · simp [hc]
  by_cases hi : incidence b = 0
  · simp [hi]
  obtain ⟨j, hj⟩ := hsupport b hc
  have htwo := vertexSimple_only_pass_edges γ source target hstep hclose hinj
    k next hnext j (by apply hincident; simpa [hj] using hi)
  rcases htwo with h | h
  · exact (hfirst (hj ▸ congrArg base h)).elim
  · exact (hsecond (hj ▸ congrArg base h)).elim

end Ising2DLambda.NecSuf.KacWard
