/-
# 補題 Q0（アルキメデス粗上界）— cycle 32 step 2

対応する人手証明:

* 本文ブロック `paper_106_theorem_drop_assumption` の (Q4)
  （`structured-latex/content/009c_drop_assumption_b_star.ts`）
* 根拠 report: `outputs/reports/cycle21_T3_drop_assumption_B_star.md` §5.1（補題 Q0）

## なぜこのファイルがあるか

命題 Q について、検査 F の台帳が挙げていた残りはこれ 1 つだった——
「(Q4) の粗上界は複素絶対値を使う段があり、その形式化が残る」。
`DropAssumptionBStar.lean` は「配線であって mathlib の欠落ではない」と書いたまま、
その配線をしていなかった。ここで配線する。

## 本文の主張（補題 Q0）

$\tilde E(\omega_P)\neq0$ ならば
$$\hat\theta_M(P)\le\varphi(\ell^{M})\log_\ell C_0,\qquad C_0=\sum_{(p,q)}|c_{pq}|.$$

人手証明は 4 段である。

1. $\hat\theta_M(P)=v_\ell(N)$、$N$ は $0$ でない整数。
2. $N=\prod_\sigma\sigma(\tilde E(\omega_P))$ で、各共役は $\sum c_{pq}\xi^{k}$（$\xi$ は 1 の冪根）の形。
   **複素絶対値**が $\le C_0$。
3. よって $|N|\le C_0^{\varphi(\ell^{M})}$。
4. $|N|\ge1$ なので $v_\ell(N)\le\log_\ell|N|\le\varphi(\ell^{M})\log_\ell C_0$。

## $\mathbb{R}$ 脱出について（形式化して分かったこと）

**本文は「複素絶対値を使ったのはこの一段だけ」と書いており、それは正しい。**
形式化すると、脱出の位置がもう一段はっきりする——

- 段 2・段 3（`norm_sum_le_of_isRootOfUnity` と `natAbs_le_pow_of_prod`）が
  $\mathbb{C}$ を使う。**ここが脱出である。**
- 段 1・段 4 は可算側で閉じる。とくに段 4 の中身は
  **$\ell^{v_\ell(N)}\le|N|$ という $\mathbb{N}$ の不等式**であり（`crudeBound_pow_padicValInt_le_natAbs`）、
  実対数はそれを書き換えているだけである（`crudeBound_padicValInt_le_mul_logb`）。
  すなわち**実対数は脱出の原因ではなく、脱出の結果を述べ直す記法である。**

この分離を型に出すために、段 4 を「$\mathbb{N}$ の不等式」と「実対数への書き換え」に分けてある。
$\mathbb{R}$ を使わない形の結論（`crudeBound_padicValInt_le_of_prod_countable`）も併せて置く。
-/
import Mathlib

namespace IntegrableLattice

open Finset

/-! ## 段 1 — $\ell^{v_\ell(N)}\le|N|$（可算側で閉じる） -/

/--
**段 1**: $0$ でない整数 $N$ について $\ell^{v_\ell(N)}\le|N|$。

$\ell^{v_\ell(N)}$ は $|N|$ を割るので、$|N|\neq0$ から大小がつく。
**$\mathbb{R}$ を使わない。**
-/
theorem crudeBound_pow_padicValInt_le_natAbs {ℓ : ℕ} [Fact ℓ.Prime] {N : ℤ} (hN : N ≠ 0) :
    ℓ ^ padicValInt ℓ N ≤ N.natAbs := by
  have hne : N.natAbs ≠ 0 := Int.natAbs_ne_zero.mpr hN
  exact Nat.le_of_dvd (Nat.pos_of_ne_zero hne) (pow_padicValNat_dvd)

/-! ## 段 2・段 3 — ここで $\mathbb{C}$（アルキメデス素点）へ脱出する -/

/--
**段 2（$\mathbb{R}/\mathbb{C}$ 脱出）**: 絶対値 $1$ の数の整数係数一次結合は、
係数の絶対値の和で押さえられる。

本文で $\xi$ は 1 の冪根なので絶対値は $1$ である。
**証明が実際に使うのは「絶対値が $1$ であること」だけで、1 の冪根であることは使わない**ので、
仮定はその形にしてある。
-/
theorem crudeBound_norm_sum_le_of_norm_eq_one {ι : Type*} (s : Finset ι) (c : ι → ℤ) (ξ : ι → ℂ)
    (hξ : ∀ i ∈ s, ‖ξ i‖ = 1) :
    ‖∑ i ∈ s, (c i : ℂ) * ξ i‖ ≤ ∑ i ∈ s, ((c i).natAbs : ℝ) := by
  refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun i hi => ?_)
  rw [norm_mul, hξ i hi, mul_one, Complex.norm_intCast, Nat.cast_natAbs, Int.cast_abs]

/--
**段 3（$\mathbb{R}/\mathbb{C}$ 脱出）**: 各因子の複素絶対値が $C_0$ 以下なら、
積の複素絶対値は $C_0^{(\text{因子の個数})}$ 以下である。
-/
theorem crudeBound_norm_prod_le_pow_card {ι : Type*} (s : Finset ι) (z : ι → ℂ) {C : ℝ}
    (hz : ∀ i ∈ s, ‖z i‖ ≤ C) : ‖∏ i ∈ s, z i‖ ≤ C ^ s.card := by
  rw [norm_prod]
  refine (Finset.prod_le_prod (fun i _ => norm_nonneg _) hz).trans ?_
  simp

/--
**段 3 の後始末**: 整数 $N$ が複素数の積として書けて、その積の絶対値が $C_0^{\varphi}$ 以下なら、
$|N|\le C_0^{\varphi}$ が $\mathbb{N}$ の不等式として得られる。

**ここが脱出の出口である**——左辺も右辺も整数なので、以降は可算側で閉じる。
-/
theorem crudeBound_natAbs_le_pow_of_norm_le {N : ℤ} {C φ : ℕ} (h : ‖(N : ℂ)‖ ≤ (C : ℝ) ^ φ) :
    N.natAbs ≤ C ^ φ := by
  have : ((N.natAbs : ℕ) : ℝ) ≤ ((C ^ φ : ℕ) : ℝ) := by
    have hcast : ‖(N : ℂ)‖ = ((N.natAbs : ℕ) : ℝ) := by
      rw [Complex.norm_intCast, Nat.cast_natAbs, Int.cast_abs]
    rw [hcast] at h
    exact_mod_cast h
  exact_mod_cast this

/-! ## 段 4 — 可算側の結論と、その実対数による書き換え -/

/--
**段 4（可算側の結論）**: $\ell^{v_\ell(N)}\le C_0^{\varphi}$。

**これが補題 Q0 の内容そのものであり、$\mathbb{R}$ を 1 度も使わない。**
本文が書いている $\log_\ell$ の形は、この不等式の書き換えである（`crudeBound_padicValInt_le_mul_logb`）。
-/
theorem crudeBound_pow_padicValInt_le_pow {ℓ : ℕ} [Fact ℓ.Prime] {N : ℤ} {C φ : ℕ} (hN : N ≠ 0)
    (h : N.natAbs ≤ C ^ φ) : ℓ ^ padicValInt ℓ N ≤ C ^ φ :=
  (crudeBound_pow_padicValInt_le_natAbs hN).trans h

/--
**段 4（実対数への書き換え）**: $\ell^{v}\le C_0^{\varphi}$ から $v\le\varphi\log_\ell C_0$。

**ここで初めて $\mathbb{R}$ が現れるが、原因ではなく記法である**——
両辺の $\log_\ell$ を取っているだけで、内容は上の $\mathbb{N}$ の不等式に尽きている。
$\log_\ell$ が単調であることに $\ell>1$ が、$\log_\ell C_0$ が意味をもつことに $C_0\ge1$ が要る。
-/
theorem crudeBound_le_mul_logb_of_pow_le {ℓ C φ v : ℕ} (hℓ : 1 < ℓ) (hC : 1 ≤ C) (h : ℓ ^ v ≤ C ^ φ) :
    (v : ℝ) ≤ φ * Real.logb ℓ C := by
  have hℓR : (1 : ℝ) < ℓ := by exact_mod_cast hℓ
  have hCR : (1 : ℝ) ≤ C := by exact_mod_cast hC
  have hpow : ((ℓ : ℝ)) ^ v ≤ ((C : ℝ)) ^ φ := by exact_mod_cast h
  have hlog : Real.logb ℓ ((ℓ : ℝ) ^ v) ≤ Real.logb ℓ ((C : ℝ) ^ φ) :=
    Real.logb_le_logb_of_le hℓR (by positivity) hpow
  rwa [Real.logb_pow, Real.logb_self_eq_one hℓR, mul_one, Real.logb_pow] at hlog

/-! ## 補題 Q0 の組み立て -/

/--
**補題 Q0（可算側の形）**: 仮定は本文の 3 つである——
$N$ は $0$ でない整数、$N$ は共役たちの積、各共役は絶対値 $1$ の数の整数係数一次結合。
結論は $\ell^{v_\ell(N)}\le C_0^{\varphi}$ で、$C_0$ は係数の絶対値の和、$\varphi$ は共役の個数。

**$\mathbb{R}$ を使うのは仮定の中の複素絶対値の評価だけで、結論は $\mathbb{N}$ の不等式である。**
-/
theorem crudeBound_padicValInt_le_of_prod_countable {ℓ : ℕ} [Fact ℓ.Prime] {ι κ : Type*}
    (conj : Finset ι) (idx : Finset κ) (c : κ → ℤ) (ξ : ι → κ → ℂ) {N : ℤ}
    (hN : N ≠ 0)
    (hprod : (N : ℂ) = ∏ σ ∈ conj, ∑ i ∈ idx, (c i : ℂ) * ξ σ i)
    (hξ : ∀ σ ∈ conj, ∀ i ∈ idx, ‖ξ σ i‖ = 1) :
    ℓ ^ padicValInt ℓ N ≤ (∑ i ∈ idx, (c i).natAbs) ^ conj.card := by
  set C : ℕ := ∑ i ∈ idx, (c i).natAbs with hC
  -- 段 2: 各共役の絶対値は C 以下（ここが ℂ）。
  have hfac : ∀ σ ∈ conj, ‖∑ i ∈ idx, (c i : ℂ) * ξ σ i‖ ≤ (C : ℝ) := by
    intro σ hσ
    refine (crudeBound_norm_sum_le_of_norm_eq_one idx c (ξ σ) (hξ σ hσ)).trans_eq ?_
    rw [hC]
    push_cast
    rfl
  -- 段 3: 積の絶対値は C^φ 以下（ここも ℂ）。
  have hN' : ‖(N : ℂ)‖ ≤ (C : ℝ) ^ conj.card := by
    rw [hprod]
    exact crudeBound_norm_prod_le_pow_card conj _ hfac
  -- 段 3 の出口: 以降は可算側。
  exact crudeBound_pow_padicValInt_le_pow hN (crudeBound_natAbs_le_pow_of_norm_le hN')

/--
**補題 Q0（本文が書いている形）**: $v_\ell(N)\le\varphi\log_\ell C_0$。

上の可算側の形に実対数を当てただけである。
$C_0\ge1$ を仮定に置いているのは、$\log_\ell C_0$ が意味をもつためである
（本文では $\tilde E\neq0$ から $C_0\ge1$ が出るが、その導出はこの補題の外にある）。
-/
theorem crudeBound_padicValInt_le_mul_logb {ℓ : ℕ} [Fact ℓ.Prime] {ι κ : Type*}
    (conj : Finset ι) (idx : Finset κ) (c : κ → ℤ) (ξ : ι → κ → ℂ) {N : ℤ}
    (hℓ : 1 < ℓ) (hN : N ≠ 0)
    (hC : 1 ≤ ∑ i ∈ idx, (c i).natAbs)
    (hprod : (N : ℂ) = ∏ σ ∈ conj, ∑ i ∈ idx, (c i : ℂ) * ξ σ i)
    (hξ : ∀ σ ∈ conj, ∀ i ∈ idx, ‖ξ σ i‖ = 1) :
    (padicValInt ℓ N : ℝ)
      ≤ conj.card * Real.logb ℓ ((∑ i ∈ idx, (c i).natAbs : ℕ) : ℝ) :=
  crudeBound_le_mul_logb_of_pow_le hℓ hC
    (crudeBound_padicValInt_le_of_prod_countable conj idx c ξ hN hprod hξ)

end IntegrableLattice
