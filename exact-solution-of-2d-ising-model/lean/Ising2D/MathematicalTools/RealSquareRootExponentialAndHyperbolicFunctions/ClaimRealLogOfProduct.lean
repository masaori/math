/-
# `log(ab) = log a + log b`（具体版）

対応する人手証明（正本は `structured-latex/content/020_critical_point.ts`）:

* `critical_claim_real_log_of_product`（ラベル **`real_log_of_product`**）

原文の主張: `a, b ∈ ℝ_{>0}` なら `ab ∈ ℝ_{>0}` であり `log(ab) = log a + log b`。

| 人手の段 | Lean |
| --- | --- |
| 準備: 正の数の積は正なので `ab > 0` | `mul_pos` |
| 準備の鎖 `exp(log a + log b) = exp(log a)exp(log b) = ab` | `hprep` の 2 段の `calc` |
| 本体の鎖 `log(ab) = log(exp(log a + log b)) = log a + log b` | 2 段の `calc` |

人手の `log` は `def_real_logarithm_positive` で、Lean は mathlib の `Real.log` で表す（具体版は無い）。その定義の
`exp(log y) = y`・`log(exp x) = x` は mathlib の `Real.exp_log`・`Real.log_exp`、人手が引く `scalar_exp_product` は
mathlib の `Real.exp_add`（`def_scalar_exp` の Lean の具体版は無い）で表す。

この人手の項目は、棚卸し `docs/organization/flat-inventory.json` にまだ無い（章が未割り当て）。Ising 模型を参照しない実数の主張なので、棚卸しの分類の規則に従って部「数学的道具立て」の
「実数の平方根・指数関数・双曲線関数」のフォルダに置いた（前の章の `ClaimLimitInNRow.lean` から使うため、部「臨界点」には置かない）。

必要十分版は `Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_map_mul`、
具体版をその系として導くのは `ClaimRealLogOfProductFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace Ising2D

/-- **人手 `real_log_of_product`**: `a, b ∈ ℝ_{>0}` なら `ab > 0` かつ `log(ab) = log a + log b`。 -/
theorem real_log_of_product {a b : ℝ} (ha : 0 < a) (hb : 0 < b) :
    0 < a * b ∧ Real.log (a * b) = Real.log a + Real.log b := by
  have hprep : Real.exp (Real.log a + Real.log b) = a * b :=
    calc Real.exp (Real.log a + Real.log b)
        = Real.exp (Real.log a) * Real.exp (Real.log b) := Real.exp_add _ _
                                        -- `scalar_exp_product` を右辺から左辺へ
      _ = a * b := by rw [Real.exp_log ha, Real.exp_log hb]
                                        -- `def_real_logarithm_positive` の `exp(log y) = y` を 2 箇所へ
  refine ⟨mul_pos ha hb, ?_⟩            -- 準備: 正の数の積は正
  calc Real.log (a * b)
      = Real.log (Real.exp (Real.log a + Real.log b)) := by rw [hprep]
                                        -- 準備の鎖
    _ = Real.log a + Real.log b := Real.log_exp _
                                        -- `def_real_logarithm_positive` の `log(exp x) = x`

end Ising2D
