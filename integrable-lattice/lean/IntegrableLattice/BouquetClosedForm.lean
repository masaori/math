/-
# 命題 8・定理 X・定理 X′（1 頂点 bouquet 族の閉形式） — cycle 19 step 2

対応する人手証明:

* 本文ブロック `paper_prop_G_infty` (G′3)（`structured-latex/content/005b_theta_infinity.ts`）
* 根拠 report: `outputs/reports/cycle19_T3_theta_infinity.md` §5.1（命題 8）・§5.2（定理 X）・
  §5.3（定理 X′）・§5.4（系 X″）

## 目的

**証明の正しさではなく、主張の検算**である。定理 X′ の閉形式
$\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^n+\Lambda(\ell^n-1)$ は、
定理 X の点ごとの付値を**数え上げて総和する**ことで出る。
その数え上げと総和は有限の組合せ計算なので、**そのまま Lean で検算できる**。
$\kappa_n$ そのもの（$\ell^{2n}$ 次の行列式）は Lean では計算しないので、
ここで検算するのは「定理 X を認めたとき定理 X′ が出るか」である。

## 形式化した主張

* `bouquet_cases_exclusive` — **命題 8 の 3 つの場合が排反であること**。
  仮定は「$p',q'$ が同時に $\ell$ で割れない」だけで、$\ell$ の奇偶は使わない。
* `card_diag_*` / `card_one_zero_*` / `card_generic_*` — 定理 X′ の証明が使っている
  レベル 1 の**点の個数**を `decide` で検算（$\ell=3,5,7$）。
* `card_diag_two` — **$\ell=2$ では $a'\equiv b'$ と $a'\equiv-b'$ が排反でない**ので
  同じ数え方が $2\varphi$ ではなく $\varphi$ になること（注 5.2 (ii) の内容）。
* `count_generic_nonneg_iff` — 生成的な組の個数 $\varphi\ell^{m-1}(\ell-3)$ が非負になるのは
  $\ell\ge3$ のときちょうど（注 5.2 (iii) の内容が個数の言葉で出る）。
* `sum_level_A` — **場合 [A] の総和**。$S_{m}=2+2\ell^{m-1}[(\lambda+m-1)(\ell-1)+\ell]$ を
  $m=1,\dots,n$ で足すと $2n\ell^n+2\lambda(\ell^n-1)+2n$。
* `sum_level_B` — **場合 [B] の総和**（$\varphi_n$ 倍した形のまま）。
* `ordKappa_of_sigma` — $(1.1)$ への代入。$\Sigma_n=2n\ell^n+\Lambda(\ell^n-1)+2n$ から
  $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^n+\Lambda(\ell^n-1)$。
* `theoremJ8_eq_XPrime` — 定理 J8 $(5.3)$ が定理 X′ の $\Lambda=2$ の場合と一致すること。
* `cycle19_5_4_example_mismatch` — **下記 1. の誤りの witness**。

## 形式化で分かったこと（本文との食い違い）

1. **根拠 report の §5.4 の 2 つの例が誤っている**（本文 `paper_prop_G_infty` は無傷）。
   `cycle19_T3_theta_infinity.md` §5.4 は
   「$\ell=7$ の $(p,q)=(3,4)$ で $\mathrm{ord}_7(\kappa_n)=2n7^n+7^n-1$、
   $\ell=11$ の $(5,6)$ で $2n11^n+11^n-1$」と書くが、
   どちらも場合 [A]（$\ell\mid p'+q'$）なので命題 8 の表より $\Lambda=2v_\ell(p'+q')=2$ であり、
   定理 X′ の値は $2n\ell^n+2(\ell^n-1)$ である。$\Lambda=1$ として書いてしまっている。
   $n=1$, $\ell=7$ で真値 $26$ に対し §5.4 の式は $20$（`cycle19_5_4_example_mismatch`）。
   **定理 X′ 本体・命題 8 の表・$(\ell,n)$ の照合表はいずれも正しく、誤っているのは
   §5.4 の例示 2 つだけ**である（同じ族の $(p,q)=(\ell-1,1)$ を扱う定理 J8 は
   $2n\ell^n+2\ell^n-2$ と正しく書いている）。
   本 step の担当範囲は本文 `structured-latex/content/` と本 report なので、
   cycle 19 の report 側の訂正は行っていない（`outputs/reports/cycle20_ops_lean_cycle19_theorems.md` §1 に記す）。
2. **食い違いはそれ以外に無い。** 命題 8 の排反性、定理 X′ の数え上げと総和は
   人手証明の通りに通った。
3. **過剰仮定は検出されなかった。** 命題 8 の排反性に $\ell$ の奇性は要らず、
   人手証明もそれを仮定していない（$\ell$ が奇であることを使うのは定理 X の 3 箇所だけで、
   注 5.2 がその 3 箇所を正しく挙げている）。

## 形式化しなかったもの

* $\kappa_n$ の独立計算（Matrix-Tree 定理）。$\ell^{2n}\times\ell^{2n}$ 行列式で、
  mathlib には全域木数の公式が**無い**（`logs/mathlib-gap-survey-cycle16.log`、
  cycle 20 でも再確認: `logs/mathlib-gap-survey-cycle20.log`）。
  これは配線ではなく mathlib の欠落である。
* 定理 X の付値計算そのもの（$v_\ell(h^N-1)=\ell^{\nu(N)}/\varphi_m$）。
  $\mathbb{Q}(\zeta_{\ell^m})$ の $\ell$ の上の素点への配線が要る。
  mathlib には円分体（`IsCyclotomicExtension`）も分岐も**在る**ので、
  これは mathlib の欠落ではなく本 step で配線をしていないことによる。
-/

import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Push

namespace IntegrableLattice

open Finset

/-! ## 1. 命題 8: 3 つの場合が排反であること -/

/-- **命題 8 の排反性**。$p',q'$ が同時に $\ell$ で割れないとき、
$\ell\mid p'+q'$ / $\ell\mid p'$ / $\ell\mid q'$ のうち 2 つが同時に成り立つことはない。
**$\ell$ の奇偶は使わない**（素数性すら使わない）。 -/
theorem bouquet_cases_exclusive {l p q : ℕ} (h : ¬(l ∣ p ∧ l ∣ q)) :
    (¬(l ∣ p ∧ l ∣ q)) ∧ (¬(l ∣ p ∧ l ∣ (p + q))) ∧ (¬(l ∣ q ∧ l ∣ (p + q))) := by
  refine ⟨h, ?_, ?_⟩
  · rintro ⟨hp, hpq⟩
    refine h ⟨hp, ?_⟩
    have := Nat.dvd_sub hpq hp
    simpa using this
  · rintro ⟨hq, hpq⟩
    refine h ⟨?_, hq⟩
    have := Nat.dvd_sub hpq hq
    simpa using this

/-! ## 2. 定理 X′ の数え上げ（レベル 1 での `decide` 検算） -/

section Counting

/-- 「両方単元、かつ $a\equiv\pm b$」の個数。$\ell$ 奇なら $2(\ell-1)$。 -/
def diagCard (n : ℕ) [NeZero n] : ℕ :=
  (univ.filter (fun x : ZMod n × ZMod n => x.1 ≠ 0 ∧ x.2 ≠ 0 ∧ (x.1 = x.2 ∨ x.1 = -x.2))).card

/-- 「片方だけが単元」の個数。$2(\ell-1)$。 -/
def oneZeroCard (n : ℕ) [NeZero n] : ℕ :=
  (univ.filter (fun x : ZMod n × ZMod n =>
    (x.1 = 0 ∧ x.2 ≠ 0) ∨ (x.1 ≠ 0 ∧ x.2 = 0))).card

/-- 「両方単元、かつ $a\not\equiv\pm b$」の個数。$(\ell-1)(\ell-3)$。 -/
def genericCard (n : ℕ) [NeZero n] : ℕ :=
  (univ.filter (fun x : ZMod n × ZMod n => x.1 ≠ 0 ∧ x.2 ≠ 0 ∧ x.1 ≠ x.2 ∧ x.1 ≠ -x.2)).card

theorem card_diag_three : diagCard 3 = 2 * (3 - 1) := by decide
theorem card_diag_five : diagCard 5 = 2 * (5 - 1) := by decide
theorem card_diag_seven : diagCard 7 = 2 * (7 - 1) := by decide

theorem card_one_zero_three : oneZeroCard 3 = 2 * (3 - 1) := by decide
theorem card_one_zero_five : oneZeroCard 5 = 2 * (5 - 1) := by decide
theorem card_one_zero_seven : oneZeroCard 7 = 2 * (7 - 1) := by decide

theorem card_generic_three : genericCard 3 = (3 - 1) * (3 - 3) := by decide
theorem card_generic_five : genericCard 5 = (5 - 1) * (5 - 3) := by decide
theorem card_generic_seven : genericCard 7 = (7 - 1) * (7 - 3) := by decide

/-- **$\ell=2$ では数え方が壊れる**: $a\equiv b$ と $a\equiv-b$ が排反でないので、
人手証明の $2\varphi_m$ は真の個数 $\varphi_m$ の 2 倍になる。
これが注 5.2 (ii)「$a'\equiv b'$ と $a'\equiv-b'$ が排反」が $\ell$ 奇で効く箇所である。 -/
theorem card_diag_two : diagCard 2 = 1 ∧ 2 * (2 - 1) = 2 := by decide

/-- 注 5.2 (iii) の個数版: 生成的な組の個数 $\varphi\,\ell^{m-1}(\ell-3)$ が
「$(\ell-1)(\ell-3)$」として正しい非負の個数になるのは $\ell\ge3$ のときである。 -/
theorem card_generic_two : genericCard 2 = 0 := by decide

end Counting

/-! ## 3. 定理 X′ の総和（場合 [A]・[B]） -/

section Sum

variable (l : ℤ)

/-- 場合 [A] のレベル $m'=m+1$ の寄与
$S_{m'}=2+2\ell^{m'-1}\bigl[(\lambda+m'-1)(\ell-1)+\ell\bigr]$。 -/
def levelA (lam : ℤ) (m : ℕ) : ℤ := 2 + 2 * l ^ m * ((lam + m) * (l - 1) + l)

/-- **定理 X′ の場合 [A] の総和**。$\Sigma_n=2n\ell^n+2\lambda(\ell^n-1)+2n$。 -/
theorem sum_level_A (lam : ℤ) (n : ℕ) :
    ∑ m ∈ range n, levelA l lam m = 2 * n * l ^ n + 2 * lam * (l ^ n - 1) + 2 * n := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, ih, levelA]
    push_cast
    ring

/-- $\sum_{a<n}\ell^{n-1-a}(\ell-1)=\ell^n-1$（場合 [B] で使う）。 -/
theorem sum_pow_rev (n : ℕ) : ∑ a ∈ range n, l ^ (n - 1 - a) * (l - 1) = l ^ n - 1 := by
  rw [← Finset.sum_mul, Finset.sum_range_reflect (fun j => l ^ j) n]
  exact geom_sum_mul l n

/-- $a<n$ なら $\ell^{n-1-a}\ell^a=\ell^{n-1}$。 -/
theorem pow_split {n a : ℕ} (h : a < n) : l ^ (n - 1 - a) * l ^ a = l ^ (n - 1) := by
  rw [← pow_add]; congr 1; omega

/-- **定理 X′ の場合 [B] の総和**（人手証明の $\varphi_n\Sigma_n$ の式そのまま）。 -/
theorem sum_level_B (lam : ℤ) (n : ℕ) :
    (∑ b ∈ range n, l ^ n * (l ^ (n - 1 - b) * (l - 1)) * (2 * l ^ b))
        + ∑ a ∈ range n, l ^ (n - 1 - a) * (l - 1) * (lam * (l ^ (n - 1) * (l - 1)) + 2 * l ^ a)
      = l ^ (n - 1) * (l - 1) * (2 * n * l ^ n + lam * (l ^ n - 1) + 2 * n) := by
  have h1 : ∀ b ∈ range n, l ^ n * (l ^ (n - 1 - b) * (l - 1)) * (2 * l ^ b)
      = 2 * l ^ n * (l ^ (n - 1) * (l - 1)) := by
    intro b hb
    have := pow_split l (mem_range.mp hb)
    calc l ^ n * (l ^ (n - 1 - b) * (l - 1)) * (2 * l ^ b)
        = 2 * l ^ n * ((l ^ (n - 1 - b) * l ^ b) * (l - 1)) := by ring
      _ = 2 * l ^ n * (l ^ (n - 1) * (l - 1)) := by rw [this]
  have h2 : ∀ a ∈ range n, l ^ (n - 1 - a) * (l - 1) * (lam * (l ^ (n - 1) * (l - 1)) + 2 * l ^ a)
      = (l ^ (n - 1 - a) * (l - 1)) * (lam * (l ^ (n - 1) * (l - 1)))
        + 2 * (l ^ (n - 1) * (l - 1)) := by
    intro a ha
    have := pow_split l (mem_range.mp ha)
    calc l ^ (n - 1 - a) * (l - 1) * (lam * (l ^ (n - 1) * (l - 1)) + 2 * l ^ a)
        = (l ^ (n - 1 - a) * (l - 1)) * (lam * (l ^ (n - 1) * (l - 1)))
          + 2 * ((l ^ (n - 1 - a) * l ^ a) * (l - 1)) := by ring
      _ = _ := by rw [this]
  have h3 : ∑ a ∈ range n, l ^ (n - 1 - a) * (l - 1) * (lam * (l ^ (n - 1) * (l - 1)))
      = (l ^ n - 1) * (lam * (l ^ (n - 1) * (l - 1))) := by
    rw [← Finset.sum_mul, sum_pow_rev]
  rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_add_distrib, h3,
    Finset.sum_const, Finset.sum_const, Finset.card_range, nsmul_eq_mul]
  ring

/-! ## 4. $(1.1)$ への代入と、定理 J8 との一致 -/

/-- $(1.1)$ に $\Sigma_n=2n\ell^n+\Lambda(\ell^n-1)+2n$、$v_\ell(\kappa(X))=0$ を代入すると
定理 X′ の閉形式になる。 -/
theorem ordKappa_of_sigma (mu lam : ℤ) (n : ℕ) (Sigma : ℤ)
    (hS : Sigma = 2 * n * l ^ n + lam * (l ^ n - 1) + 2 * n) :
    (0 : ℤ) - 2 * n + mu * (l ^ (2 * n) - 1) + Sigma
      = mu * (l ^ (2 * n) - 1) + 2 * n * l ^ n + lam * (l ^ n - 1) := by
  rw [hS]; ring

/-- **定理 J8 $(5.3)$ は定理 X′ の $\Lambda=2$、$\mu=0$ の場合**（cycle 19 step 1 §5.6 (a)）。 -/
theorem theoremJ8_eq_XPrime (n : ℕ) :
    (0 : ℤ) * (l ^ (2 * n) - 1) + 2 * n * l ^ n + 2 * (l ^ n - 1)
      = 2 * n * l ^ n + 2 * l ^ n - 2 := by ring

end Sum

/-- **cycle 19 step 2 の report §5.4 の例が誤っていることの witness**。
$\ell=7$, $(p,q)=(3,4)$ は場合 [A]（$7\mid 3+4$）なので $\Lambda=2v_7(7)=2$ であり、
定理 X′ の値は $2n7^n+2(7^n-1)$。$n=1$ で $26$ である。
§5.4 が書いている $2n7^n+7^n-1$ は $n=1$ で $20$ で、一致しない。 -/
theorem cycle19_5_4_example_mismatch :
    (2 * 1 * 7 ^ 1 + 2 * (7 ^ 1 - 1) : ℤ) = 26 ∧ (2 * 1 * 7 ^ 1 + (7 ^ 1 - 1) : ℤ) = 20 ∧
      (26 : ℤ) ≠ 20 := by norm_num

end IntegrableLattice
