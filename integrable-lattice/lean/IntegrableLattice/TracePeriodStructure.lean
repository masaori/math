/-
# 命題 C″ (3) の構造の主張 $t_k=p^{e_k}\tau$、$e_k=\min\{m:g_m\ge k\}$ — cycle 38 step 3

対応する人手証明:

* 本文ブロック `paper_045_theorem_trace_ladder`（命題 C″）の (3)（構造）
* その証明の末尾「構造の主張は $p^m\tau$ が周期であることと $g_m\ge k$ が同値であることから従う」

## このファイルが埋めるもの

台帳が 命題 C″ の残りとして挙げていた 2 件のうちの 1 件、
すなわち **$e_k=\min\{m:g_m\ge k\}$ の同値**である。

芯は本文が 1 文で書いているとおり——**$p^m\tau$ がレベル $k$ の周期であることと
$g_m\ge k$ は同じことである。** $g_m$ は $\min_N v_p(\operatorname{Tr}(S^N(S^{p^m\tau}-I)))$ なので、
「$g_m\ge k$」は「すべての $N$ で $p^k$ が割る」と同じ文であり、
それがそのまま `IsTracePeriodAt` の定義である。

書かなければならないのは、そこから **最小周期 $t_k$ が $p^{e_k}\tau$ に一致すること**である。
これには 3 つ要る:

1. $p^{e}\tau$ がレベル $k$ の周期であること（$g_e\ge k$ から）。したがって $t_k\mid p^{e}\tau$。
2. $\tau\mid t_k$（$t_k$ はレベル $k$ の周期だからレベル $1$ の周期でもあり、
   $\tau$ がレベル $1$ の最小周期だから割る）。
3. 1 と 2 から $t_k=p^{m}\tau$（$m\le e$）と書け、それが周期なので $g_m\ge k$、
   $e$ の最小性から $e\le m$。よって $m=e$。

## $p$ の素数性について（正直に書く）

`PropCTracePeriod.lean` は「$p$ の素数性を使っていない」と書いており、本文もそう述べている。
**本ファイルは段 3 で $p$ が素数であることを使う。** $u\mid p^{e}$ から $u=p^{m}$ を出す段で、
素数冪の約数が素数冪であること（`Nat.dvd_prime_pow`）が要るためである。
これは階段の主張ではなく、**最小周期の形を決める段が要求している**ものである。

## 何が可算側で、どこで $\mathbb{R}$ へ出るか

**この file は $\mathbb{R}$ へ 1 度も出ない。** 扱うのは $\mathbb{N}$ の整除と $\mathbb{Z}$ の合同だけである。

## 形式化しなかったもの

* **命題 C″ (1) のしきい値 $w^*+1$ の最良性**（$k\le w^*$ では階段が偽であること）は書いていない。
  これは反例の族を作る主張であり、本文も反例を明示していない。
* **$g_m$ を $\min_{0\le N<r}v_p(\cdots)$ として構成する段**は書いていない。
  本ファイルは $g$ を「レベルの上限を与える族」として受け取っている
  （`IsTracePeriodAt ... k ... (p^m\tau) \iff k\le g_m$）。付値の最小として作る段は別である。
-/
import Mathlib
import IntegrableLattice.PropCTracePeriod
import IntegrableLattice.TracePeriodAssembly

namespace IntegrableLattice
namespace TracePeriodStructure

open Finset

variable {R : Type*} [CommRing R]

/-- **命題 C″ (3) の構造の主張。**

$\tau$ をレベル $1$ の最小周期、$g$ を「$p^{m}\tau$ が到達するレベルの上限」
（$p^{m}\tau$ がレベル $k$ の周期 $\iff k\le g_m$）とすると、
レベル $k$ の最小周期 $t_k$ は $p^{e}\tau$ に等しい。ここで $e=\min\{m:g_m\ge k\}$ である。

$g$ を仮定として受け取るのは、本文の $g_m=\min_{0\le N<r}v_p(\operatorname{Tr}(S^N(S^{p^m\tau}-I)))$ が
まさにこの同値を与える量だからである（本文の証明の末尾の 1 文がそれである）。 -/
theorem tracePeriod_eq_pow_mul {tr : R →+ ℤ} {p : ℕ} {s : R} {T : ℕ → ℕ} {τ : ℕ} {g : ℕ → ℕ}
    (hp : p.Prime) (hτpos : 0 < τ)
    (hg : ∀ m k : ℕ, IsTracePeriodAt tr p k s (p ^ m * τ) ↔ k ≤ g m)
    (hτleast : IsLeast (tracePeriodSet tr p 1 s) τ)
    (hT : ∀ j, IsLeast (tracePeriodSet tr p j s) (T j))
    {k e : ℕ} (hk : 1 ≤ k) (he : IsLeast {m : ℕ | k ≤ g m} e) :
    T k = p ^ e * τ := by
  -- 段 1: $p^{e}\tau$ はレベル $k$ の周期なので、最小性から $t_k\mid p^{e}\tau$。
  have hper : IsTracePeriodAt tr p k s (p ^ e * τ) := (hg e k).mpr he.1
  have hdvd : T k ∣ p ^ e * τ := dvd_of_isLeast_tracePeriod (hT k) hper
  -- 段 2: $t_k$ はレベル $1$ の周期でもあるので $\tau\mid t_k$。
  have hTpos : 0 < T k := (hT k).1.1
  have hTone : IsTracePeriodAt tr p 1 s (T k) := isTracePeriodAt_of_le hk (hT k).1.2
  have hτdvd : τ ∣ T k := dvd_of_isLeast_tracePeriod hτleast hTone
  -- 段 3: $t_k=\tau u$ と書くと $u\mid p^{e}$ なので $u=p^{m}$、$m\le e$。
  obtain ⟨u, hu⟩ := hτdvd
  have hupos : 0 < u := by
    rcases Nat.eq_zero_or_pos u with rfl | h
    · simp [hu] at hTpos
    · exact h
  have hudvd : u ∣ p ^ e := by
    have h1 : τ * u ∣ τ * p ^ e := by
      rw [← hu, mul_comm τ (p ^ e)]; exact hdvd
    exact (mul_dvd_mul_iff_left hτpos.ne').mp h1
  obtain ⟨m, hme, hum⟩ := (Nat.dvd_prime_pow hp).mp hudvd
  -- $t_k=p^{m}\tau$ が周期なので $g_m\ge k$、$e$ の最小性から $e\le m$。
  have hTeq : T k = p ^ m * τ := by rw [hu, hum, mul_comm]
  have hkm : k ≤ g m := (hg m k).mp (hTeq ▸ (hT k).1.2)
  have hem : e ≤ m := he.2 hkm
  rw [hTeq, le_antisymm hme hem]

end TracePeriodStructure
end IntegrableLattice
