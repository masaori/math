/-
# トレース周期の組み立て（命題 C′ の上界そのものと、命題 C″ の (2)(4)）

対応する人手証明: 本文 `structured-latex/content/004_lambda_finite.ts` の
**命題 C′**（`paper_043b_theorem_trace_bound`）と **命題 C″**（`paper_045_theorem_trace_ladder`）。
根拠 report は `outputs/reports/cycle18_T3_trace_period_bound.md`、
`outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md`。

## このファイルが埋めるもの

cycle 28 までに `PropCTracePeriod.lean` が形式化していたのは、命題 C′・C″ の
**核**（1 段ぶんの梯子 `isTracePeriodAt_mul_prime`）と**反例**だけであった。
台帳（`structured-latex/tools/formalization-coverage.ts`）が残りとして名指ししていたのは

- 命題 C′: 「上界の主張そのものの組み立て」
- 命題 C″: 「閉形式が存在しないことの主張そのもの」

の 2 つである。本ファイルはこの 2 つを書く。**新しい数学は使わない。**
使うのは既にあるもの（1 段ぶんの梯子、$T=(3)$・$p=2$ の位数）と、
人手証明が暗黙に使っていた「最小周期は任意の周期を割る」という一点だけである。

## 人手証明のどこが Lean のどれか

| 人手証明 | Lean |
| --- | --- |
| 命題 C′ の証明の「$Gb\equiv0\ (p^k)$ から $b\equiv0\ (p^{k-w^*})$」 | 仮定 `hlift`（下記） |
| 命題 C″ (1) 階段 $t_{k+1}\mid p\,t_k$ | `PropCTracePeriod.isTracePeriodAt_mul_prime`（既存） |
| 命題 C″ (2) 改良した上界（$k=w^*+1$ から繰り返す） | `isTracePeriodAt_iterate` / `tracePeriod_dvd_pow_mul` |
| 命題 C′ の $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$ | `tracePeriod_propC_bound` |
| 「$k\le w^*+1$ では単調性 $t_k\mid t_{k+1}$ から従う」 | `tracePeriod_dvd_of_le` |
| 命題 C″ (4) 閉形式は存在しない | `no_affine_trace_period_exponent` |

## 形式化していないもの（正直に書く）

- **定理 6（$p^{w^*}G^{-1}$ が $p$ 進整数成分をもつ）は仮定 `hlift` として型に出しただけである。**
  これを証明するには整数行列の Smith 標準形が要り、mathlib には行列の単因子の形が無い
  （`Basis.SmithNormalForm` は部分加群の基底の形である。cycle 19 の欠落調査）。
  線形代数の芯だけは `PropCTracePeriod.dvd_of_mulVec_dvd` が既に持っている。
- 命題 C′ の $\det G=\operatorname{disc}(\rho)\cdot\prod_\lambda m_\lambda$ と、
  $w^*=0$ が「$\rho\bmod p$ が分離的かつ $p\nmid m_\lambda$」と同値であること。
- 命題 C″ (1) のしきい値 $w^*+1$ の最良性と、(3) の $e_k=\min\{m:g_m\ge k\}$ の同値。

## 過剰仮定について

`IsPeriodMod` についての補題（第 1 節）は $\mathbb{Z}$ の元 $m$ と列 $g:\mathbb{N}\to\mathbb{Z}$ だけで
述べてある。**$m$ が素数冪であることも、$g$ がトレース列であることも使っていない。**
人手証明が「最小周期は任意の周期を割る」と言うときに効いているのはこれだけである。
-/
import Mathlib
import IntegrableLattice.PropCTracePeriod

namespace IntegrableLattice

/-! ## 1. 最小周期は任意の周期を割る（人手証明が暗黙に使っている一点）

人手証明は $t_k=\pi_{\mathrm{tr}}(p,k)$ を「最小の周期」と定義したうえで、
「$p^n t_{w^*+1}$ は周期だから $t_k\mid p^n t_{w^*+1}$」と書く。この一歩には
**最小周期が任意の周期を割る**ことが要る。これは列と法だけで決まる事実なので、
トレースにも素数にも依らない形で書く。 -/

section PeriodMod

/-- 整数列 `g` が法 `m` で周期 `t` をもつ。 -/
def IsPeriodMod (m : ℤ) (g : ℕ → ℤ) (t : ℕ) : Prop :=
  ∀ N : ℕ, m ∣ g (N + t) - g N

variable {m : ℤ} {g : ℕ → ℤ}

lemma isPeriodMod_zero : IsPeriodMod m g 0 := by
  intro N; simp

lemma IsPeriodMod.add {t u : ℕ} (ht : IsPeriodMod m g t) (hu : IsPeriodMod m g u) :
    IsPeriodMod m g (t + u) := by
  intro N
  have h1 : m ∣ g (N + u + t) - g (N + u) := ht (N + u)
  have h2 : m ∣ g (N + u) - g N := hu N
  have hidx : N + (t + u) = N + u + t := by omega
  rw [hidx]
  have := dvd_add h1 h2
  simpa using this

/-- 周期の整数倍も周期。 -/
lemma IsPeriodMod.nsmul {t : ℕ} (ht : IsPeriodMod m g t) : ∀ q : ℕ, IsPeriodMod m g (q * t)
  | 0 => by simpa using (isPeriodMod_zero (m := m) (g := g))
  | (q + 1) => by
      have h := (ht.nsmul q).add ht
      have hidx : q * t + t = (q + 1) * t := by ring
      rwa [hidx] at h

/-- 周期 `r + u` と 周期 `u` から 周期 `r` が出る（差を取る）。 -/
lemma IsPeriodMod.sub_right {r u : ℕ} (hru : IsPeriodMod m g (r + u)) (hu : IsPeriodMod m g u) :
    IsPeriodMod m g r := by
  intro N
  have h1 : m ∣ g (N + (r + u)) - g N := hru N
  have h2 : m ∣ g (N + r + u) - g (N + r) := hu (N + r)
  have hidx : N + (r + u) = N + r + u := by omega
  rw [hidx] at h1
  have := dvd_sub h1 h2
  simpa using this

/-- **最小周期は任意の周期を割る。** 人手証明の $t_k\mid(\text{任意の周期})$ の一歩。 -/
theorem dvd_of_isLeast_isPeriodMod {t₀ t : ℕ}
    (h₀ : IsLeast {u : ℕ | 0 < u ∧ IsPeriodMod m g u} t₀) (ht : IsPeriodMod m g t) :
    t₀ ∣ t := by
  obtain ⟨⟨ht₀pos, ht₀per⟩, hmin⟩ := h₀
  refine Nat.dvd_of_mod_eq_zero ?_
  by_contra hne
  have hrpos : 0 < t % t₀ := Nat.pos_of_ne_zero hne
  -- t = (t / t₀) * t₀ + t % t₀
  have hsplit : t % t₀ + (t / t₀) * t₀ = t := by
    have hdm := Nat.div_add_mod t t₀
    rw [Nat.mul_comm]
    omega
  have hmul : IsPeriodMod m g ((t / t₀) * t₀) := ht₀per.nsmul _
  have hsum : IsPeriodMod m g (t % t₀ + (t / t₀) * t₀) := by rwa [hsplit]
  have hrem : IsPeriodMod m g (t % t₀) := hsum.sub_right hmul
  have hle : t₀ ≤ t % t₀ := hmin ⟨hrpos, hrem⟩
  exact absurd (Nat.mod_lt t ht₀pos) (not_lt.mpr hle)

end PeriodMod

/-! ## 2. トレース周期を列の周期として読み直す

`IsTracePeriodAt tr p k s t` は $\operatorname{Tr}(s^N(s^t-1))$ の話だが、
$s^N(s^t-1)=s^{N+t}-s^N$ なので、列 $N\mapsto\operatorname{Tr}(s^N)$ の周期そのものである。
この読み直しによって第 1 節の補題がそのまま使える。 -/

section TraceSeq

variable {R : Type*} [CommRing R]

/-- トレース列 $N\mapsto\operatorname{Tr}(s^N)$。 -/
def traceSeq (tr : R →+ ℤ) (s : R) : ℕ → ℤ := fun N => tr (s ^ N)

theorem isTracePeriodAt_iff_isPeriodMod (tr : R →+ ℤ) (p k : ℕ) (s : R) (t : ℕ) :
    IsTracePeriodAt tr p k s t ↔ IsPeriodMod ((p : ℤ) ^ k) (traceSeq tr s) t := by
  have hrw : ∀ N : ℕ, s ^ N * (s ^ t - 1) = s ^ (N + t) - s ^ N := by
    intro N; rw [mul_sub, mul_one, ← pow_add]
  constructor
  · intro h N
    have := h N
    rwa [hrw N, map_sub] at this
  · intro h N
    have hN := h N
    simp only [traceSeq] at hN
    rw [← map_sub] at hN
    rw [hrw N]
    exact hN

/-- レベルが上がれば周期の条件は強くなる（人手証明の単調性 $t_k\mid t_{k+1}$ の中身）。 -/
theorem isTracePeriodAt_of_le {tr : R →+ ℤ} {p k l : ℕ} {s : R} {t : ℕ} (hkl : k ≤ l)
    (h : IsTracePeriodAt tr p l s t) : IsTracePeriodAt tr p k s t := by
  intro N
  exact dvd_trans (pow_dvd_pow (p : ℤ) hkl) (h N)

end TraceSeq

/-! ## 3. 命題 C″ (2)（改良した上界）: 梯子を $k=w^*+1$ から繰り返す

人手証明は「改良した上界はこれを $k=w^*+1$ から繰り返せば出る」と書く。その繰り返しを書く。

**定理 6 は仮定 `hlift` として型に出す。** 人手証明で定理 6 が果たす役割は
「レベル $k\ (\ge w^*+1)$ の周期 $u$ に対し $s^u-1$ が $p^{k-w^*}$ で割れる」ことだけであり、
梯子が実際に使うのはそのうち $p^1$ で割れることである（`isTracePeriodAt_mul_prime` の `hj`）。 -/

section Ladder

variable {R : Type*} [CommRing R]

/-- **命題 C″ (2) の実体。** レベル $w+1$ の周期 $t$ から、レベル $w+1+n$ の周期 $p^n t$ が出る。 -/
theorem isTracePeriodAt_iterate {tr : R →+ ℤ} {p w : ℕ} {s : R} {t : ℕ}
    (hgen : ∀ x : R, ∃ q : Polynomial ℤ, x = Polynomial.aeval s q)
    (hlift : ∀ (k u : ℕ), w + 1 ≤ k → IsTracePeriodAt tr p k s u →
      ∃ C : R, s ^ u - 1 = (p : R) ^ (k - w) * C)
    (hper : IsTracePeriodAt tr p (w + 1) s t) :
    ∀ n : ℕ, IsTracePeriodAt tr p (w + 1 + n) s (p ^ n * t)
  | 0 => by simpa using hper
  | (n + 1) => by
      have ih := isTracePeriodAt_iterate hgen hlift hper n
      obtain ⟨C, hC⟩ := hlift (w + 1 + n) (p ^ n * t) (by omega) ih
      have hj : 1 ≤ w + 1 + n - w := by omega
      have hstep := isTracePeriodAt_mul_prime hgen ih hC hj
      have hidx : p * (p ^ n * t) = p ^ (n + 1) * t := by ring
      have hlvl : w + 1 + n + 1 = w + 1 + (n + 1) := by omega
      rwa [hidx, hlvl] at hstep

end Ladder

/-! ## 4. 最小周期の言葉での上界（命題 C′ の主張そのもの、命題 C″ (2)）

人手証明の $t_k=\pi_{\mathrm{tr}}(p,k)$ は「レベル $k$ の最小の正の周期」である。
その最小性を `IsLeast` で受け取り、第 1 節と第 3 節を繋ぐ。 -/

section MinimalPeriod

variable {R : Type*} [CommRing R]

/-- レベル `k` の周期の集合（正のもの）。 -/
def tracePeriodSet (tr : R →+ ℤ) (p k : ℕ) (s : R) : Set ℕ :=
  {u : ℕ | 0 < u ∧ IsTracePeriodAt tr p k s u}

/-- 最小周期は任意の周期を割る（第 1 節の言い換え）。 -/
theorem dvd_of_isLeast_tracePeriod {tr : R →+ ℤ} {p k : ℕ} {s : R} {t₀ u : ℕ}
    (h₀ : IsLeast (tracePeriodSet tr p k s) t₀) (hu : IsTracePeriodAt tr p k s u) :
    t₀ ∣ u := by
  refine dvd_of_isLeast_isPeriodMod (m := (p : ℤ) ^ k) (g := traceSeq tr s) ?_
    ((isTracePeriodAt_iff_isPeriodMod tr p k s u).mp hu)
  obtain ⟨⟨hpos, hper⟩, hmin⟩ := h₀
  refine ⟨⟨hpos, (isTracePeriodAt_iff_isPeriodMod tr p k s t₀).mp hper⟩, ?_⟩
  intro b hb
  exact hmin ⟨hb.1, (isTracePeriodAt_iff_isPeriodMod tr p k s b).mpr hb.2⟩

/-- **人手証明の単調性 $t_k\mid t_l$（$k\le l$）。** -/
theorem tracePeriod_dvd_of_le {tr : R →+ ℤ} {p k l : ℕ} {s : R} {T : ℕ → ℕ}
    (hT : ∀ j, IsLeast (tracePeriodSet tr p j s) (T j)) (hkl : k ≤ l) :
    T k ∣ T l :=
  dvd_of_isLeast_tracePeriod (hT k) (isTracePeriodAt_of_le hkl (hT l).1.2)

/-- **命題 C″ (2)（改良した上界）**: $t_{w^*+1+n}\mid p^{n}\,t_{w^*+1}$。 -/
theorem tracePeriod_dvd_pow_mul {tr : R →+ ℤ} {p w : ℕ} {s : R} {T : ℕ → ℕ}
    (hgen : ∀ x : R, ∃ q : Polynomial ℤ, x = Polynomial.aeval s q)
    (hlift : ∀ (k u : ℕ), w + 1 ≤ k → IsTracePeriodAt tr p k s u →
      ∃ C : R, s ^ u - 1 = (p : R) ^ (k - w) * C)
    (hT : ∀ j, IsLeast (tracePeriodSet tr p j s) (T j)) (n : ℕ) :
    T (w + 1 + n) ∣ p ^ n * T (w + 1) :=
  dvd_of_isLeast_tracePeriod (hT (w + 1 + n))
    (isTracePeriodAt_iterate hgen hlift (hT (w + 1)).1.2 n)

/-- **命題 C′ の上界そのもの**: すべての $k\ge1$ で
$\pi_{\mathrm{tr}}(p,k)\mid p^{\,k-1}\,\pi_{\mathrm{tr}}(p,w^*+1)$。

人手証明どおり 2 通りに分ける。$k>w^*+1$ では命題 C″ (2) を使い、
$k\le w^*+1$ では単調性 $t_k\mid t_{w^*+1}$ から従う。 -/
theorem tracePeriod_propC_bound {tr : R →+ ℤ} {p w : ℕ} {s : R} {T : ℕ → ℕ}
    (hgen : ∀ x : R, ∃ q : Polynomial ℤ, x = Polynomial.aeval s q)
    (hlift : ∀ (k u : ℕ), w + 1 ≤ k → IsTracePeriodAt tr p k s u →
      ∃ C : R, s ^ u - 1 = (p : R) ^ (k - w) * C)
    (hT : ∀ j, IsLeast (tracePeriodSet tr p j s) (T j)) {k : ℕ} (hk : 1 ≤ k) :
    T k ∣ p ^ (k - 1) * T (w + 1) := by
  rcases le_or_gt k (w + 1) with hle | hgt
  · exact Dvd.dvd.mul_left (tracePeriod_dvd_of_le hT hle) _
  · obtain ⟨n, rfl⟩ : ∃ n, k = w + 1 + n := ⟨k - (w + 1), by omega⟩
    refine dvd_trans (tracePeriod_dvd_pow_mul hgen hlift hT n) ?_
    exact mul_dvd_mul_right (pow_dvd_pow p (by omega)) _

end MinimalPeriod

/-! ## 5. 命題 C″ (4): 閉形式は存在しない

人手証明は $T=(3)$、$p=2$ を反例に挙げ、$t_k=1,2,2,4,8,16$（$k=1,\dots,6$）と書く。
$\operatorname{Tr}T^N=3^N$ なので $t_k=\operatorname{ord}_{2^k}(3)$ である。
cycle 19 は $k\le4$ の 4 つの位数だけを形式化していたが、
**「$e_k$ を $k-c$ の形に書けない」という主張そのものは書いていなかった。** ここで書く。 -/

section NoClosedForm

/-- $T=(3)$, $p=2$ のトレース周期 $t_k=\operatorname{ord}_{2^k}(3)$。 -/
noncomputable def tThree (k : ℕ) : ℕ := orderOf (3 : ZMod (2 ^ k))

theorem tThree_one : tThree 1 = 1 := by
  show orderOf (3 : ZMod 2) = 1
  exact orderOf_three_zmod_two

theorem tThree_two : tThree 2 = 2 := by
  show orderOf (3 : ZMod 4) = 2
  exact orderOf_three_zmod_four

theorem tThree_three : tThree 3 = 2 := by
  show orderOf (3 : ZMod 8) = 2
  exact orderOf_three_zmod_eight

theorem tThree_four : tThree 4 = 4 := by
  show orderOf (3 : ZMod 16) = 4
  exact orderOf_three_zmod_sixteen

theorem tThree_five : tThree 5 = 8 := by
  show orderOf (3 : ZMod 32) = 8
  have h := orderOf_eq_prime_pow (p := 2) (n := 2) (x := (3 : ZMod 32))
    (by decide) (by decide)
  simpa using h

theorem tThree_six : tThree 6 = 16 := by
  show orderOf (3 : ZMod 64) = 16
  have h := orderOf_eq_prime_pow (p := 2) (n := 3) (x := (3 : ZMod 64))
    (by decide) (by decide)
  simpa using h

/-- **本文の $t_k=1,2,2,4,8,16$（$k=1,\dots,6$）**。$t_2=t_3$ で階段が 1 段止まる。 -/
theorem tThree_values :
    tThree 1 = 1 ∧ tThree 2 = 2 ∧ tThree 3 = 2 ∧ tThree 4 = 4 ∧ tThree 5 = 8 ∧ tThree 6 = 16 :=
  ⟨tThree_one, tThree_two, tThree_three, tThree_four, tThree_five, tThree_six⟩

/-- **命題 C″ (4)（閉形式は存在しない）の主張そのもの。**

$t_k=p^{e_k}\tau$ と書いたときの $e_k$ を $k$ のアフィン式 $k-c$ で書くことはできない。
$T=(3)$, $p=2$ では $\tau=t_1=1$ なので、主張は
「$t_k=2^{\,k-c}$ をすべての $k\ge1$ で満たす定数 $c$ は無い」になる。

反証は $k=2$ と $k=3$ の 2 点で足りる。$t_2=t_3=2$ なので $2-c$ と $3-c$ が
どちらも $1$ でなければならず、$c$ が $1$ と $2$ の両方になる。
これが「階段が 1 段止まる」ことの帰結である。 -/
theorem no_affine_trace_period_exponent :
    ¬ ∃ c : ℕ, ∀ k : ℕ, 1 ≤ k → tThree k = 2 ^ (k - c) := by
  rintro ⟨c, h⟩
  have h2 : (2 : ℕ) = 2 ^ (2 - c) := by rw [← h 2 (by norm_num), tThree_two]
  have h3 : (2 : ℕ) = 2 ^ (3 - c) := by rw [← h 3 (by norm_num), tThree_three]
  have e2 : 2 - c = 1 := by
    have h' : (2 : ℕ) ^ (2 - c) = 2 ^ 1 := by rw [← h2]; norm_num
    exact Nat.pow_right_injective (le_refl 2) h'
  have e3 : 3 - c = 1 := by
    have h' : (2 : ℕ) ^ (3 - c) = 2 ^ 1 := by rw [← h3]; norm_num
    exact Nat.pow_right_injective (le_refl 2) h'
  omega

end NoClosedForm

end IntegrableLattice
