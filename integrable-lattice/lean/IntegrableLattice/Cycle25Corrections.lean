/-
# cycle 25 step 1 の訂正の検算 ＋ 本文へ入った命題 M・U の照合 — cycle 25 step 3（Lean 検算 10 サイクル目）

対応する人手証明:

* 訂正の記録: `outputs/reports/cycle25_ops_fix_q5_c1_and_g2_cond32.md`
* 訂正後の根拠 report:
  - `cycle21_T3_drop_assumption_B_star.md` §5.2（補題 Q5 の**新しい** $c_1$）・§6（定理 Q1 の $b=0$）
  - `cycle21_T3_general_closed_form.md` §3.2（定理 G2 $(3.2)$ の規約）・§6.1（$\ell=3$）
* 本文: `structured-latex/content/010_general_closed_form.ts` の命題 M（(M1)–(M6)）・命題 U（(U1)–(U6)）
* 検出元（前サイクル）: `cycle24_ops_lean_cycle23_corrections.md` §2

## 目的

1. **訂正後の主張が型に出るか**を確かめる（訂正**前**の形は形式化しない）。
2. **本文（命題 M・U）の主張が根拠 report の主張から実際に従うか**を型で照合する。
   とくに本文にしか無い言い回し（規約の明記、(U4) の数値、限界の記述）を狙う。
3. まだ通していない定理を新たに通す（本ファイルでは $A_\mathrm{gen}$ のレベル非依存性）。

## 形式化した主張（1: 訂正後の補題 Q5 の $c_1$）

* `Q5_c1_isLeast` / `Q5_c1_unique` — 新定義「$2b<(\ell-1)\ell^{c}$ を満たす最小の自然数」が
  $\mathbb{N}$ 上で**存在し一意である**こと。$\mathbb{R}$ を使わない。
* `Q5_c1_zero_of_b_zero` — $b=0$ では $c_1=0$。
* `Q5_old_logb_value_at_b_zero` / `Q5_old_junk_not_least` — 旧定義は $b=0$ で
  mathlib のジャンク値 `Real.log 0 = 0` により **$1$ を返す**が、その $1$ は
  **最小元ではない**（$0$ が条件を満たす）。**新定義は最小性を課すのでこの値を取りえない。**
* `Q5_b_zero_iff_r_zero` / `Q5_BM_empty_of_b_zero` — 訂正後の証明の $b=0$ の場合分け。
* `Q5_rho_max_of_isLeast` / `Q5_rho_max_at_top_layer` / `Q5_case_split` —
  中間段 $\rho_{\max}\ge M-c_1$ が**狭義不等式だけから**（対数・切り上げ無しで）出ること、
  および訂正で足された $\beta_P=\infty$ の枝。
* `Q5_c1_new_le_old` / `Q1_C_mono_in_c1` — 新旧の関係 $c_1^{新}\le c_1^{旧}$（$b\ge1$）と、
  そのとき定理 Q1 の定数 $C$ が悪化しないこと。
* `Q1_C_at_b_zero` / `Q1_b_zero_matches_layer_count` — $b=0$ での定理 Q1 の退化形
  $C=\theta_G^{\max}\frac{\ell+1}{\ell}$ が、既存の `DropBStar.layer_card_sum` が与える
  $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の点数による自明な数え上げと一致すること。

## 形式化した主張（2: 定理 G2 $(3.2)$ の規約）

* `G2_minEmpty_iff_ell_ge_four` — $\min\emptyset=0$ の読みでは §6.1 の $(k,M)=(0,1)$、
  $\theta^\sharp_0=2$ で条件が $\ell\ge4$ に化けること。
* `G2_minEmpty_breaks_at_ell_three` / `G2_minEmpty_ok_at_ell_five_seven` —
  **$\ell=3$ で落ち、$\ell=5,7$ では落ちない**（§6.1 は $\ell=3,5,7$ で機械照合している）。
* `G2_top_reading_ok_at_ell_three` — 正しい読み（差を $-\infty$）では $\ell=3$ でも成り立つ。

## 形式化した主張（3: 本文の命題 M・U と根拠 report の照合）

* `U1_c_from_M3_M4` — 本文 (U1) の $c$ の式が、本文 (M3) の $\alpha,\beta$ と (M4) の
  $c=\frac{\ell}{\ell-1}\beta-\frac{\ell}{(\ell-1)^2}\alpha$ から**実際に出る**こと（1 点分）。
* `U1_d_from_M3_M4` — 同じく $d$（こちらは記号の置き換えだけである。射程を正直に限定する）。
* `U2_bracket_eq_Tdef` — 本文 (M4) の $e$ の式の角括弧が、本文 (U2) の $T_\mathrm{def}$ と一致すること。
* `U4_c_at_ell_two` / `U4_d_at_ell_two` — 本文 (U4) の $c=2\mathcal{L}-2$・$d=2\theta^\sharp_1-6$ が
  (U1) の一般式から出ること（$\ell=2$, $|S_\infty|=2$, $A_\mathrm{gen}=2$, $r^\sharp=2$, $K=1$,
  $j^{*}=1$, $e_{j^*}=2$ を代入）。
* `U4_p_one_values` / `U4_p_three_values` / `U4_c_same_d_differs` —
  本文が挙げる 2 本の塔の $(c,d)$ が $(4,-6)$ と $(4,-2)$ になること、および
  「$c$ は偶然一致し $d$ が違う」という本文の記述。
* `U6_trunc_determines_stage_data` — 本文 (U6)「$N>\Lambda_k$ なら $\tilde E\bmod\ell^{N}$ が
  $(\Lambda_k,\theta^\sharp_k)$ を決める」を切り捨て付値列の形で（3 係数の場合）。

## 形式化した主張（4: まだ通していなかったもの）

* `sum_of_uniform_fibers` / `Agen_level_indep` — 本文 (M3) の「$A_\mathrm{gen}$ は $L$ の取り方に
  依らない（$L\to L+1$ でファイバーが一様に $\ell$ 個に分かれるから）」。
  `lean/README.md` が「射影直線のレベル構造。**配線**」として未形式化に挙げていたもの。

## 形式化しなかったもの

* 定理 G2 の 1（$\Lambda_k,\theta^\sharp_k,m^\sharp_k$ の Galois 不変性）と 3。
  円分体の分岐と剰余体の配線が要る（mathlib には在る。`cycle22_ops_lean_cycle21_theorems.md` §8.2）。
* 系 Q7 の $r=2$。2 変数 Laurent 環が mathlib に無い（3 段検索を cycle 22・24 が実施済み。
  本 step は繰り返していない）。
* 本文 (U4)(U5) の $\tilde E$ そのもの（voltage グラフのラプラシアン行列式）。
  Matrix–Tree が mathlib に無い（同上）。
-/
import Mathlib
import IntegrableLattice.GeneralTowerClosedForm
import IntegrableLattice.DropAssumptionBStar
import IntegrableLattice.Cycle24Corrections

namespace IntegrableLattice
namespace Cycle25

open Finset

/-! ## 1. 訂正後の補題 Q5 の $c_1$（`cycle21_T3_drop_assumption_B_star.md` §5.2）

訂正後の定義は
$$c_1:=\min\bigl\{c\in\mathbb{Z}_{\ge0}:2b<(\ell-1)\ell^{c}\bigr\}$$
である。実対数も切り上げも現れない。 -/

/-- 訂正後の $c_1$ の候補集合。 -/
def C1Set (ℓ b : ℕ) : Set ℕ := {c : ℕ | 2 * b < (ℓ - 1) * ℓ ^ c}

/-- **新定義が $\mathbb{N}$ 上でちゃんと定まること（存在と最小性）**。
述語 $2b<(\ell-1)\ell^{c}$ は整数の比較ひとつなので $\mathbb{N}$ 上で決定可能であり、
空でない $\mathbb{N}$ の部分集合は最小元を持つ。**$b$ に下限を課していない**（$b=0$ でもよい）。 -/
theorem Q5_c1_isLeast {ℓ b : ℕ} (hℓ : 2 ≤ ℓ) : ∃ c₁ : ℕ, IsLeast (C1Set ℓ b) c₁ := by
  classical
  have hex : ∃ c : ℕ, 2 * b < (ℓ - 1) * ℓ ^ c := Cycle24.Q5_c1_exists_nat (b := b) hℓ
  exact ⟨Nat.find hex, Nat.find_spec hex, fun c hc => Nat.find_le hc⟩

/-- **その最小元は一意である**（＝「$c_1$」という記号が well-defined）。 -/
theorem Q5_c1_unique {ℓ b x y : ℕ} (hx : IsLeast (C1Set ℓ b) x) (hy : IsLeast (C1Set ℓ b) y) :
    x = y := hx.unique hy

/-- **$b=0$ の縮退が消えること**: $b=0$ なら $c_1=0$（$0<\ell-1$ だから）。
旧定義は $\log_\ell 0$ を含んでここで定義されなかった。 -/
theorem Q5_c1_zero_of_b_zero {ℓ : ℕ} (hℓ : 2 ≤ ℓ) : IsLeast (C1Set ℓ 0) 0 := by
  constructor
  · show 2 * 0 < (ℓ - 1) * ℓ ^ 0
    simp
    omega
  · intro c _
    exact Nat.zero_le c

/-- `IsLeast` を作る道具（membership ＋ $x$ 未満での不成立）。 -/
theorem c1_isLeast_of (ℓ b x : ℕ) (hmem : 2 * b < (ℓ - 1) * ℓ ^ x)
    (hmin : ∀ c < x, ¬ (2 * b < (ℓ - 1) * ℓ ^ c)) : IsLeast (C1Set ℓ b) x :=
  ⟨hmem, fun c hc => by
    by_contra hlt
    push_neg at hlt
    exact hmin c hlt hc⟩

/-- **訂正 report §3.1 の表の独立再計算**（$\mathbb{N}$ の中だけの決定可能な計算）。
$(\ell,b)$ と新定義の $c_1$: $(2,0)\mapsto0$, $(2,1)\mapsto2$, $(2,2)\mapsto3$, $(2,3)\mapsto3$,
$(3,0)\mapsto0$, $(3,2)\mapsto1$, $(3,4)\mapsto2$, $(11,2)\mapsto0$。
**訂正 report が SageMath で出した表と全部一致する。** -/
theorem Q5_c1_table_check :
    IsLeast (C1Set 2 0) 0 ∧ IsLeast (C1Set 2 1) 2 ∧ IsLeast (C1Set 2 2) 3 ∧
      IsLeast (C1Set 2 3) 3 ∧ IsLeast (C1Set 3 0) 0 ∧ IsLeast (C1Set 3 2) 1 ∧
      IsLeast (C1Set 3 4) 2 ∧ IsLeast (C1Set 11 2) 0 := by
  refine ⟨c1_isLeast_of 2 0 0 (by decide) (by decide),
    c1_isLeast_of 2 1 2 (by decide) (by decide),
    c1_isLeast_of 2 2 3 (by decide) (by decide),
    c1_isLeast_of 2 3 3 (by decide) (by decide),
    c1_isLeast_of 3 0 0 (by decide) (by decide),
    c1_isLeast_of 3 2 1 (by decide) (by decide),
    c1_isLeast_of 3 4 2 (by decide) (by decide),
    c1_isLeast_of 11 2 0 (by decide) (by decide)⟩

/-! ### 1a. 旧定義のジャンク値は新定義では取りえない

cycle 24 step 5 の `Q5_logb_junk_at_b_zero` は「mathlib の `Real.log 0 = 0` のせいで
旧定義の式が黙って動いてしまう」ことを型に出した。**その動いた先の値が何であり、
なぜ新定義ではそれが起こりえないのか**を、ここで型に出す。 -/

/-- **旧定義が $b=0$ で返す値は $1$ である。**
$\frac{2\cdot0}{\ell-1}=0$、`Real.logb ℓ 0 = 0`（ジャンク値）なので
$\max\bigl(0,\lceil1+0\rceil\bigr)=1$。**この $1$ には数学的な根拠が無い。** -/
theorem Q5_old_logb_value_at_b_zero {ℓ : ℕ} (hℓ : 2 ≤ ℓ) :
    max (0 : ℤ) ⌈(1 : ℝ) + Real.logb (ℓ : ℝ) (2 * 0 / ((ℓ : ℝ) - 1))⌉ = 1 := by
  have h0 : (2 : ℝ) * 0 / ((ℓ : ℝ) - 1) = 0 := by ring
  rw [h0]
  simp [Real.logb]

/-- **新定義ではその値を取りえない**: $1$ は候補集合の元ではあるが**最小元ではない**
（$0$ が条件を満たすから）。すなわち新定義は最小性によってジャンク値を排除する。
**これが「旧定義はジャンク値で動いてしまうが、新定義では起こりえない」の内容である。** -/
theorem Q5_old_junk_not_least {ℓ : ℕ} (hℓ : 2 ≤ ℓ) : ¬ IsLeast (C1Set ℓ 0) 1 := by
  intro h
  have h0 : (0 : ℕ) ∈ C1Set ℓ 0 := (Q5_c1_zero_of_b_zero hℓ).1
  have := h.2 h0
  omega

/-! ### 1b. 訂正後の証明の $b=0$ の場合分け

$(1.2)$ の $m_i$ は $\ge1$ なので $b=\sum_im_i=0\iff r=0$。このとき $B$ は空積で
全点 $\beta_P=0$ となり、$\mathcal{B}_M=\emptyset$。 -/

/-- **$b=0\iff r=0$**（$m_i\ge1$ から）。 -/
theorem Q5_b_zero_iff_r_zero {r : ℕ} (m : Fin r → ℕ) (hm : ∀ i, 1 ≤ m i) :
    (∑ i, m i) = 0 ↔ r = 0 := by
  constructor
  · intro h
    by_contra hr
    obtain ⟨i⟩ : Nonempty (Fin r) := Fin.pos_iff_nonempty.mp (Nat.pos_of_ne_zero hr)
    have : m i ≤ ∑ j, m j := Finset.single_le_sum (fun j _ => Nat.zero_le (m j)) (mem_univ i)
    have := hm i
    omega
  · intro h
    subst h
    simp

/-- **$b=0$ なら $\mathcal{B}_M=\emptyset$**（1 点ぶんの形で）。
$\beta_P=0$ の点が $\mathcal{B}_M$ に入るには $\theta_G^{\max}\ge\varphi(\ell^M)$ が要るが、
補題 Q5 の仮定 $\varphi(\ell^M)\ge2\theta_G^{\max}$ と $\varphi(\ell^M)\ge1$ に矛盾する。
**空虚な主張ではない**（$\varphi(\ell^M)\ge1$ を実際に使っている）。 -/
theorem Q5_BM_empty_of_b_zero {q θ : ℕ} (hq : 1 ≤ q) (h2 : 2 * θ ≤ q) : ¬ (q ≤ 0 + θ) := by
  omega

/-! ### 1c. 中間段 $\rho_{\max}\ge M-c_1$（狭義不等式だけから）

既存の `DropBStar.lemma_Q5_rho_max` は**狭義不等式そのもの**を仮定に取っており、
$c_1$ の定義の仕方には依存していない（＝旧定義向けの仮定ではなかった）。
新定義版は、`IsLeast` から狭義不等式を取り出して同じ補題に渡すだけで出る。
**新しいのは、その狭義不等式が「対数を経由せずに」得られる点である。** -/

/-- **新定義版の中間段**: $c_1$ が新定義の最小元なら $\rho_{\max}\ge M-c_1$。
仮定に実対数も切り上げも現れない。 -/
theorem Q5_rho_max_of_isLeast {ℓ b M ρ c₁ : ℕ} (hℓ : 2 ≤ ℓ)
    (hc₁ : IsLeast (C1Set ℓ b) c₁)
    (h : (ℓ - 1) * ℓ ^ (M - 1) ≤ 2 * b * ℓ ^ ρ) (hM : c₁ < M) :
    M - c₁ ≤ ρ :=
  DropBStar.lemma_Q5_rho_max hℓ hc₁.1 h hM

/-- **訂正で足された $\beta_P=+\infty$ の枝**: ある $i$ で $\rho_i(P)=M$ なら
$\rho_{\max}=M\ge M-c_1$ で結論は自明である。
**帳簿上の不等式にすぎない**（$M-c_1\le M$）。それでも型に出すのは、
初稿の証明が $\beta_P\le b\ell^{\rho_{\max}}$ を**無条件に**使っており、この枝で
その不等式が成り立たないことが訂正の中身だからである。 -/
theorem Q5_rho_max_at_top_layer (M c₁ : ℕ) : M - c₁ ≤ M := Nat.sub_le M c₁

/-- **訂正後の補題 Q5 の場合分けの全体**: $b=0$ なら $\mathcal{B}_M$ は空（点は入らない）、
$b\ge1$ かつ最上層なら自明、$b\ge1$ かつ非最上層なら中間段が出る。
$\rho$ を $\rho_{\max}$、$q$ を $\varphi(\ell^{M})$ と読む。 -/
theorem Q5_case_split {ℓ b M ρ c₁ q θ : ℕ} (hℓ : 2 ≤ ℓ)
    (hc₁ : IsLeast (C1Set ℓ b) c₁) (hM : c₁ < M) (hq : 1 ≤ q) (h2 : 2 * θ ≤ q) :
    (b = 0 → ¬ (q ≤ 0 + θ)) ∧
    (ρ = M → M - c₁ ≤ ρ) ∧
    ((ℓ - 1) * ℓ ^ (M - 1) ≤ 2 * b * ℓ ^ ρ → M - c₁ ≤ ρ) := by
  refine ⟨fun _ => Q5_BM_empty_of_b_zero hq h2, ?_, fun h => Q5_rho_max_of_isLeast hℓ hc₁ h hM⟩
  intro hρ
  subst hρ
  exact Q5_rho_max_at_top_layer ρ c₁

/-! ### 1d. 新旧の関係 $c_1^{新}\le c_1^{旧}$ -/

/-- **$b\ge1$ では $c_1^{新}\le c_1^{旧}$**。
旧定義の $c_1^{旧}$ は（cycle 24 の `Q5_c1_strict_of_logb` により）狭義不等式を満たす、
すなわち候補集合の元である。最小元は候補集合のどの元以下でもある。
**旧定義が誤りだったのではなく、定義域が狭く（$b\ge1$ でしか定義されず）値が粗かった。** -/
theorem Q5_c1_new_le_old {ℓ b cNew cOld : ℕ} (hℓ : 2 ≤ ℓ) (hb : 1 ≤ b)
    (hNew : IsLeast (C1Set ℓ b) cNew)
    (hOld : (1 : ℝ) + Real.logb (ℓ : ℝ) (2 * b / ((ℓ : ℝ) - 1)) ≤ (cOld : ℝ)) :
    cNew ≤ cOld := by
  have hR : (2 * b : ℝ) < ((ℓ : ℝ) - 1) * (ℓ : ℝ) ^ cOld :=
    Cycle24.Q5_c1_strict_of_logb hℓ hb hOld
  have hcast : ((ℓ - 1 : ℕ) : ℝ) = (ℓ : ℝ) - 1 := by
    have : (1 : ℕ) ≤ ℓ := by omega
    push_cast [Nat.cast_sub this]
    ring
  have hN : 2 * b < (ℓ - 1) * ℓ ^ cOld := by
    have : ((2 * b : ℕ) : ℝ) < (((ℓ - 1) * ℓ ^ cOld : ℕ) : ℝ) := by
      push_cast [hcast]
      exact_mod_cast hR
    exact_mod_cast this
  exact hNew.2 hN

/-- **したがって定理 Q1 の定数 $C$ は悪化しない**: $C$ は $r\ell^{c_1}$ について単調増加である
（$b\ge0$、$\log_\ell C_0\ge0$）。 -/
theorem Q1_C_mono_in_c1 (b θGmax logC L x y : ℚ) (hb : 0 ≤ b) (hlog : 0 ≤ logC) (hxy : x ≤ y) :
    b * (3 + x) + θGmax * ((L + 1) / L) + x * logC
      ≤ b * (3 + y) + θGmax * ((L + 1) / L) + y * logC := by
  nlinarith

/-! ### 1e. $b=0$ での定理 Q1 の退化形（`..._drop_assumption_B_star.md` §6 の追記）

$b=0$ では $r=0$、$c_1=0$ なので $C=\theta_G^{\max}\frac{\ell+1}{\ell}$ に退化する。 -/

/-- **$b=0$ の $(6.1)$**: cycle 24 の `Q1_C_corrected` に $b=0$, $r=0$, $|\mathcal{B}_M|=0$ を入れると
$|\Theta_M|\le\theta_G^{\max}\frac{\ell+1}{\ell}\ell^{M}$。 -/
theorem Q1_C_at_b_zero (L θGmax logC LM SθG ΘM : ℚ)
    (hL : 2 ≤ L) (hLM : 0 ≤ LM) (hθ : 0 ≤ θGmax) (hlog : 0 ≤ logC)
    (hΘ : ΘM = 0 + SθG + 0)
    (hθG : 0 ≤ SθG ∧ SθG ≤ θGmax * ((L + 1) / L) * LM) :
    |ΘM - 0| ≤ (0 * (3 + 0 * 0) + θGmax * ((L + 1) / L) + 0 * 0 * logC) * LM := by
  refine Cycle24.Q1_C_corrected L 0 0 0 0 θGmax logC LM 0 SθG 0 ΘM 0
    hL hLM le_rfl hθ hlog le_rfl (by norm_num) hΘ ?_ hθG ⟨le_rfl, by simp⟩
  simp

/-- **その退化形が自明な数え上げと一致すること**:
$\theta_G^{\max}\frac{\ell+1}{\ell}\ell^{M}=\theta_G^{\max}\cdot(\ell+1)\ell^{M-1}$ であり、
右辺の $(\ell+1)\ell^{M-1}$ は既存の `DropBStar.layer_card_sum` が層分解から出している
$\mathbb{P}^1(\mathbb{Z}/\ell^{M})$ の点数**そのもの**である。
**すなわち $b=0$ の定理 Q1 は「$\Theta_M\le\theta_G^{\max}\cdot(\text{点数})$」という自明な数え上げに一致する。** -/
theorem Q1_b_zero_matches_layer_count {ℓ : ℕ} (hℓ : ℓ.Prime) {M : ℕ} (hM : 1 ≤ M) (θ : ℚ) :
    θ * (((ℓ : ℚ) + 1) / (ℓ : ℚ)) * (ℓ : ℚ) ^ M
      = θ * ((ℓ : ℚ) ^ M + (∑ ρ ∈ Finset.Ico 1 M, (Nat.totient (ℓ ^ (M - ρ)) : ℚ)) + 1) := by
  have hcard : ℓ ^ M + (∑ ρ ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ (M - ρ))) + 1
      = (ℓ + 1) * ℓ ^ (M - 1) := DropBStar.layer_card_sum hℓ hM
  have hQ : (ℓ : ℚ) ^ M + (∑ ρ ∈ Finset.Ico 1 M, (Nat.totient (ℓ ^ (M - ρ)) : ℚ)) + 1
      = ((ℓ : ℚ) + 1) * (ℓ : ℚ) ^ (M - 1) := by
    exact_mod_cast congrArg (fun n : ℕ => (n : ℚ)) hcard
  rw [hQ]
  have hℓ0 : (ℓ : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hℓ.pos.ne'
  have hpow : (ℓ : ℚ) ^ M = (ℓ : ℚ) ^ (M - 1) * (ℓ : ℚ) := by
    rw [← pow_succ]
    congr 1
    omega
  rw [hpow]
  field_simp

/-! ## 2. 定理 G2 $(3.2)$ の規約（`cycle21_T3_general_closed_form.md` §3.2・§6.1）

§6.1 の塔は $k=0$、$\Phi_u=-\ell x^{2}$、すなわち $A_0=A_1=0$、$\theta^\sharp_0=2$、
$m^\sharp_0=\infty$ であり、そこで $M^{*}=1$ を使っている。
$(3.2)$ は $\varphi(\ell^{M})>(\theta^\sharp_k-m^\sharp_k)\varphi(\ell^{k})$。 -/

/-- **$\min\emptyset=0$ の読みでは条件が $\ell\ge4$ に化ける**:
$(k,M)=(0,1)$、$\theta^\sharp_0=2$ で $(3.2)$ は $\varphi(\ell)>2\varphi(1)=2$、
すなわち $\ell-1>2$ になる。 -/
theorem G2_minEmpty_iff_ell_ge_four {ℓ : ℕ} (hℓ : ℓ.Prime) :
    ((2 - 0) * Nat.totient (ℓ ^ 0) < Nat.totient (ℓ ^ 1)) ↔ 4 ≤ ℓ := by
  rw [pow_one, pow_zero, Nat.totient_one, Nat.totient_prime hℓ]
  have := hℓ.two_le
  omega

/-- **$\ell=3$ で落ちる**（§6.1 が機械照合している素数のひとつ）。
$\varphi(3)=2$ で $2<2$ は偽。**これが「規約の明記が必要である」ことの形式的な証拠である。** -/
theorem G2_minEmpty_breaks_at_ell_three :
    ¬ ((2 - 0) * Nat.totient (3 ^ 0) < Nat.totient (3 ^ 1)) := by decide

/-- **$\ell=5,7$ では落ちない**——すなわち誤った読みは $\ell=3$ だけを選択的に壊す。
（もし全部落ちるなら誤読はすぐ見つかる。**1 つだけ落ちるから見落とされた**。） -/
theorem G2_minEmpty_ok_at_ell_five_seven :
    ((2 - 0) * Nat.totient (5 ^ 0) < Nat.totient (5 ^ 1)) ∧
    ((2 - 0) * Nat.totient (7 ^ 0) < Nat.totient (7 ^ 1)) := by decide

/-- **正しい読み（差を $-\infty$ とする＝和の形）では $\ell=3$ でも成り立つ。**
cycle 24 の `G2_cond32_sum_form_top` を §6.1 の数値に当てた形。 -/
theorem G2_top_reading_ok_at_ell_three :
    ((2 : ℕ∞) < (Nat.totient (3 ^ 1) : ℕ∞) + ⊤) := Cycle24.G2_cond32_sum_form_top _ 2

/-! ## 3. 本文（命題 M・U）と根拠 report の照合

本文 `structured-latex/content/010_general_closed_form.ts`。
(M3) は $\alpha,\beta,\gamma$ を、(M4) は $c=\frac{\ell}{\ell-1}\beta-\frac{\ell}{(\ell-1)^2}\alpha$,
$d=\gamma-2$ を与える。(U1) はそれを $\mathcal{L},\mathcal{T}$ で書き直した形を与える。
**本文の 2 箇所が整合するかを型で照合する。** -/

/-- **本文 (U1) の $c$ の式が (M3)+(M4) から出る**（$S_\infty$ の 1 点分。$\ell$ を `L` と書く）。

(M3): $\alpha=\frac{L-1}{L}j$, $\beta=A+\frac{e}{L^{r}}-\frac{(L-1)j(K+r)}{L}+\frac{L-1}{L}\mathcal{L}$。
(M4): $c=\frac{L}{L-1}\beta-\frac{L}{(L-1)^2}\alpha$。
これが (U1) の
$c=\frac{L}{L-1}A+\frac{e\,L^{1-r}}{L-1}-j\bigl(K+r+\frac{1}{L-1}\bigr)+\mathcal{L}$
に一致する。 -/
theorem U1_c_from_M3_M4 (L A e j K r Lc : ℚ) (hL0 : L ≠ 0) (hL1 : L ≠ 1) (rp : ℚ) (hrp : rp ≠ 0) :
    L / (L - 1) * (A + e / rp - (L - 1) * j * (K + r) / L + (L - 1) / L * Lc)
        - L / (L - 1) ^ 2 * ((L - 1) / L * j)
      = L / (L - 1) * A + (e * (L / rp)) / (L - 1) - j * (K + r + 1 / (L - 1)) + Lc := by
  have h1 : L - 1 ≠ 0 := sub_ne_zero.mpr hL1
  field_simp
  ring

/-- **本文 (U1) の $d$ の式**は (M3) の $\gamma$ と (M4) の $d=\gamma-2$ の**記号の置き換えだけ**である
（$\mathcal{T}=\theta^\sharp_0+\sum_{k\le K}\varphi(\ell^{k})\theta^\sharp_k$ と書き直しただけ）。
**射程の限定: これは帳簿上の恒等式であり、数学的な内容は無い。**
それでも置いたのは、$c$ の側（上）が非自明な相殺を含むのと対照させるためである。 -/
theorem U1_d_from_M3_M4 (T e LK : ℚ) : (-(e * LK) + T) - 2 = (T - e * LK) - 2 := by ring

/-- **本文 (M4) の $e$ の式の角括弧が、本文 (U2) の $T_\mathrm{def}$ と一致すること**:
$$\sum_{M=1}^{N}\bigl(\Theta_M-(\alpha M L^{M}+\beta L^{M}+\gamma)\bigr)
=\sum_{M=1}^{N}\Theta_M-\alpha\mathcal{S}_1(N)-\beta\mathcal{S}_0(N)-\gamma N .$$
本文は (M4) で角括弧、(U2) で $T_\mathrm{def}$ と別々に書いており、
「(M4) の角括弧の正体がこの $T_\mathrm{def}$ である」と述べている。**その主張が実際に成り立つ。** -/
theorem U2_bracket_eq_Tdef (L α β γ : ℚ) (Θ : ℕ → ℚ) (N : ℕ) :
    (∑ M ∈ Finset.Ico 1 (N + 1), (Θ M - ((α * M * L ^ M) + β * L ^ M + γ)))
      = (∑ M ∈ Finset.Ico 1 (N + 1), Θ M)
        - α * GeneralTower.S1 L N - β * GeneralTower.S0 L N - γ * N := by
  have hcard : (Finset.Ico 1 (N + 1)).card = N := by simp
  have hα : ∀ M ∈ Finset.Ico 1 (N + 1), α * (M : ℚ) * L ^ M = α * ((M : ℚ) * L ^ M) :=
    fun M _ => by ring
  simp only [GeneralTower.S1, GeneralTower.S0, Finset.mul_sum]
  rw [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_add_distrib,
    Finset.sum_const, hcard, nsmul_eq_mul, Finset.sum_congr rfl hα]
  ring

/-! ### 3a. 本文 (U4) の数値（$\ell=2$、1 頂点 bouquet の族）

$\ell=2$、$|S_\infty|=2$、各点で $j^{*}=1$, $e_{j^*}=2$, $K=1$, $r^\sharp=2$、$A_\mathrm{gen}=2$。
本文はここから $c=2\mathcal{L}-2$、$d=2\theta^\sharp_1-6$ と書いている。 -/

/-- **本文 (U4) の $c=2\mathcal{L}-2$ が (U1) の一般式から出る。**
$\ell=2$ を入れると 1 点分は $\frac{e\cdot\ell^{1-r^\sharp}}{\ell-1}-j\bigl(K+r^\sharp+\frac{1}{\ell-1}\bigr)+\mathcal{L}
=1-4+\mathcal{L}$、大域項は $\frac{\ell}{\ell-1}A_\mathrm{gen}=4$。2 点で $4+2(\mathcal{L}-3)=2\mathcal{L}-2$。 -/
theorem U4_c_at_ell_two (Lc : ℚ) :
    (2 : ℚ) / (2 - 1) * 2
        + 2 * ((2 * (2 : ℚ) ^ (1 - 2 : ℤ)) / (2 - 1) - 1 * (1 + 2 + 1 / (2 - 1)) + Lc)
      = 2 * Lc - 2 := by
  norm_num
  ring

/-- **本文 (U4) の $d=2\theta^\sharp_1-6$ が (U1) の一般式から出る。**
1 点分は $\mathcal{T}-e_{j^*}\ell^{K}=(\theta^\sharp_0+\varphi(2)\theta^\sharp_1)-2\cdot2
=(2+\theta^\sharp_1)-4$。2 点で $2\theta^\sharp_1-4$、$-2$ して $2\theta^\sharp_1-6$。 -/
theorem U4_d_at_ell_two (th1 : ℚ) :
    2 * ((2 + (Nat.totient 2 : ℚ) * th1) - 2 * (2 : ℚ) ^ (1 : ℕ)) - 2 = 2 * th1 - 6 := by
  norm_num
  ring

/-- **$p=1$ の塔**: $\Lambda_0=v_2(2)=1$、$\Lambda_1=\min(2,v_2(0))=\min(2,\infty)=2$
（**規約 $v_2(0)=+\infty$**。$A_2=1-p=0$ だから）、$\theta^\sharp_1=0$。
よって $\mathcal{L}=3$、$c=2\cdot3-2=4$、$d=2\cdot0-6=-6$。**本文の $(0,2,4,-6,-1)$ と一致する。** -/
theorem U4_p_one_values :
    min (2 : ℕ∞) ⊤ = 2 ∧ (2 : ℚ) * (1 + 2) - 2 = 4 ∧ 2 * (0 : ℚ) - 6 = -6 := by
  refine ⟨by simp, by norm_num, by norm_num⟩

/-- **$p=3$ の塔**: $\Lambda_0=v_2(4)=2$、$\Lambda_1=\min(2,v_2(2))=\min(2,1)=1$、$\theta^\sharp_1=2$。
よって $\mathcal{L}=3$、$c=4$、$d=2\cdot2-6=-2$。**本文の $(0,2,4,-2,-4)$ と一致する。** -/
theorem U4_p_three_values :
    min (2 : ℕ∞) (1 : ℕ∞) = 1 ∧ (2 : ℚ) * (2 + 1) - 2 = 4 ∧ 2 * (2 : ℚ) - 6 = -2 := by
  refine ⟨by decide, by norm_num, by norm_num⟩

/-- **本文の「この対では $\mathcal{L}$ が偶然一致して $c$ が同じになる」が正しいこと**:
$p=1$ の $\mathcal{L}=1+2$ と $p=3$ の $\mathcal{L}=2+1$ は等しく、$c$ は一致するが $d$ は違う。
**すなわち「$c$ の反例と $d$ の反例は独立に要る」という本文の記述は、この対では正しい。** -/
theorem U4_c_same_d_differs :
    ((1 : ℕ) + 2 = 2 + 1) ∧ ((2 : ℚ) * 0 - 6 ≠ 2 * 2 - 6) := by
  refine ⟨rfl, by norm_num⟩

/-! ### 3a′. 本文 (M2) の括弧書き「値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」

本文 (M2) は $\lambda(P_0)$ を「$\ell^{\lambda}\ge e_{j^*}+1$ を満たす最小の自然数」と定義し直したうえで、
括弧で**「値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」**と書いている。
この括弧書きは書き換えの正当性そのものなので、型に出して確かめる。 -/

/-- **本文 (M2) の括弧書きが正しいこと**: $\mathbb{N}$ 上の最小元と実対数の切り上げは一致する。
すなわち書き換えは**値を変えていない**（$\mathbb{R}$ 脱出を消しただけである）。 -/
theorem M2_lambda_eq_ceil_logb {ℓ e lam : ℕ} (hℓ : 2 ≤ ℓ)
    (h : IsLeast {n : ℕ | e + 1 ≤ ℓ ^ n} lam) :
    (lam : ℤ) = ⌈Real.logb (ℓ : ℝ) ((e : ℝ) + 1)⌉ := by
  have hb1 : (1 : ℝ) < (ℓ : ℝ) := by exact_mod_cast hℓ
  have hm0 : (0 : ℝ) < (e : ℝ) + 1 := by positivity
  -- (≥) logb ℓ (e+1) ≤ lam なので ⌈·⌉ ≤ lam
  have hup : ⌈Real.logb (ℓ : ℝ) ((e : ℝ) + 1)⌉ ≤ (lam : ℤ) := by
    rw [Int.ceil_le]
    have hle : ((e : ℝ) + 1) ≤ (ℓ : ℝ) ^ lam := by exact_mod_cast h.1
    have := (Real.logb_le_iff_le_rpow hb1 hm0 (y := (lam : ℝ))).mpr
      (by rw [Real.rpow_natCast]; exact hle)
    simpa using this
  -- (≤) n := max(0, ⌈·⌉) は条件を満たすので最小性から lam ≤ n
  have hlow : (lam : ℤ) ≤ ⌈Real.logb (ℓ : ℝ) ((e : ℝ) + 1)⌉ := by
    set c : ℤ := ⌈Real.logb (ℓ : ℝ) ((e : ℝ) + 1)⌉ with hc
    have hc0 : 0 ≤ c := by
      rw [hc]
      exact Int.ceil_nonneg (Real.logb_nonneg hb1 (by linarith))
    have hcn : ((c.toNat : ℤ)) = c := Int.toNat_of_nonneg hc0
    have hxle : Real.logb (ℓ : ℝ) ((e : ℝ) + 1) ≤ (c.toNat : ℝ) := by
      have : Real.logb (ℓ : ℝ) ((e : ℝ) + 1) ≤ (c : ℝ) := Int.le_ceil _
      rw [← hcn] at this
      exact_mod_cast this
    have hpow : ((e : ℝ) + 1) ≤ (ℓ : ℝ) ^ (c.toNat) := by
      have := (Real.logb_le_iff_le_rpow hb1 hm0 (y := (c.toNat : ℝ))).mp hxle
      rwa [Real.rpow_natCast] at this
    have hmem : e + 1 ≤ ℓ ^ (c.toNat) := by exact_mod_cast hpow
    have := h.2 hmem
    omega
  omega

/-! ### 3b. 本文 (U6)（精度が足りる条件）

$N>\Lambda_k$ ならば $\tilde E\bmod\ell^{N}$ が $(\Lambda_k,\theta^\sharp_k)$ を決める。
本文の論拠は「**切り捨て付きの付値列** $(\min(v_\ell(A_m),N))_m$ が $\tilde E\bmod\ell^{N}$ で決まる」
であった。それを 3 係数の場合に型に出す（cycle 24 の `LamC` / `thC` をそのまま使う）。 -/

/-- **切り捨て付値列が $\Lambda$ と $\theta^\sharp$ を決める**:
2 つの係数列の切り捨て付値列が一致し、かつ $\Lambda$ が閾値 $N$ より真に小さければ、
$\Lambda$ も $\theta^\sharp$ も一致する。**これが本文 (U6) の論拠そのものである。**

**射程の限定**: 形式化したのは「切り捨て付値列 $\Rightarrow$ 段データ」の部分だけである。
「$\tilde E\bmod\ell^{N}$ が切り捨て付値列を決める」（$A'_m=A_m+\ell^{N}\beta_m$ の側）は
$\mathcal{O}_k$ 係数の線形性の配線が要るので形式化していない。 -/
theorem U6_trunc_determines_stage_data (v v' : Fin 3 → ℕ∞) (N : ℕ)
    (h : ∀ i, min (v i) (N : ℕ∞) = min (v' i) (N : ℕ∞))
    (hlt : Cycle24.LamC v < (N : ℕ∞)) :
    Cycle24.LamC v' = Cycle24.LamC v ∧ Cycle24.thC v' = Cycle24.thC v := by
  -- 閾値未満の成分は完全に一致し、閾値以上の成分は両方とも閾値以上である。
  have key : ∀ i, (v i < (N : ℕ∞) → v' i = v i) ∧ ((N : ℕ∞) ≤ v i → (N : ℕ∞) ≤ v' i) := by
    intro i
    have hi := h i
    constructor
    · intro hvi
      rw [min_eq_left hvi.le] at hi
      by_cases hv' : v' i ≤ (N : ℕ∞)
      · rw [min_eq_left hv'] at hi
        exact hi.symm
      · push_neg at hv'
        rw [min_eq_right hv'.le] at hi
        exact absurd hi (ne_of_lt hvi)
    · intro hvi
      rw [min_eq_right hvi] at hi
      by_cases hv' : (N : ℕ∞) ≤ v' i
      · exact hv'
      · push_neg at hv'
        rw [min_eq_left hv'.le] at hi
        exact absurd hi.symm (ne_of_lt hv')
  -- 各成分について「$\Lambda$ に等しい」が両側で同値になる。
  have hLam : Cycle24.LamC v < (N : ℕ∞) := hlt
  have hcases : ∀ i : Fin 3, i = 0 ∨ i = 1 ∨ i = 2 := by decide
  have hleAny : ∀ (w : Fin 3 → ℕ∞) (i : Fin 3), Cycle24.LamC w ≤ w i := by
    intro w i
    simp only [Cycle24.LamC]
    rcases hcases i with rfl | rfl | rfl
    · exact min_le_left _ _
    · exact le_trans (min_le_right _ _) (min_le_left _ _)
    · exact le_trans (min_le_right _ _) (min_le_right _ _)
  have hle : ∀ i, Cycle24.LamC v ≤ v i := hleAny v
  have hval : ∀ i, (v i = Cycle24.LamC v) ↔ (v' i = Cycle24.LamC v) := by
    intro i
    constructor
    · intro hvi
      have : v i < (N : ℕ∞) := hvi ▸ hLam
      rw [(key i).1 this]
      exact hvi
    · intro hvi
      by_cases hb : v i < (N : ℕ∞)
      · rw [(key i).1 hb] at hvi; exact hvi
      · push_neg at hb
        have := (key i).2 hb
        rw [hvi] at this
        exact absurd (lt_of_lt_of_le hLam this) (lt_irrefl _)
  have heq : ∀ i, v' i = v i ∨ ((N : ℕ∞) ≤ v i ∧ (N : ℕ∞) ≤ v' i) := by
    intro i
    by_cases hb : v i < (N : ℕ∞)
    · exact Or.inl ((key i).1 hb)
    · push_neg at hb
      exact Or.inr ⟨hb, (key i).2 hb⟩
  have hLamEq : Cycle24.LamC v' = Cycle24.LamC v := by
    apply le_antisymm
    · -- $\Lambda$ を達成する成分が $v'$ でも同じ値を持つ
      have hach : ∃ i, v i = Cycle24.LamC v := by
        simp only [Cycle24.LamC]
        rcases min_cases (v 0) (min (v 1) (v 2)) with ⟨he, _⟩ | ⟨he, _⟩
        · exact ⟨0, he.symm⟩
        · rcases min_cases (v 1) (v 2) with ⟨he2, _⟩ | ⟨he2, _⟩
          · exact ⟨1, (he.trans he2).symm⟩
          · exact ⟨2, (he.trans he2).symm⟩
      obtain ⟨i, hi⟩ := hach
      have hvi : v' i = Cycle24.LamC v := (hval i).1 hi
      calc Cycle24.LamC v' ≤ v' i := hleAny v' i
        _ = Cycle24.LamC v := hvi
    · -- 逆向き: $v'$ の最小成分は $\Lambda$ 以上である
      have hge : ∀ i, Cycle24.LamC v ≤ v' i := by
        intro i
        rcases heq i with he | ⟨hb, hb'⟩
        · rw [he]; exact hle i
        · exact le_trans hLam.le hb'
      have h0 := hge 0
      have h1 := hge 1
      have h2 := hge 2
      simp only [Cycle24.LamC]
      exact le_min h0 (le_min h1 h2)
  refine ⟨hLamEq, ?_⟩
  simp only [Cycle24.thC, hLamEq]
  by_cases h0 : v 0 = Cycle24.LamC v
  · rw [if_pos h0, if_pos ((hval 0).1 h0)]
  · rw [if_neg h0, if_neg (fun hc => h0 ((hval 0).2 hc))]
    by_cases h1 : v 1 = Cycle24.LamC v
    · rw [if_pos h1, if_pos ((hval 1).1 h1)]
    · rw [if_neg h1, if_neg (fun hc => h1 ((hval 1).2 hc))]

/-! ## 4. まだ通していなかったもの: $A_\mathrm{gen}$ のレベル非依存性（本文 (M3)）

本文 (M3) は
$$A_\mathrm{gen}=\frac{1}{\ell^{L}}\sum_{P\in U\cap\mathbb{P}^1(\mathbb{Z}/\ell^{L})}\theta(P)$$
が「$L$ の取り方に依らない（$L\to L+1$ でファイバーが一様に $\ell$ 個に分かれるから）」と述べる。
`lean/README.md` はこれを「射影直線のレベル構造。**配線**」として未形式化に挙げていた。
配線の中身は「一様ファイバーの和」である。 -/

/-- **一様ファイバーの和**: $\pi:T\to S$ の各ファイバーの大きさが一様に $n$ なら
$\sum_{x\in T}\theta(\pi x)=n\sum_{y\in S}\theta(y)$。 -/
theorem sum_of_uniform_fibers {α β : Type*} [DecidableEq β] (T : Finset α) (S : Finset β)
    (π : α → β) (n : ℕ) (θ : β → ℚ)
    (hπ : ∀ x ∈ T, π x ∈ S)
    (hfib : ∀ y ∈ S, (T.filter (fun x => π x = y)).card = n) :
    ∑ x ∈ T, θ (π x) = (n : ℚ) * ∑ y ∈ S, θ y := by
  classical
  rw [← Finset.sum_fiberwise_of_maps_to hπ (fun x => θ (π x))]
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl (fun y hy => ?_)
  have : ∀ x ∈ T.filter (fun x => π x = y), θ (π x) = θ y := by
    intro x hx
    rw [(Finset.mem_filter.mp hx).2]
  rw [Finset.sum_congr rfl this, Finset.sum_const, hfib y hy, nsmul_eq_mul]

/-- **本文 (M3) の「$A_\mathrm{gen}$ は $L$ に依らない」**:
レベル $L+1$ の点集合 $T$ からレベル $L$ の点集合 $S$ への射影のファイバーが一様に $\ell$ 個で、
$\theta$ がファイバー上で一定（＝レベル $L$ の値で決まる）なら、$\frac{1}{\ell^{L}}$ で割った値が一致する。

**射程の限定**: 「ファイバーが一様に $\ell$ 個である」ことと「$\theta$ がファイバー上で一定である」ことは
**仮定として置いている**（前者は射影直線のレベル構造、後者は $U$ の外を除いた上での $\theta$ の性質で、
どちらも本ファイルでは証明していない）。型に出したのは、その 2 つから $L$ 非依存性が出るという含意だけである。 -/
theorem Agen_level_indep {α β : Type*} [DecidableEq β] (T : Finset α) (S : Finset β)
    (π : α → β) (ℓ L : ℕ) (θ : β → ℚ) (hℓ : ℓ ≠ 0)
    (hπ : ∀ x ∈ T, π x ∈ S)
    (hfib : ∀ y ∈ S, (T.filter (fun x => π x = y)).card = ℓ) :
    (∑ x ∈ T, θ (π x)) / (ℓ : ℚ) ^ (L + 1) = (∑ y ∈ S, θ y) / (ℓ : ℚ) ^ L := by
  have hℓQ : (ℓ : ℚ) ≠ 0 := Nat.cast_ne_zero.mpr hℓ
  rw [sum_of_uniform_fibers T S π ℓ θ hπ hfib, pow_succ]
  field_simp

end Cycle25
end IntegrableLattice
