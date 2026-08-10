/-
具体版が必要十分版の特殊化として得られることの導出。

必要十分版（`NecSuf.AlgebraicEigenvalue.prod_dvd_pow_card_necSuf`）は、
相等の決定できる有限な添字の型 `ι` と可換モノイド `M` について、すべての添字で
`a i * g = c` を満たす `g` が存在するならば `∏ a` が `c ^ (添字の個数)` を割ることを言う。
具体版は `ι := OrbitIndex L`（軌道の全体）、`M := ℤ[x][t]`、
`a O := Σ_{ψ ∈ 𝔅_O} W_O(ch(U), ψ)`、`c := t ^ L + u` と取り、
`∏ a = χ_U`（`charPoly_shiftMatrix_eq_prod_orbit_sum`）で左辺を書き換えたものである。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharDvdPowL
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharDvdPowL

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 具体版は必要十分版の特殊化である（`ι := OrbitIndex L`、`M := ℤ[x][t]`）。 -/
theorem charPoly_shiftMatrix_dvd_pow_L_from_necSuf (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L) ∣
      ((Polynomial.X : SecondPoly) ^ L + negUnitSecond) ^ Fintype.card (OrbitIndex L) := by
  classical
  have hpair : ∀ O : OrbitIndex L, ∃ g : SecondPoly,
      (∑ ψ : OrbitBij O.1,
          orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ)) * g
        = (Polynomial.X : SecondPoly) ^ L + negUnitSecond := by
    intro O
    obtain ⟨k, _, hk⟩ := orbitSum_mul_geom_eq_pow_L O
    exact ⟨_, hk.symm⟩
  have h := NecSuf.AlgebraicEigenvalue.prod_dvd_pow_card_necSuf
    (fun O : OrbitIndex L => ∑ ψ : OrbitBij O.1,
      orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 ψ))
    ((Polynomial.X : SecondPoly) ^ L + negUnitSecond) hpair
  rwa [← charPoly_shiftMatrix_eq_prod_orbit_sum L] at h

end Ising2DLambda.AlgebraicEigenvalue
