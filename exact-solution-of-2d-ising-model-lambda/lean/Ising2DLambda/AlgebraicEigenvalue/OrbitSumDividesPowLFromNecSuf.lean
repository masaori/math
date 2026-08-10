/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.pow_add_dvd_pow_add_of_dvd`）は、半環 `R` の元 `a` と
`1 + u = 0` を満たす `u`、および `d ∣ n` について、`n = d * k` を満たす `k` が取れて
`a ^ n + u = (a ^ d + u) * Σ_{j<k} a ^ (d * j)` が成り立つことを言う。
具体版は `R := ℤ[x][t]`、`a := t`、`u := ι(-κ(1))`、`d := |O|`、`n := L` と取り、
最後に軌道ごとの和の値（`orbitSum_shiftMatrix`）で第 1 因子を書き換えたものである。
整除 `|O| ∣ L` は `orbitCard_dvd_L` が与える（必要十分版はそれを仮定として受け取るだけで、
軌道であることを一切使わない）。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitSumDividesPowL
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.OrbitSumDividesPowL

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {L : ℕ} [NeZero L]

/-- 具体版は必要十分版の特殊化である（`a := t`、`u := ι(-κ(1))`、`d := |O|`、`n := L`）。 -/
theorem orbitSum_mul_geom_eq_pow_L_from_necSuf (O : OrbitIndex L) :
    ∃ k : ℕ, L = O.1.card * k ∧
      (Polynomial.X : SecondPoly) ^ L + negUnitSecond
        = (∑ ψ : OrbitBij O.1,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
          * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (O.1.card * j) := by
  obtain ⟨k, hk, hchain⟩ :=
    NecSuf.AlgebraicEigenvalue.pow_add_dvd_pow_add_of_dvd
      (Polynomial.X : SecondPoly) negUnitSecond one_add_negUnitSecond (orbitCard_dvd_L O)
  refine ⟨k, hk, ?_⟩
  rw [hchain, orbitSum_shiftMatrix O]
  rfl

end Ising2DLambda.AlgebraicEigenvalue
