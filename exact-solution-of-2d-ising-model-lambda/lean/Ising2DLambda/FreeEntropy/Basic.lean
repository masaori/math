/-
章「有限系の自由エントロピー」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。
このファイルは人手証明の定義 4 件をそのまま Lean の定義へ写したものである。

  人手証明のラベル              このファイル
  def_prime_exponent            primeExponent
  def_log_order_group           LogOrderGroup / generator
  def_rational_log              rationalExponent / logNat / logRat
  def_finite_free_entropy       freeEntropy

住処: 人手証明のこれらのブロックは可算側（ℕ / ℤ / Λ）を宣言している。
したがってここに ℝ / ℂ は現れない。Λ は素数から ℤ への有限台の写像として書く
（`Nat.Primes →₀ ℤ`。有限台であることが `Finsupp` そのものである）。
`log` は級数でも実対数でもなく素因数分解であり、`Nat.factorization` がその指数ベクトルである。
-/
import Mathlib.NumberTheory.Padics.PadicVal.Basic
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Data.Rat.Defs
import Mathlib.Algebra.Polynomial.AlgebraMap
import Ising2DLambda.PartitionPolynomial.Basic

namespace Ising2DLambda.FreeEntropy

/-- `def_prime_exponent`。1 以上の整数 `n` における素数 `p` の指数 `v_p(n) ∈ ℕ`。
算術の基本定理による素因数分解の指数そのもの（mathlib の `Nat.factorization`）。 -/
def primeExponent (p : Nat.Primes) (n : ℕ) : ℕ := n.factorization p

/-- `def_prime_exponent`。`v_p(1) = 0`。 -/
lemma primeExponent_one (p : Nat.Primes) : primeExponent p 1 = 0 := by
  simp [primeExponent]

/-- `def_prime_exponent` の指数の加法性 `v_p(mn) = v_p(m) + v_p(n)`。
人手証明は算術の基本定理の一意性からこれを出しており、ここでもその内容そのものである
mathlib の `Nat.factorization_mul` を引く（人手証明が明示的に適用している定理）。 -/
lemma primeExponent_mul {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) (p : Nat.Primes) :
    primeExponent p (m * n) = primeExponent p m + primeExponent p n := by
  simp [primeExponent, Nat.factorization_mul hm hn]

/-- `def_log_order_group`。対数順序群 `Λ`。
素数から `ℤ` への写像のうち、値が `0` でない素数が有限個であるもの全体。
加法は素数ごと（`Finsupp` の加法がそれである）。 -/
abbrev LogOrderGroup : Type := Nat.Primes →₀ ℤ

/-- `def_log_order_group` の生成元 `ℓ_p`。`p` で `1`、他の素数で `0` をとる写像。 -/
noncomputable def generator (p : Nat.Primes) : LogOrderGroup := Finsupp.single p 1

/-- `def_rational_log` の `w_p(q) = v_p(a) - v_p(b)`（表示 `q = a/b` から作った整数）。 -/
def rationalExponent (p : Nat.Primes) (a b : ℕ) : ℤ :=
  (primeExponent p a : ℤ) - (primeExponent p b : ℤ)

/-- 1 以上の整数の対数 `log n = Σ_p v_p(n) ℓ_p ∈ Λ`。
`Nat.factorization` は台が有限なので、そのまま `Λ` の元になる
（添字を素数へ、値を `ℤ` へ移すだけで、指数そのものは変えていない）。 -/
noncomputable def logNat (n : ℕ) : LogOrderGroup :=
  Finsupp.comapDomain (fun p : Nat.Primes => (p : ℕ))
    (n.factorization.mapRange (fun k : ℕ => (k : ℤ)) (by simp))
    (Nat.Primes.coe_nat_injective.injOn)

/-- `logNat` の各素数での値は指数そのものである。 -/
lemma logNat_apply (n : ℕ) (p : Nat.Primes) : logNat n p = (primeExponent p n : ℤ) := rfl

/-- `def_rational_log`。正の有理数 `q` の対数 `log q = Σ_p w_p(q) ℓ_p ∈ Λ`。
表示には `q` の既約表示（`q.num` と `q.den`）を使う。
表示の取り方によらないことは主張「有理数の指数は表示の取り方によらない」で示す。 -/
noncomputable def logRat (q : ℚ) : LogOrderGroup :=
  logNat q.num.natAbs - logNat q.den

/-- `def_rational_log`。`log q` の各素数での値は `w_p(q)` である。 -/
lemma logRat_apply (q : ℚ) (p : Nat.Primes) :
    logRat q p = rationalExponent p q.num.natAbs q.den := rfl

/-- `def_finite_free_entropy`。`Φ_L(q) = log Z_L(q) ∈ Λ`。
`Z_L(q)` は分配多項式 `Z_L ∈ ℤ[x]` の有理点 `q` での値（係数環 ℤ から ℚ への準同型による評価）。 -/
noncomputable def freeEntropy (L : ℕ) [NeZero L] (q : ℚ) : LogOrderGroup :=
  logRat (Polynomial.aeval q (PartitionPolynomial.partitionPolynomial L))

end Ising2DLambda.FreeEntropy
