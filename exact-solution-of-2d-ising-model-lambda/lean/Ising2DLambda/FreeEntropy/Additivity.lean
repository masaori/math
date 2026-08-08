/-
人手証明の主張「対数の加法性」（ラベル `claim_log_additive`）と
「対数の冪の法則」（ラベル `claim_log_power`）の具体版。

人手証明の Step とこのファイルの対応（加法性）:

  Step 1（表示を取る）              logRat_eq_of_repr（任意の表示から log を計算してよいこと）
  Step 2（積の表示を作る）          logRat_mul の中の `hrepr`
  Step 3（積の指数を書く）          logRat_eq_of_repr の適用
  Step 4（指数の加法性）            logNat_mul（中身は Basic.primeExponent_mul）
  Step 5（並べ替える）              logRat_mul の最後の `abel`
  Step 6（Λ の等式へ移す）          Finsupp.ext（素数ごとに値が一致すれば Λ の元として等しい）

Step 3 が使う「w_p は表示によらない」は、人手証明が明示的にラベル参照している主張
`claim_rational_exponent_well_defined`（Lean では `rationalExponent_well_defined`）である。

冪の法則は人手証明どおり `k` についての帰納法で示す（Step 1 が `k = 0`、Step 3–4 が帰納段）。
人手証明の整数倍 `k log q` は、`k : ℕ` に対する `k • ·`（k 個の和）にあたる。
`Λ` の整数倍の定義は素数ごとの積なので、両者は素数ごとに同じ値である。

住処: 人手証明のこれらのブロックは `Λ` を宣言している。ここに ℝ / ℂ は現れない
（指数は `ℕ`、その差は `ℤ`、値は `Nat.Primes →₀ ℤ`）。
-/
import Ising2DLambda.FreeEntropy.RationalExponent

namespace Ising2DLambda.FreeEntropy

/-- Step 4（指数の加法性を Λ の等式として書いたもの）。`log(mn) = log m + log n`。 -/
lemma logNat_mul {m n : ℕ} (hm : m ≠ 0) (hn : n ≠ 0) :
    logNat (m * n) = logNat m + logNat n := by
  -- Step 6 と同じく、素数ごとに値を比べる。
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

/-- Step 1・Step 3（表示の取り替え）。`q = a / b` であるどの表示からでも `log q` を計算してよい。
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

/-- Step 1–6。`log(q₁q₂) = log q₁ + log q₂`（`Λ` の中の等式）。 -/
theorem logRat_mul {q₁ q₂ : ℚ} (h₁ : 0 < q₁) (h₂ : 0 < q₂) :
    logRat (q₁ * q₂) = logRat q₁ + logRat q₂ := by
  -- Step 1。q₁, q₂ の表示を取る（既約表示を使う）。
  have hnum₁ : q₁.num.natAbs ≠ 0 := num_natAbs_ne_zero h₁
  have hnum₂ : q₂.num.natAbs ≠ 0 := num_natAbs_ne_zero h₂
  have hrepr₁ := repr_of_pos h₁
  have hrepr₂ := repr_of_pos h₂
  -- Step 2。積の表示は分子どうし・分母どうしの積である。
  have hrepr : ((q₁.num.natAbs * q₂.num.natAbs : ℕ) : ℚ) / ((q₁.den * q₂.den : ℕ) : ℚ)
      = q₁ * q₂ := by
    push_cast
    rw [← div_mul_div_comm, hrepr₁, hrepr₂]
  -- Step 3。積の側と各因子の側を、同じ形（分子の log − 分母の log）へ揃える。
  rw [logRat_eq_of_repr (mul_pos h₁ h₂) (Nat.mul_ne_zero hnum₁ hnum₂)
      (Nat.mul_ne_zero q₁.den_nz q₂.den_nz) hrepr,
    logRat_eq_of_repr h₁ hnum₁ q₁.den_nz hrepr₁, logRat_eq_of_repr h₂ hnum₂ q₂.den_nz hrepr₂]
  -- Step 4。指数の加法性を分子側と分母側へ適用する。
  rw [logNat_mul hnum₁ hnum₂, logNat_mul q₁.den_nz q₂.den_nz]
  -- Step 5–6。並べ替える。
  abel

/-- 冪の法則の Step 1（`k = 0` の場合）。`log 1 = 0`。 -/
lemma logRat_one : logRat 1 = 0 := by
  refine Finsupp.ext fun p => ?_
  simp [logRat]

/-- Step 1–5（冪の法則）。`log(q^k) = k • log q`。 -/
theorem logRat_pow {q : ℚ} (hq : 0 < q) : ∀ k : ℕ, logRat (q ^ k) = k • logRat q
  | 0 => by rw [pow_zero, logRat_one, zero_nsmul]
  | k + 1 => by
    -- Step 3。q^(k+1) = q^k · q へ加法性を適用する（正の有理数の積は正の有理数）。
    rw [pow_succ, logRat_mul (pow_pos hq k) hq]
    -- Step 4。帰納法の仮定を代入する。
    rw [logRat_pow hq k, succ_nsmul]

end Ising2DLambda.FreeEntropy
