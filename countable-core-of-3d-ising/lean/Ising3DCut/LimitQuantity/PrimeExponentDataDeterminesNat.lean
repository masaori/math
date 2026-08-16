/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・第一歩（可算側の段）。

列 $S_q$ の一致から $Z_L(q)=Z_L(q')$ を取り出す段は、素指数データ $\lambda$ が正の数を決めることに
帰着する。ここではその最初の一歩として、**正の自然数はその素因数分解の指数データで決まる**ことを
mathlib の `Nat.eq_of_factorization_eq` で示す。次の一歩で正の有理数（分子・分母）へ広げる。
-/
import Mathlib.Data.Nat.Factorization.Basic

namespace Ising3DCut.LimitQuantity

/-- 正の自然数 `a b` について、すべての素数 `p` での指数が一致すれば `a = b`。 -/
theorem nat_eq_of_prime_exponents_eq {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : ∀ p : ℕ, a.factorization p = b.factorization p) : a = b :=
  Nat.eq_of_factorization_eq ha hb h

end Ising3DCut.LimitQuantity
