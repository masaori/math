/-
# 定理 D1・命題 D1a・定理 D2–D6（係数 $d,e$ の情報階層）— cycle 23 step 4

対応する人手証明:

* 根拠 report: `outputs/reports/cycle22_T3_coefficients_d_e.md`
  §2（定理 D1・命題 D1a）・§3（定理 D2）・§4（3 層の情報階層）・§5（定理 D3）・
  §6.1（定理 D4）・§6.2（定理 D5）・§6.3（定理 D6）
* 前提となる cycle 21 の定理 G1・G4 は `GeneralTowerClosedForm.lean`（本ファイルはそれを import する）
* 本文への反映は cycle 23 step 1 の担当（本ファイルの時点では本文未反映）

## 目的

**証明の正しさではなく、主張が一意に読めるか・仮定が過不足ないかの検査**である（8 サイクル目）。

## 形式化した主張

* `D1_d_formula` / `D1_c_bracket` / `D1_c_alpha_term` — 定理 D1 $(2.2)$$(2.3)$ が
  cycle 21 $(5.2)$–$(5.4)$ の書き換えとして正しいこと（$\mathbb{Q}$ 上の恒等式）。
* `D1_d_integer` / `D1_d_empty` — $d\in\mathbb{Z}$（$\mathcal{T},e_{j^*}\in\mathbb{Z}$ から）と
  $S_\infty=\emptyset\Rightarrow d=-2$。
* `totient_step` / `D1a_d_invariant` / `D1a_c_invariant` — 命題 D1a（$K\to K+1$ で $c,d$ 不変）。
  $\varphi(\ell^{K+1})=\ell^{K+1}-\ell^{K}$（$\ell$ 素数）が効いている。
* `D2_residual` — **定理 D2 の中身**。cycle 14 $(6.1)$ の左辺と $(1.1)$ の 5 係数形の差が
  ちょうど「レベル $n$ までの過渡欠損 $-\ T_\mathrm{def}$」であること。
* `Tdef_Mstar_indep` — $T_\mathrm{def}$ の $M^*$ 非依存性。
* **`D2_equiv_forward_false`** — 定理 D2 の最後の主張
  「$T_\mathrm{def}=0$ と $(1.1)$ が $n\ge0$ から成り立つことは同値」の **$\Rightarrow$ 方向は偽**
  であることの反例。`D2_equiv_corrected` が正しい同値（$\Theta_M=\Theta^\mathrm{as}_M$ が全 $M$ で成立）を与える。
* `expand_at_one_plus_x` / `D3_stage_poly` / `D5_stage_poly` — $y=1+x$ 代入の係数抽出
  （定理 D3・D5 の手計算の核）。
* `D3_d_formula` / `D3_bracket` / `D3_c_formula` / `D3_values` / `D3_e_values` /
  `D3_ell2_torus_values` — 定理 D3 の族と $\ell=2$ トーラスの数値。
* `D3_theta_case_split` — $p$ 奇で「$4\mid p-1\iff p\equiv1\bmod4$」。
* **`D3_p_eq_one_convention`** — 定理 D3 の 2 の $\Lambda_1=\min(2,v_2(p-1))$ は、
  $p=1$（＝ $\ell=2$ トーラス。この定理の主役の片方）で $A_2=1-p=0$ になるため、
  $v_2(0)=0$ という mathlib（および標準）の規約の下では**偽**である
  （$0$ 係数を $\min$ から除く規約を明示しない限り一意に読めない）。
* `D4_congruence` / `D4_valuations` / `D4_Lambda_sum_shift` / `D4_c_shift` /
  `D4_d_invariant` — 定理 D4。
* `D5_val_facts` / `D5_V2` / `D5_theta_flip` / `D5_d_shift` — 定理 D5。
* **`D6_truncation`** — 定理 D6。$\tilde E\bmod\ell^{N}$ が段データ $(\Lambda_k,\theta^\sharp_k)$ を決めること。
* **`D6_boundary_sharp`** — $(6.1)$ の**狭義**不等号が必要であること
  （$N=\max\Lambda$ に弱めると結論が破れる具体例）。report の書き方（狭義）は正しい。

## 形式化しなかったもの（mathlib の欠落か配線か）

`lean/logs/mathlib-gap-survey-cycle23.log` を参照。
-/
import Mathlib
import IntegrableLattice.GeneralTowerClosedForm

namespace IntegrableLattice
namespace CoeffsDE

open Finset

/-! ## §2 定理 D1 — $\Lambda$ は $c$ へ、$\theta^\sharp$ は $d$ へ

report $(2.1)$ の $\mathcal{L},\mathcal{T}$ は点ごとの量なので、$S_\infty$ 上の
`Finset` の和として書き、各点の値を変数で受ける。 -/

/-- **定理 D1 $(2.2)$**: cycle 21 $(5.4)$ の $\gamma$ と $d=\gamma-2$（$(5.5)$）から
$d=\sum_{P_0}(\mathcal{T}-e_{j^*}\ell^{K})-2$ が出る。

`T P` が $\mathcal{T}(P_0)=\theta^\sharp_0+\sum_{k=1}^{K}\varphi(\ell^k)\theta^\sharp_k$。
**右辺に $\Lambda$ も $A_\mathrm{gen}$ も $v_\ell(\kappa(X))$ も現れない**ことが型で読める。 -/
theorem D1_d_formula {ι : Type*} (S : Finset ι) (T ej : ι → ℚ) (Kp : ι → ℕ) (L γ : ℚ)
    (hγ : γ = ∑ P ∈ S, (-(ej P * L ^ (Kp P)) + T P)) :
    γ - 2 = (∑ P ∈ S, (T P - ej P * L ^ (Kp P))) - 2 := by
  rw [hγ]
  congr 1
  exact Finset.sum_congr rfl (fun P _ => by ring)

/-- **定理 D1 $(2.3)$ の点ごとの部分**: cycle 21 $(5.3)$ の角括弧に $\frac{\ell}{\ell-1}$ を掛けると
report $(2.3)$ の角括弧（$\frac{j^*}{\ell-1}$ を引く前）になる。

`Lrs` $=\ell^{r^\sharp}$、`Lc` $=\mathcal{L}(P_0)=\Lambda_0+\sum_{k\ge1}\varphi(\ell^k)\Lambda_k$。 -/
theorem D1_c_bracket (L Lrs ej jst Kq Lc : ℚ) (hL1 : L ≠ 1) (hL0 : L ≠ 0) (hLrs : Lrs ≠ 0) :
    L / (L - 1) * (ej / Lrs - (L - 1) * jst * Kq / L + (L - 1) / L * Lc)
      = ej * L / (Lrs * (L - 1)) - jst * Kq + Lc := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  field_simp

/-- **定理 D1 $(2.3)$ の $\alpha$ の項**: $(5.2)$ を $-\frac{\ell}{(\ell-1)^2}\alpha$ に入れると
$-\frac{1}{\ell-1}\sum j^{*}$ に潰れる。これが $(2.3)$ の $-j^{*}\cdot\frac1{\ell-1}$ の出どころ。 -/
theorem D1_c_alpha_term (L J : ℚ) (hL1 : L ≠ 1) (hL0 : L ≠ 0) :
    L / (L - 1) ^ 2 * ((L - 1) / L * J) = J / (L - 1) := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  field_simp

/-- **定理 D1 の 2（$d\in\mathbb{Z}$）**: $\mathcal{T}$ と $e_{j^*}$ が整数なら $d$ は整数。
$c$ にある $\frac{1}{\ell-1}$ 型の分母が $d$ には一切入らない（$(2.2)$）ことの帰結。 -/
theorem D1_d_integer {ι : Type*} (S : Finset ι) (T ej : ι → ℤ) (Kp : ι → ℕ) (l : ℤ) :
    ∃ z : ℤ,
      (∑ P ∈ S, ((T P : ℚ) - (ej P : ℚ) * (l : ℚ) ^ (Kp P))) - 2 = (z : ℚ) := by
  refine ⟨(∑ P ∈ S, (T P - ej P * l ^ (Kp P))) - 2, ?_⟩
  push_cast
  ring

/-- **定理 D1 の 4**: $S_\infty=\emptyset$ なら $d=-2$（cycle 21 系 G6 と整合）。 -/
theorem D1_d_empty {ι : Type*} (T ej : ι → ℚ) (Kp : ι → ℕ) (L : ℚ) :
    (∑ P ∈ (∅ : Finset ι), (T P - ej P * L ^ (Kp P))) - 2 = -2 := by
  simp

/-! ## §2.3 命題 D1a — $K$ を上界として大きめに取ってもよい -/

/-- $\varphi(\ell^{K+1})=\ell^{K+1}-\ell^{K}$（$\ell$ 素数）。命題 D1a の相殺計算の材料。 -/
theorem totient_step {l : ℕ} (hl : l.Prime) (K : ℕ) :
    (Nat.totient (l ^ (K + 1)) : ℤ) = (l : ℤ) ^ (K + 1) - (l : ℤ) ^ K := by
  rw [Nat.totient_prime_pow hl (Nat.succ_pos K)]
  have h1 : 1 ≤ l := hl.one_lt.le
  push_cast [Nat.cast_sub h1]
  ring

/-- **命題 D1a（$d$ 側）**: 深さ $K+1$ は非飽和なので $(4.2)$ より $\theta^\sharp_{K+1}=e_{j^*}$。
$\mathcal{T}$ は $\varphi(\ell^{K+1})e_{j^*}=(\ell^{K+1}-\ell^{K})e_{j^*}$ だけ増え、
$-e_{j^*}\ell^{K}$ は $-e_{j^*}\ell^{K+1}$ になる。**差し引き 0**。 -/
theorem D1a_d_invariant (L T ej : ℚ) (K : ℕ) :
    (T + (L ^ (K + 1) - L ^ K) * ej) - ej * L ^ (K + 1) = T - ej * L ^ K := by
  ring

/-- **命題 D1a（$c$ 側）**: $\mathcal{L}$ は $\varphi(\ell^{K+1})\Lambda_{K+1}=j^{*}$ だけ増え、
$-j^{*}(K+r^\sharp+\frac1{\ell-1})$ の $K$ が $K+1$ になる。**差し引き 0**。 -/
theorem D1a_c_invariant (L jst rs Lc : ℚ) (K : ℕ) :
    (Lc + jst) - jst * (((K : ℚ) + 1) + rs + 1 / (L - 1))
      = Lc - jst * ((K : ℚ) + rs + 1 / (L - 1)) := by
  ring

/-- $\varphi(\ell^{K+1})\Lambda_{K+1}=j^{*}$（$(4.2)$ の $\Lambda_{K+1}=j^{*}/\varphi(\ell^{K+1})$）。 -/
theorem D1a_Lambda_step (φ j : ℚ) (hφ : φ ≠ 0) : φ * (j / φ) = j := by
  field_simp

/-! ## §3 定理 D2 — $e$ の正体は過渡欠損 $T_\mathrm{def}$ -/

/-- レベル $n$ までの**過渡欠損の部分和** $\sum_{M=1}^{n}(\Theta_M-\Theta^\mathrm{as}_M)$。
$T_\mathrm{def}$ は $n=M^{*}-1$（以上のどこか）での値である。 -/
noncomputable def Sdef (Θ Θas : ℕ → ℚ) (n : ℕ) : ℚ :=
  ∑ M ∈ Finset.Ico 1 (n + 1), (Θ M - Θas M)

/-- **$T_\mathrm{def}$ の $M^{*}$ 非依存性**（定理 D2 前半）: $M\ge M^{*}$ で $\Theta_M=\Theta^\mathrm{as}_M$
なら、打ち切りを 1 つ伸ばしても値は変わらない。 -/
theorem Tdef_Mstar_indep (Θ Θas : ℕ → ℚ) (ms : ℕ) (h : Θ (ms + 1) = Θas (ms + 1)) :
    Sdef Θ Θas (ms + 1) = Sdef Θ Θas ms := by
  rw [Sdef, Sdef, Finset.sum_Ico_succ_top (by omega)]
  simp [h]

/-- **定理 D2 の中身**。cycle 14 $(6.1)$ の左辺から $(1.1)$ の 5 係数形（$e$ の角括弧を
$T_\mathrm{def}=$ `Sdef Θ Θas ms` としたもの）を引くと、ちょうど
$$\sum_{M\le n}(\Theta_M-\Theta^\mathrm{as}_M)\ -\ T_\mathrm{def}$$
になる。

したがって:

* $n\ge M^{*}-1$ では両者が一致する（cycle 21 $(2.3)$ の角括弧 $=T_\mathrm{def}$。**これが定理 D2**）。
* **$n$ が小さいところで一致するかどうかは、部分和が $T_\mathrm{def}$ に等しいかで決まる。**
  総和が $0$ であることは部分和が $0$ であることを意味しない（`D2_equiv_forward_false`）。 -/
theorem D2_residual (L : ℚ) (hL : L ≠ 1) (μ κX α β γ : ℚ) (Θ Θas : ℕ → ℚ) (ms n : ℕ)
    (hΘas : ∀ M, 1 ≤ M → Θas M = α * M * L ^ M + β * L ^ M + γ) :
    (κX - 2 * n + μ * (L ^ (2 * n) - 1) + ∑ M ∈ Finset.Ico 1 (n + 1), Θ M)
        - (μ * L ^ (2 * n)
            + (L / (L - 1) * α) * (n * L ^ n)
            + (L / (L - 1) * β - L / (L - 1) ^ 2 * α) * L ^ n
            + (γ - 2) * n
            + (κX - μ + Sdef Θ Θas ms + L / (L - 1) ^ 2 * α - L / (L - 1) * β))
      = Sdef Θ Θas n - Sdef Θ Θas ms := by
  have hE := GeneralTower.theorem_G1 L hL μ κX α β γ Θas 0 n (Nat.zero_le n)
    (fun M hM => hΘas M hM)
  simp only [GeneralTower.S1, GeneralTower.S0, Nat.cast_zero, mul_zero, sub_zero,
    Finset.Ico_self, Finset.sum_empty] at hE
  have hsplit : ∑ M ∈ Finset.Ico 1 (n + 1), Θ M
      = (∑ M ∈ Finset.Ico 1 (n + 1), Θas M) + Sdef Θ Θas n := by
    rw [Sdef, Finset.sum_sub_distrib]
    ring
  rw [hsplit]
  linarith [hE]

/-- **定理 D2 の最後の主張の $\Rightarrow$ 方向は偽である。**

report §3 は「$T_\mathrm{def}=0$ であることと、閉形式 $(1.1)$ が $n\ge0$ から成り立つことは同値」
と書き、証明では「$T_\mathrm{def}=0$ は $\sum_{M<M^{*}}(\Theta_M-\Theta^\mathrm{as}_M)=0$ を意味する」
から直ちに「$\Sigma_n$ が全ての $n\ge0$ で漸近形と一致する」を結論している。
**これは飛躍である**: 総和が $0$ でも部分和は $0$ とは限らない。

反例: $\Theta^\mathrm{as}\equiv0$（$\alpha=\beta=\gamma=0$）、$\Theta_1=1$, $\Theta_2=-1$,
$\Theta_M=0\ (M\ge3)$。$M^{*}=3$（$ms=2$）で $T_\mathrm{def}=0$ だが、$n=1$ での部分和は $1$ で、
`D2_residual` よりそこで閉形式は $1$ だけずれる。 -/
theorem D2_equiv_forward_false :
    ∃ (Θ Θas : ℕ → ℚ) (α β γ : ℚ) (ms : ℕ),
      (∀ M, 1 ≤ M → Θas M = α * M * (2 : ℚ) ^ M + β * (2 : ℚ) ^ M + γ) ∧
      (∀ M, ms + 1 ≤ M → Θ M = Θas M) ∧
      Sdef Θ Θas ms = 0 ∧
      Sdef Θ Θas 1 ≠ 0 := by
  refine ⟨fun M => if M = 1 then 1 else if M = 2 then -1 else 0, fun _ => 0, 0, 0, 0, 2,
    ?_, ?_, ?_, ?_⟩
  · intro M _; ring
  · intro M hM
    have h1 : M ≠ 1 := by omega
    have h2 : M ≠ 2 := by omega
    simp [h1, h2]
  · have h : Finset.Ico 1 3 = ({1, 2} : Finset ℕ) := by decide
    simp [Sdef, h]
  · have h : Finset.Ico 1 2 = ({1} : Finset ℕ) := by decide
    simp [Sdef, h]

/-- **正しい同値**: 閉形式が全ての $n\ge0$ で成り立つ（＝部分和が常に $T_\mathrm{def}$ に等しい）ことは、
$T_\mathrm{def}=0$ **かつ**全てのレベルで $\Theta_M=\Theta^\mathrm{as}_M$（＝過渡が一切無い）ことと
同値である。$T_\mathrm{def}=0$ だけでは足りない。 -/
theorem D2_equiv_corrected (Θ Θas : ℕ → ℚ) (ms : ℕ) :
    (∀ n, Sdef Θ Θas n = Sdef Θ Θas ms)
      ↔ (Sdef Θ Θas ms = 0 ∧ ∀ M, 1 ≤ M → Θ M = Θas M) := by
  constructor
  · intro h
    have h0 : Sdef Θ Θas 0 = 0 := by simp [Sdef]
    have hms : Sdef Θ Θas ms = 0 := by rw [← h 0]; exact h0
    refine ⟨hms, ?_⟩
    intro M hM
    obtain ⟨k, rfl⟩ : ∃ k, M = k + 1 := ⟨M - 1, by omega⟩
    have h1 : Sdef Θ Θas (k + 1) = Sdef Θ Θas k := by rw [h (k + 1), h k]
    rw [Sdef, Sdef, Finset.sum_Ico_succ_top (by omega)] at h1
    linarith
  · rintro ⟨hms, hall⟩ n
    have hz : ∀ m, Sdef Θ Θas m = 0 := by
      intro m
      rw [Sdef]
      refine Finset.sum_eq_zero (fun M hM => ?_)
      rw [Finset.mem_Ico] at hM
      rw [hall M hM.1]
      ring
    rw [hz, hms]

/-! ## §5・§6 定理 D3・D4・D5 — $y=1+x$ 代入と $2$ 進付値の算術 -/

/-- $c_2y^2+c_1y+c_0$ に $y=1+x$ を代入したときの係数。
report が定理 D3・D5 の証明でやっている手計算そのもの。 -/
theorem expand_at_one_plus_x (c₂ c₁ c₀ x : ℤ) :
    c₂ * (1 + x) ^ 2 + c₁ * (1 + x) + c₀
      = (c₂ + c₁ + c₀) + (2 * c₂ + c₁) * x + c₂ * x ^ 2 := by
  ring

/-- **定理 D3 の 2 の $k=1$**: $(1-p)y^2+(2p+2)y+(1-p)$ に $y=1+x$ を入れると
$A_0=A_1=4$, $A_2=1-p$。 -/
theorem D3_stage_poly (p x : ℤ) :
    (1 - p) * (1 + x) ^ 2 + (2 * p + 2) * (1 + x) + (1 - p)
      = 4 + 4 * x + (1 - p) * x ^ 2 := by
  ring

/-- **定理 D3 の 3（$d$）**: $|S_\infty|=2$、各点で $\mathcal{T}=2+\theta^\sharp_1$、
$e_{j^*}\ell^{K}=2\cdot2=4$ なので $d=2\theta^\sharp_1-6$。 -/
theorem D3_d_formula (θ : ℚ) : 2 * ((2 + θ) - 2 * 2) - 2 = 2 * θ - 6 := by ring

/-- **定理 D3 の 3（$c$ の角括弧）**: $\ell=2$, $r^\sharp=2$, $j^{*}=1$, $K=1$, $e_{j^*}=2$ で
$\frac{e_{j^*}\ell^{1-r^\sharp}}{\ell-1}-j^{*}(K+r^\sharp+\frac1{\ell-1})+\mathcal{L}=\mathcal{L}-3$。 -/
theorem D3_bracket (Lc : ℚ) : (2 : ℚ) * (2 : ℚ)⁻¹ / 1 - 1 * (1 + 2 + 1) + Lc = Lc - 3 := by
  norm_num
  ring

/-- **定理 D3 の 3（$c$）**: $c=\frac{\ell}{\ell-1}A_\mathrm{gen}+\sum(\mathcal{L}-3)=2\mathcal{L}-2$
（$A_\mathrm{gen}=2$、$|S_\infty|=2$）。 -/
theorem D3_c_formula (Lc : ℚ) : 2 * 2 + 2 * (Lc - 3) = 2 * Lc - 2 := by ring

/-- **定理 D3 の場合分け**: $p$ が奇のとき $4\mid p-1\iff p\equiv1\pmod 4$
（すなわち $v_2(p-1)\ge2\iff p\equiv1\bmod 4$）。 -/
theorem D3_theta_case_split (p : ℕ) (hp : p % 2 = 1) :
    4 ∣ (p - 1) ↔ p % 4 = 1 := by
  omega

/-- **定理 D3 の主役 2 本の $(c,d)$**: $p=1$（$\theta^\sharp_1=0$, $\mathcal{L}=3$）と
$p=3$（$\theta^\sharp_1=2$, $\mathcal{L}=3$）。$c$ は一致し $d$ だけが違う。 -/
theorem D3_values :
    (2 * (0 : ℚ) - 6 = -6 ∧ 2 * (3 : ℚ) - 2 = 4)
      ∧ (2 * (2 : ℚ) - 6 = -2 ∧ 2 * (3 : ℚ) - 2 = 4) := by
  norm_num

/-- **定理 D3 の $e$**: 定理 D2 より $e=v_2(\kappa(X))-a-c+T_\mathrm{def}=-4+T_\mathrm{def}$。
$T_\mathrm{def}$ は $p=1$ で $3$、$p=3$ で $0$ なので $e=-1,-4$。 -/
theorem D3_e_values : (-(4 : ℚ) + 3 = -1) ∧ (-(4 : ℚ) + 0 = -4) := by norm_num

/-- $\ell=2$ トーラス（$p=1$）の閉形式 $2n2^{n}+4\cdot2^{n}-6n-1$ が
DuBose–Vallières の数列 $5,19,61,167,417,987$ を再現する（cycle 21 §6.3 の数値）。 -/
theorem D3_ell2_torus_values :
    2 * (1 : ℤ) * 2 ^ 1 + 4 * 2 ^ 1 - 6 * 1 - 1 = 5 ∧
    2 * (2 : ℤ) * 2 ^ 2 + 4 * 2 ^ 2 - 6 * 2 - 1 = 19 ∧
    2 * (3 : ℤ) * 2 ^ 3 + 4 * 2 ^ 3 - 6 * 3 - 1 = 61 ∧
    2 * (4 : ℤ) * 2 ^ 4 + 4 * 2 ^ 4 - 6 * 4 - 1 = 167 ∧
    2 * (5 : ℤ) * 2 ^ 5 + 4 * 2 ^ 5 - 6 * 5 - 1 = 417 ∧
    2 * (6 : ℤ) * 2 ^ 6 + 4 * 2 ^ 6 - 6 * 6 - 1 = 987 := by
  norm_num

/-- **定理 D3 の 2 は $p=1$ で字義どおりには偽である。**

定理 D3 の 2 は $\Lambda_1=\min(2,v_2(p-1))$ と書くが、$p=1$ では $A_2=1-p=0$ であり、
$v_2(0)$ は mathlib（および通常の規約）で $0$ である。$\min(2,0)=0\ne2$ で、
証明本文が使っている値 $\Lambda_1=2$（$\mathcal{L}=1+2=3$）と食い違う。

正しく読むには「**$A_m\ne0$ の $m$ についてのみ $\min$ を取る**」という規約が要る
（$0$ の付値は $+\infty$）。$p=1$ は定理 D3 の主役の片方（$\ell=2$ トーラス）なので、
この規約を明記しないと主張が一意に読めない。 -/
theorem D3_p_eq_one_convention :
    min 2 (padicValNat 2 (1 - 1)) = 0 ∧ (0 : ℕ) ≠ 2 := by
  constructor
  · simp
  · omega

/-! ### 定理 D4（$c$ の側。任意の固定精度で足りない） -/

/-- $2$ 進付値がちょうど $k$ であること（$v_2(n)=k$）を、割り切りの言葉で書いたもの。
`padicValNat` の $0$ での規約（`D3_p_eq_one_convention`）に巻き込まれないようにするため、
以下ではこの形を使う。 -/
def V2 (k n : ℕ) : Prop := 2 ^ k ∣ n ∧ ¬ (2 ^ (k + 1) ∣ n)

theorem V2_mul_odd (k m : ℕ) (hm : ¬ 2 ∣ m) : V2 k (2 ^ k * m) := by
  refine ⟨dvd_mul_right _ _, ?_⟩
  intro h
  rw [pow_succ] at h
  exact hm ((Nat.mul_dvd_mul_iff_left (show 0 < 2 ^ k from pow_pos (by norm_num) k)).mp h)

/-- **定理 D4 の 3 の合同**: $t=2^{N+1}-1$, $t'=3\cdot2^{N}-1$ は $t'-t=2^{N}$、
したがって $\tilde E$ の係数の差はすべて $2^{N}$ の倍数（$D$ の差は $2^{N}(2-zw^{-1}-z^{-1}w)$）。 -/
theorem D4_congruence (N : ℕ) : (2 ^ (N + 1) - 1) + 2 ^ N = 3 * 2 ^ N - 1 := by
  have h : (2 : ℕ) ^ (N + 1) = 2 * 2 ^ N := by ring
  have hp : 0 < (2 : ℕ) ^ N := pow_pos (by norm_num) N
  omega

/-- **定理 D4 の 3 の付値**（$N=M+2\ge2$ と書いた。$t=2^{N+1}-1$, $t'=3\cdot2^{N}-1$）:
$v_2(t+1)=N+1$、$v_2(t'+1)=N$、$v_2(t-1)=v_2(t'-1)=1$。
$N=1$ では最後が破れる（report §7.2 の注記と整合）。 -/
theorem D4_valuations (M : ℕ) :
    V2 (M + 3) (2 ^ (M + 3) - 1 + 1) ∧ V2 (M + 2) (3 * 2 ^ (M + 2) - 1 + 1) ∧
    V2 1 (2 ^ (M + 3) - 1 - 1) ∧ V2 1 (3 * 2 ^ (M + 2) - 1 - 1) := by
  have hp : 0 < (2 : ℕ) ^ M := pow_pos (by norm_num) M
  have h2 : (2 : ℕ) ^ (M + 2) = 4 * 2 ^ M := by ring
  have h3 : (2 : ℕ) ^ (M + 3) = 8 * 2 ^ M := by ring
  refine ⟨?_, ?_, ?_, ?_⟩
  · have e : 2 ^ (M + 3) - 1 + 1 = 2 ^ (M + 3) * 1 := by omega
    rw [e]; exact V2_mul_odd _ 1 (by omega)
  · have e : 3 * 2 ^ (M + 2) - 1 + 1 = 2 ^ (M + 2) * 3 := by omega
    rw [e]; exact V2_mul_odd _ 3 (by omega)
  · have e : 2 ^ (M + 3) - 1 - 1 = 2 ^ 1 * (4 * 2 ^ M - 1) := by omega
    rw [e]; exact V2_mul_odd _ _ (by omega)
  · have e : 3 * 2 ^ (M + 2) - 1 - 1 = 2 ^ 1 * (6 * 2 ^ M - 1) := by omega
    rw [e]; exact V2_mul_odd _ _ (by omega)

/-- **定理 D4 の 3 の $\mathcal{L}$ の減少**: 段データの変化は 3 箇所
（$(1{:}1)$ の $\Lambda_1$: $N+3\to N+2$、$(0{:}1),(1{:}0)$ の $\Lambda_0$: $N+1\to N$）だけで、
$\sum_{P_0}\mathcal{L}$ はちょうど $3$ 減る。 -/
theorem D4_Lambda_sum_shift (N : ℕ) :
    ((N + 3) + (N + 1) + (N + 1)) - ((N + 2) + N + N) = 3 := by omega

/-- $(2.3)$ で $\mathcal{L}$ の係数は $1$ なので、$\sum\mathcal{L}$ が $3$ 減れば $c$ も $3$ 減る。 -/
theorem D4_c_shift {ι : Type*} (S : Finset ι) (f g : ι → ℚ) (A : ℚ)
    (h : ∑ P ∈ S, g P = (∑ P ∈ S, f P) - 3) :
    (A + ∑ P ∈ S, g P) = (A + ∑ P ∈ S, f P) - 3 := by
  rw [h]; ring

/-- **定理 D4 の $d$ 不変性**: $\theta^\sharp$ が 4 箇所とも不変なら、$(2.2)$ より $d$ は不変。
**定理 D4 は $c$ についての障害であって $d$ の障害を含まない**（$d$ の障害は定理 D5 が別に要る）。 -/
theorem D4_d_invariant {ι : Type*} (S : Finset ι) (T T' ej : ι → ℚ) (Kp : ι → ℕ) (L : ℚ)
    (h : ∀ P ∈ S, T' P = T P) :
    (∑ P ∈ S, (T' P - ej P * L ^ (Kp P))) - 2
      = (∑ P ∈ S, (T P - ej P * L ^ (Kp P))) - 2 := by
  congr 1
  exact Finset.sum_congr rfl (fun P hP => by rw [h P hP])

/-! ### 定理 D5（$d$ の側。位置の情報も深い） -/

/-- **定理 D5 の段データ**: $(t-q)y^2+(4p+2q+2t)y+(t-q)$ に $y=1+x$ を入れると
$A_0=A_1=4p+4t$、$A_2=t-q$。 -/
theorem D5_stage_poly (p q t x : ℤ) :
    (t - q) * (1 + x) ^ 2 + (4 * p + 2 * q + 2 * t) * (1 + x) + (t - q)
      = (4 * p + 4 * t) + (4 * p + 4 * t) * x + (t - q) * x ^ 2 := by
  ring

/-- **定理 D5 の具体化**（$t=1$, $p=2^{N+1}-1$, $q=1+2^{N+2}$, $p'=p+2^{N}$）:
$4(p+t)=2^{N+3}$、$q-t=2^{N+2}$、$4(p'+t)=3\cdot2^{N+2}$。 -/
theorem D5_val_facts (N : ℕ) :
    4 * (2 ^ (N + 1) - 1 + 1) = 2 ^ (N + 3) ∧
    (1 + 2 ^ (N + 2)) - 1 = 2 ^ (N + 2) ∧
    4 * (2 ^ (N + 1) - 1 + 2 ^ N + 1) = 2 ^ (N + 2) * 3 := by
  have hp : 0 < (2 : ℕ) ^ N := pow_pos (by norm_num) N
  have h1 : (2 : ℕ) ^ (N + 1) = 2 * 2 ^ N := by ring
  have h2 : (2 : ℕ) ^ (N + 2) = 4 * 2 ^ N := by ring
  have h3 : (2 : ℕ) ^ (N + 3) = 8 * 2 ^ N := by ring
  refine ⟨by omega, by omega, by omega⟩

theorem D5_V2 (N : ℕ) :
    V2 (N + 3) (2 ^ (N + 3)) ∧ V2 (N + 2) (2 ^ (N + 2)) ∧ V2 (N + 2) (2 ^ (N + 2) * 3) := by
  refine ⟨?_, ?_, V2_mul_odd _ 3 (by omega)⟩
  · simpa using V2_mul_odd (N + 3) 1 (by omega)
  · simpa using V2_mul_odd (N + 2) 1 (by omega)

/-- 定理 D5 が述べる $\theta^\sharp_1$ の規則（$A_0,A_1$ は同じ付値なので、
最小を**最初に**達成する添字は $A_0$ の付値が $A_2$ 以下なら $0$、そうでなければ $2$）。 -/
def thetaSharp1 (v0 v2 : ℕ) : ℕ := if v0 ≤ v2 then 0 else 2

/-- **定理 D5 の核**: $\Lambda_1$ は $N+2$ のまま**不変**なのに $\theta^\sharp_1$ が $2\to0$ に動く。
付値側だけを見ていては捕まえられない。 -/
theorem D5_theta_flip (N : ℕ) :
    min (N + 3) (N + 2) = N + 2 ∧ min (N + 2) (N + 2) = N + 2 ∧
    thetaSharp1 (N + 3) (N + 2) = 2 ∧ thetaSharp1 (N + 2) (N + 2) = 0 := by
  refine ⟨by omega, by omega, ?_, ?_⟩
  · simp [thetaSharp1]
  · simp [thetaSharp1]

/-- **定理 D5 の $d$ の変化**: 1 点の $\mathcal{T}$ が $\varphi(2)\cdot(0-2)=-2$ だけ動くと、
$(2.2)$ より $d$ もちょうど $-2$ だけ動く。 -/
theorem D5_d_shift {ι : Type*} [DecidableEq ι] (S : Finset ι) (T T' ej : ι → ℚ) (Kp : ι → ℕ)
    (L : ℚ) (P₀ : ι) (hP : P₀ ∈ S)
    (hdiff : T' P₀ = T P₀ - 2)
    (hrest : ∀ P ∈ S, P ≠ P₀ → T' P = T P) :
    ((∑ P ∈ S, (T' P - ej P * L ^ (Kp P))) - 2)
      = ((∑ P ∈ S, (T P - ej P * L ^ (Kp P))) - 2) - 2 := by
  have h1 := Finset.add_sum_erase S (fun P => T' P - ej P * L ^ (Kp P)) hP
  have h2 := Finset.add_sum_erase S (fun P => T P - ej P * L ^ (Kp P)) hP
  have h3 : ∑ x ∈ S.erase P₀, (T' x - ej x * L ^ (Kp x))
      = ∑ x ∈ S.erase P₀, (T x - ej x * L ^ (Kp x)) :=
    Finset.sum_congr rfl (fun x hx => by
      rw [hrest x (Finset.mem_of_mem_erase hx) (Finset.ne_of_mem_erase hx)])
  rw [← h1, ← h2, h3, hdiff]
  ring

/-! ## §6.3 定理 D6 — 精度が足りる条件（と、その境界の鋭さ）

$\tilde E'=\tilde E+\ell^{N}h$ とすると各係数の付値は
$\min(v_\ell(A_m),N)$ の意味でしか変わらない。$\Lambda_k<N$ ならこの切り捨て付き付値列から
$\Lambda_k$（最小値）も $\theta^\sharp_k$（最小を最初に達成する添字）も読める。 -/

/-- **定理 D6**。`s` は $A_m\ne0$ の添字集合、`v`/`v'` は摂動前後の（整数化した）付値、
`m₀` は最小を**最初に**達成する添字（$=\theta^\sharp_k$）、`hlt : v m₀ < N` が $(6.1)$。

結論は「$\Lambda$ も $\theta^\sharp$ も摂動で変わらない」。 -/
theorem D6_truncation {N : ℕ} (s : Finset ℕ) (v v' : ℕ → ℕ)
    (htr : ∀ m ∈ s, min (v m) N = min (v' m) N)
    (m₀ : ℕ) (hm₀ : m₀ ∈ s) (hlt : v m₀ < N)
    (hmin : ∀ m ∈ s, v m₀ ≤ v m)
    (hfirst : ∀ m ∈ s, m < m₀ → v m₀ < v m) :
    v' m₀ = v m₀ ∧ (∀ m ∈ s, v' m₀ ≤ v' m) ∧ (∀ m ∈ s, m < m₀ → v' m₀ < v' m) := by
  have h0 := htr m₀ hm₀
  have hv0 : v' m₀ = v m₀ := by omega
  refine ⟨hv0, ?_, ?_⟩
  · intro m hm
    have h1 := htr m hm
    have h2 := hmin m hm
    omega
  · intro m hm hlt'
    have h1 := htr m hm
    have h2 := hfirst m hm hlt'
    omega

/-- **$(6.1)$ の狭義不等号は落とせない。**

`hlt : v m₀ < N` を `v m₀ ≤ N` に弱めると定理 D6 は偽になる。
反例: $\ell=2$, $N=1$、係数 $A=(4,2)$（付値 $(2,1)$）と $A'=(2,2)$（付値 $(1,1)$）。
$A-A'=(2,0)$ はすべて $2^{1}$ の倍数なので $\bmod\ 2^{N}$ で区別できないが、
$\Lambda=1=N$ で、最小を最初に達成する添字は $1$ と $0$ で**違う**（$\theta^\sharp$ が違う）。

すなわち report の $(6.1)$ が狭義（$N>\max\Lambda_k$）で書かれているのは正しい。 -/
theorem D6_boundary_sharp :
    ¬ (∀ (s : Finset ℕ) (v v' : ℕ → ℕ) (N m₀ : ℕ),
        (∀ m ∈ s, min (v m) N = min (v' m) N) →
        m₀ ∈ s → v m₀ ≤ N →
        (∀ m ∈ s, v m₀ ≤ v m) →
        (∀ m ∈ s, m < m₀ → v m₀ < v m) →
        (∀ m ∈ s, m < m₀ → v' m₀ < v' m)) := by
  intro h
  have := h ({0, 1} : Finset ℕ) (fun m => if m = 0 then 2 else 1) (fun _ => 1) 1 1
    (by decide) (by decide) (by decide) (by decide) (by decide) 0 (by decide) (by decide)
  exact absurd this (by norm_num)

end CoeffsDE
end IntegrableLattice
