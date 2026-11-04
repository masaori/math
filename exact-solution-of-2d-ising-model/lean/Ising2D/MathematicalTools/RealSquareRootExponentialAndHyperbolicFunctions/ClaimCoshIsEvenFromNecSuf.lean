/-
# `cosh` は偶関数を、必要十分版の特殊化として得る

具体版 `ClaimCoshIsEven.lean` の主張 `cosh_is_even` を、必要十分版 `Ising2D/NecSuf/SymmetrizedSumIsEven.lean` の
`NecSuf.symmetrized_sum_is_even'` を `G, R := ℝ`、`f := exp`、`d := (· / 2)`、`h := cosh` に特殊化して得る。
人手のラベルは `cosh_is_even`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshIsEven
import Ising2D.NecSuf.SymmetrizedSumIsEven

namespace Ising2D

/-- `cosh_is_even` を `NecSuf.symmetrized_sum_is_even'` の特殊化として得る。仮定 `hh` は `Real.cosh_eq`（`def_cosh_sinh`）で与える。 -/
theorem cosh_is_even_of_necSuf (x : ℝ) : Real.cosh (-x) = Real.cosh x :=
  NecSuf.symmetrized_sum_is_even' Real.exp (fun s => s / 2) Real.cosh Real.cosh_eq x

end Ising2D
