/-
人手証明の主張「有理数の指数は表示の取り方によらない」（ラベル
`claim_rational_exponent_well_defined`）の具体版。

人手証明の Step とこのファイルの対応:

  Step 1（分母を払う）              mul_eq_mul_of_div_eq_div
  Step 2（指数の加法性を適用）      Basic.primeExponent_mul
  Step 3（両辺の指数を比べる）      rationalExponent_well_defined の hval
  Step 4（移項）                    同上（`sub_eq_sub_iff_add_eq_add`）

Step 2 が使う指数の加法性は、人手証明が算術の基本定理の一意性から明示的に出している事柄で、
`Basic.primeExponent_mul` として分けてある（中身は mathlib の `Nat.factorization_mul`）。
それ以外の計算は一般論へ委ねていない。

住処: 人手証明のこのブロックは ℤ を宣言している。ここに ℝ / ℂ は現れない
（指数は `ℕ`、その差は `ℤ`）。
-/
import Ising2DLambda.FreeEntropy.Basic

namespace Ising2DLambda.FreeEntropy

/-- Step 1（分母を払う）。1 以上の整数 `a, b, a', b'` について、有理数として
`a / b = a' / b'` ならば `a * b' = a' * b` である。 -/
lemma mul_eq_mul_of_div_eq_div {a b a' b' : ℕ} (hb : b ≠ 0) (hb' : b' ≠ 0)
    (h : (a : ℚ) / b = (a' : ℚ) / b') : a * b' = a' * b := by
  have hbQ : (b : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hb
  have hb'Q : (b' : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hb'
  -- 両辺に b b' を掛ける（分母が 0 でないので割り算の等式と交差積の等式は同値）。
  have hcross : (a : ℚ) * b' = (a' : ℚ) * b := (div_eq_div_iff hbQ hb'Q).mp h
  exact_mod_cast hcross

/-- Step 2–4（結論）。`w_p(q) = v_p(a) - v_p(b)` は `q` の表示 `a/b` の取り方によらない。 -/
theorem rationalExponent_well_defined (p : Nat.Primes) {a b a' b' : ℕ}
    (ha : a ≠ 0) (hb : b ≠ 0) (ha' : a' ≠ 0) (hb' : b' ≠ 0)
    (h : (a : ℚ) / b = (a' : ℚ) / b') :
    rationalExponent p a b = rationalExponent p a' b' := by
  -- Step 1。
  have hmul : a * b' = a' * b := mul_eq_mul_of_div_eq_div hb hb' h
  -- Step 3。両辺は同じ 1 以上の整数なので、その指数も等しい。
  have hval : primeExponent p (a * b') = primeExponent p (a' * b) := by rw [hmul]
  -- Step 2。加法性を両辺へ適用する。
  rw [primeExponent_mul ha hb' p, primeExponent_mul ha' hb p] at hval
  -- Step 4。ℤ の中で移項する。
  have hvalZ : (primeExponent p a : ℤ) + (primeExponent p b' : ℤ)
      = (primeExponent p a' : ℤ) + (primeExponent p b : ℤ) := by exact_mod_cast hval
  exact sub_eq_sub_iff_add_eq_add.mpr hvalZ

end Ising2DLambda.FreeEntropy
