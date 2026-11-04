/-
# 正の実数の二乗の一意性（具体版を必要十分版から導く）

具体版 `ClaimPositiveRealSquareInjective.lean` の `positive_real_square_injective` の主張を、必要十分版
`Ising2D/NecSuf/PositiveSquareInjective.lean` の `NecSuf.positive_square_injective'` の `R := ℝ` の特殊化として得る。
人手のラベルは `positive_real_square_injective`。
-/
import Ising2D.NecSuf.PositiveSquareInjective
import Mathlib.Data.Real.Basic

namespace Ising2D

/-- `positive_real_square_injective` を `NecSuf.positive_square_injective'`（`R := ℝ`）の特殊化として得る。 -/
theorem positive_real_square_injective_of_necSuf {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    a ^ 2 = b ^ 2 ↔ a = b :=
  NecSuf.positive_square_injective' ha hb

end Ising2D
