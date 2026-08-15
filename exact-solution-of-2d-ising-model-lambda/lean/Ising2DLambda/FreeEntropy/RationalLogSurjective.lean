/-
人手証明「正の有理数の対数は全射である」（`claim_rational_log_surjective`）の具体版。

有限台の指数ベクトル λ に対し、各素数 p を有理数 p の整数冪へ送り、その有限積
`rationalOfLog λ` を作る。人手証明の分子・分母の有限積を、Lean では同じ有理数を表す整数冪の
有限積として書いている。素数一個、整数冪、有限積の順に `logRat (rationalOfLog λ) = λ` を示す。

住処: ℕ・ℤ・ℚ・Λ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.Additivity
import Mathlib

namespace Ising2DLambda.FreeEntropy

/-- `λ ∈ Λ` の有限台に沿って作る正の有理数。 -/
noncomputable def rationalOfLog (eta : LogOrderGroup) : ℚ :=
  eta.prod fun p z => (p.1 : ℚ) ^ z

/-- 構成した有理数は正である。 -/
lemma rationalOfLog_pos (eta : LogOrderGroup) : 0 < rationalOfLog eta := by
  classical
  unfold rationalOfLog
  exact Finset.prod_pos fun p hp => zpow_pos (by exact_mod_cast p.property.pos) _

/-- 素数 `p` 自身の対数は生成元 `ℓ_p` である。 -/
lemma logRat_prime (p : Nat.Primes) : logRat (p.1 : ℚ) = generator p := by
  refine Finsupp.ext fun r => ?_
  rw [logRat_apply, rationalExponent]
  have hnum : ((p.1 : ℚ).num.natAbs : ℕ) = p.1 := by simp
  have hden : (p.1 : ℚ).den = 1 := by simp
  rw [hnum, hden, primeExponent_one]
  simp only [Nat.cast_zero, sub_zero]
  change ((p.1.factorization r : ℕ) : ℤ) = generator p r
  rw [p.property.factorization]
  by_cases h : r = p
  · subst h; simp [generator]
  · have hcoe : (p : ℕ) ≠ (r : ℕ) := fun he => h (Subtype.ext he.symm)
    simp [generator, h, hcoe]

/-- 正の有理数の逆数では対数の符号が反転する。 -/
lemma logRat_inv {q : ℚ} (hq : 0 < q) : logRat q⁻¹ = -logRat q := by
  have hi : 0 < q⁻¹ := inv_pos.mpr hq
  have hmul := logRat_mul hq hi
  rw [mul_inv_cancel₀ hq.ne', logRat_one] at hmul
  rw [add_comm] at hmul
  exact eq_neg_of_add_eq_zero_left hmul.symm

/-- 素数の整数冪の対数は、その整数を係数とする生成元である。 -/
lemma logRat_prime_zpow (p : Nat.Primes) (z : ℤ) :
    logRat ((p.1 : ℚ) ^ z) = z • generator p := by
  have hpow : ∀ n : ℕ, logRat ((p.1 : ℚ) ^ n) = n • generator p := by
    intro n
    rw [logRat_pow (by exact_mod_cast p.property.pos), logRat_prime]
  cases z with
  | ofNat n =>
      simpa using hpow n
  | negSucc n =>
      rw [zpow_negSucc, logRat_inv (pow_pos (by exact_mod_cast p.property.pos) (n + 1)),
        hpow]
      ext r
      simp [Int.negSucc_eq]
      ring

/-- `claim_rational_log_surjective`。構成した正の有理数の対数は元の指数ベクトルに戻る。 -/
theorem logRat_rationalOfLog (eta : LogOrderGroup) : logRat (rationalOfLog eta) = eta := by
  classical
  induction eta using Finsupp.induction with
  | zero => simp [rationalOfLog, logRat_one]
  | single_add p z f hp hz ih =>
      rw [rationalOfLog, Finsupp.prod_add_index' (fun _ => zpow_zero _)
          (fun j m n => zpow_add₀ (by exact_mod_cast j.property.ne_zero) m n),
        Finsupp.prod_single_index (zpow_zero _)]
      change logRat ((p.1 : ℚ) ^ z * rationalOfLog f) = Finsupp.single p z + f
      rw [logRat_mul (zpow_pos (by exact_mod_cast p.property.pos) z) (rationalOfLog_pos f),
        logRat_prime_zpow, ih]
      ext r
      by_cases h : r = p
      · subst h; simp [generator]
      · simp [generator, h]

/-- 正の有理数の対数写像は全射である。 -/
theorem logRat_surjective : Function.Surjective (fun q : {q : ℚ // 0 < q} => logRat q.1) := by
  intro eta
  exact ⟨⟨rationalOfLog eta, rationalOfLog_pos eta⟩, logRat_rationalOfLog eta⟩

end Ising2DLambda.FreeEntropy
