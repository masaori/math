/-
# 命題 B（$\pi(p,1)$ の精密公式）— 等式本体、および**人手証明の主張の訂正**

対応する人手証明:
`integrable-lattice/outputs/paper-plans/002_R_Lambda_duality.md` §2 **命題 B**
（根拠 report: `sagemath/check/cycle3_T3_period/pi_p1_refined_README.md`（cycle 8）、
`outputs/reports/cycle3_T1_D-U2_rigorous.md`）。
片方向（$\operatorname{lcm}\mid$ 行列の位数）は `PropB.lean` にある。

## 訂正（重要）: 人手証明のステートメントはそのままでは**偽**である

人手証明は 2 つの異なる量に同じ記号 $\pi(p,1)$ を使っている。

* **命題 A** は $\pi(p,k)$ を「**行列冪列** $(T^N\bmod p^k)_N$ の最終周期」と定義する
  （`002` §2 命題 A、`cycle3_T1_D-U2_rigorous.md` 冒頭 1.）。
* **命題 B** の証明が実際に計算しているのは「**トレース列** $(Z_N\bmod p)_N=(\operatorname{Tr}T^N\bmod p)_N$
  の最終周期」である（証明は $Z_N\bmod p=\sum_\lambda m_\lambda\lambda^N$ と指標の一次独立だけを使う）。
  cycle 8 の検証スクリプト `pi_p1_refined.sage` の `trace_period_mod_p` も**トレース列の周期**を返している。

この 2 つは一般には**一致しない**。反例（本ファイルで形式化した）:
$$T=\begin{pmatrix}0&1\\1&1\end{pmatrix}\oplus\begin{pmatrix}0&1\\1&1\end{pmatrix}\in M_4(\mathbb{Z}),
\qquad p=2,\quad \det T=1\ (\text{よって }p\nmid\det T).$$
$\chi_T=(x^2+x+1)^2 \pmod 2$ で $x^2+x+1$ は $\mathbb{F}_2$ 上既約だから、相異なる固有値は
$\overline{\mathbb{F}_2}$ の 1 の原始 3 乗根 $\omega,\omega^2$ の 2 つで、**どちらも代数的重複度 $m_\lambda=2$**。
よって $p\mid m_\lambda$ が全固有値で成り立ち、命題 B の右辺は空集合の lcm ＝ $1$ である。
一方、行列の位数（＝命題 A の $\pi(2,1)$）は $3$ である（`orderOf_cexMat`）。
トレース列は恒等的に $0$（`trace_cexMat_pow`）で周期 $1$ ＝ 右辺と一致する。

**したがって、命題 B は「$\pi(p,1)$ ＝ 行列冪列の最終周期」と読む限り偽であり、
「トレース列 $(Z_N\bmod p)_N$ の最終周期」と読めば正しい。**
命題 A が $\min(v_p(Z_N),k)$ の周期について述べているのは
「$\pi(p,k)$ を**割る**」という整除だけなので、命題 A 自体はこの訂正に影響されない
（トレース列の周期は行列冪列の周期を割る）。

## 形式化した主張（訂正後の命題 B。**両方向**）

以下、$K$ は任意の体（$\overline{\mathbb{F}_p}$ を含む）。$s\subseteq K$ は相異なる非零元の有限集合、
$c:K\to K$ は係数（$c_\lambda=m_\lambda\bmod p$ に対応）、
$f(N)=\sum_{\mu\in s}c_\mu\mu^N$（`expSum`）とする。

* `eq_zero_of_expSum_pow_eq_zero` — 相異なる $\mu$ について $\sum_\mu d_\mu\mu^m=0$ が全ての $m$ で
  成り立てば $d\equiv0$（**指標の一次独立**。Vandermonde 行列式で証明した）。
* `expSum_eventually_periodic_iff` — $t$ が $f$ の（$N_0$ 以降の）周期 $\iff$
  $c_\mu\neq0$ なる全ての $\mu$ で $\mu^t=1$。**両方向**を含む。
* `expSum_eventually_periodic_iff_lcm_dvd` — 同じことを整除で述べた版:
  $t$ が周期 $\iff \operatorname{lcm}\{\operatorname{ord}(\mu):c_\mu\neq0\}\mid t$。
  $(\Leftarrow)$ が `PropB.lean` にあった片方向に対応し、$(\Rightarrow)$ が**本 step で足した逆方向**である。
* `isLeast_period_expSum` — よって最小の正の周期はちょうど $\operatorname{lcm}$ である（等式本体）。
* `trace_pow_eventually_periodic_iff_lcm_dvd` — トレース列に移した版
  （$\operatorname{Tr}(A^N)=\sum_\mu c_\mu\mu^N$ を仮定 `htr` として受け取る、行列で述べた形）。
* `trace_pow_restrict_maxGenEigenspace` / `trace_pow_eq_sum_maxGenEigenspace` —
  **人手証明の第 1 段** $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$ を、
  代数閉体上の一般化固有空間分解から証明した（$m_\lambda=\dim V_\lambda$。
  `finrank_maxGenEigenspace_eq_rootMultiplicity` で $\chi_f$ の根の重複度に一致する）。
* `trace_pow_eventually_periodic_iff` — **仮定なしの完成形**。$K$ 代数閉・固有値がすべて非零
  （＝ $f$ 可逆。人手証明の $p\nmid\det T$ に対応）のとき、
  $t$ がトレース列の周期 $\iff \operatorname{lcm}\{\operatorname{ord}(\lambda):m_\lambda\neq0\text{ in }K\}\mid t$。
  `natCast_ne_zero_iff_not_dvd` により、標数 $p$ では条件「$m_\lambda\neq0$ in $K$」は
  人手証明の「$p\nmid m_\lambda$」そのものである。

## 形式化していない段（正直に明記する）

* **具体行列 $T\bmod p$ から $\overline{\mathbb{F}_p}$ への係数拡大**（$M_d(\mathbb{Z}/p)$ の行列を
  $\overline{\mathbb{F}_p}$ 上の自己準同型として見る移送）は形式化していない。
  上の完成形は $\overline{\mathbb{F}_p}$ 上の自己準同型について述べてあり、
  反例 `cexMat` の側は $\mathbb{Z}/2$ 上でトレースを直接計算している。
  この 2 つを Lean 内部で繋ぐには係数拡大の移送が要る（トレースは環準同型で保たれるので数学的には自明）。
* したがって「反例の右辺が $1$ である」ことは**手計算**（$\chi_T=(x^2+x+1)^2$、
  相異なる固有値の重複度がともに $2$）に依っており、Lean が示しているのは
  $\operatorname{ord}(T\bmod 2)=3$ と $\operatorname{Tr}(T^N)\equiv0$ の 2 つである。
  この 2 つだけでも「行列冪列の周期 $\neq$ トレース列の周期」は確定する。

## 可算・非可算

すべて有限集合・有限体・有限次行列の純代数の主張であり、$\mathbb{R}$ へは脱出していない。

**新規性は主張しない**（指標の一次独立＝Artin–Dedekind、線形漸化列の周期は古典）。
-/
import Mathlib

namespace IntegrableLattice

open Finset Matrix

variable {K : Type*} [Field K]

/-- 相異なる（非零の）$\mu\in s$ による指数和 $f(N)=\sum_{\mu\in s}c_\mu\mu^N$。 -/
noncomputable def expSum (s : Finset K) (c : K → K) (N : ℕ) : K := ∑ μ ∈ s, c μ * μ ^ N

/-- **指標の一次独立**（Vandermonde 版）: 相異なる $\mu\in s$ について
$\sum_{\mu\in s}d_\mu\mu^m=0$ が全ての $m\in\mathbb{N}$ で成り立つなら、$s$ 上 $d=0$。 -/
theorem eq_zero_of_expSum_pow_eq_zero (s : Finset K) (d : K → K)
    (h : ∀ m : ℕ, ∑ μ ∈ s, d μ * μ ^ m = 0) : ∀ μ ∈ s, d μ = 0 := by
  classical
  set e := s.equivFin with he
  set v : Fin s.card → K := fun i => (e.symm i : K) with hv
  have hvinj : Function.Injective v := by
    intro i j hij
    exact e.symm.injective (Subtype.ext hij)
  -- Finset 上の和を Fin s.card 上の和へ移す
  have hsum : ∀ g : K → K, ∑ μ ∈ s, g μ = ∑ i : Fin s.card, g (v i) := by
    intro g
    rw [← Finset.sum_coe_sort s g]
    exact (Equiv.sum_comp e.symm fun x : s => g (x : K)).symm
  set d' : Fin s.card → K := fun i => d (v i) with hd'
  have hmul : (Matrix.vandermonde v)ᵀ *ᵥ d' = 0 := by
    funext m
    have := h (m : ℕ)
    rw [hsum] at this
    simpa [Matrix.mulVec, dotProduct, Matrix.vandermonde, mul_comm] using this
  have hdet : (Matrix.vandermonde v)ᵀ.det ≠ 0 := by
    rw [Matrix.det_transpose]
    exact (Matrix.det_vandermonde_ne_zero_iff).2 hvinj
  have hzero : d' = 0 := Matrix.eq_zero_of_mulVec_eq_zero hdet hmul
  intro μ hμ
  have : d' (e ⟨μ, hμ⟩) = 0 := by rw [hzero]; rfl
  simpa [hd', hv] using this

/-- **訂正後の命題 B（核）**: $t$ が指数和 $f$ の（$N_0$ 以降の）周期であることは、
$c_\mu\neq0$ なる全ての $\mu$ について $\mu^t=1$ であることと**同値**。 -/
theorem expSum_eventually_periodic_iff (s : Finset K) (c : K → K) (hs0 : ∀ μ ∈ s, μ ≠ 0)
    (N₀ t : ℕ) :
    (∀ N, N₀ ≤ N → expSum s c (N + t) = expSum s c N) ↔ ∀ μ ∈ s, c μ ≠ 0 → μ ^ t = 1 := by
  constructor
  · intro h μ hμ hcμ
    -- $d_\mu=c_\mu(\mu^t-1)\mu^{N_0}$ に一次独立を当てる
    set d : K → K := fun μ => c μ * (μ ^ t - 1) * μ ^ N₀ with hd
    have hzero : ∀ ν ∈ s, d ν = 0 := by
      refine eq_zero_of_expSum_pow_eq_zero s d ?_
      intro m
      have hm := h (N₀ + m) (Nat.le_add_right _ _)
      have : ∑ ν ∈ s, d ν * ν ^ m
          = expSum s c (N₀ + m + t) - expSum s c (N₀ + m) := by
        simp only [hd, expSum, ← Finset.sum_sub_distrib]
        refine Finset.sum_congr rfl fun ν _ => ?_
        rw [pow_add, pow_add]
        ring
      rw [this, hm, sub_self]
    have h0 := hzero μ hμ
    have hne : (μ : K) ^ N₀ ≠ 0 := pow_ne_zero _ (hs0 μ hμ)
    have : c μ * (μ ^ t - 1) = 0 := by
      rcases mul_eq_zero.mp h0 with h' | h'
      · exact h'
      · exact absurd h' hne
    rcases mul_eq_zero.mp this with h' | h'
    · exact absurd h' hcμ
    · exact sub_eq_zero.mp h'
  · intro h N _
    refine Finset.sum_congr rfl fun μ hμ => ?_
    by_cases hc : c μ = 0
    · simp [hc]
    · rw [pow_add, h μ hμ hc, mul_one]

/-- **訂正後の命題 B（整除の形。両方向）**: $t$ が周期 $\iff$
$\operatorname{lcm}\{\operatorname{ord}(\mu):\mu\in s,\ c_\mu\neq0\}\mid t$。 -/
theorem expSum_eventually_periodic_iff_lcm_dvd [DecidableEq K] (s : Finset K) (c : K → K)
    [DecidablePred fun μ : K => c μ ≠ 0] (hs0 : ∀ μ ∈ s, μ ≠ 0) (N₀ t : ℕ) :
    (∀ N, N₀ ≤ N → expSum s c (N + t) = expSum s c N)
      ↔ (s.filter fun μ => c μ ≠ 0).lcm orderOf ∣ t := by
  rw [expSum_eventually_periodic_iff s c hs0 N₀ t]
  constructor
  · intro h
    refine Finset.lcm_dvd ?_
    intro μ hμ
    rw [Finset.mem_filter] at hμ
    exact orderOf_dvd_of_pow_eq_one (h μ hμ.1 hμ.2)
  · intro h μ hμ hc
    have : orderOf μ ∣ t :=
      dvd_trans (Finset.dvd_lcm (Finset.mem_filter.2 ⟨hμ, hc⟩)) h
    exact orderOf_dvd_iff_pow_eq_one.mp this

/-- **等式本体**: 最小の正の周期はちょうど $\operatorname{lcm}\{\operatorname{ord}(\mu):c_\mu\neq0\}$。
（$\operatorname{lcm}=0$（＝ある $\mu$ が無限位数）の退化ケースを除くために `hL` を置く。
有限体上ではつねに `hL` が成り立つ。） -/
theorem isLeast_period_expSum [DecidableEq K] (s : Finset K) (c : K → K)
    [DecidablePred fun μ : K => c μ ≠ 0] (hs0 : ∀ μ ∈ s, μ ≠ 0) (N₀ : ℕ)
    (hL : 0 < (s.filter fun μ => c μ ≠ 0).lcm orderOf) :
    IsLeast {t : ℕ | 0 < t ∧ ∀ N, N₀ ≤ N → expSum s c (N + t) = expSum s c N}
      ((s.filter fun μ => c μ ≠ 0).lcm orderOf) := by
  constructor
  · exact ⟨hL, (expSum_eventually_periodic_iff_lcm_dvd s c hs0 N₀ _).2 dvd_rfl⟩
  · rintro t ⟨ht, hper⟩
    exact Nat.le_of_dvd ht ((expSum_eventually_periodic_iff_lcm_dvd s c hs0 N₀ t).1 hper)

/-- **トレース列に移した命題 B**。仮定 `htr`（$\operatorname{Tr}(A^N)=\sum_\mu c_\mu\mu^N$）は
形式化していない段であり、外から与えている（ファイル冒頭を見よ）。 -/
theorem trace_pow_eventually_periodic_iff_lcm_dvd [DecidableEq K] {n : ℕ}
    (A : Matrix (Fin n) (Fin n) K) (s : Finset K) (c : K → K)
    [DecidablePred fun μ : K => c μ ≠ 0] (hs0 : ∀ μ ∈ s, μ ≠ 0)
    (htr : ∀ N : ℕ, (A ^ N).trace = expSum s c N) (N₀ t : ℕ) :
    (∀ N, N₀ ≤ N → (A ^ (N + t)).trace = (A ^ N).trace)
      ↔ (s.filter fun μ => c μ ≠ 0).lcm orderOf ∣ t := by
  rw [← expSum_eventually_periodic_iff_lcm_dvd s c hs0 N₀ t]
  constructor
  · intro h N hN
    rw [← htr, ← htr]
    exact h N hN
  · intro h N hN
    rw [htr, htr]
    exact h N hN

/-! ### $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$（人手証明の第 1 段） -/

section TraceIdentity

open Module Module.End LinearMap

variable {V : Type*} [AddCommGroup V] [Module K V] [FiniteDimensional K V]

/-- 一般化固有空間 $V_\mu$ へ制限した $f$ の $N$ 乗のトレースは $\mu^N\dim V_\mu$。
（$f|_{V_\mu}-\mu$ が冪零であることと、冪零部分のトレースが $0$ であることから従う。） -/
theorem trace_pow_restrict_maxGenEigenspace (f : Module.End K V) (μ : K) (N : ℕ) :
    trace K _ ((f.restrict (mapsTo_maxGenEigenspace_of_comm (Commute.refl f) μ)) ^ N)
      = μ ^ N * (finrank K (f.maxGenEigenspace μ) : K) := by
  set g := f.restrict (mapsTo_maxGenEigenspace_of_comm (Commute.refl f) μ) with hgdef
  have hnil : IsNilpotent (g - algebraMap K (Module.End K (f.maxGenEigenspace μ)) μ) := by
    have h := f.isNilpotent_restrict_maxGenEigenspace_sub_algebraMap μ
    have hres : (f - algebraMap K (Module.End K V) μ).restrict
        (mapsTo_maxGenEigenspace_of_comm (Algebra.mul_sub_algebraMap_commutes f μ) μ)
        = g - algebraMap K (Module.End K (f.maxGenEigenspace μ)) μ := by
      have hmapsAlg : Set.MapsTo (algebraMap K (Module.End K V) μ)
          ↑(f.maxGenEigenspace μ) ↑(f.maxGenEigenspace μ) := fun x hx => by
        simpa [Module.algebraMap_end_apply] using (f.maxGenEigenspace μ).smul_mem μ hx
      rw [hgdef, ← LinearMap.restrict_sub
        (mapsTo_maxGenEigenspace_of_comm (Commute.refl f) μ) hmapsAlg]
      congr 1
    rwa [hres] at h
  induction N with
  | zero => simp
  | succ N ih =>
    have hpow : (g ^ (N + 1) : Module.End K (f.maxGenEigenspace μ)) = (g ^ N) ∘ₗ g := by
      rw [pow_succ]; rfl
    rw [hpow, trace_comp_eq_mul_of_commute_of_isNilpotent μ
      ((Commute.refl g).pow_left N) hnil, ih]
    ring

/-- **人手証明の第 1 段**（$K$ が代数閉のとき）: $\operatorname{Tr}(f^N)=\sum_\lambda m_\lambda\lambda^N$。
ここで $\lambda$ は $\chi_f$ の根、$m_\lambda=\dim V_\lambda$ は代数的重複度
（`Module.End.finrank_maxGenEigenspace_eq` により `charpoly.rootMultiplicity` に等しい）。 -/
theorem trace_pow_eq_sum_maxGenEigenspace [IsAlgClosed K] (f : Module.End K V) (N : ℕ)
    (hfin : {μ : K | f.maxGenEigenspace μ ≠ ⊥}.Finite) :
    trace K V (f ^ N)
      = ∑ μ ∈ hfin.toFinset, (finrank K (f.maxGenEigenspace μ) : K) * μ ^ N := by
  classical
  have hds : DirectSum.IsInternal fun μ : K => f.maxGenEigenspace μ :=
    DirectSum.isInternal_submodule_of_iSupIndep_of_iSup_eq_top
      f.independent_maxGenEigenspace f.iSup_maxGenEigenspace_eq_top
  have hmaps : ∀ μ : K, Set.MapsTo (f ^ N) ↑(f.maxGenEigenspace μ) ↑(f.maxGenEigenspace μ) :=
    fun μ => mapsTo_maxGenEigenspace_of_comm ((Commute.refl f).pow_right N) μ
  rw [LinearMap.trace_eq_sum_trace_restrict' hds hfin hmaps]
  refine Finset.sum_congr rfl fun μ _ => ?_
  rw [← Module.End.pow_restrict (f' := f) N (mapsTo_maxGenEigenspace_of_comm (Commute.refl f) μ),
    trace_pow_restrict_maxGenEigenspace f μ N, mul_comm]

/-- 上の重複度は特性多項式の根の重複度に等しい（mathlib の
`LinearMap.finrank_maxGenEigenspace_eq`）。人手証明の $m_\lambda$ はこれである。 -/
theorem finrank_maxGenEigenspace_eq_rootMultiplicity (f : Module.End K V) (μ : K) :
    (finrank K (f.maxGenEigenspace μ) : ℕ) = f.charpoly.rootMultiplicity μ :=
  LinearMap.finrank_maxGenEigenspace_eq f μ

/-- **訂正後の命題 B（仮定なしの完成形）**: $K$ が代数閉、$f$ の固有値がすべて非零（＝ $f$ 可逆。
人手証明の $p\nmid\det T$ に対応）のとき、$t$ が $N\mapsto\operatorname{Tr}(f^N)$ の
（$N_0$ 以降の）周期であることは
$\operatorname{lcm}\{\operatorname{ord}(\lambda):m_\lambda\neq0\text{ in }K\}\mid t$ と**同値**。
$\operatorname{char}K=p$ なら「$m_\lambda\neq0$ in $K$」は「$p\nmid m_\lambda$」に他ならない
（`natCast_ne_zero_iff_not_dvd`）。 -/
theorem trace_pow_eventually_periodic_iff [IsAlgClosed K] [DecidableEq K] (f : Module.End K V)
    (hfin : {μ : K | f.maxGenEigenspace μ ≠ ⊥}.Finite)
    (h0 : ∀ μ ∈ hfin.toFinset, μ ≠ 0)
    [DecidablePred fun μ : K => ((finrank K (f.maxGenEigenspace μ) : K) ≠ 0)] (N₀ t : ℕ) :
    (∀ N, N₀ ≤ N → trace K V (f ^ (N + t)) = trace K V (f ^ N))
      ↔ (hfin.toFinset.filter
          fun μ => ((finrank K (f.maxGenEigenspace μ) : K) ≠ 0)).lcm orderOf ∣ t := by
  have hexp : ∀ N : ℕ, trace K V (f ^ N)
      = expSum hfin.toFinset (fun μ => (finrank K (f.maxGenEigenspace μ) : K)) N := by
    intro N
    rw [trace_pow_eq_sum_maxGenEigenspace f N hfin]
    rfl
  rw [← expSum_eventually_periodic_iff_lcm_dvd hfin.toFinset
    (fun μ => (finrank K (f.maxGenEigenspace μ) : K)) h0 N₀ t]
  constructor
  · intro h N hN; rw [← hexp, ← hexp]; exact h N hN
  · intro h N hN; rw [hexp, hexp]; exact h N hN

/-- 標数 $p$ の体では「重複度 $m$ の像が $0$ でない」＝「$p\nmid m$」。
これが人手証明の条件 $p\nmid m_\lambda$ である。 -/
theorem natCast_ne_zero_iff_not_dvd (p : ℕ) [CharP K p] (m : ℕ) :
    ((m : K) ≠ 0) ↔ ¬ p ∣ m := by
  rw [Ne, CharP.cast_eq_zero_iff K p m]

end TraceIdentity

/-! ### 反例: 行列冪列の周期とトレース列の周期は一致しない

$T=\left(\begin{smallmatrix}0&1\\1&1\end{smallmatrix}\right)^{\oplus2}\bmod 2$。
$\det T=1$ なので $p\nmid\det T$（命題 A の仮定）を満たす。 -/

/-- 反例の行列（$\mathbb{Z}$ 上の $T$ を $\bmod\ 2$ したもの）。 -/
def cexMat : Matrix (Fin 4) (Fin 4) (ZMod 2) :=
  !![0, 1, 0, 0; 1, 1, 0, 0; 0, 0, 0, 1; 0, 0, 1, 1]

theorem cexMat_pow_three : cexMat ^ 3 = 1 := by decide

theorem cexMat_ne_one : cexMat ≠ 1 := by decide

/-- 行列冪列の最終周期（＝命題 A の $\pi(2,1)$）は $3$。 -/
theorem orderOf_cexMat : orderOf cexMat = 3 :=
  orderOf_eq_prime cexMat_pow_three cexMat_ne_one

/-- トレース列は恒等的に $0$。したがってトレース列の周期は $1$。 -/
theorem trace_cexMat_pow (N : ℕ) : (cexMat ^ N).trace = 0 := by
  have hN : N = 3 * (N / 3) + N % 3 := (Nat.div_add_mod N 3).symm
  have hlt : N % 3 < 3 := Nat.mod_lt _ (by norm_num)
  rw [hN, pow_add, pow_mul, cexMat_pow_three, one_pow, one_mul]
  interval_cases h : N % 3 <;> decide

/-- **反例の帰結**: 行列冪列の周期は $3$、トレース列の周期は $1$。
すなわち命題 B の $\pi(p,1)$ を「行列冪列の最終周期」と読むと偽になる。 -/
theorem cexMat_period_ne :
    orderOf cexMat = 3 ∧ (∀ N : ℕ, (cexMat ^ (N + 1)).trace = (cexMat ^ N).trace) :=
  ⟨orderOf_cexMat, fun N => by rw [trace_cexMat_pow, trace_cexMat_pow]⟩

end IntegrableLattice
