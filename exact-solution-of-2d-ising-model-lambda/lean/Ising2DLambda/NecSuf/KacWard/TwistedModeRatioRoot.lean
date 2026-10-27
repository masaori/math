import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.NecSuf.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem equalPower_ratio_root_necSuf {F : Type*} [Field F] {L : ℕ}
    {z z' σ : F} (hz : z ^ L = σ) (hz' : z' ^ L = σ) (hσ : σ ≠ 0) :
    (z' / z) ^ L = 1 := by
  calc
    (z' / z) ^ L = z' ^ L / z ^ L := div_pow z' z L
    _ = σ / σ := by rw [hz', hz]
    _ = 1 := div_self hσ

end Ising2DLambda.NecSuf.KacWard
