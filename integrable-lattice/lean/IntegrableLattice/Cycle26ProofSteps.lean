/-
# 命題 G′ の**証明そのもの**の検算 — cycle 26 step 6（Lean 検算 11 サイクル目）

## これまでと何が違うか

cycle 16–25 の 10 サイクルは、根拠 report と本文の**主張**を検算してきた。
cycle 25 で**証明が本文に入った**（証明を持つべき 24 ブロックすべてが証明を持つ）ので、
本サイクルは**証明の中の各ステップ**を対象にする。

対応する人手証明:

* 本文: `structured-latex/content/005b_theta_infinity.ts` の命題 G′（(G′1)–(G′3)）
* 根拠 report: `outputs/reports/cycle19_T3_theta_infinity.md`
* 本サイクル step 5 が主張へ入れた仮定: $\theta^*-m_1<\ell-1$

## なぜ命題 G′ を選んだか

**cycle 26 step 5 が「証明にしか無かった仮定」を主張へ移した直後だからである。**
移した根拠は本文が自分で書いている一文（「この仮定なしにはこの等式は述べられない」）だが、
**その一文が正しいこと自体は誰も確かめていない。** 具体的には次の 2 点が未検算だった。

1. 主張へ移した仮定 $\theta^*-m_1<\ell-1$ が、証明が実際に要求する
   「**全レベル $M\ge1$ で** $\theta^*-m_1<\varphi(\ell^M)$」を本当に含意するか。
   本文が挙げる理由は $\varphi(\ell^M)\ge\ell-1$ の一行だけである。
2. その下で直線の寄与が $\lambda(\ell^n-1)+n\theta^*$ になること（**総和の計算そのもの**）。

## 形式化した主張

* `phi_pow_ge` — $\varphi(\ell^M)\ge\ell-1$（$\ell$ 素数・$M\ge1$）。本文の一行の根拠。
* `line_hypothesis_suffices` — **主張へ移した 1 条件が全レベルの条件を含意する**（上の 1）。
* `sum_phi_pow_prime` — $\sum_{M=1}^{n}\varphi(\ell^M)=\ell^n-1$。証明が使う恒等式。
* `line_contribution` — **直線の寄与の総和計算**（上の 2）。
  $\lambda,\theta^*$ を有理数のままにして、分母 $\varphi(\ell^M)$ の相殺が
  レベルごとに起きることを型に出す。
* `level_ratio` — (G′2) の計数「割合は $\ell^{1-M}$」。
* `g3_coefficients_match` — (G′3) の閉形式と、そこから読む 5 係数
  $a=\mu,\ b=2,\ c=\Lambda,\ d=0,\ e=-\mu-\Lambda$ が**恒等式として一致する**こと。

**`Real` を 1 つも使わない。** すべて $\mathbb{N}$ / $\mathbb{Z}$ / $\mathbb{Q}$ 上で閉じる
（本文が「ℝ 脱出は命題 Q の (Q4) ただ 1 箇所」と宣言していることと整合する）。
-/

import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.NumberTheory.Divisors
import Mathlib.Data.Nat.Totient
import Mathlib.Tactic

namespace IntegrableLattice

open Finset

/-! ## 1. 主張へ移した仮定が、証明が要求する条件を含意すること -/

/-- $\ell$ が素数で $M\ge1$ なら $\varphi(\ell^M)\ge\ell-1$。

本文が「$\varphi(\ell^M)\ge\ell-1$ なので、この 1 条件で全レベルで上の付値公式が使える」と
書いている一行の根拠。$\varphi(\ell^M)=\ell^{M-1}(\ell-1)$ から出る。 -/
theorem phi_pow_ge {ℓ M : ℕ} (hℓ : ℓ.Prime) (hM : 1 ≤ M) :
    ℓ - 1 ≤ Nat.totient (ℓ ^ M) := by
  have hval : Nat.totient (ℓ ^ M) = ℓ ^ (M - 1) * (ℓ - 1) :=
    Nat.totient_prime_pow hℓ (by omega)
  have hpos : 1 ≤ ℓ ^ (M - 1) := Nat.one_le_pow _ _ hℓ.pos
  calc ℓ - 1 = 1 * (ℓ - 1) := by omega
    _ ≤ ℓ ^ (M - 1) * (ℓ - 1) := Nat.mul_le_mul_right _ hpos
    _ = Nat.totient (ℓ ^ M) := hval.symm

/-- **cycle 26 step 5 が主張へ移した 1 条件は、証明が要求する全レベルの条件を含意する。**

人手証明は付値公式を「$\theta^*-m_1<\varphi(\ell^M)$ が成り立つとき」の形で持っており、
直線の寄与を出すところでそれを**全ての $M\ge1$** について使う。
主張へ移したのは $\theta^*-m_1<\ell-1$ という**レベルに依らない 1 条件**なので、
両者が繋がることを確かめておかないと、主張と証明の間に穴が空く。 -/
theorem line_hypothesis_suffices {ℓ d : ℕ} (hℓ : ℓ.Prime) (h : d < ℓ - 1) :
    ∀ M : ℕ, 1 ≤ M → d < Nat.totient (ℓ ^ M) :=
  fun M hM => lt_of_lt_of_le h (phi_pow_ge hℓ hM)

/-! ## 2. 証明が使う総和の恒等式 -/

/-- $\sum_{M=1}^{n}\varphi(\ell^M)=\ell^n-1$（$\ell$ は素数）。

証明が「$\sum_{M=1}^{n}\varphi(\ell^{M})=\ell^{n}-1$ だから」と一行で使っている恒等式。
$\varphi(\ell^M)=\ell^{M-1}(\ell-1)$ の telescoping である。
**素数性は落とせない**（一般の $\ell$ ではこの等式は成り立たない）。 -/
theorem sum_phi_pow_prime {ℓ : ℕ} (hℓ : ℓ.Prime) (n : ℕ) :
    ∑ M ∈ Finset.Icc 1 n, Nat.totient (ℓ ^ M) = ℓ ^ n - 1 := by
  induction n with
  | zero => simp
  | succ k ih =>
      rw [Finset.sum_Icc_succ_top (by omega), ih]
      have hk : 1 ≤ ℓ ^ k := Nat.one_le_pow _ _ hℓ.pos
      have h2 : 2 ≤ ℓ := hℓ.two_le
      have hval : Nat.totient (ℓ ^ (k + 1)) = ℓ ^ k * (ℓ - 1) := by
        have := Nat.totient_prime_pow hℓ (Nat.succ_pos k)
        simpa using this
      have hexp : ℓ ^ (k + 1) = ℓ ^ k * ℓ := by ring
      have hmul : ℓ ^ k * (ℓ - 1) = ℓ ^ k * ℓ - ℓ ^ k := by
        rw [Nat.mul_sub, Nat.mul_one]
      have hge : ℓ ^ k ≤ ℓ ^ k * ℓ := Nat.le_mul_of_pos_right _ (by omega)
      rw [hval, hexp, hmul]
      omega

/-! ## 3. 直線の寄与（証明の総和計算そのもの） -/

/-- **直線 $\mathbb{Z}u$ 上の点の $\Sigma_n$ への寄与**。

人手証明の計算:
$$\sum_{M=1}^{n}\varphi(\ell^{M})\Bigl(\lambda+\frac{\theta^*}{\varphi(\ell^{M})}\Bigr)
  =\lambda\,(\ell^{n}-1)+n\,\theta^{*}.$$

各レベルの点の個数 $\varphi(\ell^M)$ と、各点の付値 $\lambda+\theta^*/\varphi(\ell^M)$ の
**分母がレベルごとに相殺する**のが計算の要点である。
$\lambda,\theta^*$ は $\mathbb{Q}$ 値で扱う（$\theta^*/\varphi(\ell^M)$ は一般に整数でない）。
$\varphi(\ell^M)\ne0$ が要ることが型に出る。 -/
theorem line_contribution {ℓ : ℕ} (hℓ : ℓ.Prime) (lam thstar : ℚ) (n : ℕ) :
    ∑ M ∈ Finset.Icc 1 n, (Nat.totient (ℓ ^ M) : ℚ) *
        (lam + thstar / (Nat.totient (ℓ ^ M) : ℚ))
      = lam * ((ℓ : ℚ) ^ n - 1) + n * thstar := by
  have hne : ∀ M ∈ Finset.Icc 1 n, (Nat.totient (ℓ ^ M) : ℚ) ≠ 0 := by
    intro M hM
    have : 0 < Nat.totient (ℓ ^ M) := Nat.totient_pos.mpr (Nat.pow_pos hℓ.pos)
    exact_mod_cast this.ne'
  -- 各項を分配して分母を相殺する（レベルごとの計算）。
  have hterm : ∀ M ∈ Finset.Icc 1 n,
      (Nat.totient (ℓ ^ M) : ℚ) * (lam + thstar / (Nat.totient (ℓ ^ M) : ℚ))
        = (Nat.totient (ℓ ^ M) : ℚ) * lam + thstar := by
    intro M hM
    rw [mul_add, mul_div_cancel₀ _ (hne M hM)]
  rw [Finset.sum_congr rfl hterm, Finset.sum_add_distrib, ← Finset.sum_mul]
  have hcard : (Finset.Icc 1 n).card = n := by simp
  rw [Finset.sum_const, hcard, nsmul_eq_mul]
  have hsum : ∑ M ∈ Finset.Icc 1 n, (Nat.totient (ℓ ^ M) : ℚ) = (ℓ : ℚ) ^ n - 1 := by
    have hnat := sum_phi_pow_prime hℓ n
    have hle : 1 ≤ ℓ ^ n := Nat.one_le_pow _ _ hℓ.pos
    have : ((∑ M ∈ Finset.Icc 1 n, Nat.totient (ℓ ^ M) : ℕ) : ℚ) = ((ℓ ^ n - 1 : ℕ) : ℚ) := by
      exact_mod_cast congrArg (Nat.cast : ℕ → ℚ) hnat
    rw [Nat.cast_sum] at this
    rw [this, Nat.cast_sub hle]
    push_cast
    ring
  rw [hsum]
  -- 残ゴールは可換性だけ（ビルド出力で残ゴールを見てから足した。決めつけていない）:
  --   (ℓ^n - 1) * lam + n * thstar = lam * (ℓ^n - 1) + n * thstar
  ring

/-! ## 4. (G′2) の計数の割合 -/

/-- 方向 $P$ のレベルちょうど $M$ の点は $(\ell-1)\ell^{2M-2}$ 個あり、
そのうち直線 $\mathbb{Z}u$ に乗る代表を持つものは $\varphi(\ell^M)$ 個。
本文はその割合を $\ell^{1-M}$ と書いている。

$\varphi(\ell^M)=(\ell-1)\ell^{M-1}$ なので割合は
$(\ell-1)\ell^{M-1}/((\ell-1)\ell^{2M-2})=\ell^{1-M}$ である。
分母を払った形（$M\ge1$ のまま $\mathbb{N}$ で書ける形）で述べる。 -/
theorem level_ratio {ℓ M : ℕ} (hℓ : ℓ.Prime) (hM : 1 ≤ M) :
    Nat.totient (ℓ ^ M) * ℓ ^ (M - 1) = (ℓ - 1) * ℓ ^ (2 * M - 2) := by
  have hval : Nat.totient (ℓ ^ M) = ℓ ^ (M - 1) * (ℓ - 1) :=
    Nat.totient_prime_pow hℓ (by omega)
  have hexp : ℓ ^ (M - 1) * ℓ ^ (M - 1) = ℓ ^ (2 * M - 2) := by
    rw [← pow_add]
    congr 1
    omega
  calc Nat.totient (ℓ ^ M) * ℓ ^ (M - 1)
      = ℓ ^ (M - 1) * (ℓ - 1) * ℓ ^ (M - 1) := by rw [hval]
    _ = (ℓ - 1) * (ℓ ^ (M - 1) * ℓ ^ (M - 1)) := by ring
    _ = (ℓ - 1) * ℓ ^ (2 * M - 2) := by rw [hexp]

/-! ## 5. (G′3) の閉形式と 5 係数の一致 -/

/-- **(G′3) の閉形式から読んだ 5 係数が、閉形式そのものと恒等式として一致すること。**

本文は
$$\mathrm{ord}_\ell(\kappa_n)=\mu\,(\ell^{2n}-1)+2\,n\,\ell^{n}+\Lambda\,(\ell^{n}-1)$$
と述べたうえで「すなわち 5 係数は $a=\mu,\ b=2,\ c=\Lambda,\ d=0,\ e=-\mu-\Lambda$」と書く。
$(1.1)$ の形 $a\ell^{2n}+bn\ell^n+c\ell^n+dn+e$ へ代入して一致することを確かめる。
**これは本文が「すなわち」で繋いでいる一歩であり、計算は書かれていない。** -/
theorem g3_coefficients_match (L mu Lam : ℚ) (n : ℕ) :
    mu * (L ^ (2 * n) - 1) + 2 * n * L ^ n + Lam * (L ^ n - 1)
      = mu * L ^ (2 * n) + 2 * n * L ^ n + Lam * L ^ n + 0 * n + (-mu - Lam) := by
  ring

/-! ## 6. 主張が書いていない規約 — $m_1=+\infty$ の読み方

**本サイクル step 6 の検出。** 命題 G′ の証明は

> そのような $m$ が 1 つも無ければ $m_1=+\infty$ と読む（このとき仮定は自動的に満たされる）

と**規約を明記している**。ところが**主張の側にはこの規約が無い**。
主張は $m_1:=\min\{m<\theta^*:B_m\neq0\}$ と定義したうえで、
$\theta^*-m_1<\varphi(\ell^M)$（(G′2) の付値公式）と
$\theta^*-m_1<\ell-1$（本サイクル step 5 が主張へ移した仮定）の**両方で $m_1$ を引き算に使う**。

$\min\emptyset$ の読み方を書かないと何が壊れるか——**cycle 25 step 1 が定理 G2 $(3.2)$ で
見つけたのとまったく同じ形の事故が起きる。** mathlib 標準の `Nat` の `min ∅ = 0` で読むと、
(G′3) の族（$\theta^*=2$、そのような $m$ は無いので本来 $m_1=+\infty$）では
$\theta^*-m_1$ が $2-0=2$ になり、仮定は $2<\ell-1$ すなわち $\ell\ge5$ を要求する。
**(G′3) が「任意の奇素数で成り立つ」と主張しているのに、$\ell=3$ だけが落ちる。**

以下の 3 つは、その事故が実際に起きることを型に出したものである。 -/

/-- $m_1=+\infty$ の正しい読み（仮定は自動的に満たされる）。

証明が書いている規約のとおり、そのような $m$ が無いときは仮定を課さない。
`Option ℕ` の `none` を $+\infty$ とし、`none` なら真とする述語で表す。 -/
def lineHypothesis (thstar : ℕ) (m1 : Option ℕ) (ℓ : ℕ) : Prop :=
  match m1 with
  | none => True                      -- $m_1=+\infty$: 自動的に満たされる
  | some m => thstar - m < ℓ - 1

/-- 正しい読みでは、(G′3) の族は**すべての奇素数**で仮定を満たす。 -/
theorem gprime3_hypothesis_holds (ℓ : ℕ) : lineHypothesis 2 none ℓ := trivial

/-- **`min ∅ = 0` で読むと $\ell=3$ が落ちる。**

(G′3) の族は $\theta^*=2$。この読みでは仮定が $2<\ell-1$ になるので $\ell\ge5$ が要る。 -/
theorem junk_reading_excludes_ell_three : ¬ (2 - 0 < 3 - 1) := by decide

/-- **落ちるのは $\ell=3$ だけである**（$\ell=5,7$ は落ちない）。

cycle 25 step 1 が定理 G2 $(3.2)$ で確認したのと同じ形である——
**1 つだけ落ちるから、規約の欠落が長く見過ごされる。** -/
theorem junk_reading_keeps_five_and_seven : (2 - 0 < 5 - 1) ∧ (2 - 0 < 7 - 1) := by
  constructor <;> decide

end IntegrableLattice
