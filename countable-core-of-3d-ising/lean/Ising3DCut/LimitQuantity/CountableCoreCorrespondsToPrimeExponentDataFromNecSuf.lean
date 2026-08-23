/- 具体版は、必要十分版の対象述語を正の有理数に特殊化して得られる。 -/
import Ising3DCut.LimitQuantity.CountableCoreCorrespondsToPrimeExponentData
import Ising3DCut.NecSuf.CountableCoreCorrespondsToPrimeExponentData

namespace Ising3DCut.LimitQuantity

theorem countable_core_corresponds_to_prime_exponent_data_viaNecSuf
    {S T : Type*} (π : ℚ → S) (lam : ℚ → T)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (hlam : ∀ u w : ℚ, 0 < u → 0 < w → lam u = lam w → u = w) :
    ∃ (Φ : positiveCoarseImage π → positiveCoarseImage lam)
      (Ψ : positiveCoarseImage lam → positiveCoarseImage π),
      (∀ s, Ψ (Φ s) = s) ∧ (∀ t, Φ (Ψ t) = t) := by
  simpa [positiveCoarseImage, Ising3DCut.NecSuf.goodImage] using
    (Ising3DCut.NecSuf.good_images_correspond (fun q : ℚ ↦ 0 < q) π lam hfree hlam)

end Ising3DCut.LimitQuantity
