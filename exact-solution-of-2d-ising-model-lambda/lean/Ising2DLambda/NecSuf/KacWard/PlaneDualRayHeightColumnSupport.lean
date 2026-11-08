import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- A binary height vanishing outside two column bounds has finite column support. -/
theorem binaryHeight_column_support (height : ℤ → ℤ → ZMod 2) (a b : ℤ)
    (hleft : ∀ r c : ℤ, c < a → height r c = 0)
    (hright : ∀ r c : ℤ, b ≤ c → height r c = 0) :
    ∀ r c : ℤ, height r c = 1 → c ∈ Finset.Icc a b := by
  intro r c hheight
  have ha : a ≤ c := by
    by_contra hc
    have hz := hleft r c (by omega)
    have : (0 : ZMod 2) = 1 := hz.symm.trans hheight
    norm_num at this
  have hb : c < b := by
    by_contra hc
    have hz := hright r c (by omega)
    have : (0 : ZMod 2) = 1 := hz.symm.trans hheight
    norm_num at this
  exact Finset.mem_Icc.mpr ⟨ha, le_of_lt hb⟩

end Ising2DLambda.NecSuf.KacWard
