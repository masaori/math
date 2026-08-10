# SageMath Check: シフト行列の特性多項式は、格子の一辺を指数とする冪と単位元の逆元との和の、軌道の個数を指数とする冪の因子である

## 対象

**対象ラベル**: `claim_shift_char_dvd_pow_L`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_shift_matrix` / `def_characteristic_matrix` /
  `def_characteristic_polynomial` / `def_row_config_orbit_set` / `def_orbit_bijection_set` /
  `def_orbit_term_factor` / `def_indeterminate_element` / `def_second_constant_embedding` /
  `def_constant_polynomial`
- 引く主張: `claim_shift_char_orbit_product` / `claim_orbit_sum_divides_pow_L` /
  `claim_prod_pair_eq_pow_card`

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの和の積であり（`claim_shift_char_orbit_product`）、
その各因子は $t^{L}+\iota(-\kappa(1))$ を割り切る（`claim_orbit_sum_divides_pow_L`）。
ここで確かめるのは、その 2 つを 2 つの有限積の積の等式（`claim_prod_pair_eq_pow_card`）で
つなぐと、**$\chi_U$ 自身が $t^{L}+\iota(-\kappa(1))$ の $\lvert\mathcal{O}_L\rvert$ 乗を
$\mathbb{Z}[x][t]$ の中で割り切る**ことである。

$$
\chi_U\cdot g=\bigl(t^{L}+\iota(-\kappa(1))\bigr)^{\lvert\mathcal{O}_L\rvert},
\qquad g=\prod_{O\in\mathcal{O}_L}b(O)
$$

確かめるのは次の 9 で、人手証明の段に 1 対 1 で対応する（$u:=\iota(-\kappa(1))$ と書く）。

1. 準備。各軌道 $O$ について $a(O)=\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)$ を全列挙で作ること。
2. 準備。各軌道について $a(O)\cdot b(O)=t^{L}+u$ を満たす $b(O)$ が取れること
   （ここでは $b(O)=\sum_{j<k}t^{\lvert O\rvert j}$ と取る）。
3. $g:=\prod_{O\in\mathcal{O}_L}b(O)$ と置くこと。
4. 鎖の第 1 段。$\chi_U\cdot g=\chi_U\cdot\prod_{O}b(O)$。
5. 鎖の第 2 段。$\chi_U=\prod_{O\in\mathcal{O}_L}a(O)$。
6. 鎖の第 3 段。$(\prod a)\cdot(\prod b)=(t^{L}+u)^{\lvert\mathcal{O}_L\rvert}$。
7. 主張そのもの。
8. 整除関係そのもの。$\mathbb{Z}[x][t]$ の中で剰余が零元であること。
9. 主張が空虚でないこと。商 $g$ が単位元でない $L$ が実際にあること。

### 主張が空虚でないことの確認

$g=1$ なら $\chi_U$ 自身が冪に等しいだけで、整除として何も確かめたことにならない。
2026-08-10 の実行では、$L=1$ では $g=1$（軌道の元の個数がすべて 1 で各 $b(O)$ が単位元）、
$L=2,\dots,6$ では $g\ne1$ であった。

## 走らせた範囲

$L=1,\dots,6$。$\mathfrak{B}_{O}$ は全列挙している（$\lvert O\rvert\le6$ なので
$\lvert\mathfrak{B}_{O}\rvert\le720$）。

**第 5 段（$\chi_U$ を特性行列の行列式として直に計算し、軌道ごとの和の積と突き合わせる段）だけは
$L=1,\dots,5$ に絞った。** 行列の大きさが $2^{L}$ なので $L=6$ では $64$ 行 $64$ 列の
$\mathbb{Z}[x][t]$ 上の行列式になり、この検証の実行時間に収まらないためである。
$L=6$ では第 5 段（`claim_shift_char_orbit_product`。それ自体は別の検証で確かめてある）を
仮定して残りを確かめている。
本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式・冪・剰余、整数の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。準備の 2 段・鎖の 3 段・主張・剰余が零元・空虚でないこと。軌道の個数は順に 2, 3, 4, 6, 8, 14） |

```
sage sagemath/check/shift-char-dvd-pow-L/check.sage
```
