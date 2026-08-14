/-
人手証明「実対数と有限系の実自由エントロピー」の具体版。

実対数を使うため ℝ へ脱出する。使う性質は、正の実数上で乗法を加法へ移すことと
狭義単調性だけである。有限系の定義には完備性・極限を使わない。
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Ising2DLambda.ThermodynamicLimit.PartitionValuePositive

namespace Ising2DLambda.ThermodynamicLimit

open PartitionPolynomial

/-- 人手証明の `ℝ_{>0}`。値と正値性を分離せず一つの型で保持する。 -/
def StrictlyPositiveReal := {t : ℝ // 0 < t}

/-- 人手証明の `log_ℝ : ℝ_{>0} → ℝ`。 -/
noncomputable def realLogarithm (t : StrictlyPositiveReal) : ℝ := Real.log t.1

/-- 実対数は正の実数の乗法を加法へ移す。 -/
theorem realLogarithm_mul (u v : StrictlyPositiveReal) :
    realLogarithm ⟨u.1 * v.1, mul_pos u.2 v.2⟩ = realLogarithm u + realLogarithm v := by
  exact Real.log_mul (ne_of_gt u.2) (ne_of_gt v.2)

/-- 実対数は正の実数上で狭義単調である。 -/
theorem realLogarithm_strictMono (u v : StrictlyPositiveReal) (huv : u.1 < v.1) :
    realLogarithm u < realLogarithm v := by
  exact Real.strictMonoOn_log u.2 v.2 huv

/-- `claim_real_log_one`。人手証明の六段の鎖と一対一に対応する。 -/
theorem realLogarithm_one :
    realLogarithm ⟨1, zero_lt_one⟩ = 0 := by
  let onePos : StrictlyPositiveReal := ⟨1, zero_lt_one⟩
  calc
    realLogarithm onePos = realLogarithm onePos + 0 := (add_zero _).symm
    _ = realLogarithm onePos + (realLogarithm onePos + (-realLogarithm onePos)) := by
      rw [add_neg_cancel]
    _ = (realLogarithm onePos + realLogarithm onePos) + (-realLogarithm onePos) := by
      rw [add_assoc]
    _ = realLogarithm ⟨onePos.1 * onePos.1, mul_pos onePos.2 onePos.2⟩ +
        (-realLogarithm onePos) := by
      rw [realLogarithm_mul]
    _ = realLogarithm onePos + (-realLogarithm onePos) := by
      simp [onePos]
    _ = 0 := add_neg_cancel _

/-- `def_finite_real_free_entropy`。正値性の証明を使って実対数の定義域へ入れる。 -/
noncomputable def finiteRealFreeEntropy (L : ℕ) [NeZero L]
    (t : StrictlyPositiveReal) : ℝ :=
  realLogarithm ⟨Polynomial.aeval t.1 (partitionPolynomial L),
    partitionPolynomial_eval_real_pos L t.2⟩

end Ising2DLambda.ThermodynamicLimit
