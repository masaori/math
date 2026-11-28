/-
# 行列の共役は和を保つ（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `mat_conj`（`structured-latex/content/000_calculation_formulae_00_09.ts`）の和を保つことの、
`n → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。
`Mat(n, ℂ)`（添字 `Fin n`）の場合の具体版は `ClaimMatrixConjugationPreservesSums.lean` の `conj_add_matrix`。

**必要十分版**: `Ising2D/NecSuf/MatrixConjugationSum.lean` の `NecSuf.conj_add_matrix'`。
この具体版をその特殊化として得るのは `ClaimMatrixConjugationPreservesSumsFromNecSuf.lean` の `conj_add_tensorPow_of_necSuf`。

## 人手証明との対応

* 人手の正則な `B` とその逆行列 `B^{-1}` は、行列 `B`・`Binv : TensorPow M` で受ける。和の鎖は `B^{-1}` と `B` の積を使わないので、
  逆行列の等式の仮定は置かない（本文の主張はこの主張に `Binv → B^{-1}` を入れたものである）。
  Lean の単元 `(TensorPow M)ˣ` と `Conjugation.T` で主張を書かないのは、単元の記号が本文の定義の一覧
  （`lean/mathlib-symbols-defined-or-declared-in-text.txt`）に無いためである（`ClaimTensorPowConjugationPreservesScalarMultiple.lean` と同じ）。
* 人手の `T_B(A) := (BA)B^{-1}` は Lean の `B * A * Binv`（Lean の `x * y * z` は `(x * y) * z`）で、
  主張の両辺は `T_B` を定義どおりに開いた形で書く。和の鎖の 1・4 行目（「`T_B` の定義」の行）はこの書き方で主張の式に入っている。
* 和の鎖の 2・3 行目 ↔ `conj_add_tensorPow` の `calc` の 2 段。`mat_mult_distributes_over_sum_in_right_factor`・`..._left_factor` は
  `Mat(2^M, ℂ)` の具体版 `mul_add_matrix_tensorPow`・`add_mul_matrix_tensorPow`（`ClaimTensorPowMatMultDistributesOverSum.lean`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTensorPowMatMultDistributesOverSum

namespace Ising2D

/-- **`mat_conj`**（和を保つ、`Mat(2^M, ℂ)`）: `T_B(A + C) = T_B(A) + T_B(C)`
（`T_B(X) = (BX)B^{-1}` を開いた形。`Binv` は `B^{-1}`）。人手の和の鎖の 4 行。 -/
theorem conj_add_tensorPow {M : ℕ} (B Binv : TensorPow M) (A C : TensorPow M) :
    B * (A + C) * Binv = B * A * Binv + B * C * Binv :=
  calc B * (A + C) * Binv
      = (B * A + B * C) * Binv := by rw [mul_add_matrix_tensorPow]           -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = B * A * Binv + B * C * Binv := add_mul_matrix_tensorPow _ _ _       -- `mat_mult_distributes_over_sum_in_left_factor`

end Ising2D
