import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

theorem polynomial_fourier_similarity_necSuf {ι R : Type*}
    [Fintype ι] [DecidableEq ι] [CommRing R]
    (M F B G : Matrix ι ι R) (x : R)
    (hMF : M * F = F * B) (hFG : F * G = 1) :
    1 - x • M = F * (1 - x • B) * G := by
  calc
    1 - x • M = F * G - x • (M * (F * G)) := by rw [hFG]; simp
    _ = F * G - x • ((M * F) * G) := by rw [mul_assoc]
    _ = F * G - x • ((F * B) * G) := by rw [hMF]
    _ = F * (1 - x • B) * G := by
      simp [mul_sub, sub_mul, mul_assoc]

end Ising2DLambda.NecSuf.KacWard
