/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.prod_congr_of_eq_necSuf`）は、相等の決定できる
添字の型 `ι` と可換モノイド `M` について、`s` のすべての元で因子が等しければ有限積が等しいことを言う。
具体版は `ι := OrbitIndex L`（軌道の全体）、`M := ℤ[x][t]`、`s := univ`、
`a O := Σ_{ψ ∈ 𝔅_O} W_O(ch(U), ψ)`、`b O := t ^ |O| + u` と取り、
第 1 段（`charPoly_shiftMatrix_eq_prod_orbit_sum`）で左辺を書き換えたものである。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharOrbitFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 具体版は必要十分版の特殊化である（`ι := OrbitIndex L`、`M := ℤ[x][t]`、`s := univ`）。 -/
theorem charPoly_shiftMatrix_eq_prod_orbit_factor_from_necSuf (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∏ O : OrbitIndex L,
          ((Polynomial.X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1))) := by
  classical
  have h := NecSuf.AlgebraicEigenvalue.prod_congr_of_eq_necSuf
    (fun O : OrbitIndex L => ∑ ψ : OrbitBij O.1,
      orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
    (fun O : OrbitIndex L =>
      (Polynomial.X : SecondPoly) ^ O.1.card + constSecond (-(constPoly 1)))
    Finset.univ (fun O _ => orbitSum_shiftMatrix O)
  rw [charPoly_shiftMatrix_eq_prod_orbit_sum L]
  exact h

end Ising2DLambda.AlgebraicEigenvalue
