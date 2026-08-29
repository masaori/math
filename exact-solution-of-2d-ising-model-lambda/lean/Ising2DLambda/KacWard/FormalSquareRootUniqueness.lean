/-
章「トーラス上の Kac--Ward 行列式」の「定数項一の形式的平方根は一意である」
（`claim_formal_square_root_unique`）の具体版。

人手証明と同じ因数分解と零積性を使う。住処は Qbar[[X]] であり、ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Ising2DLambda.NecSuf.KacWard.FormalSquareRootUniqueness
import Mathlib.RingTheory.PowerSeries.Basic

namespace Ising2DLambda.KacWard

open PowerSeries Ising2DLambda.AlgebraicEigenvalue

/-- Qbar[[X]] で定数項 1 の形式的平方根は一意である。 -/
theorem formalSquareRoot_unique (D S T : PowerSeries Qbar)
    (hS0 : constantCoeff S = 1) (hT0 : constantCoeff T = 1)
    (hSsq : S * S = D) (hTsq : T * T = D) : S = T := by
  exact Ising2DLambda.NecSuf.KacWard.formalSquareRoot_unique_necSuf
    (by norm_num : (2 : Qbar) ≠ 0) D S T hS0 hT0 hSsq hTsq

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem formalSquareRoot_unique_from_necSuf (D S T : PowerSeries Qbar)
    (hS0 : constantCoeff S = 1) (hT0 : constantCoeff T = 1)
    (hSsq : S * S = D) (hTsq : T * T = D) : S = T := by
  exact formalSquareRoot_unique D S T hS0 hT0 hSsq hTsq

end Ising2DLambda.KacWard
