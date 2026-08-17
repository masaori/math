/-
章「熱力学極限」の「整係数多項式の代数的数係数多項式への持ち上げ」（`def_integer_polynomial_qbar_lift`）の具体版。
定義ブロックなので必要十分版は無い。

  人手証明                                                          このファイル
  f = Σ a_m x^m ∈ Z[x] に対し f̂^F ∈ Qbar[t] を                        `integerPolynomialQbarLift`
    ac_k(f̂^F) := a_k (k ≤ n) / 0 (n < k) で定める
  係数の読み: ac_k(f̂^F) = a_k（Z ⊂ Q ⊂ Qbar の鎖で送った元）           `integerPolynomialQbarLift_coeff`

Lean では `Polynomial ℤ` の係数関数が既に「n < k なら 0」を含むので、`Polynomial.map` 一発で
人手証明の場合分けと同じものになる。住処: Z と Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue

/-- `def_integer_polynomial_qbar_lift` の具体版: 整係数多項式 `f` の持ち上げ `f̂^F ∈ Qbar[t]`。 -/
noncomputable def integerPolynomialQbarLift (f : Polynomial ℤ) : QbarPoly :=
  f.map (Int.castRingHom Qbar)

/-- 持ち上げの `t^k` の係数は、もとの係数を `Z ⊂ Q ⊂ Qbar` の鎖で送ったものである
（人手証明の定義式 `ac_k(f̂^F) = a_k`。`n < k` の側は `Polynomial ℤ` の係数が既に `0`）。 -/
theorem integerPolynomialQbarLift_coeff (f : Polynomial ℤ) (k : ℕ) :
    (integerPolynomialQbarLift f).coeff k = ((f.coeff k : ℤ) : Qbar) := by
  unfold integerPolynomialQbarLift
  rw [Polynomial.coeff_map]
  rfl

end Ising2DLambda.ThermodynamicLimit
