import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 台集合が部分体であるために要るのは体演算に関する六つの閉性である。 -/
def carrier_isSubfield_necSuf {K : Type*} [Field K] (S : Set K)
    (hzero : (0 : K) ∈ S) (hone : (1 : K) ∈ S)
    (hadd : ∀ x y, x ∈ S → y ∈ S → x + y ∈ S)
    (hneg : ∀ x, x ∈ S → -x ∈ S)
    (hmul : ∀ x y, x ∈ S → y ∈ S → x * y ∈ S)
    (hinv : ∀ x, x ∈ S → x⁻¹ ∈ S) : Subfield K where
  carrier := S
  zero_mem' := hzero
  one_mem' := hone
  add_mem' := by
    intro x y hx hy
    exact hadd x y hx hy
  neg_mem' := by
    intro x hx
    exact hneg x hx
  mul_mem' := by
    intro x y hx hy
    exact hmul x y hx hy
  inv_mem' := by
    intro x hx
    exact hinv x hx

end Ising2DLambda.NecSuf.FisherZero
