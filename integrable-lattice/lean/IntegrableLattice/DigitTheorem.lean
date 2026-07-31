/-
# 定理 J2（桁定理）と命題 J2′（閾値の鋭さ） — cycle 19 step 1

対応する人手証明:

* 本文ブロック `paper_prop_J` (J1)(J1′)（`structured-latex/content/008_theta_padic.ts`）
* 根拠 report: `outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md` §2.2（定理 J2）・§2.3（命題 J2′）

## 目的

**証明の正しさではなく、主張の検算**である（cycle 17 の命題 B、cycle 18 の命題 N・W、
cycle 19 の命題 C′ と同じ趣旨）。桁定理の主張が Lean の型で一意に読めるか、
仮定が過不足ないかを確かめる。

## 記号（人手証明との対応）

人手証明の $\bar A_m(a,b)=\sum_{(p,q)}\bar c_{pq}\binom{pa+qb}{m}\in\mathbb{F}_\ell$ を
`Abar S c m a b` として、**係数 $\bar c_{pq}$ と台 $S$ を任意に取れる形**で定義する。
人手証明では $\bar c_{pq}$ は voltage ラプラシアンの行列式 $\tilde E$ の係数だが、
定理 J2 の証明が $\tilde E$ について使っているのは
「$A_1$ が恒等的に $0$」（cycle 18 補題 A2 (1)）だけである。
**その 1 点だけを仮定に出す**ことで、何が効いているかが型に出る。

## 形式化した主張

* `choose_cast_of_lt` — $m<\ell^L$ なら $\binom Nm\bmod\ell$ は $N\bmod\ell^L$ だけの関数
  （補題 J0。mathlib の Lucas の定理 `Choose.choose_modEq_choose_mul_prod_range_choose` から）。
* `choose_cast_pow` — $\binom{N}{\ell^L}\equiv N/\ell^L$（第 $L$ 桁が裸で出る段）。
* `choose_cast_pow_succ` — $\binom{N}{\ell^L+1}\equiv(N/\ell^L)\cdot(N\bmod\ell)$（閾値を 1 つ超えた段）。
* `Abar_shift` — **定理 J2 本体**。$0\le m\le\ell^L$ なら
  $\bar A_m(a+\ell^Lu,\ b+\ell^Lv)=\bar A_m(a,b)$。
* `Abar_mod` / `Abar_congr` — その言い換え（$\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数）。
* `Abar_shift_pow_succ` — **命題 J2′ の等式本体**。$m=\ell^L+1$ での差はちょうど $\bar B$ であり、
  右辺に $L$ が現れない（人手証明の「$L$ に依らない」がそのまま型に出る）。
* `Bbar_diag` — $\bar B(x,x)=2\bar A_2(x)$（$\bar B$ が $\bar A_2$ の極形式であること）。
* `cexDigit_fails` — **$A_1\equiv0$ を落とすと定理 J2 が偽になる反例**（下記 2.）。

## 形式化で分かったこと（本文との食い違い・暗黙の仮定）

1. **食い違いは無い。** 桁定理・閾値の鋭さの等式は、いずれも人手証明の通りに通った。
2. **暗黙の仮定を 1 件検出**: 本文 `paper_prop_J` の (J1) は
   「$0\le m\le\ell^L$ なる $m$ について $A_m\bmod\ell$ は $(a,b)\bmod\ell^L$ だけの関数」と
   述べるだけで、**$A_1\equiv0$ を仮定として書いていない**。
   しかし $m=\ell^L$ の段はこの仮定なしでは**偽**である
   （`cexDigit_fails`: $\ell=3$, $\tilde E=z$, $L=1$ で $\bar A_3(3,0)=1\neq0=\bar A_3(0,0)$）。
   $m<\ell^L$ の段（`Abar_shift_lt`）は仮定なしで成り立つので、
   **効いているのは閾値 $m=\ell^L$ ちょうどの 1 点だけ**である。
   $A_1\equiv0$ 自体は本文では `paper_prop_G` の (G6) に書かれており、
   (J1) はそれを暗黙に引き継いでいる。根拠 report 側（§2.2 の証明）は
   cycle 18 補題 A2 (1) を明示的に引いているので、**report は正しく、本文の (J1) が
   仮定を落としている**。
3. `Abar_shift_pow_succ`（命題 J2′）は $\bar A_1\equiv0$ を**使わない**。
   人手証明も使っていないが、そのことは §2.3 の書き方からは読み取りにくい。

## 形式化しなかったもの

* 命題 J2′ の「$\ell$ 奇なら 破れる $\iff k=2$」「$\ell=2$ なら $\iff\bar A_2$ が平方でない」の部分。
  前者は「標数 $\neq2$ で二次形式は極形式から復元できる」、後者は
  $\mathbb{F}_2[T,S]$ の Frobenius の像の判定で、いずれも 2 変数多項式としての
  $\bar A_2$ の扱い（$k=\mathrm{ord}(\bar g)$ との接続）が要る。
  本ファイルは $\bar A_m$ を**点ごとの値**として扱っているので、そこへは接続していない。
  これは mathlib の欠落ではなく、本 step で配線をしていないことによる。
-/

import Mathlib.Data.Nat.Choose.Lucas
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace IntegrableLattice

open Finset

/-! ## 1. 二項係数の桁ごとの記述（Lucas の定理から） -/

section Choose

variable {ℓ : ℕ} [Fact ℓ.Prime]

omit [Fact ℓ.Prime] in
/-- $i<L$ なら、$N$ の第 $i$ 桁は $N\bmod\ell^L$ だけで決まる。 -/
theorem digit_mod_pow {i L : ℕ} (N : ℕ) (hi : i < L) :
    N % ℓ ^ L / ℓ ^ i % ℓ = N / ℓ ^ i % ℓ := by
  obtain ⟨j, rfl⟩ : ∃ j, L = i + (j + 1) := ⟨L - i - 1, by omega⟩
  rw [pow_add, Nat.mod_mul_right_div_self]
  exact Nat.mod_mod_of_dvd _ (dvd_pow_self ℓ (Nat.succ_ne_zero j))

/-- Lucas の定理（mathlib `Choose.choose_modEq_choose_mul_prod_range_choose`）の、
本ファイルで使う形（$\mathbb{Z}/\ell$ の等式として）。 -/
theorem choose_cast_eq_prod (N m L : ℕ) :
    ((N.choose m : ℕ) : ZMod ℓ)
      = (((N / ℓ ^ L).choose (m / ℓ ^ L) : ℕ) : ZMod ℓ)
        * ∏ i ∈ range L, (((N / ℓ ^ i % ℓ).choose (m / ℓ ^ i % ℓ) : ℕ) : ZMod ℓ) := by
  have h := Choose.choose_modEq_choose_mul_prod_range_choose (p := ℓ) (n := N) (k := m) L
  have h' : ((N.choose m : ℤ) : ZMod ℓ)
      = ((((N / ℓ ^ L).choose (m / ℓ ^ L) : ℤ)
          * ∏ i ∈ range L, ((N / ℓ ^ i % ℓ).choose (m / ℓ ^ i % ℓ) : ℤ) : ℤ) : ZMod ℓ) := by
    rw [ZMod.intCast_eq_intCast_iff]
    exact_mod_cast h
  push_cast at h'
  exact_mod_cast h'

/-- **補題 J0**: $m<\ell^L$ なら $\binom Nm\bmod\ell$ は $N\bmod\ell^L$ だけの関数。 -/
theorem choose_cast_of_lt {L m : ℕ} (N : ℕ) (hm : m < ℓ ^ L) :
    ((N.choose m : ℕ) : ZMod ℓ) = (((N % ℓ ^ L).choose m : ℕ) : ZMod ℓ) := by
  rw [choose_cast_eq_prod N m L, choose_cast_eq_prod (N % ℓ ^ L) m L, Nat.div_eq_of_lt hm]
  simp only [Nat.choose_zero_right, Nat.cast_one, one_mul]
  refine Finset.prod_congr rfl fun i hi => ?_
  rw [digit_mod_pow N (mem_range.mp hi)]

/-- $\binom{N}{\ell^L}\equiv N/\ell^L\pmod\ell$。第 $L$ 桁が裸で出る段。 -/
theorem choose_cast_pow (N L : ℕ) :
    ((N.choose (ℓ ^ L) : ℕ) : ZMod ℓ) = ((N / ℓ ^ L : ℕ) : ZMod ℓ) := by
  have hp : 0 < ℓ := (Fact.out (p := ℓ.Prime)).pos
  rw [choose_cast_eq_prod N (ℓ ^ L) L, Nat.div_self (pow_pos hp L)]
  have hone : ∀ i ∈ range L,
      ((((N / ℓ ^ i % ℓ).choose (ℓ ^ L / ℓ ^ i % ℓ)) : ℕ) : ZMod ℓ) = 1 := by
    intro i hi
    have hiL : i < L := mem_range.mp hi
    obtain ⟨j, hj⟩ : ∃ j, L = i + (j + 1) := ⟨L - i - 1, by omega⟩
    subst hj
    rw [pow_add, Nat.mul_div_cancel_left _ (pow_pos hp i), pow_succ']
    simp [Nat.mul_mod_right]
  rw [Finset.prod_congr rfl hone]
  simp

/-- $\binom{N}{\ell^L+1}\equiv(N/\ell^L)\cdot(N\bmod\ell)\pmod\ell$（$L\ge1$）。 -/
theorem choose_cast_pow_succ (N : ℕ) {L : ℕ} (hL : 1 ≤ L) :
    ((N.choose (ℓ ^ L + 1) : ℕ) : ZMod ℓ)
      = ((N / ℓ ^ L : ℕ) : ZMod ℓ) * ((N % ℓ : ℕ) : ZMod ℓ) := by
  have hp : 1 < ℓ := (Fact.out (p := ℓ.Prime)).one_lt
  have hpow : 1 < ℓ ^ L := Nat.one_lt_pow (by omega) hp
  have hdiv : (ℓ ^ L + 1) / ℓ ^ L = 1 := by
    rw [Nat.add_div_left _ (by omega : 0 < ℓ ^ L), Nat.div_eq_of_lt hpow]
  rw [choose_cast_eq_prod N (ℓ ^ L + 1) L, hdiv, Nat.choose_one_right]
  have hzero : ∀ i ∈ (range L).erase 0,
      ((((N / ℓ ^ i % ℓ).choose ((ℓ ^ L + 1) / ℓ ^ i % ℓ)) : ℕ) : ZMod ℓ) = 1 := by
    intro i hi
    have hi0 : i ≠ 0 := ne_of_mem_erase hi
    have hiL : i < L := mem_range.mp (mem_of_mem_erase hi)
    have hpi : 0 < ℓ ^ i := pow_pos (by omega : 0 < ℓ) i
    have h1 : (ℓ ^ L + 1) / ℓ ^ i = ℓ ^ (L - i) := by
      have he : ℓ ^ L + 1 = ℓ ^ i * ℓ ^ (L - i) + 1 := by
        rw [← pow_add]; congr 2; omega
      rw [he, Nat.mul_add_div hpi, Nat.div_eq_of_lt (Nat.one_lt_pow hi0 hp), Nat.add_zero]
    have h2 : ℓ ^ (L - i) % ℓ = 0 := by
      obtain ⟨j, hj⟩ : ∃ j, L - i = j + 1 := ⟨L - i - 1, by omega⟩
      rw [hj, pow_succ']
      exact Nat.mul_mod_right _ _
    rw [h1, h2]
    simp
  have hL0 : (0 : ℕ) ∈ range L := mem_range.mpr (by omega)
  have hm1 : (ℓ ^ L + 1) % ℓ = 1 := by
    obtain ⟨j, hj⟩ : ∃ j, L = j + 1 := ⟨L - 1, by omega⟩
    subst hj
    rw [pow_succ', Nat.mul_add_mod, Nat.mod_eq_of_lt hp]
  rw [← Finset.prod_erase_mul _ _ hL0, Finset.prod_congr rfl hzero]
  simp [hm1, ZMod.natCast_mod]

end Choose

/-! ## 2. 桁定理（定理 J2） -/

section Digit

variable {ℓ : ℕ} (S : Finset (ℕ × ℕ)) (c : ℕ × ℕ → ZMod ℓ)

/-- 人手証明の $\bar A_m(a,b)=\sum_{(p,q)}\bar c_{pq}\binom{pa+qb}{m}$。 -/
def Abar (m a b : ℕ) : ZMod ℓ :=
  ∑ pq ∈ S, c pq * ((Nat.choose (pq.1 * a + pq.2 * b) m : ℕ) : ZMod ℓ)

/-- 命題 J2′ に現れる双一次形式
$\bar B((a,b),(u,v))=\sum\bar c_{pq}\overline{(pa+qb)}\ \overline{(pu+qv)}$。 -/
def Bbar (a b u v : ℕ) : ZMod ℓ :=
  ∑ pq ∈ S, c pq * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) * ((pq.1 * u + pq.2 * v : ℕ) : ZMod ℓ)

variable {S c}

theorem Abar_one (a b : ℕ) :
    Abar S c 1 a b = ∑ pq ∈ S, c pq * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) := by
  simp [Abar]

variable [Fact ℓ.Prime]

/-- 定理 J2 の $m<\ell^L$ の段。**$\bar A_1\equiv0$ を使わない。** -/
theorem Abar_shift_lt {L m : ℕ} (hm : m < ℓ ^ L) (a b u v : ℕ) :
    Abar S c m (a + ℓ ^ L * u) (b + ℓ ^ L * v) = Abar S c m a b := by
  refine Finset.sum_congr rfl fun pq _ => ?_
  congr 1
  have key : pq.1 * (a + ℓ ^ L * u) + pq.2 * (b + ℓ ^ L * v)
      = (pq.1 * a + pq.2 * b) + ℓ ^ L * (pq.1 * u + pq.2 * v) := by ring
  rw [key, choose_cast_of_lt _ hm, choose_cast_of_lt (pq.1 * a + pq.2 * b) hm,
    Nat.add_mul_mod_self_left]

/-- **定理 J2（桁定理）**。$0\le m\le\ell^L$ ならば $\bar A_m$ は $(a,b)$ を
$\ell^L$ ずらしても変わらない。仮定は $\bar A_1\equiv0$ だけである。 -/
theorem Abar_shift (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) {L m : ℕ} (hm : m ≤ ℓ ^ L)
    (a b u v : ℕ) :
    Abar S c m (a + ℓ ^ L * u) (b + ℓ ^ L * v) = Abar S c m a b := by
  rcases lt_or_eq_of_le hm with h | h
  · exact Abar_shift_lt h a b u v
  · subst h
    have hpos : 0 < ℓ ^ L := pow_pos (Fact.out (p := ℓ.Prime)).pos L
    have expand : Abar S c (ℓ ^ L) (a + ℓ ^ L * u) (b + ℓ ^ L * v)
        = Abar S c (ℓ ^ L) a b + Abar S c 1 u v := by
      rw [Abar_one, Abar, Abar, ← Finset.sum_add_distrib]
      refine Finset.sum_congr rfl fun pq _ => ?_
      have key : pq.1 * (a + ℓ ^ L * u) + pq.2 * (b + ℓ ^ L * v)
          = (pq.1 * a + pq.2 * b) + ℓ ^ L * (pq.1 * u + pq.2 * v) := by ring
      rw [key, choose_cast_pow, choose_cast_pow, Nat.add_mul_div_left _ _ hpos]
      push_cast
      ring
    rw [expand, hA1, add_zero]

/-- 定理 J2 の言い換え: $\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数。 -/
theorem Abar_mod (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) {L m : ℕ} (hm : m ≤ ℓ ^ L) (a b : ℕ) :
    Abar S c m a b = Abar S c m (a % ℓ ^ L) (b % ℓ ^ L) := by
  conv_lhs => rw [← Nat.mod_add_div a (ℓ ^ L), ← Nat.mod_add_div b (ℓ ^ L)]
  exact Abar_shift hA1 hm _ _ _ _

theorem Abar_congr (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) {L m : ℕ} (hm : m ≤ ℓ ^ L)
    {a b a' b' : ℕ} (ha : a % ℓ ^ L = a' % ℓ ^ L) (hb : b % ℓ ^ L = b' % ℓ ^ L) :
    Abar S c m a b = Abar S c m a' b' := by
  rw [Abar_mod hA1 hm a b, Abar_mod hA1 hm a' b', ha, hb]

/-! ## 3. 命題 J2′（閾値の鋭さ）の等式本体 -/

/-- **命題 J2′**: $m=\ell^L+1$ での桁安定性の破れは、ちょうど双一次形式 $\bar B$ で与えられる。
右辺に $L$ が現れないことが「$L$ に依らない」の内容である。**$\bar A_1\equiv0$ は使わない。** -/
theorem Abar_shift_pow_succ {L : ℕ} (hL : 1 ≤ L) (a b u v : ℕ) :
    Abar S c (ℓ ^ L + 1) (a + ℓ ^ L * u) (b + ℓ ^ L * v) - Abar S c (ℓ ^ L + 1) a b
      = Bbar S c a b u v := by
  have hpos : 0 < ℓ ^ L := pow_pos (Fact.out (p := ℓ.Prime)).pos L
  obtain ⟨L', rfl⟩ : ∃ L', L = L' + 1 := ⟨L - 1, by omega⟩
  rw [Abar, Abar, Bbar, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun pq _ => ?_
  have key : pq.1 * (a + ℓ ^ (L' + 1) * u) + pq.2 * (b + ℓ ^ (L' + 1) * v)
      = (pq.1 * a + pq.2 * b) + ℓ ^ (L' + 1) * (pq.1 * u + pq.2 * v) := by ring
  rw [key, choose_cast_pow_succ _ hL, choose_cast_pow_succ _ hL,
    Nat.add_mul_div_left _ _ hpos]
  have hmod : ((pq.1 * a + pq.2 * b) + ℓ ^ (L' + 1) * (pq.1 * u + pq.2 * v)) % ℓ
      = (pq.1 * a + pq.2 * b) % ℓ := by
    have he : ℓ ^ (L' + 1) * (pq.1 * u + pq.2 * v) = (ℓ ^ L' * (pq.1 * u + pq.2 * v)) * ℓ := by
      ring
    rw [he, Nat.add_mul_mod_self_right]
  rw [hmod]
  push_cast [ZMod.natCast_mod]
  ring

omit [Fact ℓ.Prime] in
/-- $\bar B(x,x)=2\bar A_2(x)$（$\bar B$ が $\bar A_2$ の極形式であること）。 -/
theorem Bbar_diag (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) (a b : ℕ) :
    Bbar S c a b a b = 2 * Abar S c 2 a b := by
  have sq : ∀ n : ℕ, n * n = 2 * n.choose 2 + n := by
    intro n
    induction n with
    | zero => simp
    | succ k ih =>
      calc (k + 1) * (k + 1) = k * k + 2 * k + 1 := by ring
        _ = (2 * k.choose 2 + k) + 2 * k + 1 := by rw [ih]
        _ = 2 * (k.choose 1 + k.choose 2) + (k + 1) := by rw [Nat.choose_one_right]; ring
        _ = 2 * ((k + 1).choose 2) + (k + 1) := by rw [Nat.choose_succ_succ]
  have step : ∀ pq : ℕ × ℕ,
      c pq * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ)
        = 2 * (c pq * ((Nat.choose (pq.1 * a + pq.2 * b) 2 : ℕ) : ZMod ℓ))
          + c pq * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) := by
    intro pq
    set N := pq.1 * a + pq.2 * b with hNdef
    have h : ((N : ℕ) : ZMod ℓ) * ((N : ℕ) : ZMod ℓ)
        = 2 * ((Nat.choose N 2 : ℕ) : ZMod ℓ) + ((N : ℕ) : ZMod ℓ) := by
      have h0 := congrArg (fun n : ℕ => ((n : ZMod ℓ))) (sq N)
      push_cast at h0
      exact h0
    calc c pq * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ)
        = c pq * (((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ) * ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ)) := by
          ring
      _ = c pq * (2 * ((Nat.choose (pq.1 * a + pq.2 * b) 2 : ℕ) : ZMod ℓ)
            + ((pq.1 * a + pq.2 * b : ℕ) : ZMod ℓ)) := by rw [h]
      _ = _ := by ring
  have h1 : Abar S c 1 a b = 0 := hA1 a b
  rw [Abar_one] at h1
  rw [Bbar, Finset.sum_congr rfl (fun pq _ => step pq), Finset.sum_add_distrib, h1,
    ← Finset.mul_sum, Abar, add_zero]

end Digit

/-! ## 4. $\bar A_1\equiv0$ を落とすと定理 J2 は偽（暗黙の仮定の検出） -/

section Counterexample

/-- 単項式 $\tilde E=z$ に対応する台（$c_{(1,0)}=1$、他は $0$）。
これは voltage ラプラシアンの行列式ではないので $\bar A_1\equiv0$ を満たさない。 -/
def cexDigitS : Finset (ℕ × ℕ) := {(1, 0)}

/-- $\bar A_1\neq0$。 -/
theorem cexDigit_A1_ne_zero :
    Abar (ℓ := 3) cexDigitS (fun _ => 1) 1 1 0 ≠ 0 := by decide

/-- **$\bar A_1\equiv0$ を仮定しないと定理 J2 は $m=\ell^L$ で偽**（$\ell=3$, $L=1$, $m=3$）。 -/
theorem cexDigit_fails :
    Abar (ℓ := 3) cexDigitS (fun _ => 1) 3 (0 + 3 * 1) 0
      ≠ Abar (ℓ := 3) cexDigitS (fun _ => 1) 3 0 0 := by decide

/-- 一方 $m<\ell^L$ の段（`Abar_shift_lt`）は仮定なしで成り立っており、
実際この反例でも $m=2<3$ では一致する。 -/
theorem cexDigit_lt_holds :
    Abar (ℓ := 3) cexDigitS (fun _ => 1) 2 (0 + 3 * 1) 0
      = Abar (ℓ := 3) cexDigitS (fun _ => 1) 2 0 0 := by decide

end Counterexample

end IntegrableLattice
