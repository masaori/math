import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 可換環での共役した有限平方和の恒等式。係数の順序は不要である。 -/
theorem quadraticConjugateSquareSumIdentity
    {R : Type} [CommRing R] (a b : R) (hb : b * b = a)
    (ι : Type) [Fintype ι] (c u v : ι → R) :
    (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
      (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) =
      2 * ∑ i, c i * ((u i * u i) + a * (v i * v i)) := by
  classical
  calc
    (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
        (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) =
        ∑ i, (c i * ((u i + v i * b) * (u i + v i * b)) +
          c i * ((u i - v i * b) * (u i - v i * b))) := by rw [Finset.sum_add_distrib]
    _ = ∑ i, 2 * c i * (u i * u i + a * (v i * v i)) := by
      apply Finset.sum_congr rfl
      intro i _
      let r := u i
      let s := v i * b
      calc
        c i * ((r + s) * (r + s)) + c i * ((r - s) * (r - s)) =
            c i * (((r + s) * (r + s)) + ((r - s) * (r - s))) := by ring
        _ = c i * (((r*r + 2*r*s + s*s) + (r*r - 2*r*s + s*s))) := by ring
        _ = c i * (2*(r*r) + 2*(s*s)) := by ring
        _ = 2*c i * (r*r + s*s) := by ring
        _ = 2*c i * (u i*u i + (v i*v i)*(b*b)) := by dsimp [r, s]; ring
        _ = 2*c i * (u i*u i + a*(v i*v i)) := by rw [hb]; ring
    _ = 2 * ∑ i, c i * (u i * u i + a * (v i * v i)) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _
      ring

end Ising2DLambda.NecSuf.FisherZero
