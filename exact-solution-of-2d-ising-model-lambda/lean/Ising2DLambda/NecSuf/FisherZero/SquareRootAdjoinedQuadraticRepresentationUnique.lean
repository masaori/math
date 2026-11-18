import Ising2DLambda.FisherZero.SquareRootAdjoinedQuadraticRepresentationUnique

namespace Ising2DLambda.NecSuf.FisherZero

/-- 係数の一意性に平方関係と代数閉性は不要である。 -/
theorem quadraticRepresentation_unique_necSuf {K : Type*} [Field K]
    (F : Subfield K) (b u v w t : K)
    (hbF : b ∉ F) (hu : u ∈ F) (hv : v ∈ F) (hw : w ∈ F) (ht : t ∈ F)
    (h : u + v * b = w + t * b) : u = w ∧ v = t := by
  have hdiff : (v - t) * b = w - u := by
    calc
      (v - t) * b = v * b - t * b := by ring
      _ = w - u := by linear_combination h
  have hvt : v = t := by
    by_contra hne
    have hmem : b ∈ F := by
      have hquot : b = (w - u) / (v - t) := by
        apply (eq_div_iff (sub_ne_zero.mpr hne)).2
        exact (mul_comm b (v - t)).trans hdiff
      rw [hquot]
      exact F.div_mem (F.sub_mem hw hu) (F.sub_mem hv ht)
    exact hbF hmem
  constructor
  · simpa [hvt] using h
  · exact hvt

end Ising2DLambda.NecSuf.FisherZero
