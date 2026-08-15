/-
人手証明「正の有理数の対数は単射である」（`claim_rational_log_injective`）の具体版。

人手証明と同じ順で辿る。
  (i)   任意の素数 p について、log q = log q' を p で読んで w_p の移項と指数の加法性で
        v_p(a b') = v_p(a' b) を得る（`primeExponent_cross_eq`）。
  (ii)  すべての素数で指数が一致するので、有限積表示（算術の基本定理）から a b' = a' b
        （`Nat.eq_of_factorization_eq`。人手証明が明示的に引いている一意性そのもの）。
  (iii) ℚ の約分で q = q'（`Rat.eq_iff_mul_eq_mul`）。

表示 q = a/b には Lean の既約表示 `q.num.natAbs / q.den` を使う（`logRat` の定義と同じ）。
住処: ℕ・ℤ・ℚ・Λ のみ。ℝ / ℂ は現れない。
-/
import Ising2DLambda.FreeEntropy.Basic
import Mathlib

namespace Ising2DLambda.FreeEntropy

/-- (i)。人手証明の一続きの計算: `v_p(a b') = v_p(a' b)`。 -/
theorem primeExponent_cross_eq (p : Nat.Primes) {a b a' b' : ℕ}
    (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : rationalExponent p a b = rationalExponent p a' b') :
    primeExponent p (a * b') = primeExponent p (a' * b) := by
  have hcast : ((primeExponent p (a * b') : ℕ) : ℤ) = ((primeExponent p (a' * b) : ℕ) : ℤ) := by
    calc
      ((primeExponent p (a * b') : ℕ) : ℤ)
          -- 指数の加法性
          = (primeExponent p a : ℤ) + (primeExponent p b' : ℤ) := by
            rw [primeExponent_mul ha hb' p]; push_cast; ring
      -- w_p(q) = v_p(a) - v_p(b) を移項
      _ = ((rationalExponent p a b + primeExponent p b) + primeExponent p b' : ℤ) := by
            unfold rationalExponent; ring
      -- log q = log q' を p で読む
      _ = ((rationalExponent p a' b' + primeExponent p b) + primeExponent p b' : ℤ) := by rw [h]
      -- w_p(q') = v_p(a') - v_p(b')
      _ = (((primeExponent p a' : ℤ) - primeExponent p b' + primeExponent p b) + primeExponent p b' : ℤ) := by
            unfold rationalExponent; ring
      -- 結合則・可換則と -v_p(b') + v_p(b') = 0
      _ = (primeExponent p a' : ℤ) + (primeExponent p b : ℤ) := by ring
      -- 指数の加法性
      _ = ((primeExponent p (a' * b) : ℕ) : ℤ) := by
            rw [primeExponent_mul ha' hb p]; push_cast; ring
  exact_mod_cast hcast

/-- (ii)。すべての素数で指数が一致する 1 以上の整数は等しい（有限積表示）。 -/
theorem nat_eq_of_primeExponent_eq {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0)
    (h : ∀ p : Nat.Primes, primeExponent p m = primeExponent p n) : m = n := by
  apply Nat.eq_of_factorization_eq hm hn
  intro p
  by_cases hp : p.Prime
  · exact h ⟨p, hp⟩
  · rw [Nat.factorization_eq_zero_of_not_prime m hp, Nat.factorization_eq_zero_of_not_prime n hp]

/-- `claim_rational_log_injective`。正の有理数の対数は単射である。 -/
theorem logRat_injective_of_pos {q q' : ℚ} (hq : 0 < q) (hq' : 0 < q')
    (h : logRat q = logRat q') : q = q' := by
  -- 表示 q = a/b, q' = a'/b'（既約表示）
  have ha : q.num.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq.ne')
  have ha' : q'.num.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq'.ne')
  have hb : q.den ≠ 0 := q.den_nz
  have hb' : q'.den ≠ 0 := q'.den_nz
  -- (i) 各素数で v_p(a b') = v_p(a' b)
  have hcross : ∀ p : Nat.Primes,
      primeExponent p (q.num.natAbs * q'.den) = primeExponent p (q'.num.natAbs * q.den) := by
    intro p
    apply primeExponent_cross_eq p ha hb ha' hb'
    -- log q = log q' を素数 p で読む
    have := congrArg (fun l : LogOrderGroup => l p) h
    simpa [logRat_apply] using this
  -- (ii) 有限積表示から a b' = a' b
  have hnat : q.num.natAbs * q'.den = q'.num.natAbs * q.den :=
    nat_eq_of_primeExponent_eq (mul_ne_zero ha hb') (mul_ne_zero ha' hb) hcross
  -- (iii) ℚ の約分。q > 0 なので a = |num| = num
  rw [Rat.eq_iff_mul_eq_mul]
  have hz : ((q.num.natAbs * q'.den : ℕ) : ℤ) = ((q'.num.natAbs * q.den : ℕ) : ℤ) := by
    exact_mod_cast hnat
  push_cast at hz
  rw [abs_of_pos (Rat.num_pos.mpr hq), abs_of_pos (Rat.num_pos.mpr hq')] at hz
  exact hz

end Ising2DLambda.FreeEntropy
