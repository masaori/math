# 有限モード和から Onsager 積分へ脱出する

## 概要

分散因子の有限積へ実対数を適用し、四つのねじれたモード和を同じ Riemann 積分へ収束させる。

## 採用する形（2026-10-09 の研究管理の決定）

前段（[四つのねじれが同じ熱力学極限を持つことを証明する](prove-twists-share-thermodynamic-limit.md)）で、全ての $q\in\mathbb Q_{(0,1)}$ について $\Lambda$ の鎖
$\log\max_{(a,b)}|Q^{a,b}_L(q)|-2\ell_2\le\Phi_L(q)\le\log\max_{(a,b)}|Q^{a,b}_L(q)|+\ell_2$ が得られ、$|Q^{a,b}_L(q)|^2=\prod_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\Delta(q;\varpi,\varsigma)$ で各因子は実閉部分体 $R$ で $>_R0$ である。ここで初めて実数体へ出る。脱出は次の三種類に限る。

1. **実対数（脱出: 実対数）。** `def_real_closed_realization` の実現写像 $\rho_R:R\to\mathbb R$ で $\Delta(q;\varpi,\varsigma)\in R$ を正の実数へ送り、実対数を取る。
   $\frac{1}{L^2}\log_{\mathbb R}|Q^{a,b}_L(q)|=\frac{1}{2L^2}\sum_{(\varpi,\varsigma)\in\mathcal U_a\times\mathcal W_b}\log_{\mathbb R}\rho_R\bigl(\Delta(q;\varpi,\varsigma)\bigr)$（実対数が積を和へ送る）。$\Phi_L(q)\in\Lambda$ の実現（`def_rational_log_order_group_realization`）との差は $L^{-2}\cdot2\log_{\mathbb R}2$ 以下。
2. **モードの角への読み替え（脱出: 指数評価）。** 1 の冪根の実現 $\zeta_{2L}\mapsto e^{\pi i/L}$ により、$\mathcal U_a$ の元 $\varpi$ は $\theta_1=2\pi(k+a/2)/L$（$k=0,\dots,L-1$）、$\mathcal W_b$ の元 $\varsigma$ は $\theta_2=2\pi(l+b/2)/L$ に対応し、$\rho_R(\varpi+\varpi^{-1})=2\cos\theta_1$、$\rho_R(\varsigma+\varsigma^{-1})=2\cos\theta_2$。
   よって和は、連続関数 $f_q(\theta_1,\theta_2):=\log\bigl[(1+q^2)^2-2q(1-q^2)(\cos\theta_1+\cos\theta_2)\bigr]$ の、$[0,2\pi]^2$ 上の格子 $\{(2\pi(k+a/2)/L,\,2\pi(l+b/2)/L)\}$ にわたる Riemann 和の $\frac12$ 倍である。$f_q$ の連続性は、被対数が $(q^2+2q-1)^2>0$ 以上であること（正値性の分解の実現）による。
3. **極限（脱出: 連続極限）。** 四つの格子は同じ周期関数の、原点を半格子ずらした Riemann 和であり、どれも同じ積分へ収束する:
   $$\lim_{L\to\infty}\frac{1}{L^2}\log_{\mathbb R}|Q^{a,b}_L(q)|=\frac{1}{2}\cdot\frac{1}{(2\pi)^2}\int_0^{2\pi}\!\!\int_0^{2\pi}f_q(\theta_1,\theta_2)\,d\theta_1\,d\theta_2\qquad((a,b)\in\mathcal S).$$
   四つの極限が同じなので $\max_{(a,b)}$ の極限も同じであり、$\Phi_L(q)/L^2$ の実現の極限、すなわち既存の密度 `def_periodic_free_energy_density_le_one`（$q\le1$）の実現がこの積分に等しい（同定は次の指示書）。

臨界点 $q=x_c$ は有理点でないので、この段では場合分けが要らない（モード $(1,1)$ の因子 $(1-2q-q^2)^2$ も $q\ne x_c$ で正）。

## 背景・前提

- 四つのねじれが同じ熱力学極限を持つことと、既存の Riemann 和・実対数の補題に依存する。
- `docs/discussion/対数順序群上の統計力学/09_2DIsing閉形式の可算的導出.md` の最終段を照合先とする。
- 着手前に対象プロジェクトの README、MEMORY、CLAUDE.md、`docs/context/` を読むこと。

## スコープ

正の物理領域での対数・連続性・Riemann 和極限を扱う。臨界点での非解析性の証明は次タスクへ分ける。

## 記号の帰属と ℝ 脱出の見込み

- 分散因子までは `Qbar`、実対数を取った値、連続関数、Riemann 積分は `R` に住む。
- `realEscape` は「実対数」「極限」「積分」の三種類を混ぜず、各ブロックで理由を宣言する。

## 作業内容

### 対数化と Riemann 和

- 因子の正値性と零点の除外を先に証明してから積の対数を和へ変換する。
- 周期・反周期の代表点が同じ連続関数の Riemann 和であることを示す。
- 端点・臨界パラメータでは必要な場合分けを行い、連続な領域での結果を先に確立する。

## 対象ファイル

- `exact-solution-of-2d-ising-model-lambda/structured-latex/content/main-text.ts`

## 完了条件

- [ ] 有限モード和から積分まで全ての極限法則と前提がラベル参照されている。
- [ ] `R` 脱出が対数・極限・積分に限定されている。
- [ ] 本文・SageMath linkage・Lean・PDF の全検証が通る。
