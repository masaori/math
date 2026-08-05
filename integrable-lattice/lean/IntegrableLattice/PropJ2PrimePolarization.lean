/-
# 命題 J2′ の同値の代数の側（極形式で閉じる部分）— cycle 47 step 1 の次、cycle 47 step 3

対応する人手証明:

* 本文ブロック `paper_091_theorem_theta_padic`（命題 J）の (J2′)
  「$m=\ell^L+1$ で桁安定性が破れるのは、$\ell$ が奇なら $k=2$ のときに限り、
  $\ell=2$ なら $\bar A_2$ が平方でないときに限る」

## この step が何を埋めるか

cycle 46 step 4 の測定は、この項目を「半分は済み」と書いた——
**等式本体**（破れがちょうど双一次形式 $\bar B$ で与えられること）は cycle 19 の
`DigitTheorem.Abar_shift_pow_succ` に在り、**残っているのは同値の向きである。**

**その同値のうち、代数だけで閉じる側を書いた。そう書く**——
$\ell$ が奇のとき、**破れることと $\bar A_2\not\equiv0$ であることは同値**である
（`fails_iff_Abar_two_ne_zero`）。

**残るのは $\bar A_2\not\equiv0$ と $k=2$ を結ぶ側**であり、そこは点ごとの値として扱っている
$\bar A_2$ を 2 変数多項式として見る配線が要る（`DigitTheorem.lean` が
「形式化しなかったもの」に書いているのがこの配線である）。$\ell=2$ の側（平方かどうかの判定）も
同じ配線の先にある。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

$\mathbb{R}$ へ 1 度も出ない。$\overline{\mathbb{Q}}$ へも出ない。
扱うのは有限体 $\mathbb{F}_\ell$ の値と自然数の二項係数だけで、
台 $S$ は有限集合である。**すべて決定可能な世界に留まる。**

## 書いたこと（3 段）

1. **二項係数の極形式**（`choose_two_add`）。$\binom{n+m}{2}=\binom n2+\binom m2+nm$。
   $\mathbb{N}$ の中の等式で、帰納法も要らない（両辺を $2$ 倍して展開する形で書く）。
2. **$\bar B$ が $\bar A_2$ の極形式であること**（`Bbar_eq_Abar_two_polarization`）。
   $\bar B((a,b),(u,v))=\bar A_2(a+u,b+v)-\bar A_2(a,b)-\bar A_2(u,v)$。
   段 1 を台 $S$ 上で足し合わせるだけである。**$\bar A_1\equiv0$ も $\ell$ の奇偶も使わない。**
3. **$\ell$ が奇のときの同値**（`Bbar_eq_zero_iff` と `fails_iff_Abar_two_ne_zero`）。
   $\bar B\equiv0\iff\bar A_2\equiv0$。
   $(\Leftarrow)$ は段 2 から出る。$(\Rightarrow)$ は `DigitTheorem.Bbar_diag`
   （$\bar B(x,x)=2\bar A_2(x)$）に $\ell$ が奇であること（$2$ が $\mathbb{F}_\ell$ で可逆）を当てる。
   **$\ell=2$ ではこの向きが落ちる**——本文が $\ell=2$ を別扱いしているのはここである。

## 形式化しなかったもの（実測つき）

* **$\bar A_2\not\equiv0$ と $k=2$（$\bar g$ の最低次数が $2$ であること）の同値。**
  ここが 命題 J2′ の残りである。**mathlib の欠落ではない**——
  本プロジェクトが $\bar A_m$ を点ごとの値として持っており、
  2 変数多項式としての $\bar A_2$（と $\bar g$ の最低次斉次部分）へ繋いでいないだけである
  （`DigitTheorem.lean` の「形式化しなかったもの」と同じ判断）。
* **$\ell=2$ の側**（破れる $\iff\bar A_2$ が $\mathbb{F}_2[T,S]$ の平方でない）。
  同じ配線の先にある。$\mathbb{F}_2$ 上の Frobenius の像の判定であり、
  素材（`frobenius`・多項式環）は mathlib に在る。
-/
import Mathlib
import IntegrableLattice.DigitTheorem

namespace IntegrableLattice
namespace PropJ2PrimePolarization

open Finset

/-! ## 段 1: 二項係数の極形式 -/

/-- **$\binom{n+m}{2}=\binom n2+\binom m2+nm$。**

$\binom N2$ は「$N$ 個から $2$ 個選ぶ」なので、$n+m$ 個を 2 組に分けると
両方から選ぶ場合が $nm$ 通り出る、というだけの等式である。 -/
theorem choose_two_add (n m : ℕ) :
    Nat.choose (n + m) 2 = Nat.choose n 2 + Nat.choose m 2 + n * m := by
  induction n with
  | zero => simp
  | succ j ih =>
    have e : j + 1 + m = (j + m) + 1 := by omega
    have h1 : (j + m + 1).choose 2 = (j + m).choose 1 + (j + m).choose 2 :=
      Nat.choose_succ_succ (j + m) 1
    have h2 : (j + 1).choose 2 = j.choose 1 + j.choose 2 := Nat.choose_succ_succ j 1
    rw [e, h1, h2, ih, Nat.choose_one_right, Nat.choose_one_right]
    ring

/-! ## 段 2: $\bar B$ は $\bar A_2$ の極形式である -/

section Polarization

variable {ℓ : ℕ} {S : Finset (ℕ × ℕ)} {c : ℕ × ℕ → ZMod ℓ}

/-- **$\bar B((a,b),(u,v))=\bar A_2(a+u,b+v)-\bar A_2(a,b)-\bar A_2(u,v)$。**

段 1 を台 $S$ 上で足し合わせるだけである。**$\bar A_1\equiv0$ も $\ell$ の奇偶も使わない。** -/
theorem Bbar_eq_Abar_two_polarization (a b u v : ℕ) :
    Bbar S c a b u v
      = Abar S c 2 (a + u) (b + v) - Abar S c 2 a b - Abar S c 2 u v := by
  classical
  rw [Abar, Abar, Abar, Bbar, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun pq _ => ?_
  have hsplit : pq.1 * (a + u) + pq.2 * (b + v)
      = (pq.1 * a + pq.2 * b) + (pq.1 * u + pq.2 * v) := by ring
  rw [hsplit, choose_two_add]
  push_cast
  ring

end Polarization

/-! ## 段 3: $\ell$ が奇のときの同値 -/

section Odd

variable {ℓ : ℕ} [Fact ℓ.Prime] {S : Finset (ℕ × ℕ)} {c : ℕ × ℕ → ZMod ℓ}

/-- **$\ell$ が奇なら $\bar B\equiv0\iff\bar A_2\equiv0$。**

$(\Leftarrow)$ は極形式（段 2）から出る。$(\Rightarrow)$ は $\bar B(x,x)=2\bar A_2(x)$ に
$2$ が $\mathbb{F}_\ell$ で可逆であることを当てる。**$\ell=2$ ではこの向きが落ちる。** -/
theorem Bbar_eq_zero_iff (hodd : ℓ ≠ 2)
    (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) :
    (∀ a b u v : ℕ, Bbar S c a b u v = 0) ↔ (∀ a b : ℕ, Abar S c 2 a b = 0) := by
  constructor
  · intro h a b
    have hdiag := Bbar_diag (S := S) (c := c) hA1 a b
    rw [h a b a b] at hdiag
    have h2 : (2 : ZMod ℓ) ≠ 0 := by
      have hp : Nat.Prime ℓ := Fact.out
      have h2' : ((2 : ℕ) : ZMod ℓ) ≠ 0 := by
        rw [Ne, ZMod.natCast_eq_zero_iff]
        intro hdvd
        exact hodd ((Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp hdvd)
      simpa using h2'
    rcases mul_eq_zero.mp hdiag.symm with h' | h'
    · exact absurd h' h2
    · exact h'
  · intro h a b u v
    rw [Bbar_eq_Abar_two_polarization, h, h, h]
    ring

/-- **本文の (J2′) のうち代数だけで閉じる側**（$\ell$ 奇）。

閾値 $m=\ell^L+1$ で桁安定性が破れることと、$\bar A_2\not\equiv0$ であることは同値である。
破れの中身が $\bar B$ であることは cycle 19 の `DigitTheorem.Abar_shift_pow_succ` が与えている。

**残るのは $\bar A_2\not\equiv0$ と $k=2$ を結ぶ側**であり、そこは
$\bar A_2$ を 2 変数多項式として見る配線が要る。 -/
theorem fails_iff_Abar_two_ne_zero (hodd : ℓ ≠ 2)
    (hA1 : ∀ u v : ℕ, Abar S c 1 u v = 0) :
    (∃ a b u v : ℕ, Bbar S c a b u v ≠ 0) ↔ (∃ a b : ℕ, Abar S c 2 a b ≠ 0) := by
  constructor
  · intro ⟨a, b, u, v, h⟩
    by_contra hcon
    push Not at hcon
    exact h ((Bbar_eq_zero_iff hodd hA1).mpr hcon a b u v)
  · intro ⟨a, b, h⟩
    by_contra hcon
    push Not at hcon
    exact h ((Bbar_eq_zero_iff hodd hA1).mp hcon a b)

end Odd

end PropJ2PrimePolarization
end IntegrableLattice
