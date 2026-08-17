/-
章「熱力学極限」の「代数的数係数多項式が一次因子の冪で割り切れること」
（`def_qbar_linear_factor_power_divides`）の具体版。定義ブロックなので必要十分版は置かない。

  人手証明                                                    このファイル
  (t - ŵ)^k ∣ f  :⇔  ∃ g, f = (t - ŵ)^k · g                    `qbarLinearFactorPowDivides`
  k = 0 なら常に割り切る（g := f）                            `qbarLinearFactorPowDivides_zero`
  係数の上界 n と aev_w(f) = 0 から (t - ŵ)^1 ∣ f              `qbarLinearFactorPowDivides_one_of_root`
  （橋渡し）mathlib の整除 `∣` との一致                        `qbarLinearFactorPowDivides_iff_dvd`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorTheorem

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `(t - ŵ)^k` が `f` を割り切る: ある `g` があって `f = (t - ŵ)^k · g`。 -/
def qbarLinearFactorPowDivides (w : Qbar) (k : ℕ) (f : QbarPoly) : Prop :=
  ∃ g : QbarPoly, f = (Polynomial.X - qbarConst w) ^ k * g

/-- `k = 0` では任意の `f` を割り切る（証人は `g := f`。`(t - ŵ)^0 = 1` と積の単位元）。 -/
theorem qbarLinearFactorPowDivides_zero (w : Qbar) (f : QbarPoly) :
    qbarLinearFactorPowDivides w 0 f :=
  ⟨f, by rw [pow_zero, one_mul]⟩

/-- 係数の上界 `n` のもとで `aev_w(f) = 0` なら `(t - ŵ)^1 ∣ f`
（`claim_qbar_factor_theorem` の商が証人。`(t - ŵ)^1 = t - ŵ`）。 -/
theorem qbarLinearFactorPowDivides_one_of_root (f : QbarPoly) (w : Qbar) (n : ℕ)
    (hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0)
    (hroot : qbarPolyEval w f = 0) :
    qbarLinearFactorPowDivides w 1 f :=
  ⟨∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k, by
    rw [pow_one]
    exact qbarFactorTheorem f w n hcoeff hroot⟩

/-- 橋渡し: この述語は mathlib の整除 `(X - C w)^k ∣ f` と一致する（定義の展開だけ）。 -/
theorem qbarLinearFactorPowDivides_iff_dvd (w : Qbar) (k : ℕ) (f : QbarPoly) :
    qbarLinearFactorPowDivides w k f ↔ (Polynomial.X - qbarConst w) ^ k ∣ f :=
  Iff.rfl

end Ising2DLambda.ThermodynamicLimit
