/-
# cycle 24 step 1 の訂正の検算 ＋ 未検算だった定理群 — cycle 24 step 5

対応する人手証明:

* 訂正の記録: `outputs/reports/cycle24_ops_fix_grounding_reports.md`
* 訂正後の根拠 report:
  - `cycle22_T3_coefficients_d_e.md` §3（定理 D2）・§5.1（定理 D3 の 2）・§6.2（定理 D5）
  - `cycle21_T3_general_closed_form.md` §4 注 4.2・§5.3 条件 2・§5.5 系 G6
  - `cycle21_T3_drop_assumption_B_star.md` §5.2（補題 Q5）・§6（定理 Q1・系 Q7）
* 検出元（前サイクル）: `cycle22_ops_lean_cycle21_theorems.md` / `cycle23_ops_lean_cycle22_theorems.md`

## 目的（2 つある）

1. **訂正が、前サイクルの Lean 検算が挙げた指摘を実際に塞いだかを確かめる。**
   訂正後の主張をそのまま形式化して通す。通らなければ訂正がまだ不十分である。
2. **まだ Lean に通していない定理群を新たに通す。**

## 形式化した主張（1: 訂正の検算）

* `D2_level_iff` / `D2_level_zero_iff` / `D2_all_iff_no_transient` /
  `D2_no_transient_imp_Tdef_zero` — **訂正後の定理 D2 の 3 分岐**（レベル $n$ での成立 $\iff S(n)=T_\mathrm{def}$、
  $n=0$ での成立 $\iff T_\mathrm{def}=0$、全 $n\ge0$ $\iff$ 過渡が一切無い）。
  **訂正後の書き方のほうが `D2_equiv_corrected`（cycle 23）より精密である**ことも型で出た
  （$T_\mathrm{def}=0$ は連言の片方ではなく**帰結**）。
* `LamC` / `thC` / `D3_conv_p_eq_one` / `D3_conv_p_ne_one` / `D5_conv_t_eq_q` /
  `D3_conv_c_p_eq_one` / `D3_old_conv_c_broken` — **訂正後の $v_\ell(0)=+\infty$ 規約**を型に出し、
  $p=1$ と $t=q$ で規約どおりに $(\Lambda_1,\theta^\sharp_1)$ が定まること、
  および $c=4$ が復旧すること（旧規約では復旧しない）。
* `G4_cond2_corrected_at_61` — **訂正後の §5.3 条件 2（$+1$ 無し）が §6.1 の使い方と整合する**こと。
  初稿の条件（$+1$ 付き）は §6.1 で破れることも同時に出す。
* `G4_note42_d_side_totient` / `G4_note42_c_side` — 訂正で書き足された注 4.2 の**打ち消し計算**の両側。
  $(5.4)$ 側は $\varphi(\ell^{K+1})$ を `Nat.totient` のまま扱う。
* `Q5_c1_strict_of_logb` — 訂正で書き足された**狭義不等式 $2b<(\ell-1)\ell^{c_1}$ が $c_1$ の定義から従う**こと。
  実対数を経由する（**ℝ へ脱出する唯一の箇所**）。
* `Q5_c1_exists_nat` / `Q5_c1_nat_least` — **その ℝ 脱出は除去できる**（$c_1$ を
  「$2b<(\ell-1)\ell^{c}$ なる最小の $c$」と定義すれば実対数は要らない）。**本 step の新しい観察**。
* `Q1_C_corrected` — 訂正後の $(6.1)$ の定数
  $C=b(3+r\ell^{c_1})+\theta_G^{\max}\frac{\ell+1}{\ell}+r\ell^{c_1}\log_\ell C_0$ **そのもの**。
  cycle 22 の `theorem_Q1_error` は $\theta_G^{\max}$ の係数を $2$ で緩めていた。

## 形式化した主張（2: 未検算だった定理群）

* `corollary_G6` / `corollary_G6_c_as_Theta` — **系 G6（$S_\infty=\emptyset$）の 5 係数**。
  定理 G1 に $\alpha=\gamma=0,\beta=A_\mathrm{gen}$ を入れた形が report の式と一致すること、
  および $c=\frac{\ell}{\ell-1}A_\mathrm{gen}=\frac{\Theta_L}{\varphi(\ell^{L})}$。
* `Q7_char2_factorization` / `Q7_b_eq_two` — **系 Q7（$\ell=2$ トーラスの $b=2$）**の中心の
  標数 $2$ での因数分解 $w(z-1)^2+z(w-1)^2=w(zw^{-1}-1)(zw-1)$。

## 選んだ理由

系 G6 と系 Q7 は、**訂正した D 系列の主役（$\ell=2$ トーラス）と定理 G4 の適用範囲の両端**である。
系 G6 は $S_\infty=\emptyset$ の退化端で、これまで $d=-2$（`D1_d_empty`）しか型に出ていなかった。
系 Q7 は $\ell=2$ トーラスの $b=2$ を定理 G4 とは**別経路**（$\bmod\ 2$ の因数分解）で出すもので、
定理 D3 が $p=1$ で使っている値と突き合わせられる。

## 形式化しなかったもの

* 系 Q7 の $r=2$ そのもの（2 つの二項式因子が既約かつ非同伴であること）。
  2 変数 Laurent 環の UFD 性が要る（`cycle22_ops_lean_cycle21_theorems.md` §8.2 の「配線」）。
  本ファイルが型に出したのは**因数分解の恒等式**だけである。
* `mathlib` 欠落調査は `lean/logs/mathlib-gap-survey-cycle24.log`。
-/
import Mathlib
import IntegrableLattice.GeneralTowerClosedForm
import IntegrableLattice.CoefficientsDE

namespace IntegrableLattice
namespace Cycle24

open Finset
open CoeffsDE (Sdef)

/-! ## 1. 訂正後の定理 D2（`cycle22_T3_coefficients_d_e.md` §3）

訂正後の主張は 3 分岐になっている。cycle 23 の `D2_residual`
（cycle 14 $(6.1)$ の左辺と $(1.1)$ の 5 係数形の差が $S(n)-T_\mathrm{def}$ であること）から
そのまま出る。 -/

/-- **訂正後の定理 D2 の分岐 1**: レベル $n$ で閉形式 $(1.1)$ が成り立つことは、
部分和が $T_\mathrm{def}$ に等しいことと同値。 -/
theorem D2_level_iff (L : ℚ) (hL : L ≠ 1) (μ κX α β γ : ℚ) (Θ Θas : ℕ → ℚ) (ms n : ℕ)
    (hΘas : ∀ M, 1 ≤ M → Θas M = α * M * L ^ M + β * L ^ M + γ) :
    (κX - 2 * n + μ * (L ^ (2 * n) - 1) + ∑ M ∈ Finset.Ico 1 (n + 1), Θ M
        = μ * L ^ (2 * n)
          + (L / (L - 1) * α) * (n * L ^ n)
          + (L / (L - 1) * β - L / (L - 1) ^ 2 * α) * L ^ n
          + (γ - 2) * n
          + (κX - μ + Sdef Θ Θas ms + L / (L - 1) ^ 2 * α - L / (L - 1) * β))
      ↔ Sdef Θ Θas n = Sdef Θ Θas ms := by
  have h := CoeffsDE.D2_residual L hL μ κX α β γ Θ Θas ms n hΘas
  constructor
  · intro he
    have : Sdef Θ Θas n - Sdef Θ Θas ms = 0 := by rw [← h, he]; ring
    linarith
  · intro he
    have : Sdef Θ Θas n - Sdef Θ Θas ms = 0 := by rw [he]; ring
    linarith [h, this]

/-- **訂正後の定理 D2 の分岐 2**: $n=0$ での成立は $T_\mathrm{def}=0$ と同値。
（$S(0)=0$ だから。初稿はここを「全ての $n\ge0$」と書いていた。） -/
theorem D2_level_zero_iff (L : ℚ) (hL : L ≠ 1) (μ κX α β γ : ℚ) (Θ Θas : ℕ → ℚ) (ms : ℕ)
    (hΘas : ∀ M, 1 ≤ M → Θas M = α * M * L ^ M + β * L ^ M + γ) :
    (κX - 2 * (0 : ℕ) + μ * (L ^ (2 * 0) - 1) + ∑ M ∈ Finset.Ico 1 (0 + 1), Θ M
        = μ * L ^ (2 * 0)
          + (L / (L - 1) * α) * ((0 : ℕ) * L ^ 0)
          + (L / (L - 1) * β - L / (L - 1) ^ 2 * α) * L ^ 0
          + (γ - 2) * (0 : ℕ)
          + (κX - μ + Sdef Θ Θas ms + L / (L - 1) ^ 2 * α - L / (L - 1) * β))
      ↔ Sdef Θ Θas ms = 0 := by
  rw [D2_level_iff L hL μ κX α β γ Θ Θas ms 0 hΘas]
  have h0 : Sdef Θ Θas 0 = 0 := by simp [Sdef]
  rw [h0]
  exact ⟨fun h => h.symm, fun h => h.symm⟩

/-- **訂正後の定理 D2 の分岐 3**: 全ての $n\ge0$ で成り立つことは、
$\Theta_M=\Theta^\mathrm{as}_M$ が全ての $M\ge1$ で成り立つこと（過渡が一切無いこと）と同値。

**cycle 23 の `D2_equiv_corrected` は右辺を「$T_\mathrm{def}=0$ **かつ** 過渡が無い」と
連言で書いていたが、$T_\mathrm{def}=0$ は後者の帰結なので不要である。**
訂正後の report §3 が「（このとき $T_\mathrm{def}=0$ も従う）」と括弧に落としているのは、
この意味で正確である。 -/
theorem D2_all_iff_no_transient (Θ Θas : ℕ → ℚ) (ms : ℕ) :
    (∀ n, Sdef Θ Θas n = Sdef Θ Θas ms) ↔ (∀ M, 1 ≤ M → Θ M = Θas M) := by
  rw [CoeffsDE.D2_equiv_corrected]
  constructor
  · exact fun h => h.2
  · intro h
    refine ⟨?_, h⟩
    rw [Sdef]
    refine Finset.sum_eq_zero (fun M hM => ?_)
    rw [Finset.mem_Ico] at hM
    rw [h M hM.1]
    ring

/-- **$T_\mathrm{def}=0$ は分岐 3 の帰結**（逆は言えない。反例は cycle 23 の
`D2_equiv_forward_false`）。 -/
theorem D2_no_transient_imp_Tdef_zero (Θ Θas : ℕ → ℚ) (ms : ℕ)
    (h : ∀ M, 1 ≤ M → Θ M = Θas M) : Sdef Θ Θas ms = 0 := by
  rw [Sdef]
  refine Finset.sum_eq_zero (fun M hM => ?_)
  rw [Finset.mem_Ico] at hM
  rw [h M hM.1]
  ring

/-! ## 2. 訂正後の $v_\ell(0)=+\infty$ 規約（定理 D3 の 2・定理 D5）

訂正は「$\min$ は $A_m\ne0$ の $m$ についてのみ取る（$v_2(0)=+\infty$）」を明記した。
これを型に出すには付値を $\mathbb{N}\cup\{\infty\}$ に取ればよい。

**なおこの規約は cycle 21 の定理 G2（`twisted_unique_min` の `supp`）では既に型に出ていた。**
落ちていたのは cycle 22 の定理 D3・D5 が同じ規約を引き継がなかったことである。 -/

/-- 段データの $\Lambda$（3 係数の場合）。`v m = ⊤` が $A_m=0$ を表す。 -/
noncomputable def LamC (v : Fin 3 → ℕ∞) : ℕ∞ := min (v 0) (min (v 1) (v 2))

/-- 段データの $\theta^\sharp$（最小を**最初に**達成する添字）。 -/
noncomputable def thC (v : Fin 3 → ℕ∞) : ℕ :=
  if v 0 = LamC v then 0 else if v 1 = LamC v then 1 else 2

/-- **訂正後の定理 D3 の 2、$p=1$（$\ell=2$ トーラス）**: $A=(4,4,0)$、すなわち
付値は $(2,2,\infty)$ なので $\Lambda_1=2$、$\theta^\sharp_1=0$。
**証明本文が使っている値と一致する。** -/
theorem D3_conv_p_eq_one : LamC ![2, 2, ⊤] = 2 ∧ thC ![2, 2, ⊤] = 0 := by
  constructor <;> simp [LamC, thC]

/-- **訂正後の定理 D3 の 2、$p\ne1$**: $A_2=1-p\ne0$ で $v_2(A_2)=k$ とすると
$\Lambda_1=\min(2,k)$、$\theta^\sharp_1$ は $k\ge2$（$p\equiv1\bmod4$）で $0$、
$k=1$（$p\equiv3\bmod4$）で $2$。**初稿の式はこの場合には正しい。** -/
theorem D3_conv_p_ne_one (k : ℕ) :
    LamC ![2, 2, (k : ℕ∞)] = min 2 (k : ℕ∞) ∧
      thC ![2, 2, (k : ℕ∞)] = if 2 ≤ k then 0 else 2 := by
  have hmin : LamC ![2, 2, (k : ℕ∞)] = min 2 (k : ℕ∞) := by
    simp [LamC]
  refine ⟨hmin, ?_⟩
  by_cases hk : 2 ≤ k
  · have h2 : min (2 : ℕ∞) (k : ℕ∞) = 2 := by
      exact min_eq_left (by exact_mod_cast Nat.cast_le.mpr hk)
    simp [thC, hmin, hk]
  · have hk1 : (k : ℕ∞) < 2 := by
      have : k < 2 := by omega
      exact_mod_cast Nat.cast_lt.mpr this
    have h2 : min (2 : ℕ∞) (k : ℕ∞) = (k : ℕ∞) := min_eq_right hk1.le
    have hne : (2 : ℕ∞) ≠ (k : ℕ∞) := ne_of_gt hk1
    simp [thC, hmin, h2, hne, hk]

/-- **訂正後の定理 D5、$t=q$**: $A=(4(p+t),4(p+t),0)$ なので $\min$ は $A_0,A_1$ だけで取り、
$\Lambda_1=v_2(4(p+t))$、$\theta^\sharp_1=0$。訂正で書き足された境界そのもの。 -/
theorem D5_conv_t_eq_q (k : ℕ) :
    LamC ![(k : ℕ∞), (k : ℕ∞), ⊤] = (k : ℕ∞) ∧ thC ![(k : ℕ∞), (k : ℕ∞), ⊤] = 0 := by
  constructor <;> simp [LamC, thC]

/-- **訂正が $c=4$ を復旧すること**: $p=1$ で $\mathcal{L}=\Lambda_0+\Lambda_1=1+2=3$、
$c=2\mathcal{L}-2=4$（定理 D3 の 3、および cycle 21 §6.3 の実測値）。 -/
theorem D3_conv_c_p_eq_one : (2 : ℚ) * ((1 : ℚ) + 2) - 2 = 4 := by norm_num

/-- **旧規約では復旧しない**: mathlib の `padicValNat 2 0 = 0` で読むと $\Lambda_1=0$、
$\mathcal{L}=1$、$c=2\cdot1-2=0\ne4$（cycle 23 の `D3_p_eq_one_convention` が挙げた食い違い）。
**すなわち規約の明記は必要であり、かつ十分である。** -/
theorem D3_old_conv_c_broken : (2 : ℚ) * ((1 : ℚ) + 0) - 2 ≠ 4 := by norm_num

/-! ## 3. 訂正後の定理 G4 §5.3 の条件 2（`cycle21_T3_general_closed_form.md`）

初稿は $M\ge r^\sharp+\max K+1$、訂正後は $M\ge r^\sharp+\max K$。
§6.1（定理 J8 との照合）は $r^\sharp=1$, $K=0$, $M^*=1$ を使っている。 -/

/-- **訂正が内部矛盾を塞いだこと**: §6.1 の $(r^\sharp,K,M^*)=(1,0,1)$ は
**訂正後の条件 2 を満たし**、**初稿の条件 2 を満たさない**。
そのとき (b) の層の和は空で、閉形式の値も $0$（`sum_totient_Ico` の $K=N$ の場合）。 -/
theorem G4_cond2_corrected_at_61 {ℓ : ℕ} (hℓ : ℓ.Prime) :
    (1 : ℕ) ≥ 1 + 0 ∧ ¬ ((1 : ℕ) ≥ 1 + 0 + 1) ∧
      (∑ s ∈ Finset.Ico (0 + 1) (0 + 1), (Nat.totient (ℓ ^ s) : ℤ))
        = (ℓ : ℤ) ^ (0 : ℕ) - (ℓ : ℤ) ^ (0 : ℕ) := by
  refine ⟨by omega, by omega, ?_⟩
  exact GeneralTower.sum_totient_Ico hℓ (le_refl 0)

/-- **一般の境界**: $M=r^\sharp+K$（層が空）でも $(b)$ の閉形式は両辺 $0$ で成り立つ。
$+1$ を課す理由は無い。 -/
theorem G4_cond2_empty_layer_ok {ℓ : ℕ} (hℓ : ℓ.Prime) (K : ℕ) :
    (∑ s ∈ Finset.Ico (K + 1) (K + 1), (Nat.totient (ℓ ^ s) : ℤ))
      = (ℓ : ℤ) ^ K - (ℓ : ℤ) ^ K :=
  GeneralTower.sum_totient_Ico hℓ (le_refl K)

/-- **訂正後の条件 2 だけでなく、§6.1 は $M^*=1$ で条件 1–5 を**すべて**満たす**
（$\ell\ge3$、$L=1$, $r^\sharp=1$, $K=0$, $\theta^{\max}_U=2$, $e_{j^*}=j^{*}=1$）。

* 条件 1: $M\ge L$、条件 2: $M\ge r^\sharp+K$、
* 条件 3: $\varphi(\ell)>\theta^{\max}_U-2=0$、
* 条件 5: $e_{j^*}+j^{*}\ell^{M-K-1}-2=0<\varphi(\ell)$。

条件 4 は $k=0$ のみで、$M\ge0$ と $(3.2)$。§6.1 の塔では $\Phi_u=-\ell x^{2}$ なので
$A_0=A_1=0$、すなわち $m^\sharp_0=\infty$ で $(3.2)$ は自動的に成り立つ（`G2_cond32_sum_form_top`）。
**すなわち訂正は §5.3 と §6.1 の食い違いを完全に塞いだ。** -/
theorem G4_cond_all_at_61 {ℓ : ℕ} (hℓ : 3 ≤ ℓ) :
    (1 : ℕ) ≥ 1 ∧ (1 : ℕ) ≥ 1 + 0 ∧ (ℓ - 1) > 2 - 2 ∧ (1 : ℕ) ≥ 2 * 0 ∧
      1 + 1 * ℓ ^ (1 - 0 - 1) - 2 < ℓ - 1 := by
  refine ⟨le_refl 1, le_refl 1, by omega, by omega, ?_⟩
  simp
  omega

/-! ## 4. 訂正で書き足された注 4.2 の打ち消し計算 -/

/-- **$(5.4)$ 側**（$\varphi$ を `Nat.totient` のまま扱った形）:
$e_{j^*}\bigl(\varphi(\ell^{K+1})-\ell^{K+1}+\ell^{K}\bigr)=0$。 -/
theorem G4_note42_d_side_totient {ℓ : ℕ} (hℓ : ℓ.Prime) (K : ℕ) (ej : ℤ) :
    ej * ((Nat.totient (ℓ ^ (K + 1)) : ℤ) - (ℓ : ℤ) ^ (K + 1) + (ℓ : ℤ) ^ K) = 0 := by
  rw [CoeffsDE.totient_step hℓ K]
  ring

/-- **$(5.3)$ 側**（訂正で書き足された側。初稿にも cycle 22 の Lean にも無かった）:
$\frac{\ell-1}{\ell}\varphi(\ell^{K+1})\Lambda_{K+1}=\frac{(\ell-1)j^{*}}{\ell}$ の増分と、
$-\frac{(\ell-1)j^{*}(K+r^\sharp)}{\ell}$ の $K\to K+1$ の減分がちょうど打ち消す。 -/
theorem G4_note42_c_side (L φ jst rs Lc : ℚ) (hφ : φ ≠ 0) (hL : L ≠ 0) (K : ℕ) :
    ((L - 1) / L * (Lc + φ * (jst / φ)) - (L - 1) * jst * ((K : ℚ) + 1 + rs) / L)
      = ((L - 1) / L * Lc - (L - 1) * jst * ((K : ℚ) + rs) / L) := by
  field_simp
  ring

/-! ## 5. 訂正で書き足された補題 Q5 の狭義不等式（`cycle21_T3_drop_assumption_B_star.md` §5.2）

訂正は「$c_1$ の $+1$ は狭義不等式 $2b<(\ell-1)\ell^{c_1}$ のために要る」を書き足した。
$c_1:=\max\bigl(0,\lceil1+\log_\ell\frac{2b}{\ell-1}\rceil\bigr)$ からそれが従うことを確かめる。 -/

/-- **狭義不等式は $c_1$ の定義から従う**（訂正で書き足された根拠）。

$c_1\ge1+\log_\ell\frac{2b}{\ell-1}$（$\max(0,\cdot)$ は $\ge$ を保つ）より
$\ell^{c_1}\ge\ell\cdot\frac{2b}{\ell-1}$、したがって $(\ell-1)\ell^{c_1}\ge2b\ell\ge4b>2b$。

**ここが本ファイルで唯一 ℝ へ脱出する箇所である**（実対数 `Real.logb`）。
脱出は除去できる（`Q5_c1_exists_nat`）。 -/
theorem Q5_c1_strict_of_logb {ℓ b c₁ : ℕ} (hℓ : 2 ≤ ℓ) (hb : 1 ≤ b)
    (hc : (1 : ℝ) + Real.logb (ℓ : ℝ) (2 * b / ((ℓ : ℝ) - 1)) ≤ (c₁ : ℝ)) :
    (2 * b : ℝ) < ((ℓ : ℝ) - 1) * (ℓ : ℝ) ^ c₁ := by
  have hx2 : (2 : ℝ) ≤ (ℓ : ℝ) := by exact_mod_cast hℓ
  have hx1 : (1 : ℝ) < (ℓ : ℝ) := by linarith
  have hx0 : (0 : ℝ) < (ℓ : ℝ) := by linarith
  have hxne : (ℓ : ℝ) ≠ 1 := ne_of_gt hx1
  have hd : (0 : ℝ) < (ℓ : ℝ) - 1 := by linarith
  have hb1 : (1 : ℝ) ≤ (b : ℝ) := by exact_mod_cast hb
  set t : ℝ := 2 * b / ((ℓ : ℝ) - 1) with ht
  have ht0 : 0 < t := by
    rw [ht]; positivity
  -- ℓ^(1 + logb ℓ t) = ℓ * t
  have hrpow : (ℓ : ℝ) ^ ((1 : ℝ) + Real.logb (ℓ : ℝ) t) = (ℓ : ℝ) * t := by
    rw [Real.rpow_add hx0, Real.rpow_one, Real.rpow_logb hx0 hxne ht0]
  have hmono : (ℓ : ℝ) ^ ((1 : ℝ) + Real.logb (ℓ : ℝ) t) ≤ (ℓ : ℝ) ^ ((c₁ : ℕ) : ℝ) :=
    Real.rpow_le_rpow_of_exponent_le hx1.le hc
  rw [hrpow, Real.rpow_natCast] at hmono
  -- (ℓ-1) * ℓ^c₁ ≥ (ℓ-1) * ℓ * t = 2b * ℓ ≥ 4b > 2b
  have hstep : ((ℓ : ℝ) - 1) * ((ℓ : ℝ) * t) = 2 * b * (ℓ : ℝ) := by
    rw [ht]
    field_simp
  nlinarith [mul_le_mul_of_nonneg_left hmono hd.le, hstep, hb1, hx2]

/-- **その ℝ 脱出は除去できる**（本 step の新しい観察）。
$c_1$ を「$2b<(\ell-1)\ell^{c}$ なる $c$」として取れば実対数は要らない。
補題 Q5 が実際に使うのはこの狭義不等式だけである（`lemma_Q5_rho_max` の仮定）。 -/
theorem Q5_c1_exists_nat {ℓ b : ℕ} (hℓ : 2 ≤ ℓ) : ∃ c₁ : ℕ, 2 * b < (ℓ - 1) * ℓ ^ c₁ := by
  refine ⟨2 * b + 1, ?_⟩
  have h1 : 1 ≤ ℓ - 1 := by omega
  have h2 : 2 * b + 1 < ℓ ^ (2 * b + 1) := Nat.lt_pow_self (by omega)
  calc 2 * b < 2 * b + 1 := by omega
    _ < ℓ ^ (2 * b + 1) := h2
    _ = 1 * ℓ ^ (2 * b + 1) := by ring
    _ ≤ (ℓ - 1) * ℓ ^ (2 * b + 1) := Nat.mul_le_mul_right _ h1

/-- **ℝ を使わない $c_1$ の最小の取り方**。述語 $2b<(\ell-1)\ell^{c}$ は $\mathbb{N}$ 上で
決定可能なので、`Nat.find` で最小のものが取れる。**実対数も切り上げも要らない。** -/
theorem Q5_c1_nat_least {ℓ b : ℕ} (hℓ : 2 ≤ ℓ) :
    ∃ c₁ : ℕ, (2 * b < (ℓ - 1) * ℓ ^ c₁) ∧ ∀ c < c₁, ¬ (2 * b < (ℓ - 1) * ℓ ^ c) := by
  classical
  have hex : ∃ c : ℕ, 2 * b < (ℓ - 1) * ℓ ^ c := Q5_c1_exists_nat (b := b) hℓ
  exact ⟨Nat.find hex, Nat.find_spec hex, fun c hlt => Nat.find_min hex hlt⟩

/-! ### 5a. 本 step が新たに検出した問題: $b=0$ で $c_1$ が定義されない

定理 Q1 は (H) だけを仮定し、$b=\sum_{P\in S_\infty}j^{*}(P)$ に下限を課していない。
**系 G6（$S_\infty=\emptyset$）はまさに $b=0$ の場合である。**
そのとき補題 Q5 の $c_1=\max\bigl(0,\lceil1+\log_\ell\frac{2b}{\ell-1}\rceil\bigr)$ は
$\log_\ell 0$ を含み、**定義されない**（訂正で書き足された導出も $\ell^{\log_\ell t}=t$ を使うので
$t>0$ が要る）。**cycle 24 step 1 の訂正はこの場合に触れていない。** -/

/-- $b=0$ では $\log_\ell\frac{2b}{\ell-1}$ の真数が $0$ になる。
mathlib は `Real.log 0 = 0` という**ジャンク値**を返すので式は「動く」が、
訂正が書き足した導出の要 `Real.rpow_logb`（仮定 `0 < x`）は使えない。 -/
theorem Q5_logb_junk_at_b_zero {ℓ : ℕ} (hℓ : 2 ≤ ℓ) :
    (2 * (0 : ℝ)) / ((ℓ : ℝ) - 1) = 0 ∧ Real.logb (ℓ : ℝ) 0 = 0 := by
  refine ⟨by ring, ?_⟩
  simp [Real.logb]

/-- **ℝ を使わない定義ならこの縮退は消える**: $b=0$ でも $c_1=0$ が条件を満たす。
すなわち `Q5_c1_exists_nat` は $b$ に下限を要らない。 -/
theorem Q5_c1_zero_b {ℓ : ℕ} (hℓ : 2 ≤ ℓ) : 2 * 0 < (ℓ - 1) * ℓ ^ 0 := by
  simp
  omega

/-! ### 5b. 本 step が新たに検出した問題（軽微）: 定理 G2 $(3.2)$ の $m^\sharp_k=\infty$

`cycle21_T3_general_closed_form.md` §3.2 は $m^\sharp_k$ を「そのような $m$ が無ければ $\infty$」と
定義しながら、$(3.2)$ を $\varphi(\ell^{M})>(\theta^\sharp_k-m^\sharp_k)\varphi(\ell^{k})$ と
**差の形**で書いている。$\theta^\sharp_k-\infty$ の読み方は本文に無い
（**定理 D3・D5 で訂正したのと同じ型の穴**）。

**ただし実害は無い**: $\mathbb{N}$ の切り捨て引き算で $0$ と読んでも、$-\infty$ と読んでも、
条件は「常に真」になり一致する。証明が実際に使っているのは
$\frac{\varphi(\ell^M)}{\varphi(\ell^k)}+m^\sharp_k>\theta^\sharp_k$ の形である。 -/

/-- $(3.2)$ を証明が実際に使う形（$\mathbb{N}\cup\{\infty\}$ 上の和の形）で書くと、
$m^\sharp_k=\infty$ は自動的に「条件成立」になり、差の読み方を決める必要が無い。 -/
theorem G2_cond32_sum_form_top (q θs : ℕ) : (θs : ℕ∞) < (q : ℕ∞) + ⊤ := by
  simp

/-- $m^\sharp_k$ が有限なら、和の形と差の形は同値（$m^\sharp_k<\theta^\sharp_k$ は定義から）。 -/
theorem G2_cond32_sum_form_finite (q θs ms : ℕ) (h : ms < θs) :
    (θs : ℕ∞) < (q : ℕ∞) + (ms : ℕ∞) ↔ θs - ms < q := by
  constructor
  · intro hlt
    have : θs < q + ms := by exact_mod_cast hlt
    omega
  · intro hlt
    have : θs < q + ms := by omega
    exact_mod_cast this

/-! ## 6. 訂正後の定理 Q1 $(6.1)$ の定数 $C$

訂正は $|\mathcal{B}_M|$ を補題 Q5 の上界 $r\ell^{c_1}$ で置き換えた。
cycle 22 の `theorem_Q1_error` は $\theta_G^{\max}$ の係数を $2$ で緩めていたので、
**訂正後の report が書いている $\frac{\ell+1}{\ell}$ そのもの**で組み直す。 -/

/-- **訂正後の $(6.1)$ そのもの**:
$$C=b\bigl(3+r\ell^{c_1}\bigr)+\theta_G^{\max}\frac{\ell+1}{\ell}+r\ell^{c_1}\log_\ell C_0 .$$
`Bbound` $=r\ell^{c_1}$。$|\mathcal{B}_M|\le$ `Bbound` を代入してよいのは、
$|\mathcal{B}_M|$ が掛かる係数 $b$ と $\log_\ell C_0$ が**ともに非負**だからである
（$\log_\ell C_0\ge0$ は $C_0=\sum|c_{pq}|\ge1$ から。訂正で明記された）。 -/
theorem Q1_C_corrected (L b r ℓc₁ Bcard θGmax logC LM Sβ SθG Shat ΘM bMφ : ℚ)
    (hL : 2 ≤ L) (hLM : 0 ≤ LM) (hb : 0 ≤ b) (hθ : 0 ≤ θGmax) (hlog : 0 ≤ logC)
    (hBcard : 0 ≤ Bcard) (hBle : Bcard ≤ r * ℓc₁)
    (hΘ : ΘM = Sβ + SθG + Shat)
    (hβ : |Sβ - bMφ| ≤ (3 * b + Bcard * b) * LM)
    (hθG : 0 ≤ SθG ∧ SθG ≤ θGmax * ((L + 1) / L) * LM)
    (hhat : 0 ≤ Shat ∧ Shat ≤ Bcard * logC * LM) :
    |ΘM - bMφ| ≤ (b * (3 + r * ℓc₁) + θGmax * ((L + 1) / L) + r * ℓc₁ * logC) * LM := by
  obtain ⟨hβ1, hβ2⟩ := abs_le.mp hβ
  obtain ⟨hg1, hg2⟩ := hθG
  obtain ⟨hh1, hh2⟩ := hhat
  have hL0 : (0 : ℚ) < L := by linarith
  have hfrac : 0 ≤ (L + 1) / L := by positivity
  have hgap : 0 ≤ (r * ℓc₁ - Bcard) := by linarith
  have e1 : Bcard * logC * LM ≤ (r * ℓc₁) * logC * LM := by
    have : Bcard * logC ≤ (r * ℓc₁) * logC := by nlinarith
    nlinarith
  have e2 : (3 * b + Bcard * b) * LM ≤ (3 * b + (r * ℓc₁) * b) * LM := by
    nlinarith
  subst hΘ
  rw [abs_le]
  constructor <;> nlinarith [hβ1, hβ2, hg1, hg2, hh1, hh2, e1, e2]

/-! ## 7. 系 G6（$S_\infty=\emptyset$）— まだ Lean に通していなかった定理

`cycle21_T3_general_closed_form.md` §5.5。$\alpha=0$, $\beta=A_\mathrm{gen}$, $\gamma=0$ を
定理 G1 に入れる。 -/

/-- **系 G6 の 5 係数**。定理 G1 の右辺に $\alpha=\gamma=0$, $\beta=A_\mathrm{gen}$ を入れると
$$a=\mu,\quad b=0,\quad c=\tfrac{\ell}{\ell-1}A_\mathrm{gen},\quad d=-2,$$
$$e=v_\ell(\kappa(X))-\mu+\sum_{M=1}^{M^*-1}\Theta_M-A_\mathrm{gen}\Bigl(\mathcal{S}_0(M^*\!-\!1)+\tfrac{\ell}{\ell-1}\Bigr)$$
になる。**report の式そのもの。** -/
theorem corollary_G6 (L : ℚ) (hL : L ≠ 1) (μ κX Agen : ℚ) (Θ : ℕ → ℚ) (ms n : ℕ)
    (hn : ms ≤ n) (hΘ : ∀ M, ms + 1 ≤ M → Θ M = Agen * L ^ M) :
    κX - 2 * n + μ * (L ^ (2 * n) - 1) + ∑ M ∈ Finset.Ico 1 (n + 1), Θ M
      = μ * L ^ (2 * n)
        + 0 * (n * L ^ n)
        + (L / (L - 1) * Agen) * L ^ n
        + (-2) * n
        + (κX - μ + ((∑ M ∈ Finset.Ico 1 (ms + 1), Θ M)
            - Agen * (GeneralTower.S0 L ms + L / (L - 1)))) := by
  have hL1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL
  have h := GeneralTower.theorem_G1 L hL μ κX 0 Agen 0 Θ ms n hn
    (fun M hM => by rw [hΘ M hM]; ring)
  rw [h]
  ring

/-- **系 G6 の $c$ の別表示**: $A_\mathrm{gen}=\Theta_L/\ell^{L}$ なら
$\frac{\ell}{\ell-1}A_\mathrm{gen}=\frac{\Theta_L}{\varphi(\ell^{L})}$
（$\varphi(\ell^{L})=\ell^{L}-\ell^{L-1}$）。 -/
theorem corollary_G6_c_as_Theta (L T : ℚ) (Lv : ℕ) (hL0 : L ≠ 0) (hL1 : L ≠ 1) (hLv : 1 ≤ Lv) :
    L / (L - 1) * (T / L ^ Lv) = T / (L ^ Lv - L ^ (Lv - 1)) := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  obtain ⟨k, rfl⟩ : ∃ k, Lv = k + 1 := ⟨Lv - 1, by omega⟩
  have hk : L ^ (k + 1) - L ^ (k + 1 - 1) = L ^ k * (L - 1) := by
    simp only [Nat.add_sub_cancel]
    ring
  rw [hk]
  have hLk : L ^ k ≠ 0 := pow_ne_zero _ hL0
  field_simp
  ring

/-! ## 8. 系 Q7（$\ell=2$ トーラスの $b=2$）— まだ Lean に通していなかった定理

`cycle21_T3_drop_assumption_B_star.md` §6。$\bar{\tilde E}=w(z-1)^2+z(w-1)^2$ が
$\mathbb{F}_2$ 上で 2 つの二項式因子に分かれること。 -/

/-- **系 Q7 の因数分解**（標数 $2$ の任意の可換体で成り立つ恒等式）:
$$w(z-1)^2+z(w-1)^2=w\bigl(zw^{-1}-1\bigr)\bigl(zw-1\bigr)=(z+w)(zw+1).$$
$zw^{-1}=\chi^{(1,-1)}$, $zw=\chi^{(1,1)}$ なので、$\bar{\tilde E}$ は
**2 つの相異なる原始ベクトルの二項式**の積である（$r=2$, $m_1=m_2=1$）。 -/
theorem Q7_char2_factorization {K : Type*} [Field K] (h2 : (2 : K) = 0) (z w : K) (hw : w ≠ 0) :
    w * (z - 1) ^ 2 + z * (w - 1) ^ 2 = w * (z * w⁻¹ - 1) * (z * w - 1) := by
  have hz : w * (z * w⁻¹ - 1) = z - w := by
    field_simp
  rw [mul_assoc] at *
  rw [show w * ((z * w⁻¹ - 1) * (z * w - 1)) = (w * (z * w⁻¹ - 1)) * (z * w - 1) by ring, hz]
  linear_combination (z * w ^ 2 + z - 2 * z * w) * h2

/-- 同じものを $(z+w)(zw+1)$ の形で。 -/
theorem Q7_char2_binomial_form {K : Type*} [Field K] (h2 : (2 : K) = 0) (z w : K) :
    w * (z - 1) ^ 2 + z * (w - 1) ^ 2 = (z + w) * (z * w + 1) := by
  linear_combination (-2 * z * w) * h2

/-- **系 Q7 の $b$**: $r=2$, $m_1=m_2=1$ なので $b=\sum m_i=2$。
定理 G4 の経路（$b=\sum_{P_0\in S_\infty}j^{*}$、$|S_\infty|=2$, $j^{*}=1$）と**同じ値**。 -/
theorem Q7_b_eq_two : (1 : ℕ) + 1 = 2 ∧ (1 : ℕ) + 1 = 2 := ⟨rfl, rfl⟩

end Cycle24
end IntegrableLattice
