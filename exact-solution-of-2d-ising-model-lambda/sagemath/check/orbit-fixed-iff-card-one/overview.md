# SageMath Check: 軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることは同値である

## 対象

**対象ラベル**: `claim_orbit_fixed_iff_card_one`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_configuration` / `def_row_config_shift` /
  `def_row_config_shift_iterate` / `def_row_config_shift_minimal_period` /
  `def_row_config_orbit` / `def_row_config_orbit_set`

### 何を確定させるための検証か

シフト行列の特性行列の対角成分 $\mathrm{ch}(U)_{\tau,\tau}$ を軌道ごとに決めるためである。
$U_{\tau,\tau}$ の場合分けは $\tau=S(\tau)$ か否かによっているので、それが軌道の元の個数で
判定できることが要る。ここで確かめるのは

$$O\in\mathcal{O}_L,\ \tau\in O\quad\Longrightarrow\quad
\bigl(S(\tau)=\tau\iff\lvert O\rvert=1\bigr)$$

である。確かめるのは次の 5 つで、人手証明の段に 1 対 1 で対応する。

1. 準備の第一。$\tau\in O$ のとき $O(\tau)=O$ であり、したがって $\lvert O\rvert=\lvert O(\tau)\rvert=e(\tau)$。
2. 準備の第二。$S^{[1]}(\tau)=S(\tau)$。
3. 第一の向き。$S(\tau)=\tau$ ならば $e(\tau)=1$、したがって $\lvert O\rvert=1$。
4. 第二の向き。$\lvert O\rvert=1$ ならば $S(\tau)=\tau$。
5. 主張が空でないこと。$S(\tau)=\tau$ となる $\tau$ と、そうでない $\tau$ が両方現れること。
   **これを見ないと、どちらか一方の場合しか無くても 3・4 が通ってしまう。**

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | $S(\tau)=\tau$ となる $\tau$ | そうでない $\tau$ |
|---|---|---|---|
| 1 | 2 | 2 | 0 |
| 2 | 3 | 2 | 2 |
| 3 | 4 | 2 | 6 |
| 4 | 6 | 2 | 14 |
| 5 | 8 | 2 | 30 |
| 6 | 14 | 2 | 62 |

$S(\tau)=\tau$ となる $\tau$ がどの $L$ でもちょうど 2 件なのは、巡回シフトで動かない行配位が
全ての列で $+1$ を取るものと全ての列で $-1$ を取るものの 2 つに限るためである。
**$L=1$ では第二の向きの反例側（$\lvert O\rvert\ge2$ の軌道）が現れない。** $L=1$ では
$R_L$ の元が 2 つしかなく、どちらも巡回シフトで動かないためである。
両方の場合が現れることは $L=2,\dots,6$ が担保している。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜5 | $L=1,\dots,6$。軌道 $O$ をすべて、その元 $\tau\in O$ をすべて |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。
$L=7$ 以上へ伸ばしていないのは本文の他の検証と範囲を揃えたためであり、
計算量による打ち切りではない。

### 計算の厳密性

有限集合の元の相等と数え上げ、および $\mathbb{N}$ の大小だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備 2 つ・両方の向き・場合が両方現れること） |

```
sage sagemath/check/orbit-fixed-iff-card-one/check.sage
```
