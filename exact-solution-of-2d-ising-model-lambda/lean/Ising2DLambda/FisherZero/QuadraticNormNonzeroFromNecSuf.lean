import Ising2DLambda.NecSuf.FisherZero.QuadraticNormNonzero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体に適用する。 -/
theorem quadraticNorm_ne_zero_from_necSuf (F : Subfield Qbar) (a b u v : Qbar)
    (_ha : a ∈ F) (hu : u ∈ F) (hv : v ∈ F)
    (hbF : b ∉ F) (hb : b * b = a) (hz : u + v * b ≠ 0) :
    u * u - a * (v * v) ≠ 0 :=
  Ising2DLambda.NecSuf.FisherZero.quadraticNorm_ne_zero_necSuf
    (F : Set Qbar) (fun _ _ hx hy => F.div_mem hx hy) a b u v hu hv hbF hb hz

end Ising2DLambda.FisherZero
