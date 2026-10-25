import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- Two oriented word identities and involutive signs determine the intervening sign. -/
theorem matchingPairSignComposition_necSuf {R : Type*} [CommRing R]
    (s a b d e first second : R)
    (hmap : second = s * first)
    (hfirst : first = a * d) (hsecond : second = b * e)
    (ha : a * a = 1) (hd : d * d = 1) :
    s = a * b * d * e := by
  have h : b * e = s * (a * d) := by rw [← hsecond, hmap, hfirst]
  calc
    s = s * ((a * d) * (a * d)) := by rw [show (a * d) * (a * d) = 1 by
      calc
        (a * d) * (a * d) = (a * a) * (d * d) := by ring
        _ = 1 := by rw [ha, hd, one_mul]]; ring
    _ = (b * e) * (a * d) := by rw [h]; ring
    _ = a * b * d * e := by ring

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
