# SageMath Check: 軌道ごとの和は、軌道の元の個数を指数とする冪と、単位元の加法についての逆元との和である

## 対象

**対象ラベル**: `claim_orbit_sum_two_terms`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_row_config_shift` / `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_orbit_restriction` / `def_orbit_bijection_set` / `def_orbit_permutation_sign` /
  `def_orbit_term_factor` / `def_shift_matrix` / `def_characteristic_matrix` /
  `def_second_constant_embedding` / `def_constant_polynomial` / `def_indeterminate_element`

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの和の積である（`claim_shift_char_orbit_product`）。
その各因子の値をここで決める。

$$\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)=t^{\lvert O\rvert}+\iota\bigl(-\kappa(1)\bigr)$$

和の項のうち零元でありうるのは恒等写像 $\mathrm{id}_{O}$ と巡回シフトの制限 $S\!\restriction_{O}$ の
2 つだけであり（`claim_orbit_factor_zero` と `claim_orbit_bijection_id_or_shift`）、
その値は `claim_orbit_identity_factor` と `claim_orbit_shift_restriction_factor` で決めてある。
ここで確かめるのは、それらを足し合わせる段である。

確かめるのは次の 9 で、人手証明の段に 1 対 1 で対応する。

1. 準備の第一。$\mathrm{id}_{O}$ と $S\!\restriction_{O}$ がどちらも $\mathfrak{B}_{O}$ の元であること
   （$G:=\{\mathrm{id}_{O},S\!\restriction_{O}\}\subset\mathfrak{B}_{O}$）。
2. 準備の第二。$\psi\in\mathfrak{B}_{O}$ が $\psi\notin G$ を満たすならば
   $W_{O}(\mathrm{ch}(U),\psi)=\iota(\kappa(0))$ であり、それが $\mathbb{Z}[x][t]$ の零元であること。
3. 準備の第三。$\lvert O\rvert\ge1$ であり、$\lvert O\rvert\ge2$ と $\lvert O\rvert=1$ が
   場合を尽くして重ならないこと。
4. 共通の段。$\mathfrak{B}_{O}$ にわたる和が $G$ にわたる和に等しいこと（和の添字を狭めてよいこと）。
5. 第一の場合（$\lvert O\rvert\ge2$）。$S\!\restriction_{O}\ne\mathrm{id}_{O}$ なので $G$ は
   ちょうど 2 元であり、和が $t^{\lvert O\rvert}+u$ であること（$u:=\iota(-\kappa(1))$）。
6. 第二の場合（$\lvert O\rvert=1$）。$S\!\restriction_{O}=\mathrm{id}_{O}$ なので $G$ は
   ちょうど 1 元であり、和が $t+u=t^{\lvert O\rvert}+u$ であること。
7. 主張そのもの。
8. 和を狭める段が空虚でないこと。$G$ の外に $\mathfrak{B}_{O}$ の元が実際に存在すること。
9. 2 項が相異なる値を与えること（$\lvert O\rvert\ge2$ で $t^{\lvert O\rvert}\ne u$ であり、
   どちらか一方の項を落とすと和が変わること）。**これを見ないと、片方の項を落としても
   通るように見える。**

### 主張が空でないことの確認（走らせた $L$ ごとに記録する）

2026-08-10 の実行では次のとおりであった。

| $L$ | 軌道の個数 | $\lvert O\rvert\ge2$ の軌道 | $\lvert O\rvert=1$ の軌道 | $G$ の外の全単射の個数 |
|---|---|---|---|---|
| 1 | 2 | 0 | 2 | 0 |
| 2 | 3 | 1 | 2 | 0 |
| 3 | 4 | 2 | 2 | 8 |
| 4 | 6 | 4 | 2 | 66 |
| 5 | 8 | 6 | 2 | 708 |
| 6 | 14 | 12 | 2 | 6470 |

**$L=1,2$ では $G$ の外に $\mathfrak{B}_{O}$ の元が無い**（軌道の元の個数が高々 2 なので、
$O$ の上の全単射が 2 つ以下しかない）。したがって和を狭める段が実際に効いていることは
$L=3,\dots,6$ が担保している。$\lvert O\rvert\ge2$ の場合が現れることは $L=2,\dots,6$ が担保する。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| 上の 1〜9 | $L=1,\dots,6$。軌道 $O$ をすべて、各 $O$ について $\mathfrak{B}_{O}$（$\lvert O\rvert!$ 個）を全列挙 |

本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。
$L=7$ 以上へ伸ばしていないのは本文の他の検証と範囲を揃えたためである
（$\lvert O\rvert\le6$ なので $\lvert\mathfrak{B}_{O}\rvert\le720$ であり、計算量による打ち切りではない）。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式（多項式の係数の一致）、整数の冪、有限集合の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備 3 つ・共通の段・2 つの場合・主張・片方の項を落とせないこと） |

```
sage sagemath/check/orbit-sum-two-terms/check.sage
```
