/-
# 実数の 1 の冪は 1（具体版を必要十分版から導く）

具体版 `ClaimPowerOfRealOneIsOne.lean` の主張を、必要十分版
`Ising2D/NecSuf/PowerOfOneIsOne.lean` の `R := ℝ` の特殊化として得る。
人手のラベルは `power_of_real_one_is_one`。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimPowerOfRealOneIsOne
import Ising2D.NecSuf.PowerOfOneIsOne

namespace Ising2D

/-- `power_of_real_one_is_one` を `NecSuf.one_pow'`（`R := ℝ`）の特殊化として得る。 -/
theorem power_of_real_one_is_one_of_necSuf (m : ℕ) : (1 : ℝ) ^ m = 1 :=
  NecSuf.one_pow' m

end Ising2D
