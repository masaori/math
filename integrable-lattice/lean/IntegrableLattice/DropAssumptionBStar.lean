/-
# 定理 Q1（仮定 (B*) 無しで $b=\sum_{P\in S_\infty}j^*(P)$）— cycle 21 step 1

対応する人手証明:

* 根拠 report: `outputs/reports/cycle21_T3_drop_assumption_B_star.md`
  §3.2（補題 Q2）・§4（補題 Q4a・定理 Q4）・§5.1（補題 Q0）・§5.2（補題 Q5）・
  §5.3（補題 Q3）・§6（定理 Q1）
* 本文への反映は cycle 22 step 1 の担当（本ファイルの時点では本文未反映）

## 目的

**証明の正しさではなく、主張の検算**である（cycle 17 以降 6 サイクル連続で
本文・report の不備を検出してきた検査。本ファイルは 7 サイクル目）。
定理 Q1 は「(B\*) を落として $n\ell^n$ の係数 $b$ が出る」を主張する。その骨格は

1. 分解 $\tilde E=BG+\ell H$ を点で評価したときの **最小点の一意性**（補題 Q2 (2)・定理 Q4）、
2. 悪い点 $\mathcal{B}_M$ の **個数が $M$ に依らない**こと（補題 Q5）、
3. 重み $\ell^{\rho_v(P)}$ の **数え上げ**（補題 Q3）、
4. それらを三角不等式で束ねる **誤差評価**（定理 Q1 $(6.1)$）

の 4 つで、いずれも組合せ論・初等数論であって円分体の付値そのものではない。
本ファイルはこの 4 つを型に出す。

## 形式化した主張

* `unique_min_of_val_seq` — **補題 Q2 (2) の核**。$\varphi(\ell^M)v_\ell(A_m)+m$ の最小点が
  $m=\theta_G$ で**一意**であること。仮定は $\theta_G<\varphi(\ell^M)$ だけ。
* `BG_dominates` — **定理 Q4 の非アルキメデス的比較**（$\beta_P+\theta_G^{\max}<\varphi(\ell^M)$ の役割）。
* `totient_pow_mul_pow` — $\varphi(\ell^{M-\rho})\ell^{\rho}=\varphi(\ell^{M})$（$1\le\rho\le M-1$）。
* `layer_card_sum` — 層分解が $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の**分割**であること
  （個数の合計が $(\ell+1)\ell^{M-1}$）。**補題 Q3 の誤りを生んだのはここの数え違いである。**
* `lemma_Q3` — **補題 Q3**（$\sum_P\ell^{\rho_v(P)}=(M-1)\varphi(\ell^M)+2\ell^M$）。
* `lemma_Q3_old_formula_false` — report §10.1 が記録する**初稿の式 $M\varphi(\ell^M)+\ell^M$ が偽**
  であることの反例（$\ell=2$, $M=2$: 正 $10$ vs 誤 $8$）。
* `lemma_Q3_diff` — 初稿の式との差が $\ell^M-\varphi(\ell^M)$ で、$O(\ell^M)$ に収まること
  （report が「主要項は変わらない」と書いた根拠）。
* `lemma_Q5_rho_max` — **補題 Q5** の核（$\beta_P$ が $\varphi(\ell^M)$ と拮抗するなら $\rho_{\max}\ge M-c_1$）。
* `lemma_Q5_card` — 悪い点の個数が $r\,\ell^{c_1}$ 以下（ファイバーの被覆から）。
* `theorem_Q1_error` — **定理 Q1 $(6.1)$ の三角不等式による組み立て**を有理数上で検算したもの。

## 形式化で分かったこと（主張の精度）

1. **$(6.1)$ の「明示定数 $C$」は明示定数になっていない。** $C$ の定義に
   $|\mathcal{B}_M|$（レベル $M$ ごとの実際の個数）が入っており、$M$ に依存する量である。
   直後の括弧書きが「補題 Q5 より $M$ に依らず押さえられる」と補っているが、
   定数として書くなら補題 Q5 の上界 $r\ell^{c_1}$ を代入した形でなければならない。
   `theorem_Q1_error` は上界を仮定として型に出し、`theorem_Q1_error_explicit` で
   $r\ell^{c_1}$ を代入した**本当に $M$ に依らない**形を与える。
2. **補題 Q5 の $c_1$ に必要なのは狭義不等式 $2b<(\ell-1)\ell^{c_1}$ である。**
   report の $c_1=\max(0,\lceil1+\log_\ell\frac{2b}{\ell-1}\rceil)$ の **$+1$ はここに効いている**
   （$\lceil\log_\ell\cdot\rceil$ だけだと等号のとき結論が出ない）。`lemma_Q5_rho_max` の仮定を
   狭義にしてあるのはそのためで、非狭義版は反例を持つ（`lemma_Q5_needs_strict`）。
3. **補題 Q0 の適用には $\tilde E(\omega_P)\ne0$ が要るが、定理 Q1 の証明はそれを明示していない。**
   仮定 (H) から従う（$(1.1)$ の $\Sigma_n$ が有限であること自体が同値）が、
   $\mathcal{B}_M$ の点で $\hat\theta_M(P)<\infty$ であることは $(6.1)$ の第 3 項の前提である。
   型に出すと `theorem_Q1_error` の仮定 `hhat`（$\mathcal{B}_M$ 上の和が有限の上界を持つ）が
   これを要求していることから読める。**証明本文に一言要る。**

## 形式化しなかったもの（mathlib の欠落か配線か）

`lean/logs/mathlib-gap-survey-cycle22.log` を参照。

* **補題 Q4a**（$v_{\mathfrak l}(B(\omega_P))=\beta_P$）: 円分体 $\mathbb{Q}(\zeta_{\ell^M})$ の
  $\ell$ の上の素点の付値で $v(\zeta_{\ell^j}-1)$ を計算する段。
  `IsCyclotomicExtension`（15 ファイル）・`zeta_sub_one_prime`（3 ファイル）・
  分岐指数 `ramificationIdx`（16 ファイル）・慣性次数 `inertiaDeg`（15 ファイル）は
  mathlib に**在る**（`logs/mathlib-gap-survey-cycle22.log` で確認）ので、欠落ではなく**配線**である。
* **補題 Q1′**（$\tilde E=BG+\ell H$ の存在と $\bar G$ が二項式因子を持たないこと）:
  $\mathbb{F}_\ell[z^{\pm},w^{\pm}]$ が UFD であることの Laurent 版。
  **1 変数** Laurent 多項式は `Mathlib/Algebra/Polynomial/Laurent.lean` に**在る**が、
  **2 変数 Laurent 環の型は無い**（`Polynomial.laurent` / `MvPolynomial.Laurent` はともに 0 件）。
  ただし `MvPolynomial` の局所化として作れ、`UniqueFactorizationMonoid`（66 ファイル）も在るので、
  数学的な欠落ではなく**配線**である。
* **補題 Q0**（アルキメデス粗上界）: $\mathbb{R}$ へ脱出する唯一の箇所。
  `Algebra.norm` と複素絶対値の評価。**配線**（mathlib には両方在る）。
-/
import Mathlib

namespace IntegrableLattice
namespace DropBStar

open Finset

/-! ## 補題 Q2 (2) の核 — 最小点の一意性

$\Phi=\sum_m A_mx^m$、$v_{\mathfrak l}(A_m\pi^m)=\varphi(\ell^M)v_\ell(A_m)+m$ である。
$m<\theta$ で $\ell\mid A_m$（すなわち $v_\ell(A_m)\ge1$）、$m=\theta$ で $v_\ell(A_\theta)=0$ のとき、
$\theta<\varphi(\ell^M)$ ならば最小点は $m=\theta$ **のみ**である。

report §3.2 の証明はこの 3 分割をそのまま書いている。**仮定は $\theta<\varphi(\ell^M)$ だけで、
(B\*) 型の仮定は一切要らない。**これが「$G$ 側は一様に浅い」の内容である。 -/

/-- **補題 Q2 (2) の核**: $\theta < \varphi$ ならば $m\mapsto \varphi\cdot v(m)+m$ の最小点は
$m=\theta$ で一意。`v` は $\ell$ 進付値、`φ` は $\varphi(\ell^M)$。 -/
theorem unique_min_of_val_seq (φ θ : ℕ) (v : ℕ → ℕ)
    (hlow : ∀ m, m < θ → 1 ≤ v m) (hθ : v θ = 0) (hlt : θ < φ) :
    ∀ m, m ≠ θ → φ * v θ + θ < φ * v m + m := by
  intro m hm
  rcases lt_or_gt_of_ne hm with h | h
  · -- m < θ: v m ≥ 1 なので値は φ 以上、これは θ より真に大きい
    have h1 : 1 ≤ v m := hlow m h
    calc φ * v θ + θ = θ := by simp [hθ]
      _ < φ := hlt
      _ = φ * 1 := (mul_one φ).symm
      _ ≤ φ * v m := Nat.mul_le_mul_left φ h1
      _ ≤ φ * v m + m := Nat.le_add_right _ _
  · -- m > θ: v m ≥ 0 なので値は m 以上 > θ
    calc φ * v θ + θ = θ := by simp [hθ]
      _ < m := h
      _ ≤ φ * v m + m := Nat.le_add_left _ _

/-- 上の一意性から、$\theta$ が最小値であることも出る（`unique_min_of_val_seq` の系）。 -/
theorem min_eq_theta (φ θ : ℕ) (v : ℕ → ℕ)
    (hlow : ∀ m, m < θ → 1 ≤ v m) (hθ : v θ = 0) (hlt : θ < φ) :
    ∀ m, φ * v θ + θ ≤ φ * v m + m := by
  intro m
  by_cases hm : m = θ
  · subst hm; exact le_rfl
  · exact (unique_min_of_val_seq φ θ v hlow hθ hlt m hm).le

/-! ## 定理 Q4 — 分解の 2 項の比較

$\tilde E(\omega_P)=B(\omega_P)G(\omega_P)+\ell H(\omega_P)$ で、第 1 項の付値は
$\beta_P+\theta_G(P)$、第 2 項の付値は $\varphi(\ell^M)+v(H)\ge\varphi(\ell^M)$。
$(4.2)$ の $\beta_P+\theta_G^{\max}<\varphi(\ell^M)$ はまさに「第 1 項が狭義に小さい」ことを言っている。 -/

/-- **定理 Q4 の非アルキメデス的比較**: $(4.2)$ が第 1 項の狭義優越を与える。 -/
theorem BG_dominates (β θG θGmax φ vH : ℕ) (hmax : θG ≤ θGmax) (h : β + θGmax < φ) :
    β + θG < φ + vH :=
  lt_of_lt_of_le (lt_of_le_of_lt (Nat.add_le_add_left hmax β) h) (Nat.le_add_right _ _)

/-! ## 補題 Q3 — 数え上げ

$\rho_v(P):=\min(v_\ell\langle v,(a,b)\rangle,M)$ に対する層の個数は

| $\rho$ | 個数 |
| --- | --- |
| $0$ | $\ell^M$ |
| $1\le\rho\le M-1$ | $\varphi(\ell^{M-\rho})$ |
| $M$ | $1$ |

であり、合計は $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の点数 $(\ell+1)\ell^{M-1}$ に一致する。
**report §10.1 が記録する初稿の誤りは、$\rho=0$ の層を $\varphi(\ell^M)$ 個と数えたことによる。**
下の `layer_card_sum` はその分割性を、`lemma_Q3` は重み付き和を検算する。 -/

/-- $1\le\rho$ かつ $\rho<M$ のとき $\varphi(\ell^{M-\rho})\,\ell^{\rho}=\varphi(\ell^{M})$。 -/
theorem totient_pow_mul_pow {ℓ : ℕ} (hℓ : ℓ.Prime) {M ρ : ℕ} (hρ : 1 ≤ ρ) (hρM : ρ < M) :
    Nat.totient (ℓ ^ (M - ρ)) * ℓ ^ ρ = Nat.totient (ℓ ^ M) := by
  have hM : 0 < M := lt_of_le_of_lt (Nat.zero_le _) hρM
  have hMρ : 0 < M - ρ := Nat.sub_pos_of_lt hρM
  rw [Nat.totient_prime_pow hℓ hMρ, Nat.totient_prime_pow hℓ hM]
  have : M - ρ - 1 + ρ = M - 1 := by omega
  calc ℓ ^ (M - ρ - 1) * (ℓ - 1) * ℓ ^ ρ
      = ℓ ^ (M - ρ - 1) * ℓ ^ ρ * (ℓ - 1) := by ring
    _ = ℓ ^ (M - ρ - 1 + ρ) * (ℓ - 1) := by rw [pow_add]
    _ = ℓ ^ (M - 1) * (ℓ - 1) := by rw [this]

/-- $\sum_{j=1}^{M-1}\varphi(\ell^{j})=\ell^{M-1}-1$（望遠鏡和）。 -/
theorem sum_totient_pow {ℓ : ℕ} (hℓ : ℓ.Prime) (M : ℕ) :
    (∑ j ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ j)) + 1 = ℓ ^ (M - 1) := by
  induction M with
  | zero => simp
  | succ N ih =>
      rcases Nat.eq_zero_or_pos N with hN | hN
      · subst hN; simp
      · rw [Finset.sum_Ico_succ_top (by omega)]
        have hN1 : N - 1 + 1 = N := by omega
        have : (∑ j ∈ Finset.Ico 1 N, Nat.totient (ℓ ^ j)) + Nat.totient (ℓ ^ N) + 1
            = ((∑ j ∈ Finset.Ico 1 N, Nat.totient (ℓ ^ j)) + 1) + Nat.totient (ℓ ^ N) := by ring
        rw [this, ih, Nat.totient_prime_pow hℓ hN]
        have hsub : ℓ - 1 + 1 = ℓ := Nat.succ_pred_eq_of_pos hℓ.pos
        calc ℓ ^ (N - 1) + ℓ ^ (N - 1) * (ℓ - 1)
            = ℓ ^ (N - 1) * ((ℓ - 1) + 1) := by ring
          _ = ℓ ^ (N - 1) * ℓ := by rw [hsub]
          _ = ℓ ^ (N - 1 + 1) := (pow_succ ℓ (N - 1)).symm
          _ = ℓ ^ N := by rw [hN1]

/-- **層分解が分割であること**: 層ごとの個数の合計が $\mathbb{P}^1(\mathbb{Z}/\ell^M)$ の点数
$(\ell+1)\ell^{M-1}$ に一致する。**初稿の誤りはこの照合をしていれば出ていた。** -/
theorem layer_card_sum {ℓ : ℕ} (hℓ : ℓ.Prime) {M : ℕ} (hM : 1 ≤ M) :
    ℓ ^ M + (∑ ρ ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ (M - ρ))) + 1 = (ℓ + 1) * ℓ ^ (M - 1) := by
  have hre : (∑ ρ ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ (M - ρ)))
      = ∑ j ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ j) := by
    apply Finset.sum_nbij' (fun ρ => M - ρ) (fun j => M - j) <;>
      intros <;> simp_all [Finset.mem_Ico] <;> omega
  rw [hre]
  have h1 : (∑ j ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ j)) + 1 = ℓ ^ (M - 1) := sum_totient_pow hℓ M
  have hM1 : M - 1 + 1 = M := by omega
  calc ℓ ^ M + (∑ j ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ j)) + 1
      = ℓ ^ M + ((∑ j ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ j)) + 1) := by ring
    _ = ℓ ^ M + ℓ ^ (M - 1) := by rw [h1]
    _ = ℓ ^ (M - 1) * ℓ + ℓ ^ (M - 1) := by rw [← pow_succ, hM1]
    _ = (ℓ + 1) * ℓ ^ (M - 1) := by ring

/-- **補題 Q3**（report $(5.3)$）:
$$\sum_{P\in\mathbb{P}^1(\mathbb{Z}/\ell^M)}\ell^{\rho_v(P)}=(M-1)\varphi(\ell^M)+2\ell^M.$$
左辺を層ごとに（$\rho=0$ の層 $\ell^M$ 点が重み $1$、$1\le\rho\le M-1$ の層 $\varphi(\ell^{M-\rho})$ 点が
重み $\ell^\rho$、$\rho=M$ の 1 点が重み $\ell^M$）書いた形で検算する。 -/
theorem lemma_Q3 {ℓ : ℕ} (hℓ : ℓ.Prime) {M : ℕ} (hM : 1 ≤ M) :
    ℓ ^ M * 1 + (∑ ρ ∈ Finset.Ico 1 M, Nat.totient (ℓ ^ (M - ρ)) * ℓ ^ ρ) + 1 * ℓ ^ M
      = (M - 1) * Nat.totient (ℓ ^ M) + 2 * ℓ ^ M := by
  have hterm : ∀ ρ ∈ Finset.Ico 1 M,
      Nat.totient (ℓ ^ (M - ρ)) * ℓ ^ ρ = Nat.totient (ℓ ^ M) := by
    intro ρ hρ
    simp only [Finset.mem_Ico] at hρ
    exact totient_pow_mul_pow hℓ hρ.1 hρ.2
  rw [Finset.sum_congr rfl hterm, Finset.sum_const, Nat.card_Ico, smul_eq_mul]
  ring

/-- **初稿の式は偽**（report §10.1）。$\ell=2$, $M=2$ で正しい値は $10$、
初稿の $M\varphi(\ell^M)+\ell^M$ は $8$。 -/
theorem lemma_Q3_old_formula_false :
    ((2 - 1) * Nat.totient (2 ^ 2) + 2 * 2 ^ 2) ≠ (2 * Nat.totient (2 ^ 2) + 2 ^ 2) := by
  decide

/-- **主要項は変わらないこと**（report が「定理 Q1 の結論には影響しない」と書いた根拠）。
正しい式と初稿の式の差は $\ell^M-\varphi(\ell^M)=\ell^{M-1}$ であり、$O(\ell^M)$ に収まる。
すなわち $M\varphi(\ell^M)$ の主要項は共通で、定理 Q1 の $(6.1)$ の誤差の中に吸収される。 -/
theorem lemma_Q3_diff (ℓ M : ℕ) :
    (((M : ℤ) - 1) * Nat.totient (ℓ ^ M) + 2 * (ℓ : ℤ) ^ M)
      - ((M : ℤ) * Nat.totient (ℓ ^ M) + (ℓ : ℤ) ^ M)
      = (ℓ : ℤ) ^ M - Nat.totient (ℓ ^ M) := by ring

/-! ## 補題 Q5 — 悪い点は $M$ に依らず $O(1)$ 個

$\mathcal{B}_M=\{P:\beta_P+\theta_G^{\max}\ge\varphi(\ell^M)\}$。
$P\in\mathcal{B}_M$ なら $2\beta_P\ge\varphi(\ell^M)$ で、$\beta_P\le b\,\ell^{\rho_{\max}}$ だから
$2b\,\ell^{\rho_{\max}}\ge\varphi(\ell^M)=(\ell-1)\ell^{M-1}$。ここから $\rho_{\max}\ge M-c_1$ が出る。 -/

/-- **補題 Q5 の核**: $2b<(\ell-1)\ell^{c_1}$ ならば $2b\,\ell^{\rho}\ge(\ell-1)\ell^{M-1}$ から
$M-c_1\le\rho$ が従う。**狭義不等式が要ることに注意**（`lemma_Q5_needs_strict`）。 -/
theorem lemma_Q5_rho_max {ℓ b M ρ c₁ : ℕ} (hℓ : 2 ≤ ℓ)
    (hc₁ : 2 * b < (ℓ - 1) * ℓ ^ c₁)
    (h : (ℓ - 1) * ℓ ^ (M - 1) ≤ 2 * b * ℓ ^ ρ) (hM : c₁ < M) :
    M - c₁ ≤ ρ := by
  by_contra hcon
  push_neg at hcon
  have hρ : ρ ≤ M - c₁ - 1 := by omega
  have hpos : 0 < ℓ := by omega
  have hmono : ℓ ^ ρ ≤ ℓ ^ (M - c₁ - 1) := Nat.pow_le_pow_right hpos hρ
  have h1 : 2 * b * ℓ ^ ρ ≤ 2 * b * ℓ ^ (M - c₁ - 1) := Nat.mul_le_mul_left _ hmono
  have h0 : 0 < ℓ ^ (M - c₁ - 1) := pow_pos hpos _
  have h2 : 2 * b * ℓ ^ (M - c₁ - 1) < (ℓ - 1) * ℓ ^ c₁ * ℓ ^ (M - c₁ - 1) :=
    (Nat.mul_lt_mul_right h0).mpr hc₁
  have h3 : (ℓ - 1) * ℓ ^ c₁ * ℓ ^ (M - c₁ - 1) = (ℓ - 1) * ℓ ^ (M - 1) := by
    rw [mul_assoc, ← pow_add]
    congr 2
    omega
  omega

/-- **狭義でなければならない**: $2b=(\ell-1)\ell^{c_1}$ を許すと結論は偽。
反例 $\ell=2,\ b=1,\ c_1=1,\ M=3,\ \rho=1$: $2b\ell^\rho=4=(\ell-1)\ell^{M-1}$ だが
$M-c_1=2>1=\rho$。**report の $c_1$ の定義にある $+1$ はここに効いている。** -/
theorem lemma_Q5_needs_strict :
    (2 - 1) * 2 ^ (3 - 1) ≤ 2 * 1 * 2 ^ 1 ∧ 2 * 1 = (2 - 1) * 2 ^ 1 ∧ ¬ (3 - 1 ≤ 1) := by
  decide

/-- **補題 Q5 の個数評価**: 悪い点の集合が $r$ 個のファイバー（各 $\ell^{c_1}$ 点）で覆われるなら
$|\mathcal{B}_M|\le r\,\ell^{c_1}$。$M$ に依らない。 -/
theorem lemma_Q5_card {α : Type*} [DecidableEq α] (B : Finset α) (r c₁ ℓ : ℕ)
    (F : Fin r → Finset α) (hcard : ∀ i, (F i).card ≤ ℓ ^ c₁)
    (hcover : B ⊆ Finset.univ.biUnion F) :
    B.card ≤ r * ℓ ^ c₁ := by
  calc B.card ≤ (Finset.univ.biUnion F).card := Finset.card_le_card hcover
    _ ≤ ∑ i : Fin r, (F i).card := Finset.card_biUnion_le
    _ ≤ ∑ _i : Fin r, ℓ ^ c₁ := Finset.sum_le_sum (fun i _ => hcard i)
    _ = r * ℓ ^ c₁ := by simp [mul_comm]

/-! ## 定理 Q1 $(6.1)$ — 三角不等式による組み立て

report §6 の証明は次の 3 つを足す。

* $\bigl|\sum_{P\notin\mathcal{B}}\beta_P-b\,M\,\varphi\bigr|\le(3b+|\mathcal{B}|b)\ell^M$
* $0\le\sum_{P\notin\mathcal{B}}\theta_G(P)\le\theta_G^{\max}\frac{\ell+1}{\ell}\ell^{M}$
* $0\le\sum_{P\in\mathcal{B}}\hat\theta_M(P)\le|\mathcal{B}|\ell^{M}\log_\ell C_0$

これを有理数上で検算する。**$\hat\theta$ 側の上界は有限値であることを要求しており、
それには $\tilde E(\omega_P)\ne0$（補題 Q0 の仮定）が要る。**証明本文はこれを明示していない。 -/

/-- **定理 Q1 $(6.1)$ の組み立て**。3 つの部分和の評価から誤差の上界が出る。
`Bcard` は $|\mathcal{B}_M|$、`logC` は $\log_\ell C_0$、`LM` は $\ell^M$。 -/
theorem theorem_Q1_error (b Bcard θGmax logC LM Sβ SθG Shat ΘM bMφ : ℚ)
    (hLM : 0 ≤ LM) (hb : 0 ≤ b) (hBcard : 0 ≤ Bcard) (hθ : 0 ≤ θGmax) (hlog : 0 ≤ logC)
    (hΘ : ΘM = Sβ + SθG + Shat)
    (hβ : |Sβ - bMφ| ≤ (3 * b + Bcard * b) * LM)
    (hθG : 0 ≤ SθG ∧ SθG ≤ θGmax * 2 * LM)
    (hhat : 0 ≤ Shat ∧ Shat ≤ Bcard * logC * LM) :
    |ΘM - bMφ| ≤ (b * (3 + Bcard) + θGmax * 2 + Bcard * logC) * LM := by
  obtain ⟨hβ1, hβ2⟩ := abs_le.mp hβ
  obtain ⟨hg1, hg2⟩ := hθG
  obtain ⟨hh1, hh2⟩ := hhat
  have e1 : 0 ≤ θGmax * 2 * LM := by positivity
  have e2 : 0 ≤ Bcard * logC * LM := by positivity
  subst hΘ
  rw [abs_le]
  constructor <;> nlinarith [hβ1, hβ2, hg1, hg2, hh1, hh2, e1, e2]

/-- **$M$ に依らない定数へ直した形**。補題 Q5 の上界 $|\mathcal{B}_M|\le r\ell^{c_1}$ を代入すると、
$C$ から $M$ 依存が消える。**report $(6.1)$ はこの代入をせずに $|\mathcal{B}_M|$ のまま
「明示定数 $C$」と書いている。** -/
theorem theorem_Q1_error_explicit (b Bcard Bbound θGmax logC LM ΘM bMφ : ℚ)
    (hb : 0 ≤ b) (hlog : 0 ≤ logC) (hLM : 0 ≤ LM)
    (hBle : Bcard ≤ Bbound) (hB0 : 0 ≤ Bcard)
    (h : |ΘM - bMφ| ≤ (b * (3 + Bcard) + θGmax * 2 + Bcard * logC) * LM) :
    |ΘM - bMφ| ≤ (b * (3 + Bbound) + θGmax * 2 + Bbound * logC) * LM := by
  refine h.trans ?_
  gcongr

end DropBStar
end IntegrableLattice
