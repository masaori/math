/-
# 行列の共役は符号反転と差を保つ（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `matrix_conjugation_preserves_negation`, `matrix_conjugation_preserves_difference`
（`structured-latex/content/000_calculation_formulae_00_09.ts`）の、`n → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。
`Mat(n, ℂ)`（添字 `Fin n`）の場合の具体版は `ClaimMatrixConjugationPreservesDifference.lean` の `conj_neg_matrix`・`conj_sub_matrix`。

**必要十分版**: `Ising2D/NecSuf/MatrixConjugationNegSub.lean` の `NecSuf.conj_neg_matrix'`・`NecSuf.conj_sub_matrix'`。
この具体版をその特殊化として得るのは `ClaimMatrixConjugationPreservesDifferenceFromNecSuf.lean` の
`conj_neg_tensorPow_of_necSuf`・`conj_sub_tensorPow_of_necSuf`。

## 人手証明との対応

* 人手の正則な `B` とその逆行列 `B^{-1}` は、行列 `B`・`Binv : TensorPow M` で受ける。どちらの鎖も `B^{-1}` と `B` の積を使わないので、
  逆行列の等式の仮定は置かない（本文の主張はこの主張に `Binv → B^{-1}` を入れたものである）。
  単元 `(TensorPow M)ˣ` と `Conjugation.T` で書かない理由は `ClaimTensorPowConjugationPreservesSum.lean` と同じである。
* 人手の `T_B(A) := (BA)B^{-1}` は Lean の `B * A * Binv` で、主張の両辺は `T_B` を定義どおりに開いた形で書く。
* `matrix_conjugation_preserves_negation` の 4 行のうち、1・4 行目（`T_B` の定義）は主張の式に入っており、
  2・3 行目 ↔ `conj_neg_tensorPow` の `calc` の 2 段（`negation_factors_out_of_right_factor`・`..._left_factor` の
  `Mat(2^M, ℂ)` の具体版 `mul_neg_matrix_tensorPow`・`neg_mul_matrix_tensorPow`（`ClaimNegationFactorsOutOfTensorPowProduct.lean`））。
* `matrix_conjugation_preserves_difference` の 4 行 ↔ `conj_sub_tensorPow` の `calc` の 4 段
  （`matrix_difference_is_sum_with_negation` の `Mat(2^M, ℂ)` の具体版 `sub_eq_add_neg_tensorPow`
  （`ClaimTensorPowDifferenceIsSumWithNegation.lean`）→ `mat_conj` の和を保つことの具体版 `conj_add_tensorPow`
  （`ClaimTensorPowConjugationPreservesSum.lean`）→ `conj_neg_tensorPow` → `sub_eq_add_neg_tensorPow` を右辺から左辺へ）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfTensorPowProduct
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowDifferenceIsSumWithNegation
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowConjugationPreservesSum

namespace Ising2D

/-- **`matrix_conjugation_preserves_negation`**（`Mat(2^M, ℂ)`）: `T_B(-W) = -T_B(W)`
（`T_B(X) = (BX)B^{-1}` を開いた形。`Binv` は `B^{-1}`）。人手の 4 行。 -/
theorem conj_neg_tensorPow {M : ℕ} (B Binv : TensorPow M) (W : TensorPow M) :
    B * (-W) * Binv = -(B * W * Binv) :=
  calc B * (-W) * Binv
      = (-(B * W)) * Binv := by rw [mul_neg_matrix_tensorPow]                -- `negation_factors_out_of_right_factor`
    _ = -(B * W * Binv) := neg_mul_matrix_tensorPow _ _                      -- `negation_factors_out_of_left_factor`

/-- **`matrix_conjugation_preserves_difference`**（`Mat(2^M, ℂ)`）: `T_B(X - W) = T_B(X) - T_B(W)`
（`T_B(X) = (BX)B^{-1}` を開いた形。`Binv` は `B^{-1}`）。人手の 4 行。 -/
theorem conj_sub_tensorPow {M : ℕ} (B Binv : TensorPow M) (X W : TensorPow M) :
    B * (X - W) * Binv = B * X * Binv - B * W * Binv :=
  calc B * (X - W) * Binv
      = B * (X + (-W)) * Binv := by rw [sub_eq_add_neg_tensorPow]            -- `matrix_difference_is_sum_with_negation`
    _ = B * X * Binv + B * (-W) * Binv := conj_add_tensorPow _ _ _ _          -- `mat_conj` の和を保つこと
    _ = B * X * Binv + (-(B * W * Binv)) := by rw [conj_neg_tensorPow]       -- `matrix_conjugation_preserves_negation`
    _ = B * X * Binv - B * W * Binv := (sub_eq_add_neg_tensorPow _ _).symm   -- `matrix_difference_is_sum_with_negation`

end Ising2D
