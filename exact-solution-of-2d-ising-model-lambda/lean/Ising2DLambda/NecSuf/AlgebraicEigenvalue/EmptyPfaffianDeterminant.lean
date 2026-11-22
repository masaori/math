import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Ising2DLambda.AlgebraicEigenvalue

/-- 空集合での唯一のマッチングと置換だけを使い、係数環は任意の可換環とする。 -/
theorem emptyWeightedPfaffianDeterminant
    {R : Type*} [CommRing R]
    (_A : Matrix Empty Empty R)
    (c b : PerfectMatching Empty → R)
    (hc : ∀ D, c D = 1) (hb : ∀ D, b D = 1)
    (hdet : Matrix.det _A = 1) :
    (∑ D : PerfectMatching Empty, c D * b D) = 1 ∧
      Matrix.det _A = 1 ∧
      (∑ D : PerfectMatching Empty, c D * b D) ^ 2 = Matrix.det _A := by
  classical
  have hpf : (∑ D : PerfectMatching Empty, c D * b D) = 1 := by
    simp [hc, hb]
  refine ⟨hpf, hdet, ?_⟩
  rw [hpf, hdet]
  simp

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
