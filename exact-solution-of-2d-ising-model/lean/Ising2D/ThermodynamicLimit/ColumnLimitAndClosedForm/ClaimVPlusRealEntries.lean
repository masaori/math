/-
# `V^{(+)}` の成分は実である（具体版）

`Ising2D.EvenSectorBridge`（`TheoremCPlusEqualsLambda.lean`）の欄 `Vr`・`hVr`
（`V^{(+)}` の実行列としての表示）を、`Ising2D.vPlusDataOf` の `V^{(+)}` について与える。

## 人手証明との関係

人手 `c_plus_equals_Lambda_half_integer`（`structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`、
`closing_009_theorem_c_plus_equals_Lambda_half`）は、2026-11-05 の書き直しで「`V^{(+)}` の成分は実である」を使わなくなった
（Step 2 は `W` と `ε` の成分の実性から `\overline{q}` が同じ固有空間に入ることを示す）。Lean の `TheoremCPlusEqualsLambda.lean` は
まだ書き直し前の経路（`V^{(+)}` の実行列表示 `Vr` の実部を取る）で組んであるので、その入力としてこのファイルを置く。
主張そのものに人手の対応ブロックは無いが、各段は次の人手の定義・主張の具体版を引く。

| 段 | Lean |
| --- | --- |
| 成分がすべて実数（`def_matrix_with_real_entries`）、実対称（`def_real_symmetric_complex_matrix`） | `MatrixHasRealEntries`、`MatrixIsRealSymmetric` |
| `½S_1^{(+)} = i(K_1/2)_ℂH_1^{(+)}` は実対称（`iH_is_real_symmetric`、`K_1 → K_1/2`） | `halfS1plus_isRealSymmetric`（`S1plus_isRealSymmetric`） |
| `S_2 = i(K_2^*)_ℂH_2` は実対称（`iH_is_real_symmetric`） | `S2_isRealSymmetric` |
| `exp(½S_1^{(+)}) = (V_1^{(+)})^{1/2}`・`exp(S_2)` は実対称（`exp_of_real_symmetric_is_real_symmetric`、`A → ½S_1^{(+)}`・`A → S_2`） | `V1plusHalf_isRealSymmetric`、`V2H2Form_hasRealEntries` の中 |
| `(2s_2)^{M_col/2}exp(S_2)` の成分は実（`real_scalar_multiple_of_real_entry_matrix_has_real_entries`、`c → (2s_2)^{M_col/2}`） | `V2H2Form_hasRealEntries`（`real_smul_hasRealEntries`） |
| 積の成分は実（`product_of_real_entry_matrices_has_real_entries` を 2 回） | `VPlus_hasRealEntries`（`matrix_mul_hasRealEntries`） |
| 実行列としての表示 | `reMat`、`eq_map_reMat`、`VPlusR`、`vPlusDataOf_V_eq_map` |

Lean の `VPlus` は `(V_1^{(+)})^{1/2} · (2s_2)^{M_col/2}exp(S_2) · (V_1^{(+)})^{1/2}` の積の形
（`V2H2Form` がスカラー倍を中に持つ）なので、スカラー倍を `V2H2Form` の中で扱う。

具体的な `V^{(+)}` の成分についての主張で、`EvenSectorBridge` の欄を埋めるためだけに立てるので、必要十分版は置かない。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusPositiveDefinite
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfRealSymmetricIsRealSymmetric
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## `V^{(+)}` の因子 -/

/-- `(i/2)K_1 = i(K_1/2)`（`V1plusHalf` の指数の係数を `iH_is_real_symmetric` の形へ）。 -/
theorem halfS1plus_coeff_eq (K1 : ℝ) :
    (1 / 2 : ℂ) * Complex.I * (K1 : ℂ) = Complex.I * ((K1 / 2 : ℝ) : ℂ) := by
  push_cast
  ring

/-- 人手 `iH_is_real_symmetric` を `K_1 → K_1/2` で: `½S_1^{(+)} = i(K_1/2)_ℂH_1^{(+)}` は実対称。 -/
theorem halfS1plus_isRealSymmetric (K1 : ℝ) :
    MatrixIsRealSymmetric (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) := by
  rw [halfS1plus_coeff_eq]
  exact S1plus_isRealSymmetric (K1 / 2)

/-- `(V_1^{(+)})^{1/2} = exp(½S_1^{(+)})` は実対称（`exp_of_real_symmetric_is_real_symmetric`、`A → ½S_1^{(+)}`）。 -/
theorem V1plusHalf_isRealSymmetric (K1 : ℝ) : MatrixIsRealSymmetric (V1plusHalf M (K1 : ℂ)) :=
  exp_of_real_symmetric_is_real_symmetric _ (halfS1plus_isRealSymmetric K1)

/-- `(2s_2)^{M_col/2}exp(S_2)`（`S_2 = iK_2^*H_2`）の成分は実: `exp(S_2)` は実対称
（`exp_of_real_symmetric_is_real_symmetric`、`A → S_2`）なので成分は実、
`real_scalar_multiple_of_real_entry_matrix_has_real_entries`（`c → (2s_2)^{M_col/2}`）。 -/
theorem V2H2Form_hasRealEntries (s2 K2star : ℝ) :
    MatrixHasRealEntries (V2H2Form M s2 (K2star : ℂ)) :=
  real_smul_hasRealEntries _ _
    (exp_of_real_symmetric_is_real_symmetric _ (S2_isRealSymmetric K2star)).1

/-- **`V^{(+)}` の成分は実である**（`K_1, K_2^*` 実）: 3 つの因子の成分が実なので、
`product_of_real_entry_matrices_has_real_entries` を 2 回。 -/
theorem VPlus_hasRealEntries (s2 K1 K2star : ℝ) :
    MatrixHasRealEntries (VPlus M s2 (K1 : ℂ) (K2star : ℂ)) :=
  matrix_mul_hasRealEntries _ _
    (matrix_mul_hasRealEntries _ _ (V1plusHalf_isRealSymmetric K1).1 (V2H2Form_hasRealEntries s2 K2star))
    (V1plusHalf_isRealSymmetric K1).1

/-! ## 実行列としての表示 -/

/-- 成分の実部を取った実行列。 -/
noncomputable def reMat (A : TensorPow M) : Matrix (Conf M) (Conf M) ℝ :=
  A.map Complex.re

/-- 成分が実なら、`A` は実部の実行列を成分ごとに `ℂ` へ埋め込んだもの。 -/
theorem eq_map_reMat {A : TensorPow M} (h : MatrixHasRealEntries A) :
    A = (reMat A).map (fun r : ℝ => (r : ℂ)) := by
  ext s t
  obtain ⟨r, hr⟩ := h s t
  rw [Matrix.map_apply, reMat, Matrix.map_apply, hr, Complex.ofReal_re]

/-- `vPlusDataOf` の `V^{(+)}` の実行列表示。 -/
noncomputable def VPlusR (P : IsingParam) (M : ℕ) : Matrix (Conf M) (Conf M) ℝ :=
  reMat (VPlus M (Real.sinh (2 * P.K2)) (P.K1 : ℂ) (P.K2star : ℂ))

/-- **`Ising2D.EvenSectorBridge.hVr`**: `vPlusDataOf` の `V^{(+)}` は実行列 `VPlusR` を成分ごとに `ℂ` へ埋め込んだもの。 -/
theorem vPlusDataOf_V_eq_map (P : IsingParam) (hM : M ≠ 0)
    (hdual : P.const.c2 * P.const.s2star = P.const.c2star) :
    (vPlusDataOf P hM hdual).V = (VPlusR P M).map (fun r : ℝ => (r : ℂ)) := by
  rw [vPlusDataOf_V, VPlusR]
  exact eq_map_reMat (VPlus_hasRealEntries _ _ _)

end Ising2D
