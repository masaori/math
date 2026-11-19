/-
# `sinh` は奇関数を、必要十分版の特殊化として得る

具体版 `ClaimSinhIsOdd.lean` の主張 `sinh_is_odd` を、必要十分版 `Ising2D/NecSuf/AntisymmetrizedDifferenceIsOdd.lean` の
`NecSuf.antisymmetrized_difference_is_odd'` を `G, R, S := ℝ`、`hns := fun a b => (neg_sub b a).symm`、`f := exp`、`d := (· / 2)`、
`hd := neg_div 2`、`h := sinh` に特殊化して得る。
人手のラベルは `sinh_is_odd`。人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimSinhIsOdd
import Ising2D.NecSuf.AntisymmetrizedDifferenceIsOdd

namespace Ising2D

/-- `sinh_is_odd` を `NecSuf.antisymmetrized_difference_is_odd'` の特殊化として得る。
仮定 `hns` は ℝ の `neg_sub`（`a − b = −(b − a)`）、`hd` は `neg_div 2`（分子の符号を分数の外へ出す）、
`hh` は `Real.sinh_eq`（`def_cosh_sinh`）で与える。 -/
theorem sinh_is_odd_of_necSuf (x : ℝ) : Real.sinh (-x) = -Real.sinh x :=
  NecSuf.antisymmetrized_difference_is_odd' (fun a b => (neg_sub b a).symm) Real.exp (fun s => s / 2)
    (neg_div 2) Real.sinh Real.sinh_eq x

end Ising2D
