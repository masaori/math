/-
# 実数の絶対値の主張を、必要十分版の特殊化として得る

具体版 `ClaimRealAbsoluteValueBoundsTriangleAndProduct.lean` の主張を、必要十分版
`Ising2D/NecSuf/AbsoluteValueBoundsTriangleAndProduct.lean` を `R := ℝ` に特殊化して得る。人手のラベルは
`real_number_is_at_most_its_absolute_value`, `negative_absolute_value_is_at_most_real_number`,
`real_absolute_value_of_nonpositive`, `real_abs_triangle_inequality`, `real_abs_of_product`。
人手証明と 1 対 1 に対応する形は具体版のほうである。
-/
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimRealAbsoluteValueBoundsTriangleAndProduct
import Ising2D.NecSuf.AbsoluteValueBoundsTriangleAndProduct

namespace Ising2D

/-- `real_number_is_at_most_its_absolute_value` を `NecSuf.le_abs'`（`R := ℝ`）の特殊化として得る。 -/
theorem real_number_is_at_most_its_absolute_value_of_necSuf (q : ℝ) : q ≤ |q| :=
  NecSuf.le_abs' q

/-- `negative_absolute_value_is_at_most_real_number` を `NecSuf.neg_abs_le'`（`R := ℝ`）の特殊化として得る。 -/
theorem negative_absolute_value_is_at_most_real_number_of_necSuf (q : ℝ) : -|q| ≤ q :=
  NecSuf.neg_abs_le' q

/-- `real_absolute_value_of_nonpositive` を `NecSuf.abs_of_nonpos'`（`R := ℝ`）の特殊化として得る。 -/
theorem real_absolute_value_of_nonpositive_of_necSuf {q : ℝ} (hq : q ≤ 0) : |q| = -q :=
  NecSuf.abs_of_nonpos' hq

/-- `real_abs_triangle_inequality` を `NecSuf.abs_add_le'`（`R := ℝ`）の特殊化として得る。 -/
theorem real_abs_triangle_inequality_of_necSuf (a b : ℝ) : |a + b| ≤ |a| + |b| :=
  NecSuf.abs_add_le' a b

/-- `real_abs_of_product` を `NecSuf.abs_mul'`（`R := ℝ`）の特殊化として得る。 -/
theorem real_abs_of_product_of_necSuf (a b : ℝ) : |a * b| = |a| * |b| :=
  NecSuf.abs_mul' a b

end Ising2D
