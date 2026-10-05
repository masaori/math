import Ising2DLambda.KacWard.DiagonalGaugeInverse
import Ising2DLambda.NecSuf.KacWard.TwistSignParity

namespace Ising2DLambda.KacWard

/-- 実際の切断線の指数と整数の負の一を必要十分版へ供給する。 -/
theorem twistSign_eq_neg_one_pow_twistParity_from_necSuf {L : ℕ}
    (s : SpinStructure) (e : OrientedEdge L) :
    twistSign s e = (-1 : ℤ) ^ twistParity s e := by
  exact Ising2DLambda.NecSuf.KacWard.pow_eq_pow_mod_two_necSuf
    (-1 : ℤ) (by decide)
    (s.1.toNat * horizontalSeamParity e + s.2.toNat * verticalSeamParity e)

end Ising2DLambda.KacWard
