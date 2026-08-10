# SageMath Check: 軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子は単位元の加法についての逆元である

## 対象

**対象ラベル**: `claim_orbit_shift_restriction_factor`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_shift` / `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_orbit_restriction` / `def_orbit_bijection_set` / `def_orbit_permutation_sign` /
  `def_orbit_term_factor` / `def_shift_matrix` / `def_characteristic_matrix` /
  `def_second_constant_embedding` / `def_constant_polynomial` / `def_indeterminate_element`

### 何を確定させるための検証か

シフト行列の特性多項式の軌道ごとの和は、`claim_orbit_factor_zero` と
`claim_orbit_bijection_id_or_shift` により恒等写像 $\mathrm{id}_{O}$ と巡回シフトの制限
$S\!\restriction_{O}$ の 2 項に絞られている。その一方（恒等写像の側）は
`claim_orbit_identity_factor` で決めた。ここで確かめるのは残りの一方である。

$$W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)=\iota\bigl(-\kappa(1)\bigr)
\qquad(\lvert O\rvert\ge2)$$

確かめるのは次の 10 で、人手証明の段に 1 対 1 で対応する。

1. 準備の第一。$S\!\restriction_{O}$ が $O$ から $O$ への全単射であること。
2. 準備の第二。$\iota(\kappa(-1))=u$ であること（$u:=\iota(-\kappa(1))$ と置く）。
3. 準備の第三。$\lvert O\rvert\ge2$ のとき、任意の $\tau\in O$ について $S(\tau)\ne\tau$ であり、
   $\mathrm{ch}(U)_{\tau,S(\tau)}=u$ であること。
4. 準備の第四。$u\cdot u=\iota(\kappa(1))$ であり、それが $\mathbb{Z}[x][t]$ の単位元であること。
5. 鎖の第 1・第 2 の等号。因子が定義どおりであることと、$\mathrm{sgn}_{O}(S\!\restriction_{O})=(-1)^{\lvert O\rvert-1}$ であること。
6. 鎖の第 4・第 5 の等号。成分の有限積が $u^{\lvert O\rvert}$ であること。
7. 鎖の第 6・第 7 の等号。$\iota(\kappa((-1)^{\lvert O\rvert-1}))=u^{\lvert O\rvert-1}$ であること。
8. 主張そのもの。$W_{O}(\mathrm{ch}(U),S\!\restriction_{O})=\iota(-\kappa(1))$ であること。
9. 主張が空でないこと。$\lvert O\rvert\ge2$ の軌道が現れること。
10. 仮定 $\lvert O\rvert\ge2$ が外せないこと。$\lvert O\rvert=1$ の軌道では
    $S\!\restriction_{O}=\mathrm{id}_{O}$ であり、因子は $t+\iota(-\kappa(1))$ であって
    $\iota(-\kappa(1))$ ではない。**これを見ないと、仮定を落としても通るように見える。**

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

**$L=1$ では主張の仮定を満たす軌道が無く、主張は空である。** $L=1$ では $R_L$ の元が
2 つしかなく、どちらも巡回シフトで動かないためである。仮定を満たす場合が実際に現れることは
$L=2,\dots,6$ が担保している。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜10 | $L=1,\dots,6$。軌道 $O$ をすべて |

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
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備 4 つ・鎖の各段・主張・仮定が外せないこと） |

```
sage sagemath/check/orbit-shift-restriction-factor/check.sage
```
