/-
# 命題 W*（$w^*$ の代数的閉形式。トレース双対と微分）

対応する人手証明:

* 本文ブロック `paper_wstar_different`（`structured-latex/content/004_lambda_finite.ts`）
* 数値検証: `sagemath/check/cycle19_T3_trace_period`

## このファイルが担当する範囲（正直な範囲宣言）

命題 W* は **3 つの段**からできている。

1. **微分の段**: $\chi=\prod_i f_i^{a_i}$、$\rho=\mathrm{rad}(\chi)$、$h=\chi/\rho$ のとき
   $\chi'/h=\sum_i a_i f_i'\,(\rho/f_i)$ であり、とくに $\chi'/h\in\mathbb{Z}[x]$。
2. **双対の段**: $\rho$ が分離的なら $A^\vee=\rho'(\theta)^{-1}A$（Euler の双対基底公式）、
   したがって $\operatorname{coker}(G)\cong A/\eta A$ で、$G$ の単因子は $A/\eta A$ の不変量に等しい。
3. **付値の段**: $A$ が $p$ 極大なら $p^j\eta^{-1}\in A_{(p)}$ は各 $\mathfrak p\mid p$ で
   $j\,e_\mathfrak p\ge v_\mathfrak p(\eta)$ と同値で、最小の $j$ は
   $\max_\mathfrak p\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$ である。

**本ファイルが形式化するのは 1 と 3 である。2 は形式化していない。**
2 が残る理由は `PropCTracePeriod.lean` が既に一次情報で特定している——mathlib には
`Mathlib/RingTheory/DedekindDomain/Different.lean` に `traceDual`・`differentIdeal`・
`aeval_derivative_mem_differentIdeal` が**在る**が、これらを「重み付きトレース形式の Gram 行列の
最大単因子」へ結ぶ配線が無く、整数行列の Smith 標準形も
（`Basis.SmithNormalForm` は部分加群の基底の形であって行列の単因子の形ではない）無い。
**「難しそう」ではなく、どこで詰まるかを名指ししてある。**

## 形式化して分かったこと（本文との差）

* **微分の段に既約性も相異性も要らない。** 本文は $\chi=\prod_i f_i^{a_i}$ を
  「$f_i$ は $\chi$ の相異なる既約因子」として導入するが、
  $\chi'=h\cdot\sum_i a_i f_i'(\rho/f_i)$ という恒等式そのものは**任意の可換環の任意の族**で成り立つ。
  効いているのは $a_i\ge1$ だけである（`derivative_prod_pow`）。
  既約性・相異性が要るのは $\rho=\mathrm{rad}(\chi)$ と名乗る段と $\rho$ の分離性であって、
  恒等式の段ではない。**仮定は主張が要求したものではなく、文脈が要求したものである**
  （cycle 27 step 2 が `PropC.lean` の持ち上げ補題で見たのと同じ形）。
* **本文の「この式の切り上げは実数の切り上げではない」は、型でそのまま言える。**
  本ファイルの $w^*$ は $\mathbb{N}$ の元で、$\lceil\cdot\rceil$ は $\mathbb{N}$ の除算ひとつである
  （`ceilDivNat`）。$\mathbb{R}$ も $\mathbb{Q}$ も 1 度も現れない。

**新規性は主張しない**（Euler の双対基底公式・差積・切り上げ除算はいずれも古典）。
-/
import Mathlib

namespace IntegrableLattice

open Finset Polynomial

/-! ## 微分の段: $\chi'/h=\sum_i a_i f_i'(\rho/f_i)$

人手証明の第 1 段（「$\chi=\prod_i f_i^{a_i}$ のとき $\chi'/h=\sum_i a_i f_i'\rho/f_i$ なので
$\chi'/h\in\mathbb{Z}[x]$」）。割り算の形ではなく**積の形**で述べる——
$\chi'=h\cdot(\text{多項式})$ と書ければ「$\chi'/h$ が多項式である」は言えており、
商体へ出る必要が無いからである。 -/

section Derivative

variable {R : Type*} [CommRing R] {ι : Type*} [DecidableEq ι]

/-- **微分の段**（本文の $\chi'/h=\sum_i a_i f_i'\,(\rho/f_i)$）。

$\chi=\prod_{i\in s} f_i^{a_i}$、$h=\prod_{i\in s} f_i^{a_i-1}$ とすると
$$\chi' = h\cdot\sum_{i\in s} a_i\,f_i'\prod_{j\in s\setminus\{i\}} f_j .$$
右辺の $\prod_{j\ne i} f_j$ が本文の $\rho/f_i$ にあたる。

**$f_i$ の既約性も相異性も使わない。** 使うのは $a_i\ge1$ だけである。 -/
theorem derivative_prod_pow (s : Finset ι) (f : ι → R[X]) (a : ι → ℕ)
    (ha : ∀ i ∈ s, 1 ≤ a i) :
    Polynomial.derivative (∏ i ∈ s, f i ^ a i)
      = (∏ i ∈ s, f i ^ (a i - 1))
        * ∑ i ∈ s, Polynomial.C (a i : R) * Polynomial.derivative (f i)
            * ∏ j ∈ s.erase i, f j := by
  classical
  revert ha
  induction s using Finset.induction with
  | empty => simp
  | insert x t hx ih =>
      intro ha
      have hax : 1 ≤ a x := ha x (Finset.mem_insert_self x t)
      have ha' : ∀ i ∈ t, 1 ≤ a i := fun i hi => ha i (Finset.mem_insert_of_mem hi)
      -- $\prod_{i\in t} f_i^{a_i} = (\prod_{i\in t} f_i^{a_i-1})\cdot\prod_{i\in t} f_i$
      have hsplit : (∏ i ∈ t, f i ^ a i)
          = (∏ i ∈ t, f i ^ (a i - 1)) * ∏ i ∈ t, f i := by
        rw [← Finset.prod_mul_distrib]
        refine Finset.prod_congr rfl fun i hi => ?_
        have hi' : a i - 1 + 1 = a i := by have := ha' i hi; omega
        rw [← pow_succ, hi']
      have hax' : a x - 1 + 1 = a x := by omega
      have hxpow : f x ^ (a x - 1) * f x = f x ^ a x := by
        rw [← pow_succ, hax']
      -- 新しく入った添字 `x` を除いた積は `t` 上の積そのもの
      have herase : (insert x t).erase x = t := Finset.erase_insert hx
      -- `t` の添字 `i` については、`x` が積の外へ出る
      have hsum : ∑ i ∈ t, Polynomial.C (a i : R) * Polynomial.derivative (f i)
            * ∏ j ∈ (insert x t).erase i, f j
          = f x * ∑ i ∈ t, Polynomial.C (a i : R) * Polynomial.derivative (f i)
            * ∏ j ∈ t.erase i, f j := by
        rw [Finset.mul_sum]
        refine Finset.sum_congr rfl fun i hi => ?_
        have hne : x ≠ i := by rintro rfl; exact hx hi
        rw [Finset.erase_insert_of_ne hne,
          Finset.prod_insert (fun h => hx (Finset.mem_of_mem_erase h))]
        ring
      rw [Finset.prod_insert hx, Finset.prod_insert hx, Finset.sum_insert hx,
        Polynomial.derivative_mul, Polynomial.derivative_pow, ih ha', herase, hsum,
        hsplit, ← hxpow]
      ring

end Derivative

/-! ## 付値の段: $\min\{j:\forall\mathfrak p,\ j\,e_\mathfrak p\ge v_\mathfrak p\}
      =\max_\mathfrak p\lceil v_\mathfrak p/e_\mathfrak p\rceil$

人手証明の第 3 段。本文が「この式の切り上げは実数の切り上げではない。整数の除算ひとつで決まる」と
書いている当の主張を、$\mathbb{N}$ の中だけで述べる。 -/

section Ceil

/-- 自然数の切り上げ除算 $\lceil v/e\rceil$。本文の $\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$。
実数の切り上げではなく**整数の除算ひとつ**である（本文の但し書きがこの定義に対応する）。 -/
def ceilDivNat (v e : ℕ) : ℕ := (v + e - 1) / e

/-- 切り上げ除算の特徴づけ: $e\ge1$ なら $\lceil v/e\rceil\le j\iff v\le j\,e$。
本文の「$p^j\eta^{-1}\in A_{(p)}$ は各 $\mathfrak p$ で $j\,e_\mathfrak p\ge v_\mathfrak p(\eta)$」と
「最小の $j$ は切り上げ」を結ぶ一点。 -/
theorem ceilDivNat_le_iff {v e j : ℕ} (he : 1 ≤ e) : ceilDivNat v e ≤ j ↔ v ≤ j * e := by
  unfold ceilDivNat
  rw [← Nat.lt_succ_iff, Nat.div_lt_iff_lt_mul he]
  have hexp : Nat.succ j * e = j * e + e := Nat.succ_mul j e
  omega

end Ceil

section WStar

variable {ι : Type*}

/-- **付値の段**（本文の
$w^*=\max_{\mathfrak p\mid p}\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$）。

$\mathfrak p\mid p$ を走る有限集合 `s` の上で、各 $\mathfrak p$ に付値 `v 𝔭` と分岐指数 `e 𝔭 ≥ 1` が
与えられているとする。このとき
$$\min\{\,j\ :\ \forall\mathfrak p\in s,\ v_\mathfrak p\le j\,e_\mathfrak p\,\}
  =\max_{\mathfrak p\in s}\Bigl\lceil \frac{v_\mathfrak p}{e_\mathfrak p}\Bigr\rceil .$$
左辺が本文の $w^*=\min\{j\ge0:p^j\eta^{-1}\in A_{(p)}\}$（$p$ 極大の下での同値を経た形）、
右辺が主張の閉形式である。 -/
theorem isLeast_wStar (s : Finset ι) (v e : ι → ℕ) (he : ∀ i ∈ s, 1 ≤ e i) :
    IsLeast {j : ℕ | ∀ i ∈ s, v i ≤ j * e i}
      (s.sup fun i => ceilDivNat (v i) (e i)) := by
  constructor
  · intro i hi
    exact (ceilDivNat_le_iff (he i hi)).mp (Finset.le_sup (f := fun i => ceilDivNat (v i) (e i)) hi)
  · intro j hj
    refine Finset.sup_le fun i hi => ?_
    exact (ceilDivNat_le_iff (he i hi)).mpr (hj i hi)

/-- **不分岐で $p\nmid a$ なら $w^*=0$**（本文の最後の但し書き）。

本文の $v_\mathfrak p(\eta)=e_\mathfrak p v_p(a)+d_\mathfrak p$ に、不分岐（$e_\mathfrak p=1$、
差積指数 $d_\mathfrak p=0$）と $p\nmid a$（$v_p(a)=0$）を入れると $w^*=0$ になる。
`PropCTracePeriod.lean` の $w^*=0$ の特徴づけと一致する。 -/
theorem wStar_eq_zero_of_unramified (s : Finset ι) (v e : ι → ℕ)
    (hv : ∀ i ∈ s, v i = 0) :
    (s.sup fun i => ceilDivNat (v i) (e i)) = 0 := by
  refine Nat.le_zero.mp (Finset.sup_le fun i hi => ?_)
  unfold ceilDivNat
  rw [hv i hi]
  rcases Nat.eq_zero_or_pos (e i) with h | h
  · simp [h]
  · exact Nat.le_of_eq (Nat.div_eq_of_lt (by omega))

/-- **従順分岐なら $w^*\le v_p(a)+1$**（本文の但し書き）。

$v_\mathfrak p(\eta)=e_\mathfrak p\,\mathrm{vpa}+d_\mathfrak p$ で従順分岐
（$d_\mathfrak p<e_\mathfrak p$、すなわち $\lceil d_\mathfrak p/e_\mathfrak p\rceil\le1$）なら
$\lceil v_\mathfrak p/e_\mathfrak p\rceil\le \mathrm{vpa}+1$ である。 -/
theorem wStar_le_of_tame (s : Finset ι) (e d : ι → ℕ) (vpa : ℕ)
    (he : ∀ i ∈ s, 1 ≤ e i) (hd : ∀ i ∈ s, d i < e i) :
    (s.sup fun i => ceilDivNat (e i * vpa + d i) (e i)) ≤ vpa + 1 := by
  refine Finset.sup_le fun i hi => ?_
  refine (ceilDivNat_le_iff (he i hi)).mpr ?_
  have := hd i hi
  calc e i * vpa + d i ≤ e i * vpa + e i := by omega
    _ = (vpa + 1) * e i := by ring

end WStar

end IntegrableLattice
