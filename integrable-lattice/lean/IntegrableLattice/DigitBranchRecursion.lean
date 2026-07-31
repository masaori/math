/-
# 定理 L1（桁枝再帰。打ち消しは起きない）と系 L2 — cycle 20 step 1

対応する人手証明:

* 本文ブロック `paper_prop_R` の (R1)(R2)(R3)（`structured-latex/content/009_theta_recursion.ts`）
* 根拠 report: `outputs/reports/cycle20_T3_cancellation_recursion.md` §2（補題 L0・L0′・定理 L1）・
  §3.1（系 L2）

## 目的

**証明の正しさではなく、主張の検算**である。定理 L1 は
「$\theta(\nu)=\ell d+s^*$ で $s^*$ は必ず存在し $s^*\le\ell-1$」＝**打ち消しは起きない**を主張する。
主張が一意に読めるか・仮定が過不足ないかを型に出して調べる。

## 形式化した主張

* `sigma_eq_of_max` / `exists_sigma_ne_zero` / `exists_sigma_ne_zero_lt` —
  **定理 L1 の 2**（$s^*$ の存在と $s^*\le\ell-1$）。
* `one_add_X_pow_split` / `branch_decomposition` — **補題 L0**（枝分解）。
  $(1+x)^{\ell}=1+x^{\ell}$（Frobenius）だけで出る。
* `coeff_branch_single` / `coeff_branch_sum` — **定理 L1 の証明の $(2.1)$**
  （$[x^{\ell d+s}]f_\nu=\sum_{c\in C}\lambda_c\binom cs$、$0\le s<\ell$）。
* `coeff_branch_lt_ne` — 次数 $<\ell d$ の係数はすべて $0$（$\theta\ge\ell d$ の側）。
* `exists_coeff_ne_zero_of_branches` — **定理 L1 の 3 の内容**
  （枝の最低次が $d$ で揃った先頭係数が非零なら、$\ell d\le\theta\le\ell d+\max C$ で
  $\theta$ は必ず有限。すなわち打ち消しでは消えない）。
* `L1_bound` — **定理 L1 の 4**（$\theta\le\ell^{\mathrm{sep}}-1$）の帰納段の算術。
* `geom_sum_one_add_X_pow_char` — **系 L2 の上界の達成**
  （$\sum_{j<\ell^t}(1+x)^j=x^{\ell^t-1}$ in $\mathbb{F}_\ell[x]$）。

## 形式化で分かったこと（過剰仮定・記述の精度）

1. **$s^*$ の存在に「行列 $\bigl(\binom cs\bigr)$ の可逆性」は要らない。**
   本文 (R2)（および report 定理 L1 の 2 の証明）は
   「$B=\bigl(\binom cs\bigr)_{0\le c,s\le\ell-1}$ が下三角単位行列で可逆だから $\sigma=\lambda B\neq0$」と述べるが、
   実際に効くのは **$C$ の最大元 $c_{\max}$ ひとつだけ**である:
   $s=c_{\max}$ と取れば $c<s$ の項は $\binom cs=0$ で消え、$c>s$ の項は $C$ の外なので
   $\sigma_{c_{\max}}=\lambda_{c_{\max}}\neq0$（`sigma_eq_of_max`）。
   したがって
   * $\mathbb{F}_\ell$ が体であることも $\ell$ が素数であることも**使わない**
     （`sigma_eq_of_max` は任意の可換環 $R$ で成立する）、
   * 得られる上界は $s^*\le\max C$ で、**$s^*\le\ell-1$ より鋭い**。
   $\ell$ の素数性が要るのは枝分解 `one_add_X_pow_split`（Frobenius）の側だけである。
2. **$s^*$ の定義は「最小の $s$」だが、存在を言うのに最小性は要らない。**
   `exists_sigma_ne_zero` は「ある $s$ で $\sigma_s\neq0$」を与え、最小性は $\theta$ の値を
   確定させる段（`coeff_branch_lt_ne` と合わせるところ）で初めて使う。
3. **`coeff_branch_single` に必要なのは $s<\ell$ だけで、$c<\ell$ は要らない。**
   report の $(2.1)$ の議論は「$0\le s\le\ell-1$ なら $\ell d+s<\ell(d+1)$」だけを使っており、
   枝の添字 $c$ が $\ell$ 未満であることは（$c$ が枝の番号である以上自動的に満たされるが）
   $(2.1)$ の成立には不要である。型に出すとそれが読める。

## 形式化しなかったもの（mathlib の欠落か配線か）

`lean/logs/mathlib-gap-survey-cycle21.log` を参照。

* **$\mathbb{Z}_\ell$ 指数の $(1+x)^\gamma$**（補題 J0 で $\mathbb{F}_\ell[[x]]$ に定義されるもの）:
  本ファイルは指数を $\mathbb{N}$ に取った多項式版で形式化している。
  `PowerSeries` も二項冪級数（`Mathlib/RingTheory/PowerSeries/Binomial.lean`）も **mathlib に在る**ので、
  欠落ではなく**配線**（$\mathbb{Z}_\ell$ 上の二項係数と Lucas を繋いでいない）である。
* **$\mathrm{sep}$ についての帰納法そのもの**: 測度 $\nu$ を $\mathbb{Z}_\ell$ 上の有限台の
  関数として定義し直す必要がある。これも配線であり、`L1_bound` で帰納段の算術だけを検算した。
-/
import Mathlib

namespace IntegrableLattice

open Polynomial Finset

/-! ## 定理 L1 の 2 — $s^*$ は必ず存在する（打ち消しは起きない） -/

section Sigma

variable {R : Type*} [CommRing R]

/-- **定理 L1 の 2 の核**。$C$ の最大元 $s=\max C$ では
$\sigma_s=\sum_{c\in C}\lambda_c\binom cs$ がちょうど $\lambda_s$ になる。

**可換環ならなんでもよい**（$\mathbb{F}_\ell$ が体であることも $\ell$ の素数性も使わない）。 -/
theorem sigma_eq_of_max (C : Finset ℕ) (hC : C.Nonempty) (lam : ℕ → R) :
    ∑ c ∈ C, lam c * (c.choose (C.max' hC) : R) = lam (C.max' hC) := by
  rw [Finset.sum_eq_single (C.max' hC)]
  · simp
  · intro b hb hne
    have hlt : b < C.max' hC := lt_of_le_of_ne (Finset.le_max' C b hb) hne
    simp [Nat.choose_eq_zero_of_lt hlt]
  · intro h
    exact absurd (C.max'_mem hC) h

/-- **定理 L1 の 2**（存在部分）。$\lambda_c\neq0$（$c\in C$）で $C\neq\emptyset$ なら
$\sigma_s\neq0$ なる $s$ が存在し、しかも $s\in C$ に取れる。 -/
theorem exists_sigma_ne_zero (C : Finset ℕ) (hC : C.Nonempty) (lam : ℕ → R)
    (hlam : ∀ c ∈ C, lam c ≠ 0) :
    ∃ s ∈ C, (∑ c ∈ C, lam c * (c.choose s : R)) ≠ 0 :=
  ⟨C.max' hC, C.max'_mem hC, by
    rw [sigma_eq_of_max]
    exact hlam _ (C.max'_mem hC)⟩

/-- **定理 L1 の 2**（上界部分）。$C\subseteq\{0,\dots,\ell-1\}$ なら $s^*\le\ell-1$。
本文は $s^*\le\ell-1$ と書くが、実際には $s^*\le\max C$ が出ている。 -/
theorem exists_sigma_ne_zero_lt (ℓ : ℕ) (C : Finset ℕ) (hC : C.Nonempty)
    (hCr : C ⊆ range ℓ) (lam : ℕ → R) (hlam : ∀ c ∈ C, lam c ≠ 0) :
    ∃ s < ℓ, (∑ c ∈ C, lam c * (c.choose s : R)) ≠ 0 := by
  obtain ⟨s, hsC, hs⟩ := exists_sigma_ne_zero C hC lam hlam
  exact ⟨s, Finset.mem_range.mp (hCr hsC), hs⟩

end Sigma

/-! ## 補題 L0 — 枝分解（Frobenius） -/

section Branch

variable {R : Type*} [CommRing R]

/-- **補題 L0 の核**。標数 $\ell$ では $(1+x)^{c+\ell g}=(1+x)^c(1+x^\ell)^g$。 -/
theorem one_add_X_pow_split (ℓ : ℕ) [ExpChar R ℓ] (c g : ℕ) :
    (1 + X : R[X]) ^ (c + ℓ * g) = (1 + X) ^ c * (1 + X ^ ℓ) ^ g := by
  have hfrob : ((1 : R[X]) + X) ^ ℓ = 1 + X ^ ℓ := by
    have := add_pow_expChar (R := R[X]) (p := ℓ) 1 X
    simpa using this
  rw [pow_add, pow_mul, hfrob]

/-- **補題 L0**。有限台の指数集合 $G\subset\mathbb{N}$ について、
$\sum_{\gamma\in G}\mu_\gamma(1+x)^\gamma$ を第 0 桁 $c=\gamma\bmod\ell$ で分けた形。 -/
theorem branch_decomposition (ℓ : ℕ) [ExpChar R ℓ] (hℓ : 0 < ℓ) (G : Finset ℕ) (mu : ℕ → R) :
    ∑ γ ∈ G, C (mu γ) * (1 + X : R[X]) ^ γ
      = ∑ c ∈ range ℓ, (1 + X) ^ c *
          ∑ γ ∈ G.filter (fun γ => γ % ℓ = c), C (mu γ) * (1 + X ^ ℓ) ^ (γ / ℓ) := by
  have hmaps : ∀ γ ∈ G, γ % ℓ ∈ range ℓ := by
    intro γ _
    exact Finset.mem_range.mpr (Nat.mod_lt _ hℓ)
  rw [← Finset.sum_fiberwise_of_maps_to hmaps
    (fun γ => C (mu γ) * (1 + X : R[X]) ^ γ)]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun γ hγ => ?_
  have hc : γ % ℓ = c := (Finset.mem_filter.mp hγ).2
  have hsplit : γ = c + ℓ * (γ / ℓ) := by
    conv_lhs => rw [← Nat.mod_add_div γ ℓ, hc]
  calc C (mu γ) * (1 + X : R[X]) ^ γ
      = C (mu γ) * ((1 + X) ^ c * (1 + X ^ ℓ) ^ (γ / ℓ)) := by
        rw [← one_add_X_pow_split ℓ c (γ / ℓ), ← hsplit]
    _ = (1 + X) ^ c * (C (mu γ) * (1 + X ^ ℓ) ^ (γ / ℓ)) := by ring

end Branch

/-! ## 定理 L1 の 3 — 係数の取り出し（$(2.1)$）と、打ち消しが起きないこと -/

section Coeff

variable {R : Type*} [CommRing R]

/-- **$(2.1)$ の 1 枝ぶん**。位数が $d$ 以上の $g$ について、
$[x^{\ell d+s}]\bigl((1+x)^c g(x^\ell)\bigr)=g_d\binom cs$（$s<\ell$）。

**仮定は $s<\ell$ と $0<\ell$ だけ**で、$c<\ell$ は要らない（report の議論も使っていない）。 -/
theorem coeff_branch_single (ℓ c d s : ℕ) (hℓ : 0 < ℓ) (hs : s < ℓ)
    (g : R[X]) (hg : ∀ k < d, g.coeff k = 0) :
    ((1 + X : R[X]) ^ c * expand R ℓ g).coeff (ℓ * d + s)
      = g.coeff d * (c.choose s : R) := by
  rw [coeff_mul]
  rw [Finset.sum_eq_single (s, ℓ * d)]
  · rw [coeff_one_add_X_pow, Polynomial.coeff_expand_mul' hℓ]
    ring
  · rintro ⟨i, j⟩ hij hne
    have hsum : i + j = ℓ * d + s := by simpa using hij
    by_cases hdvd : ℓ ∣ j
    · obtain ⟨k, rfl⟩ := hdvd
      have hkd : k ≠ d := by
        rintro rfl
        have : i = s := by omega
        exact hne (by simp [this])
      rcases lt_or_gt_of_ne hkd with hk | hk
      · simp [Polynomial.coeff_expand_mul' hℓ, hg k hk]
      · exfalso
        have hle : ℓ * (d + 1) ≤ ℓ * k := Nat.mul_le_mul_left ℓ hk
        have hexp : ℓ * (d + 1) = ℓ * d + ℓ := by ring
        omega
    · simp [Polynomial.coeff_expand hℓ, if_neg hdvd]
  · intro h
    refine absurd ?_ h
    simp [Nat.add_comm]

/-- **$(2.1)$**。枝の和にわたる係数。 -/
theorem coeff_branch_sum (ℓ d s : ℕ) (hℓ : 0 < ℓ) (hs : s < ℓ) (g : ℕ → R[X])
    (hg : ∀ c ∈ range ℓ, ∀ k < d, (g c).coeff k = 0) :
    (∑ c ∈ range ℓ, (1 + X : R[X]) ^ c * expand R ℓ (g c)).coeff (ℓ * d + s)
      = ∑ c ∈ range ℓ, (g c).coeff d * (c.choose s : R) := by
  rw [finsetSum_coeff]
  exact Finset.sum_congr rfl fun c hc => coeff_branch_single ℓ c d s hℓ hs (g c) (hg c hc)

/-- 次数 $<\ell d$ の係数はすべて $0$（$\theta\ge\ell d$ の側）。 -/
theorem coeff_branch_lt (ℓ d : ℕ) (hℓ : 0 < ℓ) (g : ℕ → R[X])
    (hg : ∀ c ∈ range ℓ, ∀ k < d, (g c).coeff k = 0) {m : ℕ} (hm : m < ℓ * d) :
    (∑ c ∈ range ℓ, (1 + X : R[X]) ^ c * expand R ℓ (g c)).coeff m = 0 := by
  rw [finsetSum_coeff]
  refine Finset.sum_eq_zero fun c hc => ?_
  rw [coeff_mul]
  refine Finset.sum_eq_zero ?_
  rintro ⟨i, j⟩ hij
  have hsum : i + j = m := by simpa using hij
  by_cases hdvd : ℓ ∣ j
  · obtain ⟨k, rfl⟩ := hdvd
    have hk : k < d := by
      by_contra hk
      have hk' : d ≤ k := Nat.le_of_not_lt hk
      have hle : ℓ * d ≤ ℓ * k := Nat.mul_le_mul_left ℓ hk'
      omega
    simp [Polynomial.coeff_expand_mul' hℓ, hg c hc k hk]
  · simp [Polynomial.coeff_expand hℓ, if_neg hdvd]

/-- **定理 L1 の 3 の内容（打ち消しは起きない）**。
各枝 $g_c$ の位数が $d$ 以上で、最低次係数が $C$ 上で非零・$C$ の外で $0$ なら、
和 $f=\sum_c(1+x)^cg_c(x^\ell)$ の位数はちょうど $\ell d+s^*$ の形で有限であり、
$s^*\le\max C<\ell$。とくに **$f\neq0$**（すべての $\sigma_s$ が消えることはない）。 -/
theorem exists_coeff_ne_zero_of_branches (ℓ d : ℕ) (hℓ : 0 < ℓ) (g : ℕ → R[X])
    (hg : ∀ c ∈ range ℓ, ∀ k < d, (g c).coeff k = 0)
    (C : Finset ℕ) (hC : C.Nonempty) (hCr : C ⊆ range ℓ)
    (hin : ∀ c ∈ C, (g c).coeff d ≠ 0)
    (hout : ∀ c ∈ range ℓ, c ∉ C → (g c).coeff d = 0) :
    ∃ s < ℓ, (∀ m < ℓ * d,
        (∑ c ∈ range ℓ, (1 + X : R[X]) ^ c * expand R ℓ (g c)).coeff m = 0) ∧
      (∑ c ∈ range ℓ, (1 + X : R[X]) ^ c * expand R ℓ (g c)).coeff (ℓ * d + s) ≠ 0 := by
  set s := C.max' hC with hs_def
  have hsℓ : s < ℓ := Finset.mem_range.mp (hCr (C.max'_mem hC))
  refine ⟨s, hsℓ, fun m hm => coeff_branch_lt ℓ d hℓ g hg hm, ?_⟩
  rw [coeff_branch_sum ℓ d s hℓ hsℓ g hg]
  have hsplit : ∑ c ∈ range ℓ, (g c).coeff d * (c.choose s : R)
      = ∑ c ∈ C, (g c).coeff d * (c.choose s : R) := by
    refine (Finset.sum_subset hCr ?_).symm
    intro c hc hcC
    simp [hout c hc hcC]
  rw [hsplit, hs_def, sigma_eq_of_max]
  exact hin _ (C.max'_mem hC)

end Coeff

/-! ## 定理 L1 の 4・系 L2 — 上界とその達成 -/

/-- **定理 L1 の 4 の帰納段**。$d\le\ell^{t-1}-1$ と $s\le\ell-1$ から $\ell d+s\le\ell^t-1$。
（$\mathbb{N}$ の切り捨て引き算を避けるため $+1$ した形で述べる。） -/
theorem L1_bound (ℓ t d s : ℕ) (ht : 1 ≤ t) (hd : d + 1 ≤ ℓ ^ (t - 1)) (hs : s + 1 ≤ ℓ) :
    ℓ * d + s + 1 ≤ ℓ ^ t := by
  have h1 : ℓ * d + s + 1 ≤ ℓ * (d + 1) := by
    have := hs
    nlinarith [Nat.zero_le d]
  have h2 : ℓ * (d + 1) ≤ ℓ * ℓ ^ (t - 1) := Nat.mul_le_mul_left ℓ hd
  have h3 : ℓ * ℓ ^ (t - 1) = ℓ ^ t := by
    rw [← pow_succ']
    congr 1
    omega
  omega

/-- **系 L2 の上界の達成**。$\mathbb{F}_\ell[x]$ で
$\sum_{j<\ell^t}(1+x)^j=x^{\ell^t-1}$。すなわち $\theta=\ell^{\mathrm{sep}}-1$ が実現する。 -/
theorem geom_sum_one_add_X_pow_char (ℓ t : ℕ) [Fact (Nat.Prime ℓ)] :
    (∑ j ∈ range (ℓ ^ t), (1 + X : (ZMod ℓ)[X]) ^ j) = X ^ (ℓ ^ t - 1) := by
  have hℓ : 1 ≤ ℓ ^ t := Nat.one_le_pow _ _ (Fact.out (p := Nat.Prime ℓ)).pos
  have hmul : (∑ j ∈ range (ℓ ^ t), (1 + X : (ZMod ℓ)[X]) ^ j) * ((1 + X) - 1)
      = (1 + X) ^ (ℓ ^ t) - 1 := geom_sum_mul _ _
  have hfrob : ((1 : (ZMod ℓ)[X]) + X) ^ (ℓ ^ t) = 1 + X ^ (ℓ ^ t) := by
    have := add_pow_char_pow (R := (ZMod ℓ)[X]) (p := ℓ) (n := t) (x := 1) (y := X)
    simpa using this
  rw [hfrob] at hmul
  have hX : (∑ j ∈ range (ℓ ^ t), (1 + X : (ZMod ℓ)[X]) ^ j) * X = X ^ (ℓ ^ t - 1) * X := by
    rw [show ((1 : (ZMod ℓ)[X]) + X) - 1 = X by ring] at hmul
    rw [hmul, ← pow_succ, Nat.sub_add_cancel hℓ]
    ring
  exact mul_right_cancel₀ (Polynomial.X_ne_zero) hX

end IntegrableLattice
