import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

/- The composition needs only a finite mode set, an initial product
   decomposition, and two pointwise equalities. -/
theorem dispersion_mode_product_necSuf
    {K R : Type*} [Fintype K] [CommMonoid R]
    (D : R) (fiber direction dispersion : K → R)
    (hfiber : D = ∏ m : K, fiber m)
    (hdirection : ∀ m, fiber m = direction m)
    (hdispersion : ∀ m, direction m = dispersion m) :
    D = ∏ m : K, dispersion m := by
  classical
  calc
    D = ∏ m : K, fiber m := hfiber
    _ = ∏ m : K, direction m := by
      apply Finset.prod_congr rfl
      intro m _
      exact hdirection m
    _ = ∏ m : K, dispersion m := by
      apply Finset.prod_congr rfl
      intro m _
      exact hdispersion m

end Ising2DLambda.NecSuf.KacWard
