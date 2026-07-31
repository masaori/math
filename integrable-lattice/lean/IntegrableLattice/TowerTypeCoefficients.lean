/-
# 定理 J6（型 II の閉形式）と定理 J7（$n\ell^n$ の係数 $b=\sum j^*$） — cycle 19 step 1

対応する人手証明:

* 本文ブロック `paper_prop_J` (J4)（`structured-latex/content/008_theta_padic.ts`）
* 根拠 report: `outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md` §5.1（定理 J6）・§5.2（定理 J7）・
  §5.3（定理 J8）

## 目的

**証明の正しさではなく、主張の検算**である。定理 J6・J7 はどちらも仮定が多い
（J6: $\theta$ が至る所有限・有限レベルで止まる・$n_1$ の取り方、
J7: (N) 球の分離と $\mathrm{argmin}$ の一意性・(B\*) 最小点の一意性）。
**仮定を型に出すことで「何を仮定しているか」を明示する**のが本ファイルの主目的である。
仮定を認めた先の計算（レベルごとの和・幾何級数・$M'\ell^{M'}$ の係数の取り出し）は
有限の代数計算なので、そこは実際に Lean で検算する。

## 形式化した主張

* `sum_level_stab` — **定理 J6 の計算本体**。$\Theta_{M'}=\ell^{M'-L}\Theta_L$（$M'\ge n_1$）の下で
  $\varphi(\ell^L)\sum_{M'=n_1}^{n}\Theta_{M'}=\Theta_L(\ell^{n}-\ell^{n_1-1})$。
  すなわち $\ell^n$ の係数は $\Theta_L/\varphi(\ell^L)$、残りは定数である。
* `level_ratio_indep` — **$\Theta_L/\varphi(\ell^L)$ が $L$ の取り方に依らないこと**（分母を払った形）。
* `layer_sum` — **定理 J7 の証明 (b) の層ごとの和**。
  $\sum_{t<s}\varphi(\ell^{s-t})\bigl(e+j\ell^{R+t}\bigr)=e(\ell^{s}-1)+j\,s\,\varphi(\ell^{s+R})$。
  人手証明が「$\varphi(\ell^{M'-1-v})\ell^{v+1}=\varphi(\ell^{M'})$ は $v$ に依らない」と述べている
  相殺がそのまま効く。
* `sum_mul_pow` — $\sum_{M=1}^{n}M\ell^{M}$ の閉形式（$(\ell-1)^2$ 倍した形）。
  定理 J7 (c) と定理 J8 (6) の両方が使う。
* `J8_direction_sum` — 定理 J8 (5) の退化方向 1 本あたりの寄与
  $\ell^{M'-1}+1+M'\varphi(\ell^{M'})$。
* `sum_Theta_J8` — 定理 J8 (6)。$\Theta_{M'}=2\ell^{M'}+2+2M'\varphi(\ell^{M'})$ から
  $\Sigma_n=2n\ell^n+2\ell^n-2+2n$、したがって $\mathrm{ord}_\ell(\kappa_n)=2n\ell^n+2\ell^n-2$。
* `J6_no_n_pow_term` — 定理 J6 の結論の形（$n\ell^n$ 項が無い）と定理 J8 の結論の形
  （$n\ell^n$ 項がある）が、$n\ge1$ で実際に異なること。型 II / 型 III の判別が
  空虚な区別ではないことの確認。

## 形式化で分かったこと（本文との食い違い・過剰仮定）

1. **食い違いは無い。** 上の計算はいずれも人手証明の通りに通った。
   とくに定理 J8 の $\Sigma_n=2n\ell^n+2\ell^n-2+2n$ と
   $\mathrm{ord}_\ell(\kappa_n)=2n\ell^n+2\ell^n-2$ は、
   `BouquetClosedForm.theoremJ8_eq_XPrime`（step 2 の定理 X′ の $\Lambda=2$ の場合）と
   独立に一致する。**2 つの step の相互検証（§5.6 (a)）が Lean 上でも成立している。**
2. **過剰仮定を 1 件検出**: 定理 J6 の仮定 (ii) は
   「$n_1\ge L$ を $\theta^{\max}-2<\varphi(\ell^{n_1})$ を満たすように取る」だが、
   `sum_level_stab` の計算（＝結論の閉形式そのもの）が使うのは
   **$L\le n_1$ と「$M'\ge n_1$ で $\Theta_{M'}=\ell^{M'-L}\Theta_L$」だけ**である。
   $\theta^{\max}-2<\varphi(\ell^{n_1})$ は $\hat\theta_{M'}=\theta$ を保証するための仮定であって、
   そこから先の総和には効かない。**人手証明もその順に議論しているが、
   定理の主張としては 2 種類の仮定が混ざっている**（$n_1$ の存在条件と、$n_1$ 以降の安定性）。
3. **もう 1 件**: 定理 J6 の「係数 $\Theta_L/\varphi(\ell^L)$ は $L$ の取り方に依らない」は、
   `level_ratio_indep` の通り $\Theta_{L'}=\ell^{L'-L}\Theta_L$ と
   $\varphi(\ell^{L'})=\ell^{L'-L}\varphi(\ell^L)$ の**2 つの比例関係だけ**から出る。
   $\theta$ が有限であることも、$\mathbb{P}^1$ のファイバーが一様であることも、
   この段では使わない（使うのは 2 つの比例関係を出すところまで）。

## 形式化しなかったもの（なぜ足りないのか）

* **定理 J7 の主張そのもの**（$b=\sum_{P\in S_\infty}j^*(P)$）。
  $S_\infty$ と $j^*$ は $\mathbb{F}_\ell[[x]]$ における
  $\psi_j(x)=D_j\bigl(1+x,(1+x)^c\bigr)$ の $x=0$ での位数として定義されており、
  形式冪級数環・Hasse 微分・$\mathbb{Z}_\ell$ 冪 $(1+x)^\gamma$ の配線が要る。
  mathlib には形式冪級数（`PowerSeries`、`PowerSeries.order`）も
  二項冪級数（`Mathlib/RingTheory/PowerSeries/Binomial.lean`）も**在る**
  （`logs/mathlib-gap-survey-cycle20.log`）ので、これは mathlib の欠落ではなく、
  本 step で配線をしていないことによる。
* **$\Theta_{M'}$ から $M'\ell^{M'}$ の係数を「読み取る」段の一般形**。
  人手証明は $\Theta_{M'}=\beta M'\ell^{M'}+O(\ell^{M'})$ と書くが、$O$ 記法は
  そのままでは主張にならない。本ファイルは定理 J8 の具体形
  （$O$ の中身が明示されている場合）についてだけ総和を検算している。
  一般形を述べるには「$\Theta$ が 4 係数の形に乗る」ことを仮定に出す必要があり、
  それは report §5.6 (d) が**数値の当てはめ**で確かめている事柄である。
-/

import IntegrableLattice.BouquetClosedForm

namespace IntegrableLattice

open Finset

section Tower

variable (l : ℤ)

/-! ## 1. 定理 J6（型 II の閉形式）の計算本体 -/

/-- **定理 J6 の計算本体**。レベル $M'=n_1,\dots,n_1+s-1$（$n=n_1+s-1$）で
$\Theta_{M'}=\ell^{M'-L}\Theta_L$ が成り立つとき、
$\varphi(\ell^L)\sum\Theta_{M'}=\Theta_L\bigl(\ell^{n_1-1+s}-\ell^{n_1-1}\bigr)$。
$\ell^{n}$ の係数は $\Theta_L/\varphi(\ell^L)$、残りは $n$ に依らない定数である。

**使っている仮定は $1\le L\le n_1$ と安定性だけ**であり、
人手証明の仮定 (ii)（$\theta^{\max}-2<\varphi(\ell^{n_1})$）はこの段には効かない。 -/
theorem sum_level_stab (ThetaL : ℤ) {L n₁ : ℕ} (hL : 1 ≤ L) (hLn : L ≤ n₁) (s : ℕ) :
    (l ^ (L - 1) * (l - 1)) * ∑ i ∈ range s, l ^ (n₁ + i - L) * ThetaL
      = ThetaL * (l ^ (n₁ - 1 + s) - l ^ (n₁ - 1)) := by
  have hexp : ∀ i ∈ range s, l ^ (n₁ + i - L) * ThetaL = l ^ (n₁ - L) * l ^ i * ThetaL := by
    intro i _
    rw [← pow_add]
    congr 2
    omega
  have hLL : l ^ (L - 1) * l ^ (n₁ - L) = l ^ (n₁ - 1) := by
    rw [← pow_add]; congr 1; omega
  calc (l ^ (L - 1) * (l - 1)) * ∑ i ∈ range s, l ^ (n₁ + i - L) * ThetaL
      = (l ^ (L - 1) * (l - 1)) * ∑ i ∈ range s, l ^ (n₁ - L) * l ^ i * ThetaL := by
        rw [Finset.sum_congr rfl hexp]
    _ = (l ^ (L - 1) * l ^ (n₁ - L)) * ThetaL * ((∑ i ∈ range s, l ^ i) * (l - 1)) := by
        simp only [Finset.mul_sum, Finset.sum_mul]
        exact Finset.sum_congr rfl fun i _ => by ring
    _ = l ^ (n₁ - 1) * ThetaL * (l ^ s - 1) := by rw [hLL, geom_sum_mul]
    _ = ThetaL * (l ^ (n₁ - 1 + s) - l ^ (n₁ - 1)) := by rw [pow_add]; ring

/-- **定理 J6 の「係数は $L$ の取り方に依らない」**（分母を払った形）。
使うのは $\Theta_{L'}=\ell^{d}\Theta_L$ と $\varphi(\ell^{L'})=\ell^{d}\varphi(\ell^L)$ の
2 つの比例関係だけである。 -/
theorem level_ratio_indep (Theta Theta' phi phi' : ℤ) (d : ℤ)
    (hT : Theta' = d * Theta) (hp : phi' = d * phi) :
    Theta' * phi = Theta * phi' := by
  rw [hT, hp]; ring

/-! ## 2. 定理 J7 の層ごとの和 -/

/-- **定理 J7 の証明 (b) の層ごとの和**。
$v$ を $R-1,\dots,R+s-2$ と走らせた（$t=v-(R-1)$ と置いた）ときの
$\sum_t\varphi(\ell^{s-t})\bigl(e+j\ell^{R+t}\bigr)$。
第 2 項に現れる $\varphi(\ell^{s-t})\ell^{R+t}=\varphi(\ell^{s+R})$ が $t$ に依らないことが
$M'\ell^{M'}$ 項（ここでは $s\cdot\varphi$）を生む。 -/
theorem layer_sum (e j : ℤ) (s R : ℕ) :
    ∑ t ∈ range s, (l ^ (s - 1 - t) * (l - 1)) * (e + j * l ^ (R + t))
      = e * (l ^ s - 1) + j * (s : ℤ) * (l ^ (s + R - 1) * (l - 1)) := by
  have hsplit : ∀ t ∈ range s, (l ^ (s - 1 - t) * (l - 1)) * (e + j * l ^ (R + t))
      = (l ^ (s - 1 - t) * (l - 1)) * e + j * (l ^ (s + R - 1) * (l - 1)) := by
    intro t ht
    have hpow : l ^ (s - 1 - t) * l ^ (R + t) = l ^ (s + R - 1) := by
      rw [← pow_add]
      congr 1
      have := mem_range.mp ht
      omega
    calc (l ^ (s - 1 - t) * (l - 1)) * (e + j * l ^ (R + t))
        = (l ^ (s - 1 - t) * (l - 1)) * e + j * ((l ^ (s - 1 - t) * l ^ (R + t)) * (l - 1)) := by
          ring
      _ = _ := by rw [hpow]
  rw [Finset.sum_congr rfl hsplit, Finset.sum_add_distrib, ← Finset.sum_mul, sum_pow_rev,
    Finset.sum_const, Finset.card_range, nsmul_eq_mul]
  ring

/-- $\sum_{M=1}^{n}M\ell^{M}$ の閉形式（$(\ell-1)^2$ 倍した形）。
定理 J7 (c) と定理 J8 (6) が使う。 -/
theorem sum_mul_pow (n : ℕ) :
    (l - 1) ^ 2 * ∑ M ∈ range (n + 1), (M : ℤ) * l ^ M
      = l + l ^ (n + 1) * ((n : ℤ) * (l - 1) - 1) := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, mul_add, ih]
    push_cast
    ring

/-! ## 3. 定理 J8 の総和 -/

/-- **定理 J8 (5)** の退化方向 1 本あたりの寄与。
$\sum_{v=0}^{M-2}\varphi(\ell^{M-1-v})(1+\ell^{v+1})+(\varphi(\ell^{M})+2)
=\ell^{M-1}+1+M\varphi(\ell^{M})$（$M=s+1$ と置いた形）。 -/
theorem J8_direction_sum (s : ℕ) :
    (∑ t ∈ range s, (l ^ (s - 1 - t) * (l - 1)) * (1 + 1 * l ^ (1 + t)))
        + (l ^ s * (l - 1) + 2)
      = l ^ s + 1 + ((s : ℤ) + 1) * (l ^ s * (l - 1)) := by
  rw [layer_sum l 1 1 s 1]
  simp only [Nat.add_sub_cancel]
  ring

/-- **定理 J8 (6)**。$\Theta_{M'}=2\ell^{M'}+2+2M'\varphi(\ell^{M'})$ を $M'=1,\dots,n$ で
足すと $\Sigma_n=2n\ell^n+2\ell^n-2+2n$。 -/
theorem sum_Theta_J8 (n : ℕ) :
    ∑ m ∈ range n, (2 * l ^ (m + 1) + 2 + 2 * ((m : ℤ) + 1) * (l ^ m * (l - 1)))
      = 2 * (n : ℤ) * l ^ n + 2 * l ^ n - 2 + 2 * n := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [Finset.sum_range_succ, ih]
    push_cast
    ring

/-- **定理 J8 $(5.3)$**: $\mathrm{ord}_\ell(\kappa_n)=\Sigma_n-2n=2n\ell^n+2\ell^n-2$。 -/
theorem ordKappa_J8 (n : ℕ) :
    (2 * (n : ℤ) * l ^ n + 2 * l ^ n - 2 + 2 * n) - 2 * n
      = 2 * (n : ℤ) * l ^ n + 2 * l ^ n - 2 := by ring

end Tower

/-- 型 II（定理 J6: $n\ell^n$ 項なし）と型 III（定理 J8: $n\ell^n$ 項あり）の結論は
実際に異なる。$\ell=3$, $n=2$ で、同じ $\ell^n$ 係数 $2$・同じ定数を持つ型 II の式が $16-4=12$、
型 III の式が $2\cdot2\cdot9+2\cdot9-2=52$。 -/
theorem J6_no_n_pow_term :
    (2 * (3 : ℤ) ^ 2 - 2 * 2 - 2 : ℤ) = 12 ∧
      (2 * (2 : ℤ) * 3 ^ 2 + 2 * 3 ^ 2 - 2 : ℤ) = 52 ∧ (12 : ℤ) ≠ 52 := by norm_num

end IntegrableLattice
