import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A binary height constant across adjacent rows and supported on finitely many rows is zero. -/
theorem finiteRowHeight_zero (height : ℤ → ZMod 2) (rows : Finset ℤ)
    (hstep : ∀ r : ℤ, height r = height (r - 1))
    (hsupport : ∀ r : ℤ, height r = 1 → r ∈ rows) (r : ℤ) :
    height r = 0 := by
  have hconstant (s : ℤ) : height s = height 0 := by
    induction s using Int.induction_on with
    | zero => rfl
    | succ s ih =>
        calc
          height (s + 1) = height s := by
            simpa only [add_sub_cancel_right] using hstep (s + 1)
          _ = height 0 := ih
    | pred s ih => exact (hstep (-(s : ℤ))).symm.trans ih
  obtain ⟨s, hs⟩ : ∃ s : ℤ, s ∉ rows := by
    by_cases hne : rows.Nonempty
    · obtain ⟨e, he, hmax⟩ := Finset.exists_max_image rows id hne
      refine ⟨e + 1, ?_⟩
      intro hmem
      have := hmax (e + 1) hmem
      simp only [id_eq] at this
      omega
    · exact ⟨0, by simp [Finset.not_nonempty_iff_eq_empty.mp hne]⟩
  have hzero : height s = 0 := by
    have hcases (x : ZMod 2) : x = 0 ∨ x = 1 := by
      fin_cases x <;> first | exact Or.inl rfl | exact Or.inr rfl
    by_cases hone : height s = 1
    · exact False.elim (hs (hsupport s hone))
    · exact (hcases (height s)).resolve_right hone
  exact (hconstant r).trans ((hconstant s).symm.trans hzero)

end Ising2DLambda.NecSuf.KacWard
