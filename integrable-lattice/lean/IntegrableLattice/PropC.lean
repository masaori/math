/-
# 命題 C（Pisano 型上界）の核

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 C**
（$\pi(p,k)\mid p^{k-1}\pi(p,1)$。既知の Pisano 型上界）、
設定は同 §2 命題 A（`outputs/reports/cycle3_T1_D-U2_rigorous.md`）と同じ。

人手証明の $\pi(p,k)$ は「$T^N\bmod p^k$ の最終周期」である。$p\nmid\det T$ のとき
$T\bmod p^k$ は可逆なので列は純周期的で $\pi(p,k)=\operatorname{ord}(T\bmod p^k)$ になり、
$\pi(p,k)\mid p^{k-1}\pi(p,1)$ の中身は

> 還元写像 $GL_d(\mathbb{Z}/p^k)\to GL_d(\mathbb{Z}/p)$ の核の指数は $p^{k-1}$ を割る

すなわち
$$U\equiv I \pmod p\ \Longrightarrow\ U^{p^{k-1}}=I \quad\text{in } M_d(\mathbb{Z}/p^k)$$
である。本ファイルはこれを形式化する（`pow_prime_pow_eq_one_of_eq_one_add`）。

**証明の作り**: 二項展開の段（`dvd_one_add_pow_prime_sub_one`）と、その反復
（`dvd_pow_prime_pow_sub_one`）は**可換環**で証明する。行列環は非可換だが、
$U=1+pV$ の冪はすべて $V$ の多項式なので、$(\mathbb{Z}/p^k)[X]$ 上で示してから
`Polynomial.aeval V`（余域は非可換でよい）で移送すればよい。

**形式化していない部分**（`README.md` の「形式化の現状」表にも記載）:
$\pi(p,k)$ を最終周期の最小値として定義し、上の核から
$\pi(p,k)\mid p^{k-1}\pi(p,1)$ を結論する段は形式化していない。
$p\nmid\det T$ から純周期性（最終周期＝`orderOf`）を出す補題群が別途必要である。

なお人手証明が明記するとおり、**等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）は一般には成り立たない**
（cycle 6 で 572 件中 4.5% の反例）。ここで証明するのは整除（上界）方向だけである。

**新規性は主張しない**（Pisano 型上界は古典）。
-/
import Mathlib

namespace IntegrableLattice

open Finset Polynomial

/-- $j\ge1$ のとき $(1+p^jw)^p-1$ は $p^{j+1}$ で割れる。
二項展開で、$m=0$ の項は $p^{jp}$（$jp\ge2j\ge j+1$）を出し、
$0<m<p$ の項は $p^{j}$ と $p\mid\binom{p}{m}$ を合わせて $p^{j+1}$ を出す。 -/
theorem dvd_one_add_pow_prime_sub_one {S : Type*} [CommRing S] (p : ℕ) [hp : Fact p.Prime]
    {j : ℕ} (hj : 1 ≤ j) (w : S) :
    (p : S) ^ (j + 1) ∣ (1 + (p : S) ^ j * w) ^ p - 1 := by
  have hp2 : 2 ≤ p := hp.out.two_le
  rw [add_pow, Finset.sum_range_succ]
  simp only [one_pow, one_mul, Nat.sub_self, pow_zero, Nat.choose_self, Nat.cast_one, mul_one]
  rw [add_sub_cancel_right]
  refine Finset.dvd_sum ?_
  intro m hm
  rw [Finset.mem_range] at hm
  have hae : ((p : S) ^ j * w) ^ (p - m) = (p : S) ^ (j * (p - m)) * w ^ (p - m) := by
    rw [mul_pow, ← pow_mul]
  rcases Nat.eq_zero_or_pos m with rfl | hmpos
  · -- `m = 0`: 項は `a^p`。`j*p ≥ 2j ≥ j+1`。
    simp only [Nat.sub_zero, Nat.choose_zero_right, Nat.cast_one, mul_one]
    rw [mul_pow, ← pow_mul]
    exact Dvd.dvd.mul_right (pow_dvd_pow _ (by nlinarith)) _
  · -- `0 < m < p`: `p ∣ C(p,m)` と `p^j ∣ a^(p-m)` を合わせる。
    obtain ⟨c, hc⟩ := hp.out.dvd_choose_self hmpos.ne' hm
    have hjle : j ≤ j * (p - m) := Nat.le_mul_of_pos_right j (by omega)
    have hsplit : (p : S) ^ (j * (p - m)) = (p : S) ^ j * (p : S) ^ (j * (p - m) - j) := by
      rw [← pow_add]; congr 1; omega
    rw [hae, hc, hsplit]
    push_cast
    exact ⟨(p : S) ^ (j * (p - m) - j) * w ^ (p - m) * (c : S), by ring⟩

/-- $p\mid u-1$ なら $p^{k+1}\mid u^{p^k}-1$（上の補題の反復）。 -/
theorem dvd_pow_prime_pow_sub_one {S : Type*} [CommRing S] (p : ℕ) [hp : Fact p.Prime]
    (u : S) (h : (p : S) ∣ u - 1) :
    ∀ k : ℕ, (p : S) ^ (k + 1) ∣ u ^ p ^ k - 1 := by
  intro k
  induction k with
  | zero => simpa using h
  | succ k ih =>
      obtain ⟨w, hw⟩ := ih
      have hu : u ^ p ^ k = 1 + (p : S) ^ (k + 1) * w := by
        have := sub_eq_iff_eq_add.mp hw; linear_combination this
      have hstep := dvd_one_add_pow_prime_sub_one (S := S) p (j := k + 1) (by omega) w
      rw [← hu, ← pow_mul, ← pow_succ] at hstep
      exact hstep

/-- **命題 C の核**: $(\mathbb{Z}/p^k)$-代数 $S$（非可換でよい）で
$U=1+pV$ ならば $U^{p^{k-1}}=1$。
$S=M_d(\mathbb{Z}/p^k)$ に使えば「$U\equiv I \pmod p \Rightarrow U^{p^{k-1}}=I$」になる。 -/
theorem pow_prime_pow_eq_one_of_eq_one_add {p k : ℕ} [hp : Fact p.Prime] (hk : k ≠ 0)
    {S : Type*} [Ring S] [Algebra (ZMod (p ^ k)) S] (U V : S) (hU : U = 1 + (p : S) * V) :
    U ^ p ^ (k - 1) = 1 := by
  -- 可換環 `R = (ZMod (p^k))[X]` の上で示してから `aeval V` で移送する。
  set R := (ZMod (p ^ k))[X] with hR
  have hp0 : ((p : R)) ^ k = 0 := by
    have : ((p : R)) ^ k = ((p ^ k : ℕ) : R) := by rw [Nat.cast_pow]
    rw [this, ← Polynomial.C_eq_natCast, ZMod.natCast_self, map_zero]
  have hdvd : ((p : R)) ∣ (1 + (p : R) * X) - 1 := by
    rw [add_sub_cancel_left]; exact Dvd.intro _ rfl
  have hkey := dvd_pow_prime_pow_sub_one (S := R) p (1 + (p : R) * X) hdvd (k - 1)
  rw [show k - 1 + 1 = k by omega, hp0] at hkey
  have hzero : (1 + (p : R) * X) ^ p ^ (k - 1) - 1 = 0 := zero_dvd_iff.mp hkey
  -- `aeval V : R →ₐ[ZMod (p^k)] S` で移送する。
  have himg := congrArg (Polynomial.aeval V) hzero
  simp only [map_sub, map_pow, map_add, map_one, map_mul, Polynomial.aeval_X,
    map_natCast, map_zero] at himg
  rw [hU]
  linear_combination (norm := noncomm_ring) himg

/-- **命題 C の核（行列版）**: $U\equiv I \pmod p$ ならば $U^{p^{k-1}}=I$ in $M_d(\mathbb{Z}/p^k)$。
還元 $GL_d(\mathbb{Z}/p^k)\to GL_d(\mathbb{Z}/p)$ の核の指数が $p^{k-1}$ を割ることの内容である。 -/
theorem matrix_pow_prime_pow_eq_one {p k d : ℕ} [hp : Fact p.Prime] (hk : k ≠ 0)
    (U : Matrix (Fin d) (Fin d) (ZMod (p ^ k)))
    (h : ∃ V, U = 1 + (p : Matrix (Fin d) (Fin d) (ZMod (p ^ k))) * V) :
    U ^ p ^ (k - 1) = 1 := by
  obtain ⟨V, hV⟩ := h
  exact pow_prime_pow_eq_one_of_eq_one_add hk U V hV

end IntegrableLattice
