/-
# 行列の共役はスカラー倍を保つ（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `mat_conj`（`structured-latex/content/000_calculation_formulae_00_09.ts`）のスカラー倍を保つことの、
`n → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。
`Mat(n, ℂ)`（添字 `Fin n`）の場合の具体版は `ClaimMatrixConjugationPreservesSums.lean` の `conj_smul_matrix`。

**必要十分版**: `Ising2D/NecSuf/MatrixConjugationSum.lean` の `NecSuf.conj_smul_matrix'`。
この具体版をその特殊化として得るのは `ClaimMatrixConjugationPreservesSumsFromNecSuf.lean` の `conj_smul_tensorPow_of_necSuf`。

## 人手証明との対応

* 人手の正則な `B` とその逆行列 `B^{-1}` は、行列 `B`・`Binv : TensorPow M` で受ける。スカラー倍の鎖は `B^{-1}` と `B` の積を使わないので、
  逆行列の等式の仮定は置かない（本文の主張はこの主張に `Binv → B^{-1}` を入れたものである）。
  Lean の単元 `(TensorPow M)ˣ` と `Conjugation.T` で主張を書かないのは、単元の記号が本文の定義の一覧
  （`lean/mathlib-symbols-defined-or-declared-in-text.txt`）に無いためである。
* 人手の `T_B(A) := (BA)B^{-1}` は Lean の `B * A * Binv`（Lean の `x * y * z` は `(x * y) * z`）で、
  主張の両辺は `T_B` を定義どおりに開いた形で書く。スカラー倍の鎖の 1・4 行目（「`T_B` の定義」の行）はこの書き方で主張の式に入っている。
* スカラー倍の鎖の 2・3 行目 ↔ `conj_smul_tensorPow` の `calc` の 2 段。`scalar_multiple_factors_out_of_right_factor`・`..._left_factor` は
  `Mat(2^M, ℂ)` の具体版 `mul_smul_matrix_tensorPow`・`smul_mul_matrix_tensorPow`（`ClaimIdentityAndScalarMultipleInTensorPowProduct.lean`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct

namespace Ising2D

/-- **`mat_conj`**（スカラー倍を保つ、`Mat(2^M, ℂ)`）: `T_B(αA) = α T_B(A)`
（`T_B(X) = (BX)B^{-1}` を開いた形。`Binv` は `B^{-1}`）。人手のスカラー倍の鎖の 4 行。 -/
theorem conj_smul_tensorPow {M : ℕ} (B Binv : TensorPow M) (α : ℂ) (A : TensorPow M) :
    B * (α • A) * Binv = α • (B * A * Binv) :=
  calc B * (α • A) * Binv
      = (α • (B * A)) * Binv := by rw [mul_smul_matrix_tensorPow]       -- `scalar_multiple_factors_out_of_right_factor`
    _ = α • (B * A * Binv) := smul_mul_matrix_tensorPow _ _ _           -- `scalar_multiple_factors_out_of_left_factor`

end Ising2D
