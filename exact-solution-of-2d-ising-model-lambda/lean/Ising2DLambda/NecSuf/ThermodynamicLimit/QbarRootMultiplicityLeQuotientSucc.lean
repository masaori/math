/-
「一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない」の必要十分版。

重複度（最大元）も代数的数も本質でない。効いているのは
「$(X-C\,w)^{M'+1}$ が $(X-C\,w)\cdot g$ を割るなら $(X-C\,w)^{M'}$ が $g$ を割る」
という一次因子の消去だけである（`poly_linear_factor_cancellation_necSuf`）。
係数の上界はどの多項式にも取れるので、必要なのは可換環だけである
（体・代数閉性・零因子の非存在は要らない）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Polynomial

theorem root_multiplicity_le_quotient_succ_necSuf {R : Type*} [CommRing R]
    (w : R) (g : R[X]) (M' : ℕ)
    (hdvd : (X - C w) ^ (M' + 1) ∣ (X - C w) * g) : (X - C w) ^ M' ∣ g := by
  obtain ⟨h, hh⟩ := hdvd
  refine ⟨h, ?_⟩
  -- 一次因子との積が一致することを示し、消去する。
  have hmul : (X - C w) * ((X - C w) ^ M' * h) = (X - C w) * g := by
    calc (X - C w) * ((X - C w) ^ M' * h)
        = (X - C w) ^ (M' + 1) * h := by ring
      _ = (X - C w) * g := hh.symm
  -- 係数の上界は、どの多項式にも取れる（次数より上の係数は零）。
  set n := max ((X - C w) ^ M' * h).natDegree g.natDegree with hn
  exact (Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_linear_factor_cancellation_necSuf
    w ((X - C w) ^ M' * h) g n
    (fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt
      (lt_of_le_of_lt (le_max_left _ _) hk))
    (fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt
      (lt_of_le_of_lt (le_max_right _ _) hk))
    hmul).symm

end Ising2DLambda.NecSuf.ThermodynamicLimit
