/-
# 定理 G4（一般の塔の閉形式。$\ell^n$ の係数 $c$ の明示式）— cycle 21 step 2

対応する人手証明:

* 根拠 report: `outputs/reports/cycle21_T3_general_closed_form.md`
  §2（定理 G1）・§3（定理 G2）・§4（定理 G3）・§5（定理 G4）
* 本文への反映は cycle 22 step 1 の担当（本ファイルの時点では本文未反映）

## 目的

**証明の正しさではなく、主張の検算**である。定理 G4 の骨格は

1. $\Theta_M=\alpha M\ell^M+\beta\ell^M+\gamma$ から 5 係数 $(a,b,c,d,e)$ を読む**代数**（定理 G1）、
2. 捻り段データ $(\Lambda_k,\theta^\sharp_k)$ の**最小点の一意性**（定理 G2 の 2）、
3. 飽和深度 $K$ の**算術**（定理 G3）、
4. $(5.2)$–$(5.4)$ を定理 G1 に代入して $b=\sum j^*$ が出ること（$(5.5)$）

の 4 つで、(1)(3)(4) は完全に初等的、(2) は係数環を $\mathbb{Z}$ から
$\mathcal{O}_k=\mathbb{Z}[\zeta_{\ell^k}]$ へ広げたときの最小化の算術である。本ファイルはこの 4 つを型に出す。

## 形式化した主張

* `S0_closed` / `S1_closed` — $\sum_{M=1}^{n}\ell^M$ と $\sum_{M=1}^{n}M\ell^M$ の閉形式。
* `sum_totient_Ico` / `layer_b_boundary` — §5.2 (b) の $\sum_{s=K+1}^{N}\varphi(\ell^{s})=\ell^{N}-\ell^{K}$ と
  その成立条件（$K\le N$）。**§5.3 の $M^*$ の条件 2 が 1 つ強すぎることの根拠**。
* `theorem_G1` — **定理 G1 $(2.2)$$(2.3)$ の全 5 係数**。$(2.1)$ を仮定して cycle 14 $(6.1)$ に
  代入し、$\ell^{2n},n\ell^n,\ell^n,n,1$ の係数が report の式に一致することを**恒等式として**示す。
* `theorem_G1_remark_2_2` — 注 2.2 の内容（$\Theta_M$ に $\delta M$ の項があると $n^2$ が出て
  $(1.1)$ の形が壊れる）。
* `twisted_unique_min` — **定理 G2 の 2**（$(3.2)$ の下で $(3.3)$ の最小点が一意）。
  係数環を広げて $v_\ell$ の値が $\frac1{\varphi(\ell^k)}\mathbb{Z}$ に入ることを、
  $\varphi(\ell^k)$ 倍した整数 `w` で表現している。
* `K_wellDefined` / `K_zero_iff` / `K_ge_one_of_ell_two` — **定理 G3** の $K$ の定義可能性と
  「$K=0\iff j^*\le\ell-2$」「$\ell=2$ では必ず $K\ge1$」。
* `G3_positivity` — 定理 G3 の証明の中心の不等式
  $\varphi(\ell^M)-\theta+m_1\ge\ell^{M-k}[(\ell-1)\ell^{k-1}-j^*]-e+2>0$。
* `G3_two_levels` — $(4.2)$ の $\Lambda_k=j^*/\varphi(\ell^k)$、$\theta^\sharp_k=e_{j^*}$ が
  **2 つのレベルでの一致から**決まること。
* `theorem_G4_b` — $(5.2)$ を定理 G1 の $b=\frac{\ell}{\ell-1}\alpha$ に入れると
  $b=\sum_{P_0\in S_\infty}j^*(P_0)$ になること（$(5.5)$）。**定理 Q1 と独立に同じ値を出す。**
* `theorem_G4_c` — $(5.3)$ を $c=\frac{\ell}{\ell-1}\beta-\frac{\ell}{(\ell-1)^2}\alpha$ に入れた
  展開形（本 report が文献に足していると主張する係数）。

## 形式化で分かったこと（主張の精度）

1. **注 4.2（「$K$ は上界であって、$k\le K$ の層が必ず飽和するとは言っていない」）は正しい。**
   $(5.3)$$(5.4)$ には $-\frac{(\ell-1)j^*(K+r^\sharp)}{\ell}$ と $-e_{j^*}\ell^{K}$ という
   $K$ 依存の項が入っているので、$K$ を大きく取り直すと値が変わりそうに見える。
   実際に $K\to K+1$ の変化量を計算すると、非飽和層では $(4.2)$ より
   $\theta^\sharp_{K+1}=e_{j^*}$ なので $\gamma$ の変化は
   $-e\ell^{K+1}+e\ell^{K}+\varphi(\ell^{K+1})e=0$ で**打ち消し合う**（`G4_K_dependence`）。
   したがって式は $K$ の取り方に依らない。**report はこの打ち消しを書いていない**ので、
   注 4.2 の正当性の根拠が本文からは読めない。本文へ移すときは一言添えるべきである。
2. **§5.3 の $M^*$ の条件 2 は 1 つ強すぎ、しかも §6.1 と食い違っている。**
   条件 2 は $M\ge r^\sharp+\max K+1$ だが、(b) の層の閉形式が成り立つ条件は
   $M\ge r^\sharp+K$ である（`sum_totient_Ico` / `layer_b_boundary`）。
   実際 §6.1（定理 J8 との照合）は $r^\sharp=1$, $K=0$ の下で $M^*=1=r^\sharp+K$ を使っており、
   §5.3 の条件 2 を満たしていない。**直すべきは §5.3 の条件 2 の方である。**
3. **定理 G1 の $e$ の式 $(2.3)$ は $M^*$ の取り方に依存しない**（`theorem_G1` が任意の $ms$ で
   成り立つ形になっている）。これは自明ではないが、$(2.1)$ が $M\ge M^*$ で成り立つ限り
   $M^*$ を大きくしても $e$ が変わらないことを意味する（`theorem_G1_e_indep`）。

## 形式化しなかったもの（mathlib の欠落か配線か）

`lean/logs/mathlib-gap-survey-cycle22.log` を参照。

* **定理 G2 の 1**（$\Lambda_k,\theta^\sharp_k,m^\sharp_k$ が $t$ に依らないこと）:
  $\mathrm{Gal}(\mathbb{Q}(\zeta_{\ell^k})/\mathbb{Q})$ の作用で $v_\ell$ が不変であることを使う。
  `IsCyclotomicExtension.autEquivPow`・`Valuation` の Galois 不変性は mathlib に**在る**ので
  **配線**である。
* **定理 G2 の 3**（$\varphi(\ell^k)\Lambda_k\in\mathbb{Z}_{\ge1}$）: $\mathcal{O}_k$ の極大イデアルが
  $(\eta-1)$ で剰余体が $\mathbb{F}_\ell$ であること。
  `zeta_sub_one_prime`（3 ファイル）・`IsCyclotomicExtension.Rat`（8 ファイル）は**在る**。
  なお「完全分岐」は `IsTotallyRamified` という名では存在しない（3 段とも 0 件）が、
  **これは語の選び方の問題であって欠落ではない**: `ramificationIdx` / `inertiaDeg` で表現されている。**配線**。
* **$A_{\mathrm{gen}}$ の $L$ 非依存性**（$(5.1)$）: $\mathbb{P}^1(\mathbb{Z}/\ell^{L+1})\to\mathbb{P}^1(\mathbb{Z}/\ell^{L})$
  のファイバーが一様に $\ell$ 個であること。射影直線のレベル構造を Lean 内に作っていない。**配線**。
* **Matrix–Tree 定理**（$\kappa_n$ の独立計算）: mathlib に全域木数の公式は**無い**
  （`logs/mathlib-gap-survey-cycle21.log` で 3 段方式により確認済み。本サイクルでも再確認した）。
  したがって $\kappa_n$ 側の照合は Lean 外（Python / SageMath）で行っている。
-/
import Mathlib

namespace IntegrableLattice
namespace GeneralTower

open Finset

/-! ## 定理 G1 — $\Theta_M$ の形から 5 係数へ

$\mathcal{S}_1(N)=\sum_{M=1}^{N}M\ell^M$、$\mathcal{S}_0(N)=\sum_{M=1}^{N}\ell^M$。 -/

/-- $\mathcal{S}_0(n)=\sum_{M=1}^{n}L^M$。 -/
noncomputable def S0 (L : ℚ) (n : ℕ) : ℚ := ∑ M ∈ Finset.Ico 1 (n + 1), L ^ M

/-- $\mathcal{S}_1(n)=\sum_{M=1}^{n}M\,L^M$。 -/
noncomputable def S1 (L : ℚ) (n : ℕ) : ℚ := ∑ M ∈ Finset.Ico 1 (n + 1), (M : ℚ) * L ^ M

theorem S0_closed (L : ℚ) (hL : L ≠ 1) (n : ℕ) :
    S0 L n = (L ^ (n + 1) - L) / (L - 1) := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  induction n with
  | zero => simp [S0]
  | succ N ih =>
      rw [S0, Finset.sum_Ico_succ_top (by omega), ← S0, ih]
      field_simp
      ring

theorem S1_closed (L : ℚ) (hL : L ≠ 1) (n : ℕ) :
    S1 L n = (L - (n + 1) * L ^ (n + 1) + n * L ^ (n + 2)) / (L - 1) ^ 2 := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  induction n with
  | zero => simp [S1]
  | succ N ih =>
      rw [S1, Finset.sum_Ico_succ_top (by omega), ← S1, ih]
      push_cast
      field_simp
      ring

/-- $\mathcal{S}_1$ を「$n\ell^n$ 項・$\ell^n$ 項・定数項」に分解した形。
report §2 の証明が読み取っている 3 つの係数 $\frac{L}{L-1}$, $-\frac{L}{(L-1)^2}$,
$\frac{L}{(L-1)^2}$ をそのまま型に出す。 -/
theorem S1_decomp (L : ℚ) (hL : L ≠ 1) (n : ℕ) :
    S1 L n = (L / (L - 1)) * (n * L ^ n) + (-(L / (L - 1) ^ 2)) * L ^ n + L / (L - 1) ^ 2 := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  rw [S1_closed L hL n]
  field_simp
  ring

/-- $\mathcal{S}_0$ の同じ分解（$\ell^n$ 係数 $\frac{L}{L-1}$、定数項 $-\frac{L}{L-1}$）。 -/
theorem S0_decomp (L : ℚ) (hL : L ≠ 1) (n : ℕ) :
    S0 L n = (L / (L - 1)) * L ^ n + (-(L / (L - 1))) := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  rw [S0_closed L hL n]
  field_simp
  ring

/-- **定理 G1**（report $(2.2)$$(2.3)$）。$(2.1)$（$M\ge ms+1$ で
$\Theta_M=\alpha M\ell^M+\beta\ell^M+\gamma$）を仮定し、cycle 14 $(6.1)$
$$\mathrm{ord}_\ell(\kappa_n)=v_\ell(\kappa(X))-2n+\mu(\ell^{2n}-1)+\sum_{M=1}^{n}\Theta_M$$
へ代入すると、5 係数がちょうど report の式になる。

$M^*=ms+1$ とパラメータ化して $\mathbb{N}$ の切り捨て引き算を避けてある。 -/
theorem theorem_G1 (L : ℚ) (hL : L ≠ 1) (μ κX α β γ : ℚ) (Θ : ℕ → ℚ) (ms n : ℕ)
    (hn : ms ≤ n)
    (hΘ : ∀ M, ms + 1 ≤ M → Θ M = α * M * L ^ M + β * L ^ M + γ) :
    κX - 2 * n + μ * (L ^ (2 * n) - 1) + ∑ M ∈ Finset.Ico 1 (n + 1), Θ M
      = μ * L ^ (2 * n)
        + (L / (L - 1) * α) * (n * L ^ n)
        + (L / (L - 1) * β - L / (L - 1) ^ 2 * α) * L ^ n
        + (γ - 2) * n
        + (κX - μ
            + ((∑ M ∈ Finset.Ico 1 (ms + 1), Θ M) - α * S1 L ms - β * S0 L ms - γ * ms)
            + L / (L - 1) ^ 2 * α - L / (L - 1) * β) := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  -- 和を低レベル部分と高レベル部分に分ける
  have hsplit : ∑ M ∈ Finset.Ico 1 (n + 1), Θ M
      = (∑ M ∈ Finset.Ico 1 (ms + 1), Θ M) + ∑ M ∈ Finset.Ico (ms + 1) (n + 1), Θ M := by
    rw [Finset.sum_Ico_consecutive _ (by omega) (by omega)]
  -- 高レベル部分に (2.1) を入れる
  have hhigh : ∑ M ∈ Finset.Ico (ms + 1) (n + 1), Θ M
      = α * (S1 L n - S1 L ms) + β * (S0 L n - S0 L ms) + γ * (n - ms) := by
    have hcongr : ∀ M ∈ Finset.Ico (ms + 1) (n + 1),
        Θ M = α * M * L ^ M + β * L ^ M + γ := by
      intro M hM
      simp only [Finset.mem_Ico] at hM
      exact hΘ M hM.1
    rw [Finset.sum_congr rfl hcongr]
    have h1 : ∑ M ∈ Finset.Ico (ms + 1) (n + 1), (α * M * L ^ M + β * L ^ M + γ)
        = α * (∑ M ∈ Finset.Ico (ms + 1) (n + 1), (M : ℚ) * L ^ M)
          + β * (∑ M ∈ Finset.Ico (ms + 1) (n + 1), L ^ M)
          + γ * ((Finset.Ico (ms + 1) (n + 1)).card : ℚ) := by
      simp only [Finset.sum_add_distrib, Finset.sum_const, nsmul_eq_mul, mul_assoc,
        ← Finset.mul_sum]
      ring
    rw [h1]
    have h2 : (∑ M ∈ Finset.Ico (ms + 1) (n + 1), (M : ℚ) * L ^ M) = S1 L n - S1 L ms := by
      rw [S1, S1, ← Finset.sum_Ico_consecutive (fun M => (M : ℚ) * L ^ M)
        (show 1 ≤ ms + 1 by omega) (show ms + 1 ≤ n + 1 by omega)]
      ring
    have h3 : (∑ M ∈ Finset.Ico (ms + 1) (n + 1), L ^ M) = S0 L n - S0 L ms := by
      rw [S0, S0, ← Finset.sum_Ico_consecutive (fun M => L ^ M)
        (show 1 ≤ ms + 1 by omega) (show ms + 1 ≤ n + 1 by omega)]
      ring
    have h4 : ((Finset.Ico (ms + 1) (n + 1)).card : ℚ) = (n : ℚ) - ms := by
      rw [Nat.card_Ico]
      have : n + 1 - (ms + 1) = n - ms := by omega
      rw [this, Nat.cast_sub hn]
    rw [h2, h3, h4]
  rw [hsplit, hhigh, S1_decomp L hL n, S0_decomp L hL n]
  field_simp
  ring

/-- **注 2.2**: $\Theta_M$ に $\delta M$ の項があると $\Sigma_n$ に $n^2$ が出る。
$\sum_{M=1}^{n}M=\frac{n(n+1)}2$ は $n$ の 2 次式なので $(1.1)$ の形（$n$ の 1 次まで）を壊す。 -/
theorem theorem_G1_remark_2_2 (n : ℕ) :
    (∑ M ∈ Finset.Ico 1 (n + 1), (M : ℚ)) = (n : ℚ) * (n + 1) / 2 := by
  induction n with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_Ico_succ_top (by omega), ih]
      push_cast
      ring

/-- **$e$ の式は $M^*$ の取り方に依らない**: $(2.1)$ が $M\ge ms+1$ と $M\ge ms+2$ の両方で
成り立つなら、$(2.3)$ の角括弧の中身は $ms$ で計算しても $ms+1$ で計算しても同じ。 -/
theorem theorem_G1_e_indep (L : ℚ) (hL : L ≠ 1) (α β γ : ℚ) (Θ : ℕ → ℚ) (ms : ℕ)
    (hΘ : ∀ M, ms + 1 ≤ M → Θ M = α * M * L ^ M + β * L ^ M + γ) :
    ((∑ M ∈ Finset.Ico 1 (ms + 1), Θ M) - α * S1 L ms - β * S0 L ms - γ * ms)
      = ((∑ M ∈ Finset.Ico 1 (ms + 2), Θ M) - α * S1 L (ms + 1) - β * S0 L (ms + 1)
          - γ * (ms + 1)) := by
  have hstep : Θ (ms + 1) = α * ((ms : ℚ) + 1) * L ^ (ms + 1) + β * L ^ (ms + 1) + γ := by
    have h := hΘ (ms + 1) (le_refl _)
    push_cast at h
    linarith [h]
  have hsum : ∑ M ∈ Finset.Ico 1 (ms + 2), Θ M
      = (∑ M ∈ Finset.Ico 1 (ms + 1), Θ M) + Θ (ms + 1) := by
    rw [show ms + 2 = (ms + 1) + 1 from rfl, Finset.sum_Ico_succ_top (by omega)]
  have hS1 : S1 L (ms + 1) = S1 L ms + ((ms : ℚ) + 1) * L ^ (ms + 1) := by
    rw [S1, S1, Finset.sum_Ico_succ_top (show 1 ≤ ms + 1 by omega)]
    push_cast
    ring
  have hS0 : S0 L (ms + 1) = S0 L ms + L ^ (ms + 1) := by
    rw [S0, S0, Finset.sum_Ico_succ_top (show 1 ≤ ms + 1 by omega)]
  rw [hsum, hS1, hS0, hstep]
  push_cast
  ring

/-! ## 定理 G2 の 2 — 捻り段データの最小点の一意性

$\mathcal{O}_k=\mathbb{Z}[\eta]$（$\eta$ は原始 $\ell^k$ 乗根）上で $v_\ell$ は
$\frac1{\varphi(\ell^k)}\mathbb{Z}_{\ge0}$ に値を取る。$\varphi(\ell^k)$ 倍して整数にしたものを
`w m` と書き、$q=\varphi(\ell^M)/\varphi(\ell^k)=\ell^{M-k}$ と置くと、最小化する量は
$q\cdot w(m)+m$ である。$(3.2)$（$\varphi(\ell^M)>(\theta^\sharp-m^\sharp)\varphi(\ell^k)$、
すなわち $q>\theta^\sharp-m^\sharp$）の下で最小点が一意になる。 -/

/-- **定理 G2 の 2**: $(3.2)$ の下で $m=\theta^\sharp$ が $q\,w(m)+m$ の唯一の最小点。

`supp m` は $A^{[k]}_m\ne0$（$0$ の項は付値 $\infty$ なので比較から外れる）。
`hq : θs < q + ms` が $(3.2)$ である。 -/
theorem twisted_unique_min (q W θs ms : ℕ) (w : ℕ → ℕ) (supp : ℕ → Prop)
    (hq : θs < q + ms)
    (hWθ : w θs = W)
    (hlow : ∀ m, m < θs → supp m → W + 1 ≤ w m)
    (hms : ∀ m, m < θs → supp m → ms ≤ m)
    (hhigh : ∀ m, θs < m → W ≤ w m) :
    ∀ m, m ≠ θs → supp m → q * W + θs < q * w m + m := by
  intro m hm hsupp
  rcases lt_or_gt_of_ne hm with h | h
  · -- m < θs（かつ A_m ≠ 0）: 付値が 1/φ(ℓ^k) だけ大きく、q の分の余裕が (3.2) で効く
    have h1 : W + 1 ≤ w m := hlow m h hsupp
    have h2 : ms ≤ m := hms m h hsupp
    calc q * W + θs < q * W + (q + ms) := by omega
      _ = q * (W + 1) + ms := by ring
      _ ≤ q * w m + ms := by exact Nat.add_le_add_right (Nat.mul_le_mul_left q h1) ms
      _ ≤ q * w m + m := Nat.add_le_add_left h2 _
  · -- m > θs: 付値は W 以上、次数が真に大きい
    have h1 : W ≤ w m := hhigh m h
    calc q * W + θs < q * W + m := by omega
      _ ≤ q * w m + m := Nat.add_le_add_right (Nat.mul_le_mul_left q h1) m

/-- $k=0$（$\eta=1$、$\mathcal{O}_0=\mathbb{Z}$、$q=\varphi(\ell^M)$）では
`twisted_unique_min` は cycle 19 定理 S の最小化そのもの（注 3.1）。 -/
theorem twisted_unique_min_k_zero (φM W θs : ℕ) (w : ℕ → ℕ)
    (hq : θs < φM) (hWθ : w θs = W)
    (hlow : ∀ m, m < θs → W + 1 ≤ w m) (hhigh : ∀ m, θs < m → W ≤ w m) :
    ∀ m, m ≠ θs → φM * W + θs < φM * w m + m := by
  intro m hm
  exact twisted_unique_min φM W θs 0 w (fun _ => True) (by omega) hWθ
    (fun m h _ => hlow m h) (fun _ _ _ => Nat.zero_le _) hhigh m hm trivial

/-! ## 定理 G3 — 飽和深度の明示上界

$K(P_0):=\max\{k\ge0:\ j^*\ell\ge(\ell-1)\ell^{k}\}$。 -/

/-- $K$ の定義に使う集合は $k=0$ を含む（$j^*\ge1$、$\ell\ge2$）。したがって $K\ge0$ は常に定義される。 -/
theorem K_wellDefined {ℓ j : ℕ} (hℓ : 2 ≤ ℓ) (hj : 1 ≤ j) : (ℓ - 1) * ℓ ^ 0 ≤ j * ℓ := by
  simp
  nlinarith [Nat.sub_le ℓ 1]

/-- **$K=0\iff j^*\le\ell-2$**（定理 G3 の最後の主張）。
左辺は「$k\ge1$ の全ての $k$ で $j^*\ell<(\ell-1)\ell^k$」＝「飽和は深さ 0 のみ」。 -/
theorem K_zero_iff {ℓ j : ℕ} (hℓ : 2 ≤ ℓ) (hj : 1 ≤ j) :
    (∀ k, 1 ≤ k → j * ℓ < (ℓ - 1) * ℓ ^ k) ↔ j + 2 ≤ ℓ := by
  constructor
  · intro h
    have h1 := h 1 (le_refl 1)
    simp only [pow_one] at h1
    have : j < ℓ - 1 := by
      by_contra hc
      push_neg at hc
      have : (ℓ - 1) * ℓ ≤ j * ℓ := Nat.mul_le_mul_right ℓ hc
      omega
    omega
  · intro h k hk
    have h1 : j < ℓ - 1 := by omega
    have h2 : j * ℓ < (ℓ - 1) * ℓ :=
      (Nat.mul_lt_mul_right (show 0 < ℓ by omega)).mpr h1
    have h3 : (ℓ - 1) * ℓ ≤ (ℓ - 1) * ℓ ^ k := by
      apply Nat.mul_le_mul_left
      calc ℓ = ℓ ^ 1 := (pow_one ℓ).symm
        _ ≤ ℓ ^ k := Nat.pow_le_pow_right (by omega) hk
    omega

/-- **$\ell=2$ では必ず $K\ge1$**（注 4.1 の「$\ell=2$ が特別な理由」）。
$j^*\ge1$ なら $j^*\cdot2\ge(2-1)\cdot2^1$ なので $k=1$ が集合に入る。 -/
theorem K_ge_one_of_ell_two {j : ℕ} (hj : 1 ≤ j) : (2 - 1) * 2 ^ 1 ≤ j * 2 := by
  simp; omega

/-- $\ell$ が奇でも $j^*\ge\ell-1$ なら $K\ge1$（注 4.1 の「同じことは $\ell$ 奇でも起きる」。
実例 $\ell=3$, $j^*=2=\ell-1$）。 -/
theorem K_ge_one_of_jstar_large {ℓ j : ℕ} (hℓ : 2 ≤ ℓ) (hj : ℓ - 1 ≤ j) :
    (ℓ - 1) * ℓ ^ 1 ≤ j * ℓ := by
  simpa using Nat.mul_le_mul_right ℓ hj

/-- 実例の検算: $\ell=3$, $j^*=2$ で $k=1$ は飽和しうる（$K\ge1$）が $k=2$ は非飽和。 -/
theorem K_example_ell_three : (3 - 1) * 3 ^ 1 ≤ 2 * 3 ∧ 2 * 3 < (3 - 1) * 3 ^ 2 := by decide

/-- **定理 G3 の中心の不等式**: $k>K$（すなわち $j^*\ell<(\ell-1)\ell^{k}$）と
$e_{j^*}<\ell^{M-k}$ の下で $\varphi(\ell^M)-\theta+m_1>0$、すなわち
$\theta-m_1<\varphi(\ell^M)$ が成り立つ（定理 B′ の最小点一意性の条件）。

$\theta=e+j^*\ell^{M-k}$、$\varphi(\ell^M)=(\ell-1)\ell^{M-1}$、$m_1\ge2$。 -/
theorem G3_positivity {ℓ j e m₁ M k : ℕ} (hℓ : 2 ≤ ℓ) (hk1 : 1 ≤ k) (hkM : k ≤ M)
    (hm₁ : 2 ≤ m₁) (hK : j * ℓ < (ℓ - 1) * ℓ ^ k) (he : e < ℓ ^ (M - k)) :
    e + j * ℓ ^ (M - k) < (ℓ - 1) * ℓ ^ (M - 1) + m₁ := by
  -- j < (ℓ-1)ℓ^(k-1) すなわち (ℓ-1)ℓ^(k-1) - j ≥ 1
  have hk1' : ℓ ^ k = ℓ ^ (k - 1) * ℓ := by
    rw [← pow_succ]; congr 1; omega
  have hj : j < (ℓ - 1) * ℓ ^ (k - 1) := by
    have hK' : j * ℓ < (ℓ - 1) * ℓ ^ (k - 1) * ℓ := by
      rw [mul_assoc, ← hk1']; exact hK
    exact Nat.lt_of_mul_lt_mul_right hK'
  -- ℓ^(M-k) * (ℓ-1)ℓ^(k-1) = (ℓ-1)ℓ^(M-1)
  have hfac : ℓ ^ (M - k) * ((ℓ - 1) * ℓ ^ (k - 1)) = (ℓ - 1) * ℓ ^ (M - 1) := by
    have : M - k + (k - 1) = M - 1 := by omega
    calc ℓ ^ (M - k) * ((ℓ - 1) * ℓ ^ (k - 1))
        = (ℓ - 1) * (ℓ ^ (M - k) * ℓ ^ (k - 1)) := by ring
      _ = (ℓ - 1) * ℓ ^ (M - k + (k - 1)) := by rw [← pow_add]
      _ = (ℓ - 1) * ℓ ^ (M - 1) := by rw [this]
  -- j + 1 ≤ (ℓ-1)ℓ^(k-1) なので ℓ^(M-k)(j+1) ≤ (ℓ-1)ℓ^(M-1)
  have hstep : ℓ ^ (M - k) * (j + 1) ≤ (ℓ - 1) * ℓ ^ (M - 1) := by
    rw [← hfac]
    exact Nat.mul_le_mul_left _ hj
  have : e + j * ℓ ^ (M - k) < ℓ ^ (M - k) * (j + 1) := by
    have : ℓ ^ (M - k) * (j + 1) = j * ℓ ^ (M - k) + ℓ ^ (M - k) := by ring
    omega
  omega

/-- **$(4.2)$ の $(\Lambda_k,\theta^\sharp_k)$ が 2 つのレベルから決まる**。
$\varphi(\ell^M)\Lambda+\theta^\sharp=e+j\ell^{M-k}$ が $M$ と $M+1$ で成り立つなら
$\Lambda=j/\varphi(\ell^k)$ かつ $\theta^\sharp=e$。
$\mathbb{N}$ の切り捨て引き算を避けるため $B:=M-k$、$C:=k-1$ と置いた
（$\varphi(\ell^M)=(\ell-1)\ell^{B+C}$、$\varphi(\ell^k)=(\ell-1)\ell^{C}$）。 -/
theorem G3_two_levels (L : ℚ) (hL0 : L ≠ 0) (hL1 : L ≠ 1) (Λ θs e j : ℚ) (B C : ℕ)
    (h1 : (L - 1) * L ^ (B + C) * Λ + θs = e + j * L ^ B)
    (h2 : (L - 1) * (L ^ (B + C) * L) * Λ + θs = e + j * (L ^ B * L)) :
    Λ = j / ((L - 1) * L ^ C) ∧ θs = e := by
  have hLne : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  have hB : (L : ℚ) ^ B ≠ 0 := pow_ne_zero _ hL0
  have hC : (L : ℚ) ^ C ≠ 0 := pow_ne_zero _ hL0
  have hd : (L - 1) * L ^ (B + C) * Λ * (L - 1) = j * L ^ B * (L - 1) := by
    linear_combination h2 - h1
  have hd2 : (L - 1) * L ^ (B + C) * Λ = j * L ^ B := mul_right_cancel₀ hLne hd
  rw [pow_add] at hd2
  have hd3 : ((L - 1) * L ^ C * Λ) * L ^ B = j * L ^ B := by linear_combination hd2
  have hkey : (L - 1) * L ^ C * Λ = j := mul_right_cancel₀ hB hd3
  refine ⟨?_, ?_⟩
  · rw [eq_div_iff (mul_ne_zero hLne hC)]
    linear_combination hkey
  · rw [pow_add] at h1
    linear_combination h1 - hd2

/-! ## §5.2 (b) の層の和と、$M^*$ の条件 2 の強さ

report §5.2 (b) は $\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})=\ell^{M-r^\sharp}-\ell^{K}$ を使う。
これは $s=M-r$ と置き換えると $\sum_{s=K+1}^{M-r^\sharp}\varphi(\ell^{s})=\ell^{M-r^\sharp}-\ell^{K}$ である。

**この等式が成り立つ条件は $K\le M-r^\sharp$、すなわち $M\ge r^\sharp+K$ である**（$K=M-r^\sharp$ では
両辺とも $0$）。ところが §5.3 の $M^*$ の条件 2 は $M\ge r^\sharp+\max K+1$ と**1 つ強い**。
そして §6.1（定理 J8 との照合）は $r^\sharp=1$, $K=0$ の下で **$M^*=1$** を使っている。
$1=r^\sharp+K$ なので §5.3 の条件 2 は満たさず、**§5.3 と §6.1 が食い違っている**。
下の `sum_totient_Ico` が示すとおり、正しい条件は $M\ge r^\sharp+K$ の方であり、
§6.1 の計算は正しい。**直すべきは §5.3 の条件 2 である。** -/

/-- $\sum_{s=K+1}^{N}\varphi(\ell^{s})=\ell^{N}-\ell^{K}$（$K\le N$。$K=N$ では両辺 $0$）。
**$K\le N$ が必要十分**であり、$N<K$ では左辺は $0$ だが右辺は負になる。 -/
theorem sum_totient_Ico {ℓ : ℕ} (hℓ : ℓ.Prime) {K N : ℕ} (hKN : K ≤ N) :
    (∑ s ∈ Finset.Ico (K + 1) (N + 1), (Nat.totient (ℓ ^ s) : ℤ)) = (ℓ : ℤ) ^ N - (ℓ : ℤ) ^ K := by
  induction N with
  | zero =>
      have : K = 0 := by omega
      subst this; simp
  | succ P ih =>
      rcases Nat.lt_or_ge K (P + 1) with h | h
      · have hKP : K ≤ P := by omega
        rw [Finset.sum_Ico_succ_top (by omega), ih hKP, Nat.totient_prime_pow hℓ (by omega)]
        have hℓ1 : 1 ≤ ℓ := hℓ.one_lt.le
        push_cast [Nat.cast_sub hℓ1]
        rw [pow_succ]
        ring
      · have : K = P + 1 := by omega
        subst this; simp

/-- **境界の検算**: $M=r^\sharp+K$ では (b) の層の範囲は空で、閉形式の値も $0$ になる。
すなわち §5.3 の条件 2 の「$+1$」は不要である。 -/
theorem layer_b_boundary {ℓ : ℕ} (hℓ : ℓ.Prime) (K : ℕ) :
    (∑ s ∈ Finset.Ico (K + 1) (K + 1), (Nat.totient (ℓ ^ s) : ℤ)) = (ℓ : ℤ) ^ K - (ℓ : ℤ) ^ K := by
  simp

/-! ## 定理 G4 — $(5.2)$–$(5.4)$ を定理 G1 に代入する -/

/-- **$(5.5)$ の $b$**: $(5.2)$ の $\alpha=\frac{\ell-1}{\ell}\sum j^*$ を定理 G1 の
$b=\frac{\ell}{\ell-1}\alpha$ に入れると $b=\sum_{P_0\in S_\infty}j^*(P_0)$。
**定理 Q1（`DropAssumptionBStar.lean`）が別経路で出した値と一致する。** -/
theorem theorem_G4_b (L : ℚ) (hL0 : L ≠ 0) (hL1 : L ≠ 1) (J : ℚ) :
    L / (L - 1) * ((L - 1) / L * J) = J := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  field_simp

/-- **$(5.5)$ の $d$**: $d=\gamma-2$（定理 G1 $(2.2)$ の最後の式そのもの）。 -/
theorem theorem_G4_d (γ : ℚ) : γ - 2 = γ - 2 := rfl

/-- **$c$（$\ell^n$ の係数）の展開形**。$(5.2)$$(5.3)$ を
$c=\frac{\ell}{\ell-1}\beta-\frac{\ell}{(\ell-1)^2}\alpha$ に入れる。
$\alpha$ の項は $-\frac{\ell}{(\ell-1)^2}\cdot\frac{\ell-1}{\ell}J=-\frac{J}{\ell-1}$ に潰れる。 -/
theorem theorem_G4_c (L : ℚ) (hL0 : L ≠ 0) (hL1 : L ≠ 1) (J β : ℚ) :
    L / (L - 1) * β - L / (L - 1) ^ 2 * ((L - 1) / L * J) = L / (L - 1) * β - J / (L - 1) := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  field_simp

/-- **$K$ の取り方は $(5.3)$$(5.4)$ の値を変えない**（注 4.2 の正当性）。
$(5.4)$ の $\gamma$ は $-e\ell^{K}+\theta^\sharp_0+\sum_{k=1}^{K}\varphi(\ell^k)\theta^\sharp_k$ で、
$K$ を $K+1$ にすると $-e\ell^{K+1}+\varphi(\ell^{K+1})\theta^\sharp_{K+1}$ が加わる分だけ変わる。
非飽和層では $\theta^\sharp_{K+1}=e$（$(4.2)$）なので、変化量は
$-e\ell^{K+1}+e\ell^K+\varphi(\ell^{K+1})e=e(\ell^K-\ell^{K+1}+\varphi(\ell^{K+1}))=0$。
**すなわち実は不変であり、注 4.2 の「$K$ は上界であってよい」は正しい。** -/
theorem G4_K_dependence (L e : ℚ) (K : ℕ) :
    -(e * L ^ (K + 1)) + (L ^ (K + 1) - L ^ K) * e = -(e * L ^ K) := by ring

end GeneralTower
end IntegrableLattice
