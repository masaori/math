/-
# `log(a^n) = ι(n) log a`（具体版）

対応する人手証明（正本は `structured-latex/content/020_critical_point.ts`）:

* `critical_claim_real_log_of_power`（ラベル **`real_log_of_power`**）

原文の主張: `a ∈ ℝ_{>0}`、`n ∈ ℤ_{≥1}` なら `a^n ∈ ℝ_{>0}` であり `log(a^n) = ι_{ℤ→ℝ}(n) log a`（`ι_{ℤ→ℝ}` は `inclusion_zz_to_rr`）。

| 人手の段 | Lean |
| --- | --- |
| `n` の帰納法で `a^n > 0` と `log(a^n) = ι(n) log a` を同時に示す | `Nat.le_induction`（`n ≥ 1`）、結論は 2 つの連言 |
| `n = 1`: `a^1 = a^0a = 1·a = a`、よって `a^1 > 0` | `h1` の 3 段の `calc` |
| `n = 1`: `log(a^1) = log a = 1·log a = ι(1) log a` | 3 段の `calc`（最後は `inclusion_zz_to_rr_of_one`） |
| `n → n+1`: `a^{n+1} = a^na` は正の数の積なので正 | `pow_succ` と `(real_log_of_product …).1` |
| `n → n+1`: `log(a^{n+1}) = log(a^na) = log(a^n) + log a = ι(n) log a + log a = ι(n) log a + 1·log a = (ι(n)+1) log a = ι(n+1) log a` | 6 段の `calc`（最後は `inclusion_zz_to_rr_succ`） |

人手の `log` は `def_real_logarithm_positive` で、Lean は mathlib の `Real.log` で表す（具体版は無い）。
人手の実数の冪の定義 `def_power_of_real_number` の `a^{m+1} := a^ma` は mathlib の `pow_succ`、`a^0 := 1` は `pow_zero` で書く。
人手の `ι_{ℤ→ℝ}(n)` は、`n ∈ ℤ_{≥1}` を Lean の `ℕ` で書くので自然数の実数への埋め込み `(n : ℝ)` で書く（`ClaimInclusionOfIntegersIntoRealNumbers.lean`）。

この人手の項目は、棚卸し `docs/organization/flat-inventory.json` にまだ無い（章が未割り当て）。Ising 模型を参照しない実数の主張なので、棚卸しの分類の規則に従って部「数学的道具立て」の
「実数の平方根・指数関数・双曲線関数」のフォルダに置いた（前の章の `ClaimLimitInNRow.lean` から使うため、部「臨界点」には置かない）。

必要十分版は `Ising2D/NecSuf/InverseOfAdditiveToMultiplicativeMap.lean` の `NecSuf.inv_map_pow`、
具体版をその系として導くのは `ClaimRealLogOfPowerFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers

namespace Ising2D

/-- **人手 `real_log_of_power`**: `a ∈ ℝ_{>0}`、`n ≥ 1` なら `a^n > 0` かつ `log(a^n) = ι(n) log a`。 -/
theorem real_log_of_power {a : ℝ} (ha : 0 < a) :
    ∀ n : ℕ, 1 ≤ n → 0 < a ^ n ∧ Real.log (a ^ n) = (n : ℝ) * Real.log a := by
  intro n hn
  induction n, hn using Nat.le_induction with
  | base =>
    have h1 : a ^ 1 = a :=
      calc a ^ 1 = a ^ 0 * a := pow_succ a 0
                                        -- `def_power_of_real_number` の `a^{m+1} := a^ma` を `m = 0` で
        _ = 1 * a := by rw [pow_zero]
                                        -- `def_power_of_real_number` の `a^0 := 1`
        _ = a := one_mul a
                                        -- ℝ の乗法の単位元
    refine ⟨by rw [h1]; exact ha, ?_⟩
    calc Real.log (a ^ 1) = Real.log a := by rw [h1]
                                        -- 上の `a^1 = a`
      _ = 1 * Real.log a := (one_mul _).symm
                                        -- ℝ の乗法の単位元
      _ = ((1 : ℕ) : ℝ) * Real.log a := by rw [inclusion_zz_to_rr_of_one]
                                        -- `inclusion_zz_to_rr_of_one` を右辺から左辺へ
  | succ n hn ih =>
    have hprod := real_log_of_product ih.1 ha
                                        -- `real_log_of_product` を `a^n, a ∈ ℝ_{>0}` に
    refine ⟨?_, ?_⟩
    · rw [pow_succ]                     -- `def_power_of_real_number` の `a^{n+1} := a^na`
      exact hprod.1                     -- 正の数 `a^n` と `a` の積なので正
    · calc Real.log (a ^ (n + 1)) = Real.log (a ^ n * a) := by rw [pow_succ]
                                        -- `def_power_of_real_number` の `a^{n+1} := a^na`
        _ = Real.log (a ^ n) + Real.log a := hprod.2
                                        -- `real_log_of_product` を `a^n, a ∈ ℝ_{>0}` に
        _ = (n : ℝ) * Real.log a + Real.log a := by rw [ih.2]
                                        -- 帰納法の仮定
        _ = (n : ℝ) * Real.log a + 1 * Real.log a := by rw [one_mul]
                                        -- ℝ の乗法の単位元
        _ = ((n : ℝ) + 1) * Real.log a := (add_mul _ _ _).symm
                                        -- ℝ の分配法則
        _ = ((n + 1 : ℕ) : ℝ) * Real.log a := by rw [inclusion_zz_to_rr_succ n]
                                        -- `inclusion_zz_to_rr` の `ι(n + 1) := ι(n) + 1` を右辺から左辺へ

end Ising2D
