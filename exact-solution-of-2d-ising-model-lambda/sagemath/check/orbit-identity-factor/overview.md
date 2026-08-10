# SageMath Check: 恒等写像の因子は、その軌道の元の個数で決まる

## 対象

**対象ラベル**: `claim_orbit_identity_factor`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_shift` / `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_orbit_bijection_set` / `def_orbit_permutation_sign` / `def_orbit_term_factor` /
  `def_shift_matrix` / `def_characteristic_matrix` / `def_second_constant_embedding` /
  `def_constant_polynomial` / `def_indeterminate_element`

### 何を確定させるための検証か

シフト行列の特性多項式の軌道ごとの和は、`claim_orbit_factor_zero` と
`claim_orbit_bijection_id_or_shift` により恒等写像 $\mathrm{id}_{O}$ と巡回シフトの制限
$S\!\restriction_{O}$ の 2 項に絞られている。ここで確かめるのはその一方、恒等写像の側の値である。

$$W_{O}\bigl(\mathrm{ch}(U),\mathrm{id}_{O}\bigr)=
\begin{cases}
t^{\lvert O\rvert} & (\lvert O\rvert\ge2)\\
t+\iota(-\kappa(1)) & (\lvert O\rvert=1)
\end{cases}$$

確かめるのは次の 8 つで、人手証明の段に 1 対 1 で対応する。

1. 準備。$O$ が空でないこと（$\lvert O\rvert\ge1$ なので 2 つの場合が場合を尽くす）と、
   $\mathrm{id}_{O}$ が $O$ から $O$ への全単射であること。
2. 共通の段の第 1 の等号。$W_{O}(\mathrm{ch}(U),\mathrm{id}_{O})$ が定義どおり
   $\iota(\kappa(\mathrm{sgn}_{O}(\mathrm{id}_{O})))\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\mathrm{id}_{O}(\tau)}$ であること。
3. 共通の段の第 2 の等号。$\mathrm{sgn}_{O}(\mathrm{id}_{O})=+1$ であること。
4. 共通の段の第 3・第 4 の等号。$\iota(\kappa(1))$ が $\mathbb{Z}[x][t]$ の単位元であり、
   $W_{O}(\mathrm{ch}(U),\mathrm{id}_{O})=\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\tau}$ であること。
5. 第一の場合。$\lvert O\rvert\ge2$ のとき対角成分がすべて $t$ であり、その有限積が
   $t^{\lvert O\rvert}$ に等しいこと。
6. 第二の場合。$\lvert O\rvert=1$ のとき $O=\{\tau_1\}$ と書けて、有限積が 1 つの因子
   $\mathrm{ch}(U)_{\tau_1,\tau_1}=t+\iota(-\kappa(1))$ に等しいこと。
7. 主張が空でないこと。$\lvert O\rvert\ge2$ の軌道と $\lvert O\rvert=1$ の軌道が両方現れること。
   **これを見ないと、どちらか一方の場合しか無くても 5・6 が通ってしまう。**
8. 2 つの場合の値が相異なること。$\lvert O\rvert=1$ を第一の場合の式で書くと $t^{1}=t$ になるが、
   実際の値は $t+\iota(-\kappa(1))$ である。すなわち場合分けは省けない。

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | $\lvert O\rvert\ge2$ の軌道 | $\lvert O\rvert=1$ の軌道 |
|---|---|---|---|
| 1 | 2 | 0 | 2 |
| 2 | 3 | 1 | 2 |
| 3 | 4 | 2 | 2 |
| 4 | 6 | 4 | 2 |
| 5 | 8 | 6 | 2 |
| 6 | 14 | 12 | 2 |

$\lvert O\rvert=1$ の軌道がどの $L$ でもちょうど 2 個なのは、巡回シフトで動かない行配位が
全ての列で $+1$ を取るものと全ての列で $-1$ を取るものの 2 つに限るためである
（`claim_orbit_fixed_iff_card_one` の検証と同じ観察）。
**$L=1$ では第一の場合が現れない。** $L=1$ では $R_L$ の元が 2 つしかなく、どちらも
巡回シフトで動かないためである。両方の場合が現れることは $L=2,\dots,6$ が担保している。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜8 | $L=1,\dots,6$。軌道 $O$ をすべて |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。
$L=7$ 以上へ伸ばしていないのは本文の他の検証と範囲を揃えたためであり、
計算量による打ち切りではない（この検証は軌道ごとに 1 つの写像しか見ないので軽い）。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式（多項式の係数の一致）、整数の冪、有限集合の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備・共通の段・2 つの場合・場合が両方現れること・場合分けが省けないこと） |

```
sage sagemath/check/orbit-identity-factor/check.sage
```
