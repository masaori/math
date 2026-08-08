/-
人手証明の主張「すべての配位を等しく数える点での自由エントロピー」（ラベル
`claim_free_entropy_at_one`）の具体版。

人手証明はこの主張を 7 つの等号からなる一続きの式で示しており、Step という段を持たない。
そこで各等号とこのファイルの対応を書く。

  第 1 の等号（自由エントロピーの定義）      freeEntropy_at_one の `rw [freeEntropy]`
  第 2 の等号（係数表示、代入は環準同型）    partitionPolynomial_eval_one の前半
                                             （`partitionPolynomial_eq_sum_multiplicity` の適用）
  第 3 の等号（1^m = 1）                     同前半の `simp`
  第 4 の等号（多重度の総和）                同後半（`multiplicity_sum_eq_two_pow` の適用）
  第 5 の等号（冪の法則）                    logRat_pow
  第 6–第 8 の等号（有理数の対数の定義から
    素因数分解を経て ℓ₂ へ）                 logRat_two

第 2・第 4 の等号で引く 2 つの定理は、人手証明が明示的にラベル参照している主張
`claim_coefficient_representation` と `claim_coefficient_sum` そのものである。

必要十分版を別に置かないのは、この主張が既に形式化した 3 つの主張
（係数表示・多重度の総和・冪の法則）をつなぐだけで、新しい論法を持たないためである。
つないでいる各主張には必要十分版がある。

住処: 人手証明のこのブロックは `Λ` を宣言している。ここに ℝ / ℂ は現れない
（代入先は `ℚ`、値は `Nat.Primes →₀ ℤ`）。
-/
import Ising2DLambda.FreeEntropy.Additivity
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation

namespace Ising2DLambda.FreeEntropy

open Finset PartitionPolynomial

/-- 第 6–第 8 の等号。`log 2 = ℓ₂`。`2` の素因数分解が `2 = 2¹` であることそのもの。 -/
lemma logRat_two : logRat 2 = generator ⟨2, Nat.prime_two⟩ := by
  refine Finsupp.ext fun p => ?_
  have hnum : (2 : ℚ).num.natAbs = 2 := by norm_num
  have hden : (2 : ℚ).den = 1 := by norm_num
  rw [logRat_apply, rationalExponent, hnum, hden, primeExponent, primeExponent,
    Nat.Prime.factorization Nat.prime_two]
  -- p が 2 かどうかで分ける（2 の因子は 2 だけで、その指数は 1）。
  by_cases h : p = (⟨2, Nat.prime_two⟩ : Nat.Primes)
  · subst h; simp [generator]
  · have hp' : (2 : ℕ) ≠ (p : ℕ) := fun he => h (Subtype.ext he.symm)
    simp [generator, hp', h]

variable (L : ℕ) [NeZero L]

/-- 第 2–第 4 の等号。`Z_L(1) = Σ_m Ω_L(m) = 2^{L²}`。 -/
theorem partitionPolynomial_eval_one :
    Polynomial.aeval (1 : ℚ) (partitionPolynomial L) = ((2 ^ L ^ 2 : ℕ) : ℚ) := by
  -- 第 2・第 3 の等号。係数表示へ書き直し、代入が和と積を保つことと `1^m = 1` を使う。
  rw [partitionPolynomial_eq_sum_multiplicity L, map_sum]
  have : ∀ m ∈ range (2 * L ^ 2 + 1),
      Polynomial.aeval (1 : ℚ)
          (Polynomial.C (PartitionPolynomial.multiplicity L m : ℤ) * Polynomial.X ^ m)
        = ((PartitionPolynomial.multiplicity L m : ℕ) : ℚ) := by
    intro m _
    simp
  rw [sum_congr rfl this]
  -- 第 4 の等号。多重度の総和は配位の総数である。
  rw [← Nat.cast_sum, multiplicity_sum_eq_two_pow L]

/-- 第 1・第 5–第 8 の等号。`Φ_L(1) = L² ℓ₂`。 -/
theorem freeEntropy_at_one :
    freeEntropy L 1 = (L ^ 2) • generator ⟨2, Nat.prime_two⟩ := by
  -- 第 1 の等号。定義を開き、第 2–第 4 の等号で得た値を入れる。
  rw [freeEntropy, partitionPolynomial_eval_one L]
  -- 第 5 の等号。冪の法則（2 は正の有理数、L² は自然数）。
  rw [show ((2 ^ L ^ 2 : ℕ) : ℚ) = (2 : ℚ) ^ L ^ 2 by push_cast; ring]
  rw [logRat_pow (by norm_num) (L ^ 2)]
  -- 第 6–第 8 の等号。log 2 = ℓ₂ を代入する。
  rw [logRat_two]

end Ising2DLambda.FreeEntropy
