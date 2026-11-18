import Ising2DLambda.FisherZero.QuadraticLinearValuesAdjoin

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `b` が `F` の外にあれば、`u + v * b` の二つの係数は一意である。 -/
theorem quadraticRepresentation_unique (F : Subfield Qbar) (b u v w t : Qbar)
    (hbF : b ∉ F) (hu : u ∈ F) (hv : v ∈ F) (hw : w ∈ F) (ht : t ∈ F)
    (h : u + v * b = w + t * b) : u = w ∧ v = t := by
  -- 本文の差の等式 `(v-t)b=w-u`。
  have hdiff : (v - t) * b = w - u := by
    calc
      (v - t) * b = v * b - t * b := by ring
      _ = w - u := by linear_combination h
  -- `v≠t` なら本文の除法で `b∈F` となる。
  have hvt : v = t := by
    by_contra hne
    have hmem : b ∈ F := by
      have hquot : b = (w - u) / (v - t) := by
        apply (eq_div_iff (sub_ne_zero.mpr hne)).2
        exact (mul_comm b (v - t)).trans hdiff
      rw [hquot]
      exact F.div_mem (F.sub_mem hw hu) (F.sub_mem hv ht)
    exact hbF hmem
  -- `v=t` を元の等式へ戻し、加法を消去する。
  constructor
  · simpa [hvt] using h
  · exact hvt

end Ising2DLambda.FisherZero
