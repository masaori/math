# SageMath Check: 行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は零元である

## 対象

**対象ラベル**: `claim_orbit_factor_zero`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_configuration` / `def_row_config_order` / `def_row_config_shift` /
  `def_row_config_orbit` / `def_row_config_orbit_set` / `def_orbit_bijection_set` /
  `def_orbit_inversion_count` / `def_orbit_permutation_sign` / `def_shift_matrix` /
  `def_characteristic_matrix` / `def_second_constant_embedding` / `def_constant_polynomial` /
  `def_orbit_term_factor`

### 何を確定させるための検証か

各軌道の因子の和 $\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)$ が
$t^{\lvert O\rvert}-1$ になることを言うには、まずこの和のうち零元でない項が
恒等写像と巡回シフトの制限の 2 つに限ることが要る。ここで確かめるのはその前半、すなわち

$$\psi(\tau_1)\ne\tau_1\ \text{かつ}\ \psi(\tau_1)\ne S(\tau_1)\ \text{を満たす}\ \tau_1\in O\ \text{があれば}\quad
W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)=\iota\bigl(\kappa(0)\bigr)$$

である。確かめるのは次の 5 つで、人手証明の式変形の段に 1 対 1 で対応する。

1. 第 1 の等号。$W_{O}(\mathrm{ch}(U),\psi)$ が定義どおり
   $\iota(\kappa(\mathrm{sgn}_{O}(\psi)))\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\psi(\tau)}$ であること。
2. 第 2 の等号。有限積から $\tau_1$ の因子を括り出せること。
3. 第 3 の等号。$\mathrm{ch}(U)_{\tau_1,\psi(\tau_1)}$ が零元であること
   （`claim_shift_char_matrix_entry_zero` を、この場面に現れる 2 元について確かめ直す）。
4. 第 4 の等号（主張そのもの）。$W_{O}(\mathrm{ch}(U),\psi)=\iota(\kappa(0))$ であること。
5. 対偶の側。仮定を満たさない $\psi$（任意の $\tau\in O$ で $\psi(\tau)$ が $\tau$ か $S(\tau)$）の
   因子は零元でないこと。**これを見ないと、すべての因子が零元でも 4 が通ってしまう。**

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | 仮定を満たす $\psi$ の件数 | 満たさない $\psi$ の件数 |
|---|---|---|---|
| 1 | 2 | 0 | 2 |
| 2 | 3 | 0 | 4 |
| 3 | 4 | 8 | 6 |
| 4 | 6 | 66 | 10 |
| 5 | 8 | 708 | 14 |
| 6 | 14 | 6470 | 26 |

**$L=1,2$ では主張は空である。** どちらも軌道の元の個数が高々 2 で、$\lvert O\rvert=2$ の軌道では
$O$ の上の全単射が 2 つしかなく、そのどちらも各点を $\tau$ か $S(\tau)$ へ送るためである
（$\lvert O\rvert=1$ でも同じ）。仮定を満たす $\psi$ が現れるのは $\lvert O\rvert\ge3$ の軌道が
現れる $L=3$ からである。空でないことは $L=3,\dots,6$ が担保している。

満たさない $\psi$ の件数が $L$ ごとに軌道の個数の 2 倍より小さいのは、$\lvert O\rvert=1$ の軌道では
恒等写像と巡回シフトの制限が同じ写像になるためである（$L=1$ の 2 個、$L=2$ の 2 個、
$L=3$ の 2 個、… がそれに当たる）。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜5 | $L=1,\dots,6$。軌道 $O$ をすべて、$O$ の上の全単射 $\psi$ を $\lvert O\rvert!$ 通りすべて |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。
$L=7$ 以上へ伸ばしていないのは本文の他の検証と範囲を揃えたためであり、計算量による打ち切りではない
（$L\le6$ では軌道の元の個数が高々 6 なので、$\psi$ の全列挙は高々 720 通りである）。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の元の相等・積、有限集合の元の相等と数え上げ、整数の積だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。定義・括り出し・成分の零元性・主張・対偶の側） |

```
sage sagemath/check/orbit-factor-zero/check.sage
```
