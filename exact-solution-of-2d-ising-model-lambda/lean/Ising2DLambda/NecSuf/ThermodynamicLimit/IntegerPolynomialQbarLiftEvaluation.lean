/-
「持ち上げの値は整係数多項式の代数的数における値に一致する」
（`claim_integer_polynomial_qbar_lift_evaluation`）の必要十分版。

具体版と同じ三段で進む:
  第 1 段: 左の値を係数の有限和で書く（仮定 `hL`。具体版では `claim_qbar_evaluation_coefficient_sum`）
  第 2 段: 係数が項ごとに一致する（仮定 `hcoeff`。具体版では `integerPolynomialQbarLift_coeff`）
  第 3 段: 右の値を係数の有限和で書く（仮定 `hR`。具体版では `def_qbar_polynomial_evaluation` の定義式）

必要な構造は「有限和が取れること」（`AddCommMonoid`）と「冪が取れること」（`Monoid`）だけである。
分配律・可換性・体の構造は使わない（項ごとの一致を有限和へ移すだけなので）。
実数体・複素数体は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

/-- 必要十分版: 二つの値がそれぞれ係数の有限和 `∑ c k * x^k` で書け、係数が項ごとに一致するなら、二つの値は等しい。 -/
theorem lift_eval_eq_of_coeff_eq_necSuf {S : Type*} [AddCommMonoid S] [Monoid S]
    (x : S) (n : ℕ) (cL cR : ℕ → S) (vL vR : S)
    (hL : vL = ∑ k ∈ Finset.range (n + 1), cL k * x ^ k)
    (hcoeff : ∀ k, cL k = cR k)
    (hR : vR = ∑ k ∈ Finset.range (n + 1), cR k * x ^ k) :
    vL = vR := by
  calc vL
      -- 第 1 段（左の値を係数の有限和で書く）。
      = ∑ k ∈ Finset.range (n + 1), cL k * x ^ k := hL
    -- 第 2 段（係数の一致を各項へ同時に当てる）。
    _ = ∑ k ∈ Finset.range (n + 1), cR k * x ^ k :=
        Finset.sum_congr rfl (fun k _ => by rw [hcoeff k])
    -- 第 3 段（右の値の定義式）。
    _ = vR := hR.symm

end Ising2DLambda.NecSuf.ThermodynamicLimit
