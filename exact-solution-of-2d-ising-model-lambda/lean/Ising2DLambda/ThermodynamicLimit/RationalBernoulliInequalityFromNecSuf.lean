/-
「有理数の Bernoulli 不等式」の具体版が、必要十分版 `one_add_nsmul_le_one_add_pow_necSuf`
（順序可換半環）の `K := ℚ` への特殊化として得られることを明示する。
-/
import Ising2DLambda.ThermodynamicLimit.RationalBernoulliInequality
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalBernoulliInequality

namespace Ising2DLambda.ThermodynamicLimit

/-- 具体版を必要十分版から導く（`K := ℚ`）。 -/
theorem one_add_nsmul_le_one_add_pow_rat_from_necSuf (h : ℚ) (hh : 0 ≤ h) (n : ℕ) :
    1 + (n : ℚ) * h ≤ (1 + h) ^ n :=
  NecSuf.ThermodynamicLimit.one_add_nsmul_le_one_add_pow_necSuf h hh n

end Ising2DLambda.ThermodynamicLimit
