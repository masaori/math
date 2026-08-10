# SageMath Check: シフト行列の特性行列の対角成分は、その軌道の元の個数で決まる

## 対象

**対象ラベル**: `claim_shift_char_diagonal_entry`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_shift` / `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_shift_matrix` / `def_characteristic_matrix` / `def_second_constant_embedding` /
  `def_constant_polynomial` / `def_indeterminate_element`

### 何を確定させるための検証か

シフト行列の特性多項式の軌道ごとの因子に現れる、恒等写像の項を計算するためである。
その項は対角成分 $\mathrm{ch}(U)_{\tau,\tau}$ の積なので、まず対角成分の値が要る。
既に示した `claim_shift_char_matrix_entry_zero` は対角成分を扱っていない。ここで確かめるのは

$$O\in\mathcal{O}_L,\ \tau\in O\quad\Longrightarrow\quad
\mathrm{ch}(U)_{\tau,\tau}=
\begin{cases}
t & (\lvert O\rvert\ge2)\\
t+\iota(-\kappa(1)) & (\lvert O\rvert=1)
\end{cases}$$

である。確かめるのは次の 5 つで、人手証明の段に 1 対 1 で対応する。

1. 準備。$\mathrm{ch}(U)_{\tau,\tau}=t+\iota(-U_{\tau,\tau})$。
2. 第一の場合。$\lvert O\rvert\ge2$ ならば $S(\tau)\ne\tau$ であり、$U_{\tau,\tau}=\kappa(0)$、
   したがって $\mathrm{ch}(U)_{\tau,\tau}=t$。
3. 第二の場合。$\lvert O\rvert=1$ ならば $S(\tau)=\tau$ であり、$U_{\tau,\tau}=\kappa(1)$、
   したがって $\mathrm{ch}(U)_{\tau,\tau}=t+\iota(-\kappa(1))$。
4. 主張が空でないこと。$\lvert O\rvert\ge2$ の $\tau$ と $\lvert O\rvert=1$ の $\tau$ が
   両方現れること。**これを見ないと、どちらか一方の場合しか無くても 2・3 が通ってしまう。**
5. 2 つの値が相異なること（場合分けが値を実際に分けていること）。

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | $\lvert O\rvert\ge2$ の $\tau$ | $\lvert O\rvert=1$ の $\tau$ |
|---|---|---|---|
| 1 | 2 | 0 | 2 |
| 2 | 3 | 2 | 2 |
| 3 | 4 | 6 | 2 |
| 4 | 6 | 14 | 2 |
| 5 | 8 | 30 | 2 |
| 6 | 14 | 62 | 2 |

$\lvert O\rvert=1$ の $\tau$ がどの $L$ でもちょうど 2 件なのは、巡回シフトで動かない行配位が
全ての列で $+1$ を取るものと全ての列で $-1$ を取るものの 2 つに限るためである。
**$L=1$ では第一の場合が現れない。** $L=1$ では $R_L$ の元が 2 つしかなく、どちらも
巡回シフトで動かないためである。両方の場合が現れることは $L=2,\dots,6$ が担保している。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜5 | $L=1,\dots,6$。軌道 $O$ をすべて、その元 $\tau\in O$ をすべて |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。
$L=7$ 以上へ伸ばしていないのは本文の他の検証と範囲を揃えたためであり、
計算量による打ち切りではない。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式（多項式の係数の一致）と有限集合の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備・2 つの場合・場合が両方現れること・2 つの値が相異なること） |

```
sage sagemath/check/shift-char-diagonal-entry/check.sage
```
