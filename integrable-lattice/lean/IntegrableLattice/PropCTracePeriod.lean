/-
# 命題 C′（トレース列の周期の上界）と cycle 19 の新しい定理 A′

対応する人手証明:

* 本文ブロック `paper_prop_C_trace`（`structured-latex/content/004_lambda_finite.ts`）
* 根拠 report: `outputs/reports/cycle18_T3_trace_period_bound.md`（命題 C′ の初出）
* 本ファイルの主対象: `outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md`

## 目的

**証明の正しさではなく、主張の検算**である（cycle 17 の命題 B、cycle 18 の命題 N・W と同じ趣旨）。
命題 C′ の主張が Lean の型で一意に読めるかを確かめ、その過程で本文の記述と食い違う点を洗い出す。

## 記号（人手証明との対応）

$T\in M_d(\mathbb{Z})$、$p$ 素数、$p\nmid\det T$。$\rho=\mathrm{rad}(\chi_T)$、$r=\deg\rho$、
$S=\bigoplus_i C_{f_i}^{\oplus a_i}$（半単純模型）、$R=\mathbb{Z}[S]$、
$G=(\operatorname{Tr}T^{i+j})_{0\le i,j<r}$、$w^*=v_p(G\text{ の最大単因子})$、
$t_k=\pi_{\mathrm{tr}}(p,k)$。

本ファイルでは $R$ を「1 元 $s$ で生成される可換環」、$\operatorname{Tr}$ を
「$R$ から $\mathbb{Z}$ への加法準同型」として**抽象化**する。人手証明が使っているのは
この 2 つの性質だけであり（行列であること・$S$ が半単純模型であることは使っていない）、
抽象化することでその事実自体が検算になる。

## 形式化した主張

* `TraceOrth tr p k B` — 「$\forall x\in R,\ p^k\mid\operatorname{Tr}(xB)$」。
  人手証明が $t$ を「トレース列の周期」と呼ぶときに実際に使っている性質。
* `traceOrth_of_forall_pow` — $R$ が $s$ で生成されるなら、$x=s^N$ についての条件だけから
  すべての $x\in R$ についての条件が出る（人手証明が暗黙に使っている段）。
* `dvd_of_mulVec_dvd` — **定理 6 の Smith 標準形の段**。$H G=p^{w}I$ なる整数行列 $H$ が
  存在すれば、$Gb\equiv0\ (p^k)$ から $p^{k-w}\mid b_j$ が出る。
  「$w^*$＝最大単因子の付値」という定義が使われているのは**この形でだけ**である。
* `traceOrth_one_add_pow` — **cycle 19 の定理 A′の心臓部**。
  $B$ がレベル $k$ で直交し、かつ $B=p^{j}C$（$j\ge1$）なら、
  $(1+B)^p-1$ はレベル $k+1$ で直交する。
* `isTracePeriodAt_mul_prime` — その周期版。$t$ がレベル $k$ の周期なら $pt$ はレベル $k+1$ の周期。
  これが $t_{k+1}\mid p\,t_k$（cycle 18 の**予想 A**、cycle 19 で**定理**になった）である。
* `luc` / `lucas_two_power_not_period` — **命題 12 の反例**（$T=F\oplus F$, $p=2$）。
  レベル 1 では周期 1 なのに、レベル 2 では $2$ 冪はどれも周期にならない。
  ゆえに「$t_k\mid p^a t_1$」は $a$ をどう取っても偽。
* `orderOf_three_zmod_*` / `trace_period_not_affine` — **閉形式が存在しないことの反例**
  （$T=(3)$, $p=2$、$w^*=0$）。$t_2=t_3=2$ かつ $t_3\neq t_4$ なので、
  $t_k=p^{k-c}\tau$ の形の閉形式は存在しない。

## 形式化で分かったこと（本文との食い違い・過剰仮定）

1. **定理 A′（旧・予想 A）の証明に $p$ の素数性は要らない。** 本ファイルの
   `traceOrth_one_add_pow` は `p` が素数であることを一切使わない
   （効いているのは二項係数のうち $\binom{p}{1}=p$ だけである）。
   素数性が要るのは $\pi_{\mathrm{tr}}$ の定義（$p$ 進レベル）と Smith 標準形の段であって、
   階段の段ではない。
2. **`TraceOrth` と「周期」は同じものではない。** 人手証明は $t$ を最小周期として導入するが、
   証明で使うのは「$t$ が周期である」（最小性ではない）だけである。
   最小性を仮定に入れると `isTracePeriodAt_mul_prime` は述べられない
   （$pt$ は最小とは限らない）。本文の証明が最小性を使っていないことは、
   この形式化で確認できる。

## 形式化していない主張（理由つき）

* **定理 W（$w^*=\min\{j: p^j\eta^{-1}\in\mathbb{Z}[\theta]\}$）は形式化していない。**
  mathlib には `Mathlib/RingTheory/DedekindDomain/Different.lean` に `traceDual`・
  `differentIdeal`・`aeval_derivative_mem_differentIdeal`・`conductor_mul_differentIdeal` が
  **在る**（cycle 19 の grep で実在を確認済み。「無い」とは書かない）。
  無いのは、これらを「重み付きトレース形式の Gram 行列の最大単因子」へ結ぶ配線と、
  整数行列の Smith 標準形（mathlib の `Basis.SmithNormalForm` は
  部分加群の基底の形で、行列の単因子の形では与えられていない）である。
  本ファイルは Smith 標準形を**使わず**、その帰結（$HG=p^wI$）を仮定として型に出した。
* **$\pi_{\mathrm{tr}}$ そのものの最小性・純周期性**は `PropCPeriod.lean` の
  `isUnit_pow_add_eq_iff` と同じ方式で扱えるが、本ファイルの主張には不要なので入れていない。

**新規性は主張しない**（線形漸化列の周期・トレース形式・Wall 型上界はいずれも古典）。
-/
import Mathlib

namespace IntegrableLattice

open Finset

/-! ## 1. トレース直交性 -/

section TraceOrth

variable {R : Type*} [CommRing R]

/-- レベル `k` のトレース直交性: すべての `x ∈ R` で `p^k ∣ tr (x * B)`。
人手証明で「`t` はトレース列の `mod p^k` の周期」と書かれている条件そのもの
（`B = s^t - 1` と取る）。 -/
def TraceOrth (tr : R →+ ℤ) (p k : ℕ) (B : R) : Prop :=
  ∀ x : R, (p : ℤ) ^ k ∣ tr (x * B)

/-- `tr` は加法準同型なので `p^m` 倍は外へ出る。 -/
lemma tr_natCast_pow_mul (tr : R →+ ℤ) (p m : ℕ) (z : R) :
    tr ((p : R) ^ m * z) = (p : ℤ) ^ m * tr z := by
  have h : ((p : R) ^ m) * z = (p ^ m : ℕ) • z := by
    rw [nsmul_eq_mul]
    push_cast
    ring
  rw [h, AddMonoidHom.map_nsmul, nsmul_eq_mul]
  push_cast
  ring

/-- `B` がレベル `k` で直交し、かつ `B = p^j * C` なら、`B^(i+1)` は
レベル `k + j*i` で直交する。人手証明の「一方の `B` はトレース直交性を保ったまま残す」段。 -/
lemma traceOrth_pow_succ {tr : R →+ ℤ} {p k j : ℕ} {B C : R}
    (hB : TraceOrth tr p k B) (hBC : B = (p : R) ^ j * C) (i : ℕ) (x : R) :
    (p : ℤ) ^ (k + j * i) ∣ tr (x * B ^ (i + 1)) := by
  have h1 : B ^ i = (p : R) ^ (j * i) * C ^ i := by
    rw [hBC, mul_pow, ← pow_mul]
  have h2 : x * B ^ (i + 1) = (p : R) ^ (j * i) * ((x * C ^ i) * B) := by
    rw [pow_succ, h1]; ring
  rw [h2, tr_natCast_pow_mul]
  obtain ⟨u, hu⟩ := hB (x * C ^ i)
  exact ⟨u, by rw [hu, pow_add]; ring⟩

/-- **定理 A′ の心臓部。** `B` がレベル `k` で直交し `B = p^j C`（`j ≥ 1`）なら、
`(1 + B)^p - 1` はレベル `k+1` で直交する。

`p` の素数性は使わない（`Nat.choose p 1 = p` だけを使う）。 -/
theorem traceOrth_one_add_pow {tr : R →+ ℤ} {p k j : ℕ} {B C : R}
    (hB : TraceOrth tr p k B) (hBC : B = (p : R) ^ j * C) (hj : 1 ≤ j) :
    TraceOrth tr p (k + 1) ((1 + B) ^ p - 1) := by
  intro x
  -- (1+B)^p - 1 = ∑_{i<p} B^(i+1) * C(p, i+1)
  have hexp : (1 + B) ^ p - 1
      = ∑ i ∈ range p, B ^ (i + 1) * ((p.choose (i + 1) : ℕ) : R) := by
    have h := add_pow B (1 : R) p
    rw [add_comm B (1 : R)] at h
    rw [h, Finset.sum_range_succ']
    simp
  rw [hexp, Finset.mul_sum, map_sum]
  refine Finset.dvd_sum ?_
  intro i _
  have hmul : x * (B ^ (i + 1) * ((p.choose (i + 1) : ℕ) : R))
      = (p.choose (i + 1) : ℕ) • (x * B ^ (i + 1)) := by
    rw [nsmul_eq_mul]; push_cast; ring
  rw [hmul, AddMonoidHom.map_nsmul, nsmul_eq_mul]
  rcases Nat.eq_zero_or_pos i with hi | hi
  · -- i = 0: 係数がちょうど p。ここだけが `k+1` ぎりぎりになる。
    subst hi
    obtain ⟨u, hu⟩ := hB x
    refine ⟨u, ?_⟩
    have hc1 : ((p.choose (0 + 1) : ℕ) : ℤ) = (p : ℤ) := by simp
    have hb1 : B ^ (0 + 1) = B := by simp
    rw [hc1, hb1, hu, pow_succ]
    ring
  · -- i ≥ 1: `traceOrth_pow_succ` の指数 k + j*i が k+1 以上。
    have hdvd := traceOrth_pow_succ hB hBC i x
    have hle : k + 1 ≤ k + j * i := by
      have : 1 ≤ j * i := Nat.one_le_iff_ne_zero.mpr (by positivity)
      omega
    exact Dvd.dvd.mul_left (dvd_trans (pow_dvd_pow _ hle) hdvd) _

end TraceOrth

/-! ## 2. 生成元の冪だけからトレース直交性を出す -/

section Generated

variable {R : Type*} [CommRing R]

/-- `R` が `s` で（`ℤ` 上）生成されるなら、`x = s^N` についての条件だけで十分。 -/
lemma traceOrth_of_forall_pow {tr : R →+ ℤ} {p k : ℕ} {s B : R}
    (hgen : ∀ x : R, ∃ q : Polynomial ℤ, x = Polynomial.aeval s q)
    (h : ∀ N : ℕ, (p : ℤ) ^ k ∣ tr (s ^ N * B)) : TraceOrth tr p k B := by
  intro x
  obtain ⟨q, rfl⟩ := hgen x
  rw [Polynomial.aeval_eq_sum_range, Finset.sum_mul, map_sum]
  refine Finset.dvd_sum ?_
  intro i _
  have hs : (q.coeff i • s ^ i) * B = q.coeff i • (s ^ i * B) := by
    rw [smul_mul_assoc]
  rw [hs, AddMonoidHom.map_zsmul, zsmul_eq_mul]
  exact Dvd.dvd.mul_left (h i) _

/-- `t` が「レベル `k` のトレース周期」であること（最小性は要求しない）。 -/
def IsTracePeriodAt (tr : R →+ ℤ) (p k : ℕ) (s : R) (t : ℕ) : Prop :=
  ∀ N : ℕ, (p : ℤ) ^ k ∣ tr (s ^ N * (s ^ t - 1))

/-- **定理 A′**（cycle 18 の予想 A）。`s^t - 1 = p^j C`（`j ≥ 1`）なら、
レベル `k` の周期 `t` から レベル `k+1` の周期 `p*t` が出る。

人手証明では `j = k - w*` を定理 6 から取り、`k ≥ w* + 1` が `j ≥ 1` に対応する。 -/
theorem isTracePeriodAt_mul_prime {tr : R →+ ℤ} {p k j : ℕ} {s C : R} {t : ℕ}
    (hgen : ∀ x : R, ∃ q : Polynomial ℤ, x = Polynomial.aeval s q)
    (hper : IsTracePeriodAt tr p k s t)
    (hBC : s ^ t - 1 = (p : R) ^ j * C) (hj : 1 ≤ j) :
    IsTracePeriodAt tr p (k + 1) s (p * t) := by
  have hB : TraceOrth tr p k (s ^ t - 1) := traceOrth_of_forall_pow hgen hper
  have hstep := traceOrth_one_add_pow hB hBC hj
  intro N
  have hrw : s ^ (p * t) - 1 = (1 + (s ^ t - 1)) ^ p - 1 := by
    have : (1 : R) + (s ^ t - 1) = s ^ t := by ring
    rw [this, ← pow_mul, mul_comm t p]
  rw [hrw]
  exact hstep (s ^ N)

end Generated

/-! ## 3. 定理 6 の Smith 標準形の段（整数ベクトルの割り切れ） -/

/-- `H * M = p^w • 1` なる整数行列 `H` があるとき、`M *ᵥ b ≡ 0 (mod p^k)` なら
`p^(k-w) ∣ b i`。人手証明で `w* = 最大単因子の付値` が使われているのはこの形だけである。 -/
theorem dvd_of_mulVec_dvd {r : ℕ} {p w k : ℕ} (hp : 0 < p)
    (M H : Matrix (Fin r) (Fin r) ℤ) (b : Fin r → ℤ)
    (hHM : H * M = ((p : ℤ) ^ w) • (1 : Matrix (Fin r) (Fin r) ℤ))
    (hb : ∀ i, (p : ℤ) ^ k ∣ (M.mulVec b) i) (i : Fin r) :
    (p : ℤ) ^ (k - w) ∣ b i := by
  choose c hc using hb
  have hMb : M.mulVec b = ((p : ℤ) ^ k) • c := funext fun j => by
    rw [hc j]; simp
  have key : (p : ℤ) ^ k ∣ (p : ℤ) ^ w * b i := by
    have h1 : ((p : ℤ) ^ w) • b = H.mulVec (M.mulVec b) := by
      rw [Matrix.mulVec_mulVec, hHM, Matrix.smul_mulVec, Matrix.one_mulVec]
    have h2 : H.mulVec (M.mulVec b) = ((p : ℤ) ^ k) • H.mulVec c := by
      rw [hMb, Matrix.mulVec_smul]
    have h3 := congrFun (h1.trans h2) i
    simp only [Pi.smul_apply, smul_eq_mul] at h3
    exact ⟨H.mulVec c i, h3⟩
  by_cases hwk : w ≤ k
  · have hsplit : (p : ℤ) ^ k = (p : ℤ) ^ w * (p : ℤ) ^ (k - w) := by
      rw [← pow_add]; congr 1; omega
    rw [hsplit] at key
    have hne : ((p : ℤ) ^ w) ≠ 0 := pow_ne_zero _ (by exact_mod_cast hp.ne')
    exact (mul_dvd_mul_iff_left hne).mp key
  · have : k - w = 0 := by omega
    rw [this, pow_zero]
    exact one_dvd _

/-! ## 4. 命題 12 の反例（$T=F\oplus F$, $p=2$）: $p$ 冪補正は不可能 -/

/-- Lucas 数（$\operatorname{Tr}(F\oplus F)^N = 2L_N$）。 -/
def luc : ℕ → ℤ
  | 0 => 2
  | 1 => 1
  | (n + 2) => luc (n + 1) + luc n

lemma luc_add_two (n : ℕ) : luc (n + 2) = luc (n + 1) + luc n := rfl

/-- 3 段の関係式。ここに現れる `2 *` が「mod 2 で周期 3」の全内容である。 -/
lemma luc_add_three (n : ℕ) : luc (n + 3) = 2 * luc (n + 1) + luc n := by
  have h : luc (n + 3) = luc (n + 2) + luc (n + 1) := rfl
  rw [h, luc_add_two]; ring

/-- `luc` の `mod 2` 還元。 -/
def luc2 (n : ℕ) : ZMod 2 := (luc n : ZMod 2)

lemma luc2_periodic (n : ℕ) : luc2 (n + 3) = luc2 n := by
  simp only [luc2, luc_add_three]
  push_cast
  have : (2 : ZMod 2) = 0 := by decide
  rw [this]
  ring

lemma luc2_mod_three (n : ℕ) : luc2 n = luc2 (n % 3) := by
  induction n using Nat.strong_induction_on with
  | _ n ih =>
    rcases lt_or_ge n 3 with h | h
    · rw [Nat.mod_eq_of_lt h]
    · obtain ⟨m, rfl⟩ : ∃ m, n = m + 3 := ⟨n - 3, by omega⟩
      rw [luc2_periodic, ih m (by omega), Nat.add_mod_right]

lemma two_pow_mod_three (a : ℕ) : 2 ^ a % 3 = 1 ∨ 2 ^ a % 3 = 2 := by
  induction a with
  | zero => left; rfl
  | succ n ih =>
    have h : 2 ^ (n + 1) % 3 = (2 ^ n % 3) * (2 % 3) % 3 := by
      rw [pow_succ, Nat.mul_mod]
    rcases ih with h1 | h1 <;> rw [h, h1]
    · right; rfl
    · left; rfl

/-- レベル 1（`mod 2`）では周期 1: トレース列 `2 L_N` は恒等的に偶数。 -/
theorem lucas_period_one_level_one (N : ℕ) : (2 : ℤ) ∣ 2 * luc (N + 1) - 2 * luc N := by
  exact ⟨luc (N + 1) - luc N, by ring⟩

/-- **命題 12 の反例。** レベル 2（`mod 4`）では、`2^a` はどれも周期にならない。
したがって `t_2 ∣ 2^a * t_1 = 2^a` は `a` をどう取っても偽である。 -/
theorem lucas_two_power_not_period (a : ℕ) :
    ¬ ∀ N : ℕ, (4 : ℤ) ∣ 2 * luc (N + 2 ^ a) - 2 * luc N := by
  intro h
  have h0 := h 0
  have hdvd : (2 : ℤ) ∣ luc (2 ^ a) - luc 0 := by
    obtain ⟨u, hu⟩ := h0
    refine ⟨u, ?_⟩
    have hcan : (2 : ℤ) * (luc (0 + 2 ^ a) - luc 0) = 2 * (2 * u) := by linarith
    have h2 : (2 : ℤ) ≠ 0 := by norm_num
    have := mul_left_cancel₀ h2 hcan
    simpa using this
  have heq : luc2 (2 ^ a) = luc2 0 := by
    have : ((luc (2 ^ a) - luc 0 : ℤ) : ZMod 2) = 0 :=
      (ZMod.intCast_zmod_eq_zero_iff_dvd _ 2).mpr (by exact_mod_cast hdvd)
    simp only [luc2]
    push_cast at this
    linear_combination this
  rw [luc2_mod_three (2 ^ a)] at heq
  rcases two_pow_mod_three a with h1 | h1 <;> rw [h1] at heq <;> revert heq <;> decide

/-! ## 5. 閉形式が存在しないことの反例（$T=(3)$, $p=2$, $w^*=0$） -/

section NoClosedForm

private instance : Fact (Nat.Prime 2) := ⟨by norm_num⟩

/-- $t_1 = 1$。 -/
theorem orderOf_three_zmod_two : orderOf (3 : ZMod 2) = 1 :=
  orderOf_eq_one_iff.mpr (by decide)

/-- $t_2 = 2$。 -/
theorem orderOf_three_zmod_four : orderOf (3 : ZMod 4) = 2 :=
  orderOf_eq_prime (by decide) (by decide)

/-- $t_3 = 2$。**ここで階段が止まる**（$t_2 = t_3$）。 -/
theorem orderOf_three_zmod_eight : orderOf (3 : ZMod 8) = 2 :=
  orderOf_eq_prime (by decide) (by decide)

/-- $t_4 = 4$。階段が再び動く。 -/
theorem orderOf_three_zmod_sixteen : orderOf (3 : ZMod 16) = 4 := by
  have h := orderOf_eq_prime_pow (p := 2) (n := 1) (x := (3 : ZMod 16))
    (by decide) (by decide)
  simpa using h

/-- **閉形式の不存在。** $T=(3)$, $p=2$ では $\operatorname{Tr}T^N=3^N$ なので
$t_k=\operatorname{ord}_{2^k}(3)$ である。$t_2=t_3$ かつ $t_3\neq t_4$ なので、
$t_k = p^{\,k-c}\,\tau$（$c$ は $k$ に依らない定数）の形の閉形式は存在しない。 -/
theorem trace_period_not_affine :
    orderOf (3 : ZMod 4) = orderOf (3 : ZMod 8) ∧
      orderOf (3 : ZMod 8) ≠ orderOf (3 : ZMod 16) := by
  refine ⟨?_, ?_⟩
  · rw [orderOf_three_zmod_four, orderOf_three_zmod_eight]
  · rw [orderOf_three_zmod_eight, orderOf_three_zmod_sixteen]
    decide

end NoClosedForm

end IntegrableLattice
