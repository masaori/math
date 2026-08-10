/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.pow_add_eq_mul_geom`）は、半環 `R` の元 `a` と
`1 + u = 0` を満たす `u` について `a ^ k + u = (a + u) * Σ_{j<k} a ^ j` を言う。
具体版は `R := ℤ[x][t]`、`a := t^d`、`u := ι(-κ(1))` と取ったものである。
`d` は必要十分版に現れない（消えた仮定ではなく、`a` の作り方に吸収されている）ので、
指数法則 `(t^d)^k = t^{dk}` で具体版の形へ戻す段がここに現れる。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.PowerSumTelescope
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PowerSumTelescope

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 具体版は必要十分版の特殊化である（`a := t^d`、`u := ι(-κ(1))`）。 -/
theorem powerSumTelescope_from_necSuf (d k : ℕ) :
    (Polynomial.X : SecondPoly) ^ (d * k) + negUnitSecond
      = ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
        * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (d * j) := by
  have h := NecSuf.AlgebraicEigenvalue.pow_add_eq_mul_geom
    ((Polynomial.X : SecondPoly) ^ d) negUnitSecond one_add_negUnitSecond k
  -- 必要十分版の `(t^d)^j` を、指数法則で具体版の `t^{dj}` へ書き換える。
  have hpow : ∀ j : ℕ, ((Polynomial.X : SecondPoly) ^ d) ^ j
      = (Polynomial.X : SecondPoly) ^ (d * j) := fun j => (pow_mul _ d j).symm
  rw [hpow k] at h
  rw [h]
  exact congrArg _ (Finset.sum_congr rfl (fun j _ => hpow j))

end Ising2DLambda.AlgebraicEigenvalue
