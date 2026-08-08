/-
人手証明の主張「対数の加法性」（ラベル `claim_log_additive`）と
「対数の冪の法則」（ラベル `claim_log_power`）の具体版。

加法性の人手証明は、素数 `p` を固定したうえでの 7 つの等号からなる一続きの式である
（Step という段を持たない）。等号の名前とこのファイルの対応:

  前置き（表示 q = a/b を取る）      repr_of_pos（既約表示を使う）
  第 2 の等号（有理数の積の定義）    logRat_mul の中の `hrepr`（積の表示は分子どうし・分母どうしの積）
  第 1・第 3・第 6 の等号
    （正の有理数の対数の定義と、
      指数が表示によらないこと）      logRat_eq_of_repr
  第 4 の等号（指数の加法性）        logNat_mul（中身は Basic.primeExponent_mul）
  第 5 の等号（ℤ の加法の
    可換性と結合性で並べ替える）      logRat_mul の最後の `abel`
  第 7 の等号と結び（素数ごとに
    値が等しいので Λ の元として等しい） Finsupp.ext

第 3 の等号が使う「w_p は表示によらない」は、人手証明が明示的にラベル参照している主張
`claim_rational_exponent_well_defined`（Lean では `rationalExponent_well_defined`）である。

冪の法則の人手証明も Step を持たず、`k` についての帰納法の 2 つの段がそれぞれ一続きの式である。
このファイルもその形に対応させる（`k = 0` の段が `logRat_one` と `zero_nsmul`、
帰納段の 4 つの等号が `pow_succ`・`logRat_mul`・帰納法の仮定・`succ_nsmul`）。
人手証明の整数倍 `k log q` は、`k : ℕ` に対する `k • ·`（k 個の和）にあたる。
`Λ` の整数倍の定義は素数ごとの積なので、両者は素数ごとに同じ値である。

住処: 人手証明のこれらのブロックは `Λ` を宣言している。ここに ℝ / ℂ は現れない
（指数は `ℕ`、その差は `ℤ`、値は `Nat.Primes →₀ ℤ`）。
-/
import Ising2DLambda.FreeEntropy.RationalExponent

namespace Ising2DLambda.FreeEntropy

/-- 第 4 の等号（指数の加法性）を Λ の等式として書いたもの。`log(mn) = log m + log n`。 -/
lemma logNat_mul {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) :
    logNat (m * n) = logNat m + logNat n := by
  -- 第 7 の等号と同じく、素数ごとに値を比べる。
  refine Finsupp.ext fun p => ?_
  rw [Finsupp.add_apply, logNat_apply, logNat_apply, logNat_apply, primeExponent_mul hm hn]
  push_cast
  ring

/-- 正の有理数の分子は `0` でない（既約表示を使うための下ごしらえ）。 -/
lemma num_natAbs_ne_zero {q : ℚ} (hq : 0 < q) : q.num.natAbs ≠ 0 :=
  Int.natAbs_ne_zero.mpr (Rat.num_ne_zero.mpr hq.ne')

/-- 正の有理数の既約表示は、人手証明の言う「1 以上の整数 `a, b` による表示 `q = a/b`」である。 -/
lemma repr_of_pos {q : ℚ} (hq : 0 < q) : ((q.num.natAbs : ℕ) : ℚ) / (q.den : ℚ) = q := by
  rw [← Int.cast_natCast, Int.natAbs_of_nonneg (Rat.num_nonneg.mpr hq.le)]
  exact Rat.num_div_den q

/-- 第 1・第 3・第 6 の等号（正の有理数の対数の定義と、指数が表示によらないこと）。
`q = a / b` であるどの表示からでも `log q` を計算してよい。
人手証明が `claim_rational_exponent_well_defined` を引いている箇所にあたる。 -/
lemma logRat_eq_of_repr {q : ℚ} (hq : 0 < q) {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (hrepr : (a : ℚ) / b = q) : logRat q = logNat a - logNat b := by
  refine Finsupp.ext fun p => ?_
  rw [logRat, Finsupp.sub_apply, Finsupp.sub_apply, logNat_apply, logNat_apply, logNat_apply,
    logNat_apply]
  -- 既約表示 q.num / q.den も q の表示なので、well-defined 性から指数の差は一致する。
  have := rationalExponent_well_defined p (num_natAbs_ne_zero hq) q.den_nz ha hb
    (by rw [repr_of_pos hq, hrepr])
  simpa [rationalExponent] using this

/-- 加法性の 7 つの等号。`log(q₁q₂) = log q₁ + log q₂`（`Λ` の中の等式）。 -/
theorem logRat_mul {q₁ q₂ : ℚ} (h₁ : 0 < q₁) (h₂ : 0 < q₂) :
    logRat (q₁ * q₂) = logRat q₁ + logRat q₂ := by
  -- 前置き。q₁, q₂ の表示を取る（既約表示を使う）。
  have hnum₁ : q₁.num.natAbs ≠ 0 := num_natAbs_ne_zero h₁
  have hnum₂ : q₂.num.natAbs ≠ 0 := num_natAbs_ne_zero h₂
  have hrepr₁ := repr_of_pos h₁
  have hrepr₂ := repr_of_pos h₂
  -- 第 2 の等号。積の表示は分子どうし・分母どうしの積である。
  have hrepr : ((q₁.num.natAbs * q₂.num.natAbs : ℕ) : ℚ) / ((q₁.den * q₂.den : ℕ) : ℚ)
      = q₁ * q₂ := by
    push_cast
    rw [← div_mul_div_comm, hrepr₁, hrepr₂]
  -- 第 1・第 3・第 6 の等号。積の側と各因子の側を、同じ形（分子の log − 分母の log）へ揃える。
  rw [logRat_eq_of_repr (mul_pos h₁ h₂) (Nat.mul_ne_zero hnum₁ hnum₂)
      (Nat.mul_ne_zero q₁.den_nz q₂.den_nz) hrepr,
    logRat_eq_of_repr h₁ hnum₁ q₁.den_nz hrepr₁, logRat_eq_of_repr h₂ hnum₂ q₂.den_nz hrepr₂]
  -- 第 4 の等号。指数の加法性を分子側と分母側へ適用する。
  rw [logNat_mul hnum₁ hnum₂, logNat_mul q₁.den_nz q₂.den_nz]
  -- 第 5 の等号。ℤ の加法の可換性と結合性で並べ替える。
  abel

/-- 冪の法則の帰納法の出発点（`k = 0` の段）で使う。`log 1 = 0`。 -/
lemma logRat_one : logRat 1 = 0 := by
  refine Finsupp.ext fun p => ?_
  simp [logRat]

/-- 冪の法則。`log(q^k) = k • log q`。`k` についての帰納法の 2 つの段に対応する。 -/
theorem logRat_pow {q : ℚ} (hq : 0 < q) : ∀ k : ℕ, logRat (q ^ k) = k • logRat q
  | 0 => by rw [pow_zero, logRat_one, zero_nsmul]
  | k + 1 => by
    -- 帰納段の第 1・第 2 の等号。q^(k+1) = q^k · q へ加法性を適用する（正の有理数の積は正の有理数）。
    rw [pow_succ, logRat_mul (pow_pos hq k) hq]
    -- 帰納段の第 3・第 4 の等号。帰納法の仮定を代入し、k • g + g = (k+1) • g で括る。
    rw [logRat_pow hq k, succ_nsmul]

end Ising2DLambda.FreeEntropy
