# cycle 17 / T3 Pure: $\ell$ 奇のトーラス塔（退化ケース）の数値検証

対応する証明本体: [`outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md`](../../../outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md)

前提となる証明本体:
[`cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)（仮説 6.1、式 $(6.3)$、定理 D2、定理 D1）、
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（式 $(6.1)$、補題 8.4、補題 8.5）。

## 対象

$X$ = 1 頂点 2 ループ・voltage $(1,0),(0,1)$（すなわち $\ell^n\times\ell^n$ トーラス $X_{\ell^n,\ell^n}$）。

$$D(z,w)=4-z-z^{-1}-w-w^{-1},\quad \kappa(X)=1,\quad \mu=0,\quad E=D,\quad k=2,$$
$$H=-(T^2+S^2),\quad Z_H=\{(1:c)\in\mathbb{P}^1(\mathbb{F}_\ell):c^2=-1\},\quad
z_H=\begin{cases}2&\ell\equiv1\ (4)\\0&\ell\equiv3\ (4)\\1&\ell=2\end{cases}$$

## 検証する対象ラベル（証明本体の命題）

| ラベル | 内容 | 検証する Step |
|---|---|---|
| 補題 A | $t=(1+\pi)^a-1$, $s=(1+\pi)^b-1$, $N=(t^2+s^2)+ts(t+s)$ の $\pi$ 展開係数 $A_2,A_3,A_4$ | A |
| 補題 B | 帯上（$b\equiv ca$, $c^2\equiv-1$）で $A_2\equiv A_3\equiv0$, $A_4\equiv a^4/6$ | A, D-3 |
| 定理 C（＝仮説 6.1 の証明） | $\ell\ge5$、帯上で $v_\ell(D)=4/\varphi(\ell^M)$ | B-1, B-2, D-2 |
| 補題 D | 帯外（非対角・帯外の対角）で $v_\ell(D)=2/\varphi(\ell^{\max(i,j)})$ | B-1, B-3, D-2 |
| 定理 E | $\mathrm{ord}_\ell(\kappa_n)=\dfrac{2\ell+2+2z_H}{\ell-1}(\ell^n-1)-2n$（$\ell$ 奇、$n\ge0$） | C-1, C-2 |
| 注 3.1 | 本証明は $\ell=2$ に及ばない | D-4 |
| $z_H$ の判定 | $\ell\equiv3\bmod4$ では帯が空 | D-5 |

## 手順

```
sage torus_odd_ell.sage
```

（1 回の実行に約 25 分。実行ログは `torus_odd_ell.out`、実測値の要約は `RESULTS.md`。）

外部依存は SageMath のみ。`_shared/defs.sage` は使わず、この 1 本で自己完結している
（cycle 16 の `_defs.sage` から必要な実装 — 2 段終結式による $\prod D(\zeta,\xi)$ — だけを
移植して同じ結果を再現できるようにした）。

## Step の内訳

- **Step A**（数秒）— 補題 A・補題 B を $\mathbb{Q}[a,b]$ および $\mathbb{Q}[c]/(c^2+1)$ 上の
  **厳密な多項式恒等式**として照合する。数値の代入照合ではない。
  report §3.1 の証明中で使った二項係数による表示との一致、$A_2,\dots,A_7$ の整数値性、
  および別経路（$\Xi=N/t^2$ の展開）でも同じ結論になることを確認する。
- **Step B**（大部分の実行時間）— 点ごとの付値。
  - **B-1**: レベル $M$ の対角点（$a,b$ ともに $\ell^M$ の単元）を**全列挙**し、
    $v_\ell(D)\cdot\varphi(\ell^M)$ が帯上で $4$、帯外で $2$ になることを確認する。
  - **B-2**: 深いレベル。$\mathrm{Gal}(K/\mathbb{Q})=(\mathbb{Z}/\ell^M)^\times$ が
    $(a,b)\mapsto(ua,ub)$ で作用し付値は Galois 不変なので、$a=1$ の列だけで全点を尽くす。
    **これは標本抽出ではない**（cycle 16 Step B は標本抽出だった）。
  - **B-3**: 非対角点（位数が異なる。方向は必ず $(1:0)$ か $(0:1)$ で帯の外）の全列挙。
- **Step C** — 閉形式との照合。
  - **C-1**: 点ごとの付値の実測を $(1.1)$ に従って足し上げ、定理 E の式と比べる。
  - **C-2**: 塔の全域木数を 2 段終結式で**独立に厳密計算**し、定理 E の式と比べる。
    定理 E の式にはフィットパラメータが 0 個なので、**照合は全段が out-of-sample** である。
- **Step D** — 敵対的レビュー（report §8 の 1–6 に対応）。
  - **D-2**: 双方向の判定（帯外に $4$ が無い／帯内に $2$ が無い）。
  - **D-3**: $A_4$ が帯上で消えないことを 12 個の素数について**全列挙**で確認。
  - **D-4**: $\ell=2$ に本証明を当てると壊れることの確認。
  - **D-5**: $\ell\equiv3\bmod4$ で $-1$ が非平方であることの確認。

## 付値の計算方法（なぜ厳密か）

$K=\mathbb{Q}(\zeta_{\ell^M})$ で $\ell$ は**完全分岐**し、$\ell$ の上の素イデアルはただ 1 つ、剰余次数は 1。
したがって $x\in\mathbb{Z}[\zeta_{\ell^M}]$ の全ての共役は同じ付値をもち

$$v_\ell(x)=\frac{v_\ell\bigl(N_{K/\mathbb{Q}}(x)\bigr)}{\varphi(\ell^M)},\qquad
N_{K/\mathbb{Q}}\bigl(f(\zeta)\bigr)=\mathrm{Res}\bigl(\Phi_{\ell^M},f\bigr).$$

実装はこの式をそのまま使う。整数の終結式と整数の $\ell$ 進付値だけなので、
**浮動小数も近似も現れない**。$\mathbb{R}$ へは一度も出ない。

## 限界（黙って範囲を狭めないための明示）

1. **計算の打ち切り。** 付値の計算は次数 $\varphi(\ell^M)$ の終結式、塔の値の計算は次数 $\ell^{2n}$ の
   2 段終結式で、深いところは現実的な時間で終わらない。各ループに時間上限
   （`FULL_BUDGET=240s` / `DEEP_BUDGET=300s` / `TOWER_BUDGET=600s`）を設け、
   **打ち切った計算はログ末尾の一覧に全件出力**する。実際に打ち切られた件数は `RESULTS.md` を見ること。
2. **定理 C の $M$ は証明では任意だが、数値照合が届いた $M$ には上限がある。**
   照合が届いていないことは証明の欠陥ではないが、「全ての $M$ で数値確認した」とは書かない。
3. **数値照合は証明の代用ではない。** Step A–D はすべて**証明済み命題の照合**であり、
   本 report には「数値だけで示した」主張は無い。とくに **0 件の観察（$A_4=0$ が 0 件など）は
   仮説の支持根拠ではなく、証明の照合として扱う**（cycle 6 の事故の教訓）。
4. **cycle 16 §8-3 の 3 つの穴のうち、埋まったのは「型 II の実例が無い」の 1 件だけ。**
   $\Delta\neq0$ の例と $v_\ell(\kappa(X))>0$ の例は本サイクルの対象外で、依然として 0 件である。
