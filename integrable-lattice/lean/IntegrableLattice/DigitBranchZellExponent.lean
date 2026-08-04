/-
# 命題 R の残り 2 件 — $\mathbb{Z}_\ell$ 指数の $(1+x)^\gamma$ と、$\mathrm{sep}$ についての帰納法 — cycle 35 step 1

対応する人手証明:

* 本文ブロック `paper_101_theorem_digit_branch`（命題 R）の (R1)(R3)
  （`structured-latex/content/009_theta_recursion.ts`）
* 同じ命題の枝分解と係数の取り出しは `DigitBranchRecursion.lean` にある。

## この file が埋めるもの

`DigitBranchRecursion.lean` は「形式化しなかったもの」として次の 2 件を挙げていた。
本 file はその 2 件を書く。

1. **$\mathbb{Z}_\ell$ 指数の $(1+x)^\gamma$**。本文の指数 $\gamma=pa+qb$ は
   $\mathbb{Z}_\ell$ に住むが、`DigitBranchRecursion.lean` は指数を $\mathbb{N}$ に取った
   多項式版で形式化していた。
2. **$\mathrm{sep}$ についての帰納法そのもの**。`DigitBranchRecursion.lean` は
   `L1_bound` で帰納段の算術だけを検算し、帰納法そのものは書いていなかった。

## 書いてみて分かったこと（2 件は同じ 1 本の補題に載る）

**$\mathbb{Z}_\ell$ の指数に意味を与えているのは、$\ell$ 進の位相でも完備性でもなく、
$(1+x)^{\ell^t}=1+x^{\ell^t}$ という 1 本の等式である。** これがあると

> 指数が $\ell^t$ を法として等しければ、次数 $<\ell^t$ の係数は一致する

が出る（`coeff_one_add_X_pow_congr`）。すなわち **$(1+x)^\gamma$ の次数 $\ell^t$ 未満の部分は
$\gamma\bmod\ell^t$ だけで決まる**ので、$\gamma\in\mathbb{Z}_\ell$ に対する $(1+x)^\gamma$ は
「各 $t$ での有限な切り捨て」の族として意味をもつ。極限を取る操作は要らない。

そして**同じ補題が $\mathrm{sep}$ の帰納法の土台でもある**。$\mathrm{sep}(a,b)$ は
「$\mathcal G$ の元が $\bmod\ \ell^{t}$ で相異なる最小の $t$」だったから、
$\mathcal G\subset\mathbb{Z}_\ell$ の元は $\bmod\ \ell^{\mathrm{sep}}$ の代表元で
（次数 $<\ell^{\mathrm{sep}}$ の範囲では）取り替えてよい。
**したがって $\mathbb{Z}_\ell$ 指数の族は、$\mathrm{sep}$ の深さまでは $\mathbb{N}$ 指数の族と
同じ多項式を与える**（`coeff_branchSum_padic_eq`）。台帳が別々の 2 件として挙げていたのは、
$\mathbb{Z}_\ell$ 側を切り捨てる深さを与えるのが $\mathrm{sep}$ そのものだ、という
繋がりを見ていなかったためである。

## 形式化した残りの段（cycle 35 step 1 で 2 件とも書いた）

* $\mathbb{Z}_\ell$ 指数の $(1+x)^\gamma$ — `zellPow` / `coeff_zellPow_eq` / `coeff_branchSum_padic_eq`
* $\mathrm{sep}$ についての帰納法 — `exists_coeff_ne_zero_of_sepAt` /
  `sep` / `exists_coeff_ne_zero_lt_pow_sep`

$\mathrm{sep}$ そのものも取ってある（`exists_sepAt` が存在を、`sep` が最小値を与える）ので、
本文の (R3) は仮定を置かない形で言えている。
-/
import Mathlib
import IntegrableLattice.DigitBranchRecursion

namespace IntegrableLattice
namespace PropRZellExponent

open Polynomial Finset

/-! ## 段 1: 指数は $\ell^t$ を法としてしか効かない

$(1+x)^{\ell^t}=1+x^{\ell^t}$ から、次数 $<\ell^t$ の係数が
指数の $\bmod\ \ell^t$ だけで決まることを出す。これが本 file の土台である。 -/

section Congr

variable {R : Type*} [CommRing R]

/-- $(1+x)^{\ell^t}=1+x^{\ell^t}$（Frobenius の $t$ 回反復）。 -/
theorem one_add_X_pow_ell_pow (ℓ t : ℕ) [ExpChar R ℓ] :
    ((1 : R[X]) + X) ^ (ℓ ^ t) = 1 + X ^ (ℓ ^ t) := by
  have h := add_pow_expChar_pow (R := R[X]) (p := ℓ) (n := t) 1 X
  simpa using h

/-- $x^{\ell^t}$ は $(1+x)^{\ell^t k}-1$ を割る。 -/
theorem X_pow_dvd_one_add_X_pow_mul_sub_one (ℓ t k : ℕ) [ExpChar R ℓ] :
    (X : R[X]) ^ (ℓ ^ t) ∣ (1 + X) ^ (ℓ ^ t * k) - 1 := by
  have h : ((1 : R[X]) + X) ^ (ℓ ^ t * k) = (1 + X ^ (ℓ ^ t)) ^ k := by
    rw [pow_mul, one_add_X_pow_ell_pow]
  rw [h]
  have hd := sub_dvd_pow_sub_pow (1 + X ^ (ℓ ^ t) : R[X]) 1 k
  simpa using hd

/-- **指数の橋渡し（本 file の土台）**。指数が $\ell^t$ を法として等しければ、
次数 $<\ell^t$ の係数は一致する。

**$\mathbb{Z}_\ell$ の指数に意味を与えているのはこの 1 本である。**
極限も完備性も使わず、効くのは $(1+x)^{\ell^t}=1+x^{\ell^t}$ だけである。 -/
theorem coeff_one_add_X_pow_congr (ℓ t : ℕ) [ExpChar R ℓ] {m n : ℕ}
    (hmn : m % ℓ ^ t = n % ℓ ^ t) {i : ℕ} (hi : i < ℓ ^ t) :
    ((1 + X : R[X]) ^ m).coeff i = ((1 + X : R[X]) ^ n).coeff i := by
  -- 主張は $m$ と $n$ について対称なので、$n\le m$ の場合に帰着する。
  rcases le_total n m with hle | hle
  · obtain ⟨k, hk⟩ : ℓ ^ t ∣ m - n := (Nat.modEq_iff_dvd' hle).mp hmn.symm
    have hm : m = n + ℓ ^ t * k := by omega
    obtain ⟨q, hq⟩ := X_pow_dvd_one_add_X_pow_mul_sub_one (R := R) ℓ t k
    have hdiff : ((1 + X : R[X]) ^ m - (1 + X) ^ n) = ((1 + X) ^ n * q) * X ^ (ℓ ^ t) := by
      have hsplit : (1 + X : R[X]) ^ (ℓ ^ t * k) = 1 + X ^ (ℓ ^ t) * q := by
        rw [← hq]; ring
      rw [hm, pow_add, hsplit]; ring
    have hzero : ((1 + X : R[X]) ^ m - (1 + X) ^ n).coeff i = 0 := by
      rw [hdiff, coeff_mul_X_pow', if_neg (by omega)]
    rw [coeff_sub, sub_eq_zero] at hzero
    exact hzero
  · obtain ⟨k, hk⟩ : ℓ ^ t ∣ n - m := (Nat.modEq_iff_dvd' hle).mp hmn
    have hn : n = m + ℓ ^ t * k := by omega
    obtain ⟨q, hq⟩ := X_pow_dvd_one_add_X_pow_mul_sub_one (R := R) ℓ t k
    have hdiff : ((1 + X : R[X]) ^ n - (1 + X) ^ m) = ((1 + X) ^ m * q) * X ^ (ℓ ^ t) := by
      have hsplit : (1 + X : R[X]) ^ (ℓ ^ t * k) = 1 + X ^ (ℓ ^ t) * q := by
        rw [← hq]; ring
      rw [hn, pow_add, hsplit]; ring
    have hzero : ((1 + X : R[X]) ^ n - (1 + X) ^ m).coeff i = 0 := by
      rw [hdiff, coeff_mul_X_pow', if_neg (by omega)]
    rw [coeff_sub, sub_eq_zero] at hzero
    exact hzero.symm

end Congr

/-! ## 段 2: $\mathbb{Z}_\ell$ 指数の $(1+x)^\gamma$

段 1 から、$\gamma\in\mathbb{Z}_\ell$ に対する $(1+x)^\gamma$ は
「次数 $<\ell^t$ の部分」として $t$ ごとに意味をもつ。
指数として $\gamma\bmod\ell^t$ の代表元を取る。 -/

section Padic

variable {R : Type*} [CommRing R]

/-- $\gamma\in\mathbb{Z}_\ell$ に対する $(1+x)^\gamma$ の、次数 $<\ell^t$ までの部分。
指数を $\gamma\bmod\ell^{t}$ の標準代表元に取る。 -/
noncomputable def zellPow (ℓ : ℕ) [Fact (Nat.Prime ℓ)] (t : ℕ) (γ : ℤ_[ℓ]) : R[X] :=
  (1 + X) ^ ((PadicInt.toZModPow t γ).val)

/-- **$\mathbb{Z}_\ell$ 指数が well-defined であること**。
$\gamma$ を $\bmod\ \ell^{t}$ で近似する自然数 $m$ を何に取っても、
次数 $<\ell^{t}$ の係数は同じである。 -/
theorem coeff_zellPow_eq (ℓ : ℕ) [Fact (Nat.Prime ℓ)] [ExpChar R ℓ] (t : ℕ) (γ : ℤ_[ℓ]) {m : ℕ}
    (hm : (m : ZMod (ℓ ^ t)) = PadicInt.toZModPow t γ) {i : ℕ} (hi : i < ℓ ^ t) :
    ((1 + X : R[X]) ^ m).coeff i = (zellPow (R := R) ℓ t γ).coeff i := by
  haveI : NeZero (ℓ ^ t) := ⟨pow_ne_zero _ (Fact.out (p := Nat.Prime ℓ)).pos.ne'⟩
  refine coeff_one_add_X_pow_congr ℓ t ?_ hi
  -- 両辺の指数はどちらも `ZMod (ℓ ^ t)` の同じ元の値なので、`ℓ ^ t` を法として等しい。
  have h1 : m % ℓ ^ t = (PadicInt.toZModPow t γ).val := by
    rw [← ZMod.val_natCast, hm]
  have h2 : (PadicInt.toZModPow t γ).val % ℓ ^ t = (PadicInt.toZModPow t γ).val :=
    Nat.mod_eq_of_lt (ZMod.val_lt _)
  rw [h1, h2]

end Padic

/-! ## 段 3: 指数の族と、その枝分解

以降、指数の有限族 $G$ と重み $\mu$ から作る多項式 $\sum_{\gamma\in G}\mu_\gamma(1+x)^\gamma$ を
扱う。本文の $\overline{\Phi_{(a,b)}}$ にあたる。 -/

section BranchSum

variable {R : Type*} [CommRing R]

/-- 指数の有限族 $G$ と重み $\mu$ から作る多項式（本文の $\overline{\Phi_{(a,b)}}$）。 -/
noncomputable def branchSum (G : Finset ℕ) (mu : ℕ → R) : R[X] :=
  ∑ γ ∈ G, C (mu γ) * (1 + X) ^ γ

/-- 第 0 桁が $c$ の指数を集めて $\ell$ で押し下げた族（本文の $\mathcal G_c$）。 -/
noncomputable def branchIndex (ℓ c : ℕ) (G : Finset ℕ) : Finset ℕ :=
  (G.filter (fun γ => γ % ℓ = c)).image (fun γ => γ / ℓ)

/-- 押し下げた族の上の重み（本文の $\mu_{c+\ell\gamma}$）。 -/
noncomputable def branchWeight (ℓ c : ℕ) (mu : ℕ → R) : ℕ → R :=
  fun k => mu (c + ℓ * k)

/-- 押し下げは第 0 桁を固定した範囲で単射である。 -/
theorem branchIndex_injOn (ℓ c : ℕ) (G : Finset ℕ) :
    Set.InjOn (fun γ => γ / ℓ) (G.filter (fun γ => γ % ℓ = c)) := by
  intro γ hγ δ hδ h
  have hγc : γ % ℓ = c := (Finset.mem_filter.mp hγ).2
  have hδc : δ % ℓ = c := (Finset.mem_filter.mp hδ).2
  have hγd : ℓ * (γ / ℓ) + γ % ℓ = γ := Nat.div_add_mod γ ℓ
  have hδd : ℓ * (δ / ℓ) + δ % ℓ = δ := Nat.div_add_mod δ ℓ
  simp only at h
  rw [h] at hγd
  omega

/-- **本文の (R1)（桁枝分解）**。
$\overline{\Phi}=\sum_{c<\ell}(1+x)^{c}\,g_c(x^{\ell})$。 -/
theorem branchSum_decomposition (ℓ : ℕ) [ExpChar R ℓ] (hℓ : 0 < ℓ) (G : Finset ℕ) (mu : ℕ → R) :
    branchSum G mu
      = ∑ c ∈ range ℓ, (1 + X : R[X]) ^ c *
          expand R ℓ (branchSum (branchIndex ℓ c G) (branchWeight ℓ c mu)) := by
  classical
  rw [branchSum, branch_decomposition ℓ hℓ G mu]
  refine Finset.sum_congr rfl fun c _ => ?_
  congr 1
  -- 押し下げた族の上の和へ、単射性を使って添字を移す。
  rw [branchSum, branchIndex, map_sum,
    Finset.sum_image (fun γ hγ δ hδ h => branchIndex_injOn ℓ c G hγ hδ h)]
  refine Finset.sum_congr rfl fun γ hγ => ?_
  have hγc : γ % ℓ = c := (Finset.mem_filter.mp hγ).2
  have hγd : c + ℓ * (γ / ℓ) = γ := by
    rw [← hγc, Nat.add_comm]
    exact Nat.div_add_mod γ ℓ
  simp only [branchWeight, hγd, map_mul, expand_C, map_pow, map_add, map_one, expand_X]

end BranchSum

/-! ## 段 4: $\mathrm{sep}$ についての帰納法

本文の (R3) は「$\mathcal G$ の元が $\bmod\ \ell^{t}$ で相異なるなら、再帰は深さ $t$ で止まり
$\theta\le\ell^{t}-1$」である。$t$ についての帰納法で書く。

`DigitBranchRecursion.lean` は帰納段の算術（`L1_bound`）と、
打ち消しが起きないこと（`exists_coeff_ne_zero_of_branches`）を持っている。
本 file はその 2 つを繋ぐ帰納法そのものを書く。 -/

section Sep

variable {R : Type*} [CommRing R]

/-- 指数が $\bmod\ \ell^{t}$ で相異なること（本文の $\mathrm{sep}(a,b)\le t$）。 -/
def SepAt (ℓ t : ℕ) (G : Finset ℕ) : Prop :=
  ∀ γ ∈ G, ∀ δ ∈ G, γ % ℓ ^ t = δ % ℓ ^ t → γ = δ

/-- 第 0 桁を揃えた 2 つの指数が押し下げたところで $\bmod\ \ell^{t}$ で一致するなら、
もとの指数は $\bmod\ \ell^{t+1}$ で一致する。分離性が 1 段浅くなることの算術の中身。 -/
theorem mod_pow_succ_of_mod_pow {ℓ t c γ δ : ℕ}
    (hγd : ℓ * (γ / ℓ) + c = γ) (hδd : ℓ * (δ / ℓ) + c = δ)
    (h : γ / ℓ % ℓ ^ t = δ / ℓ % ℓ ^ t) :
    γ % ℓ ^ (t + 1) = δ % ℓ ^ (t + 1) := by
  rcases le_total (δ / ℓ) (γ / ℓ) with hle | hle
  · obtain ⟨u, hu⟩ := (Nat.modEq_iff_dvd' hle).mp h.symm
    have hk : γ / ℓ = δ / ℓ + ℓ ^ t * u := by rw [← hu]; omega
    have hg : γ = δ + ℓ ^ (t + 1) * u := by
      calc γ = ℓ * (γ / ℓ) + c := hγd.symm
        _ = ℓ * (δ / ℓ + ℓ ^ t * u) + c := by rw [hk]
        _ = ℓ * (δ / ℓ) + c + ℓ ^ (t + 1) * u := by rw [pow_succ]; ring
        _ = δ + ℓ ^ (t + 1) * u := by rw [hδd]
    rw [hg, Nat.add_mul_mod_self_left]
  · obtain ⟨u, hu⟩ := (Nat.modEq_iff_dvd' hle).mp h
    have hk : δ / ℓ = γ / ℓ + ℓ ^ t * u := by rw [← hu]; omega
    have hg : δ = γ + ℓ ^ (t + 1) * u := by
      calc δ = ℓ * (δ / ℓ) + c := hδd.symm
        _ = ℓ * (γ / ℓ + ℓ ^ t * u) + c := by rw [hk]
        _ = ℓ * (γ / ℓ) + c + ℓ ^ (t + 1) * u := by rw [pow_succ]; ring
        _ = γ + ℓ ^ (t + 1) * u := by rw [hγd]
    rw [hg, Nat.add_mul_mod_self_left]

/-- 押し下げた族は 1 段浅い分離性をもつ。 -/
theorem sepAt_branchIndex {ℓ t c : ℕ} {G : Finset ℕ}
    (hG : SepAt ℓ (t + 1) G) : SepAt ℓ t (branchIndex ℓ c G) := by
  classical
  intro k hk k' hk' hkk'
  rw [branchIndex, Finset.mem_image] at hk hk'
  obtain ⟨γ, hγ, rfl⟩ := hk
  obtain ⟨δ, hδ, rfl⟩ := hk'
  have hγc : γ % ℓ = c := (Finset.mem_filter.mp hγ).2
  have hδc : δ % ℓ = c := (Finset.mem_filter.mp hδ).2
  have hγG : γ ∈ G := (Finset.mem_filter.mp hγ).1
  have hδG : δ ∈ G := (Finset.mem_filter.mp hδ).1
  have hγd : ℓ * (γ / ℓ) + c = γ := by rw [← hγc]; exact Nat.div_add_mod γ ℓ
  have hδd : ℓ * (δ / ℓ) + c = δ := by rw [← hδc]; exact Nat.div_add_mod δ ℓ
  have hstep := hG γ hγG δ hδG (mod_pow_succ_of_mod_pow hγd hδd hkk')
  rw [hstep]

/-- **本文の (R3)（有限性と有効上界）**。
指数が $\bmod\ \ell^{t}$ で相異なり、重みのどれかが $0$ でなければ、
$\overline{\Phi}$ は次数 $\ell^{t}$ 未満に $0$ でない係数をもつ。
すなわち $\theta\le\ell^{t}-1<\infty$ で、**打ち消しでは消えない**。 -/
theorem exists_coeff_ne_zero_of_sepAt (ℓ : ℕ) [ExpChar R ℓ] (hℓ : 0 < ℓ) :
    ∀ (t : ℕ) (G : Finset ℕ) (mu : ℕ → R), SepAt ℓ t G → (∃ γ ∈ G, mu γ ≠ 0) →
      ∃ i < ℓ ^ t, (branchSum G mu).coeff i ≠ 0 := by
  classical
  intro t
  induction t with
  | zero =>
    -- $\bmod\ \ell^0=1$ で相異なる、とは「元が高々 1 つ」ということ。
    intro G mu hG hne
    obtain ⟨γ, hγ, hmu⟩ := hne
    refine ⟨0, by simp, ?_⟩
    have hsingle : G = {γ} := by
      refine Finset.eq_singleton_iff_unique_mem.mpr ⟨hγ, fun δ hδ => ?_⟩
      exact hG δ hδ γ hγ (by rw [pow_zero, Nat.mod_one, Nat.mod_one])
    rw [branchSum, hsingle]
    simpa [coeff_one_add_X_pow] using hmu
  | succ t ih =>
    intro G mu hG hne
    obtain ⟨γ₀, hγ₀, hmu₀⟩ := hne
    set g : ℕ → R[X] :=
      fun c => branchSum (branchIndex ℓ c G) (branchWeight ℓ c mu) with hg_def
    -- 第 0 桁が $\gamma_0$ のものと同じ枝は、帰納法の仮定を満たす。
    have hc₀ : γ₀ % ℓ ∈ range ℓ := Finset.mem_range.mpr (Nat.mod_lt _ hℓ)
    have hmem₀ : γ₀ / ℓ ∈ branchIndex ℓ (γ₀ % ℓ) G := by
      rw [branchIndex, Finset.mem_image]
      exact ⟨γ₀, Finset.mem_filter.mpr ⟨hγ₀, rfl⟩, rfl⟩
    have hw₀ : branchWeight ℓ (γ₀ % ℓ) mu (γ₀ / ℓ) ≠ 0 := by
      have hd : γ₀ % ℓ + ℓ * (γ₀ / ℓ) = γ₀ := by
        rw [Nat.add_comm]; exact Nat.div_add_mod γ₀ ℓ
      rw [branchWeight, hd]
      exact hmu₀
    obtain ⟨i₀, hi₀, hne₀⟩ :=
      ih (branchIndex ℓ (γ₀ % ℓ) G) (branchWeight ℓ (γ₀ % ℓ) mu)
        (sepAt_branchIndex hG) ⟨γ₀ / ℓ, hmem₀, hw₀⟩
    -- 枝の最低次 $d$ を取る。存在は上の枝が保証する。
    have hex : ∃ k, ∃ c ∈ range ℓ, (g c).coeff k ≠ 0 := ⟨i₀, γ₀ % ℓ, hc₀, hne₀⟩
    set d := Nat.find hex with hd_def
    obtain ⟨cd, hcd, hcdne⟩ := Nat.find_spec hex
    have hmin : ∀ c ∈ range ℓ, ∀ k < d, (g c).coeff k = 0 := by
      intro c hc k hk
      by_contra hne'
      have hle : Nat.find hex ≤ k := Nat.find_le ⟨c, hc, hne'⟩
      omega
    have hdlt : d < ℓ ^ t := by
      have hle : d ≤ i₀ := Nat.find_le ⟨γ₀ % ℓ, hc₀, hne₀⟩
      omega
    -- 打ち消しが起きないこと（`DigitBranchRecursion.lean`）を当てる。
    set Cd : Finset ℕ := (range ℓ).filter (fun c => (g c).coeff d ≠ 0) with hCd_def
    have hCdne : Cd.Nonempty := ⟨cd, Finset.mem_filter.mpr ⟨hcd, hcdne⟩⟩
    have hCdr : Cd ⊆ range ℓ := Finset.filter_subset _ _
    obtain ⟨s, hs, _, hcoeff⟩ :=
      exists_coeff_ne_zero_of_branches (R := R) ℓ d hℓ g hmin Cd hCdne hCdr
        (fun c hc => (Finset.mem_filter.mp hc).2)
        (fun c hc hcC => by
          by_contra hne'
          exact hcC (Finset.mem_filter.mpr ⟨hc, hne'⟩))
    refine ⟨ℓ * d + s, ?_, ?_⟩
    · -- $d\le\ell^{t}-1$ と $s\le\ell-1$ から $\ell d+s\le\ell^{t+1}-1$（`L1_bound`）。
      exact L1_bound ℓ (t + 1) d s (by omega) (by simpa using hdlt) hs
    · rw [branchSum_decomposition ℓ hℓ G mu]
      exact hcoeff

/-- 十分深く取れば指数は相異なる（$\mathrm{sep}$ が意味をもつこと）。
指数の族が有限なので、$\ell^{t}$ が全部の指数を越える深さを取ればよい。 -/
theorem exists_sepAt {ℓ : ℕ} (hℓ : 1 < ℓ) (G : Finset ℕ) : ∃ t, SepAt ℓ t G := by
  classical
  set N := G.sup id + 1 with hN_def
  have hN : ∀ γ ∈ G, γ < N := fun γ hγ =>
    Nat.lt_succ_of_le (Finset.le_sup (f := id) hγ)
  have hpow : N < ℓ ^ N := Nat.lt_pow_self hℓ
  refine ⟨N, fun γ hγ δ hδ h => ?_⟩
  have h1 : γ % ℓ ^ N = γ := Nat.mod_eq_of_lt (lt_trans (hN γ hγ) hpow)
  have h2 : δ % ℓ ^ N = δ := Nat.mod_eq_of_lt (lt_trans (hN δ hδ) hpow)
  rw [h1, h2] at h
  exact h

open scoped Classical in
/-- **本文の $\mathrm{sep}(a,b)$**。指数が $\bmod\ \ell^{t}$ で相異なるようになる最小の深さ。 -/
noncomputable def sep (ℓ : ℕ) (hℓ : 1 < ℓ) (G : Finset ℕ) : ℕ :=
  Nat.find (exists_sepAt hℓ G)

open scoped Classical in
/-- **本文の (R3) そのもの**。$\mathcal G\neq\emptyset$ なら
$\theta(a,b)\le\ell^{\mathrm{sep}(a,b)}-1<\infty$。

$\mathrm{sep}$ の深さで指数が相異なることは `Nat.find_spec` が与える。 -/
theorem exists_coeff_ne_zero_lt_pow_sep (ℓ : ℕ) [ExpChar R ℓ] (hℓ : 1 < ℓ)
    (G : Finset ℕ) (mu : ℕ → R) (hne : ∃ γ ∈ G, mu γ ≠ 0) :
    ∃ i < ℓ ^ sep ℓ hℓ G, (branchSum G mu).coeff i ≠ 0 :=
  exists_coeff_ne_zero_of_sepAt ℓ (by omega) _ G mu (Nat.find_spec (exists_sepAt hℓ G)) hne

end Sep

/-! ## 段 5: $\mathbb{Z}_\ell$ 指数の族を $\mathbb{N}$ 指数の族で置き換えてよいこと

段 2 と段 4 を繋ぐ。$\mathcal G\subset\mathbb{Z}_\ell$ の元を $\bmod\ \ell^{t}$ の
標準代表元で置き換えると、次数 $<\ell^{t}$ の範囲では同じ多項式になる。
**$\mathrm{sep}$ が「代表元に取り替えてよい深さ」を与えている**ので、
台帳が別々に挙げていた 2 件は 1 本の補題の両面である。 -/

section PadicFamily

variable {R : Type*} [CommRing R]

/-- **$\mathbb{Z}_\ell$ 指数の族と $\mathbb{N}$ 指数の族が、次数 $<\ell^{t}$ で一致すること**。

`lift` は各 $\gamma\in\mathcal G$ に対して $\bmod\ \ell^{t}$ の近似を与える自然数である。 -/
theorem coeff_branchSum_padic_eq (ℓ : ℕ) [Fact (Nat.Prime ℓ)] [ExpChar R ℓ] (t : ℕ)
    (Gp : Finset ℤ_[ℓ]) (mu : ℤ_[ℓ] → R) (lift : ℤ_[ℓ] → ℕ)
    (hlift : ∀ γ ∈ Gp, ((lift γ : ℕ) : ZMod (ℓ ^ t)) = PadicInt.toZModPow t γ)
    {i : ℕ} (hi : i < ℓ ^ t) :
    (∑ γ ∈ Gp, C (mu γ) * (1 + X : R[X]) ^ (lift γ)).coeff i
      = (∑ γ ∈ Gp, C (mu γ) * zellPow (R := R) ℓ t γ).coeff i := by
  classical
  rw [finsetSum_coeff, finsetSum_coeff]
  refine Finset.sum_congr rfl fun γ hγ => ?_
  rw [coeff_C_mul, coeff_C_mul, coeff_zellPow_eq ℓ t γ (hlift γ hγ) hi]

end PadicFamily

end PropRZellExponent
end IntegrableLattice
