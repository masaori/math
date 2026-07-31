# cycle 18 / T3 Pure: 一般の退化塔の数値検証

対応する証明本体: [`outputs/reports/cycle18_T3_general_degenerate_tower.md`](../../../outputs/reports/cycle18_T3_general_degenerate_tower.md)

前提となる証明本体:
[`cycle17_T3_degenerate_torus_odd_ell.md`](../../../outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md)（§6.1 が本サイクルの出発点）、
[`cycle16_T3_lower_order_and_degeneracy.md`](../../../outputs/reports/cycle16_T3_lower_order_and_degeneracy.md)（定理 N1・N2、定理 D1・D2）、
[`cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)（式 $(1.1)$、補題 8.4）。

## 対象

一般の有限連結 voltage 多重グラフ $X$（$\alpha:E\to\mathbb{Z}^2$）の $\mathbb{Z}_\ell^2$ 塔。
cycle 16・17 が扱えたのは非退化塔とトーラス塔だけで、**一般の退化塔は未解決**だった。

中心となる不変量は**消滅深度**

$$\theta(a,b):=\min\{m:\ell\nmid A_m(a,b)\},\qquad
A_m(a,b)=\sum_{(p,q)}c_{pq}\binom{p\,a+q\,b}{m}\in\mathbb{Z},$$

ここで $\tilde E=\sum c_{pq}z^pw^q$ は $E=\ell^{-\mu}\det L$ を単項式で正規化したもの。

> **記号の注意**: 論文本文 `paper_prop_G` の (G1′) にある「ずれ指数 $\delta$」とは**別の量**である。
> 記号の混同で命題 B が偽になった cycle 17 の事故を踏まえ、本サイクルは $\theta$ を使う。

## 検証する対象ラベル（証明本体の命題）

| ラベル | 内容 | 検証する Step |
|---|---|---|
| 補題 A1 | $\tilde E(g^a,g^b)=\sum_m A_m(a,b)\pi^m$、$A_m=\sum c_{pq}\binom{pa+qb}{m}\in\mathbb{Z}$ | A |
| 補題 A2 | $A_0=A_1=0$（整数として）、$m<k$ で $\ell\mid A_m$、$\bar A_k=H(a,b)$ | A, F2 |
| 補題 A3 | $m\le\ell$ で digit 安定、$m=\ell+1$ で初めて破れうる | B |
| 補題 A3p | $\ell$ 奇なら $\theta$ は偶数 | B |
| 補題 A4 | $\theta(ca,cb)=\theta(a,b)$（$\ell\nmid c$） | B |
| 系 B′ | $\theta(P)\le\ell$ なら全ての $M$ で $v_\ell(E)=\theta(P)/\varphi(\ell^{M'})$ | C |
| 定理 C | 全方向 $\theta(P)\le\ell$ なら $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+\frac{\Theta}{\ell-1}(\ell^n-1)-2n+v_\ell(\kappa_X)$ | D |
| 系 D | 非退化なら $\theta\equiv k$、$\Theta=k(\ell+1)$（cycle 16 定理 N1） | F1 |
| 系 E | $z_H\ge1$ かつ条件成立なら型 II | F4 |
| 命題 F | $\ell=2,3$ の退化塔は構造的に射程外 | E1, F3 |
| 命題 G | $\theta\ge\ell+1$ で $M$ 依存が起きうる | E2 |
| §4.4 の観察 | $\theta\ge\ell+1$ でも $M$ 依存しない例（**数値支持どまり**） | E3 |

## 手順

```bash
cd integrable-lattice/sagemath/check/cycle18_T3_general_degenerate
sage general_degenerate.sage > general_degenerate.out 2>&1
```

`_defs18.sage` は cycle 16 の `_defs.sage`（voltage グラフ、2 段終結式による塔の値、
円分体での付値）を `load` したうえで、$\pi$ 展開係数 $A_m$ と $\theta$ を追加する。
**計算の実装は cycle 16 と共有しているので、塔の値は本サイクルの理論と独立に得られている。**

## 限界（正直に記す）

- **Step D の照合段数には上限がある。** 2 段終結式の次数が $\ell^{2n}$ で増えるため、
  $\ell=3$ で $n\le3$、$\ell=5,7$ で $n\le2$、$\ell\ge11$ で $n\le1$ に留めた。
  時間上限で打ち切った計算はログ末尾に全件出力される。
- **Step B の全列挙は $\ell\le5$。** $\ell=7$ は $(u,v)\in\{0,1\}^2$ に絞った。
- **Step E1 の母集団は bouquet 2–3 ループと 2 頂点 3–4 重辺（voltage 11 種）に限られる。**
  件数はこの母集団についてのものであって、「全ての退化塔」についてではない。
- **Step E3 は観察であって照合ではない。** 定理 C の仮定を満たさない例で式が当たっているが、
  これは数値支持であって証明ではない（report §4.4 に明記）。
- Step A–D と Step E1・E2・F は証明済み命題の照合である。
