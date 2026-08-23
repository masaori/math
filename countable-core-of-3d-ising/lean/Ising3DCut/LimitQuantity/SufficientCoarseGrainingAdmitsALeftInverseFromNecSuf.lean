/- 具体版は、必要十分版で対象述語を正の有理数に特殊化して得られる。 -/
import Ising3DCut.LimitQuantity.SufficientCoarseGrainingAdmitsALeftInverse
import Ising3DCut.NecSuf.SufficientCoarseGrainingAdmitsALeftInverse

namespace Ising3DCut.LimitQuantity

theorem positiveCoarseLeftInverse_leftInverse_fromNecSuf {S : Type*} (π : ℚ → S)
    (hfree : ∀ u w : ℚ, 0 < u → 0 < w → π u = π w → u = w)
    (u : ℚ) (hu : 0 < u) :
    positiveCoarseLeftInverse π (toPositiveCoarseImage π u hu) = u := by
  simpa [positiveCoarseLeftInverse, toPositiveCoarseImage, positiveCoarseImage,
    Ising3DCut.NecSuf.goodLeftInverse, Ising3DCut.NecSuf.toGoodImage,
    Ising3DCut.NecSuf.goodImage] using
    (Ising3DCut.NecSuf.goodLeftInverse_leftInverse (fun q : ℚ ↦ 0 < q) π hfree u hu)

end Ising3DCut.LimitQuantity
