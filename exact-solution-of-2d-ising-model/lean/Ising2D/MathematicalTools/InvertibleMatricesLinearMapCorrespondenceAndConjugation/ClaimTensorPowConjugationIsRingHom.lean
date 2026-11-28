/-
# 共役写像の乗法性と単位性（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `conjugation_is_ring_homomorphism`
（`structured-latex/content/000_calculation_formulae_45_46.ts`）の乗法性と単位性の、`n → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。
`Mat(n, ℂ)`（添字 `Fin n`）の場合の具体版は `ClaimConjugationIsRingHom.lean` の `conj_mul_matrix`・`conj_one_matrix`。

**必要十分版**: `Ising2D/NecSuf/Conjugation.lean` の `Conj.sandwich_mul`・`Conj.sandwich_one`。
この具体版をその特殊化として得るのは `ClaimConjugationIsRingHomFromNecSuf.lean` の `conj_mul_tensorPow_of_necSuf`・`conj_one_tensorPow_of_necSuf`。

## 人手証明との対応

* 人手の正則な `B` とその逆行列 `B^{-1}` は、行列 `B`・`Binv : TensorPow M` と、鎖が使う逆行列の等式の仮定で受ける。
  乗法性の鎖が使うのは `B^{-1}B = I`（仮定 `hinv`）だけで、単位性の鎖が使うのは `BB^{-1} = I`（仮定 `hinv`）だけである。
  正則な `B` とその `B^{-1}` は両側の等式を持つのでどちらの仮定も満たし、本文の主張はこの二つの主張に `Binv → B^{-1}` を入れたものである。
  Lean の単元 `(TensorPow M)ˣ` と `Conjugation.T` で主張を書かないのは、単元の記号が本文の定義の一覧
  （`lean/mathlib-symbols-defined-or-declared-in-text.txt`）に無いためである。
* 人手の `T_B(A) := (BA)B^{-1}`（`mat_conj`）は Lean の `B * A * Binv`（Lean の `x * y * z` は `(x * y) * z`）で、
  主張の両辺は `T_B` を定義どおりに開いた形で書く。乗法性の鎖の 1・8・9 行目と単位性の鎖の 1 行目（どれも「`T_B` の定義」の行）は、
  この書き方で主張の式に入っている。
* 乗法性の鎖の 2〜7 行目 ↔ `conj_mul_tensorPow` の `calc` の 6 段。単位性の鎖の 2・3 行目 ↔ `conj_one_tensorPow` の 2 段。
* `mat_mult_associative` は Lean の具体版が無く、mathlib の `Matrix.mul_assoc` を 1 段に 1 回使う（`ClaimConjugationIsRingHom.lean` と同じ）。
  `identity_matrix_is_left_unit_of_mat_mult`・`..._right_unit_...` は `Mat(2^M, ℂ)` の具体版
  `identity_matrix_mul_tensorPow`・`mul_identity_matrix_tensorPow`（`ClaimIdentityAndScalarMultipleInTensorPowProduct.lean`）。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInTensorPowProduct

namespace Ising2D.Conjugation

/-- **`conjugation_is_ring_homomorphism` の乗法性**（`Mat(2^M, ℂ)`）: `T_B(AC) = T_B(A)T_B(C)`
（`T_B(X) = (BX)B^{-1}` を開いた形。`Binv` は `B^{-1}` で、鎖が使う `B^{-1}B = I` を仮定 `hinv` で受ける）。 -/
theorem conj_mul_tensorPow {M : ℕ} (B Binv : TensorPow M) (hinv : Binv * B = 1) (A C : TensorPow M) :
    B * (A * C) * Binv = (B * A * Binv) * (B * C * Binv) :=
  calc B * (A * C) * Binv
      = ((B * A) * C) * Binv := by rw [Matrix.mul_assoc B A C]                -- `mat_mult_associative`
    _ = ((B * A) * ((1 : TensorPow M) * C)) * Binv := by
        rw [identity_matrix_mul_tensorPow C]                                  -- `identity_matrix_is_left_unit_of_mat_mult`
    _ = ((B * A) * ((Binv * B) * C)) * Binv := by rw [hinv]                   -- `B^{-1}B = I`
    _ = ((B * A) * (Binv * (B * C))) * Binv := by rw [Matrix.mul_assoc Binv B C]  -- `mat_mult_associative`
    _ = (((B * A) * Binv) * (B * C)) * Binv := by
        rw [← Matrix.mul_assoc (B * A) Binv (B * C)]                          -- `mat_mult_associative`
    _ = ((B * A) * Binv) * ((B * C) * Binv) := Matrix.mul_assoc _ _ _         -- `mat_mult_associative`

/-- **`conjugation_is_ring_homomorphism` の単位性**（`Mat(2^M, ℂ)`）: `T_B(I) = I`
（`T_B(I) = (BI)B^{-1}` を開いた形。`Binv` は `B^{-1}` で、鎖が使う `BB^{-1} = I` を仮定 `hinv` で受ける）。 -/
theorem conj_one_tensorPow {M : ℕ} (B Binv : TensorPow M) (hinv : B * Binv = 1) :
    B * (1 : TensorPow M) * Binv = 1 :=
  calc B * (1 : TensorPow M) * Binv
      = B * Binv := by rw [mul_identity_matrix_tensorPow B]                   -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 := hinv                                                             -- `BB^{-1} = I`

end Ising2D.Conjugation
