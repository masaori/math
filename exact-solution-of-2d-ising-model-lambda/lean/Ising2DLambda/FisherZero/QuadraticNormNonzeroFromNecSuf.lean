import Ising2DLambda.FisherZero.QuadraticNormNonzero
import Ising2DLambda.NecSuf.FisherZero.QuadraticNormNonzero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体に適用する。 -/
theorem quadraticNorm_ne_zero_from_necSuf (F : Subfield Qbar) (a b c₀ c₁ : Qbar)
    (_ha : a ∈ F) (hc₀ : c₀ ∈ F) (hc₁ : c₁ ∈ F)
    (hbF : b ∉ F) (hb : b * b = a) (hz : c₀ + c₁ * b ≠ 0) :
    c₀ * c₀ - a * (c₁ * c₁) ≠ 0 :=
  Ising2DLambda.NecSuf.FisherZero.quadraticNorm_ne_zero_necSuf
    (F : Set Qbar) (fun _ _ hx hy => F.div_mem hx hy) a b c₀ c₁ hc₀ hc₁ hbF hb hz

end Ising2DLambda.FisherZero
