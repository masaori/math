/-
人手証明の主張「相異なる有理点の素指数データは分配多項式を一意に決める」
（ラベル `claim_rational_values_determine_partition_polynomial`）の具体版。

人手証明とこのファイルの対応:

  素指数データの単射性から各評価値が等しい
    `eval_eq_of_primeExponentData_eq`
  A-B は d+1 個の相異なる根を持つ
    `rationalPolynomial_eq_of_primeExponentData_eq` の評価値の等式と点の単射性
  次数 d 以下の非零多項式に d+1 個の根はない
    同じ定理の `Polynomial.eq_of_natDegree_lt_card_of_eval_eq`

ここで `primeExponentData` は正の有理数上で定義された本文の λ を表し、その単射性は
素因数分解の一意性に対応する。多項式と評価値を区別し、住処は `Nat`、`Rat`、
有理係数多項式、有限型のみである。ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.Polynomial.Roots

namespace Ising3DCut.NullModel

noncomputable section

/-- 素因数分解の一意性を一度だけ適用し、素指数データの等式を有理数の等式へ戻す。 -/
lemma eval_eq_of_primeExponentData_eq {D : Type*}
    (primeExponentData : ℚ → D) (hdata_injective : Function.Injective primeExponentData)
    {A B : Polynomial ℚ} {q : ℚ}
    (hdata : primeExponentData (A.eval q) = primeExponentData (B.eval q)) :
    A.eval q = B.eval q :=
  hdata_injective hdata

/-- `claim_rational_values_determine_partition_polynomial` の具体版。
次数 `d` 以下の二つの有理係数多項式が、相異なる `d+1` 個の正の有理点で
同じ素指数データを持つなら、その二つの多項式は等しい。 -/
theorem rationalPolynomial_eq_of_primeExponentData_eq {D : Type*}
    (primeExponentData : ℚ → D) (hdata_injective : Function.Injective primeExponentData)
    (d : ℕ) (q : Fin (d + 1) → ℚ) (hq_injective : Function.Injective q)
    (A B : Polynomial ℚ) (hA_degree : A.natDegree ≤ d) (hB_degree : B.natDegree ≤ d)
    (hdata : ∀ i, primeExponentData (A.eval (q i)) = primeExponentData (B.eval (q i))) :
    A = B := by
  apply Polynomial.eq_of_natDegree_lt_card_of_eval_eq A B hq_injective
  · intro i
    exact eval_eq_of_primeExponentData_eq primeExponentData hdata_injective (hdata i)
  · simp only [Fintype.card_fin]
    omega

end

end Ising3DCut.NullModel
