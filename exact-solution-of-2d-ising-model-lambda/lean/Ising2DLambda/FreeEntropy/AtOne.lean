/-
人手証明の主張「すべての配位を等しく数える点での自由エントロピー」（ラベル
`claim_free_entropy_at_one`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（代入を係数表示で書く）    partitionPolynomial_eval_one の前半
                                    （`partitionPolynomial_eq_sum_multiplicity` の適用）
  Step 2（多重度の総和）            同後半（`multiplicity_sum_eq_two_pow` の適用）
  Step 3（自由エントロピーの定義）  freeEntropy_at_one の `rw [freeEntropy]`
  Step 4（冪の法則）                logRat_pow
  Step 5（log 2 = ℓ₂）              logRat_two
  Step 6（結論）                    freeEntropy_at_one

Step 1・Step 2 で引く 2 つの定理は、人手証明が明示的にラベル参照している主張
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

/-- Step 5。`log 2 = ℓ₂`。`2` の素因数分解が `2 = 2¹` であることそのもの。 -/
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

/-- Step 1–2。`Z_L(1) = Σ_m Ω_L(m) = 2^{L²}`。 -/
theorem partitionPolynomial_eval_one :
    Polynomial.aeval (1 : ℚ) (partitionPolynomial L) = ((2 ^ L ^ 2 : ℕ) : ℚ) := by
  -- Step 1。係数表示へ書き直し、代入が和と積を保つことを使う。
  rw [partitionPolynomial_eq_sum_multiplicity L, map_sum]
  have : ∀ m ∈ range (2 * L ^ 2 + 1),
      Polynomial.aeval (1 : ℚ)
          (Polynomial.C (PartitionPolynomial.multiplicity L m : ℤ) * Polynomial.X ^ m)
        = ((PartitionPolynomial.multiplicity L m : ℕ) : ℚ) := by
    intro m _
    simp
  rw [sum_congr rfl this]
  -- Step 2。多重度の総和は配位の総数である。
  rw [← Nat.cast_sum, multiplicity_sum_eq_two_pow L]

/-- Step 3–6。`Φ_L(1) = L² ℓ₂`。 -/
theorem freeEntropy_at_one :
    freeEntropy L 1 = (L ^ 2) • generator ⟨2, Nat.prime_two⟩ := by
  -- Step 3。定義を開き、Step 1–2 の値を入れる。
  rw [freeEntropy, partitionPolynomial_eval_one L]
  -- Step 4。冪の法則（2 は正の有理数、L² は自然数）。
  rw [show ((2 ^ L ^ 2 : ℕ) : ℚ) = (2 : ℚ) ^ L ^ 2 by push_cast; ring]
  rw [logRat_pow (by norm_num) (L ^ 2)]
  -- Step 5–6。log 2 = ℓ₂ を代入する。
  rw [logRat_two]

end Ising2DLambda.FreeEntropy
