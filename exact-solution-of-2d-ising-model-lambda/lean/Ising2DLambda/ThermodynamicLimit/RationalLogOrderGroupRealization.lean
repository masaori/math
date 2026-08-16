/-
章「熱力学極限」の「実数体と実対数（実数体への脱出: 実対数）」（`def_real_logarithm`）と
「有理係数の対数順序群の実現写像（実数体への脱出: 実対数）」（`def_rational_log_order_group_realization`）の具体版。

  人手証明                                                    このファイル
  ℝ_{>0} := {t ∈ ℝ | 0 < t}                                     `PositiveReal`
  log_ℝ : ℝ_{>0} → ℝ（実対数）                                   `realLog`
  乗法を加法へ移す log_ℝ(uv) = log_ℝ(u) + log_ℝ(v)               `realLog_mul`
  狭義単調 u < v ⇒ log_ℝ(u) < log_ℝ(v)                          `realLog_lt_realLog`
  u ≤ v ⇒ log_ℝ(u) ≤ log_ℝ(v)                                   `realLog_le_realLog`
  ρ_ℝ(μ) := Σ_{p ∈ supp μ} ι_{ℚ→ℝ}(μ(p)) · log_ℝ(ι_{ℚ→ℝ}(p))     `realizeRational`（`Finsupp.sum` は台に渡る和）

ここが本文で初めて ℝ を呼び出す箇所である（脱出理由: 実対数）。`ι_{ℚ→ℝ}` は Lean の型強制 `(r : ℝ)`。
実対数について使うのは mathlib の `Real.log_mul`・`Real.log_lt_log` だけで、級数・微分・完備性は使わない。
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroup

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_real_logarithm` の `ℝ_{>0}`。値と正値性を一つの型で持つ。 -/
def PositiveReal := {t : ℝ // 0 < t}

/-- `def_real_logarithm` の `log_ℝ : ℝ_{>0} → ℝ`。 -/
noncomputable def realLog (t : PositiveReal) : ℝ := Real.log t.1

/-- 乗法を加法へ移す。 -/
theorem realLog_mul (u v : PositiveReal) :
    realLog ⟨u.1 * v.1, mul_pos u.2 v.2⟩ = realLog u + realLog v :=
  Real.log_mul (ne_of_gt u.2) (ne_of_gt v.2)

/-- 狭義単調。 -/
theorem realLog_lt_realLog (u v : PositiveReal) (huv : u.1 < v.1) :
    realLog u < realLog v :=
  Real.log_lt_log u.2 huv

/-- `u ≤ v ⇒ log_ℝ(u) ≤ log_ℝ(v)`（等しいなら両辺が等しく、小さいなら狭義単調）。 -/
theorem realLog_le_realLog (u v : PositiveReal) (huv : u.1 ≤ v.1) :
    realLog u ≤ realLog v := by
  rcases lt_or_eq_of_le huv with h | h
  · exact le_of_lt (realLog_lt_realLog u v h)
  · unfold realLog
    rw [h]

/-- 素数 `p` を `ι_{ℚ→ℝ}` で読んだ正の実数。 -/
def primePositiveReal (p : Nat.Primes) : PositiveReal :=
  ⟨((p.1 : ℚ) : ℝ), by exact_mod_cast p.property.pos⟩

/-- `def_rational_log_order_group_realization` の `ρ_ℝ : Λ_ℚ → ℝ`。
`Finsupp.sum` は台 `supp μ` に渡る有限和である。 -/
noncomputable def realizeRational (μ : RationalLogOrderGroup) : ℝ :=
  μ.sum fun p r => (r : ℝ) * realLog (primePositiveReal p)

/-- 定義の書き下し: 台に渡る和。 -/
theorem realizeRational_eq_sum_support (μ : RationalLogOrderGroup) :
    realizeRational μ = μ.support.sum fun p => ((μ p : ℚ) : ℝ) * realLog (primePositiveReal p) := rfl

end Ising2DLambda.ThermodynamicLimit
