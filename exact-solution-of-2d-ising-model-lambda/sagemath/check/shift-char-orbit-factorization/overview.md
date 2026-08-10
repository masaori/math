# SageMath Check: シフト行列の特性多項式は、軌道ごとに、その軌道の元の個数を指数とする冪と単位元の逆元との和を掛け合わせたものである

## 対象

**対象ラベル**: `claim_shift_char_orbit_factorization`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張 1 件
- 併せて使う定義: `def_shift_matrix` / `def_characteristic_matrix` /
  `def_characteristic_polynomial` / `def_row_config_orbit_set` / `def_orbit_bijection_set` /
  `def_orbit_term_factor` / `def_indeterminate_element` / `def_second_constant_embedding` /
  `def_constant_polynomial`
- 引く主張: `claim_shift_char_orbit_product` / `claim_orbit_sum_two_terms`

### 何を確定させるための検証か

シフト行列の特性多項式は軌道ごとの和の積であり（`claim_shift_char_orbit_product`）、
各軌道の和は $t^{\lvert O\rvert}+\iota(-\kappa(1))$ である（`claim_orbit_sum_two_terms`）。
ここで確かめるのは、その 2 つをつなぐと **$\chi_U$ が軌道ごとの因子の積として明示的に書ける**ことである。

$$
\chi_U=\prod_{O\in\mathcal{O}_L}\Bigl(t^{\lvert O\rvert}+\iota\bigl(-\kappa(1)\bigr)\Bigr)
$$

確かめるのは次の 5 で、人手証明の段に 1 対 1 で対応する（$u:=\iota(-\kappa(1))$ と書く）。

1. 鎖の第 1 段。$\chi_U=\prod_{O}a(O)$（$a(O)=\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)$）。
2. 鎖の第 2 段。各軌道について $a(O)=t^{\lvert O\rvert}+u$。
3. 第 2 段が使う事実。各因子が等しいので有限積が等しいこと。
4. 主張そのもの。
5. 主張が空虚でないこと。因子が 2 つ以上あり、かつ指数 $\lvert O\rvert$ が相異なる軌道が実際にあること。

### 主張が空虚でないことの確認

すべての軌道の元の個数が同じなら、積は 1 種類の因子の冪でしかなく、
軌道ごとに指数が変わることを確かめたことにならない。2026-08-10 の実行では、
$L=2$ 以上で指数 $\lvert O\rvert$ が 2 種類以上現れた（$L=6$ では $1,2,3,6$ の 4 種類）。

## 走らせた範囲

$L=1,\dots,6$。$\mathfrak{B}_{O}$ は全列挙している（$\lvert O\rvert\le6$ なので
$\lvert\mathfrak{B}_{O}\rvert\le720$）。

**第 1 段（$\chi_U$ を特性行列の行列式として直に計算し、軌道ごとの和の積と突き合わせる段）だけは
$L=1,\dots,5$ に絞った。** 行列の大きさが $2^{L}$ なので $L=6$ では $64$ 行 $64$ 列の
$\mathbb{Z}[x][t]$ 上の行列式になり、この検証の実行時間に収まらないためである。
$L=6$ では第 1 段（`claim_shift_char_orbit_product`。それ自体は別の検証で確かめてある）を
仮定して残りを確かめている。
本文の主張は任意の $L$ についてのものなので、有限個の $L$ で確かめたことは証明ではない。

### 計算の厳密性

$\mathbb{Z}[x][t]$ の中の等式・冪・有限積、整数の数え上げだけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-10 | すべて通過（$L=1,\dots,6$。鎖の 2 段・有限積の書き換え・主張・空虚でないこと。軌道の個数は順に 2, 3, 4, 6, 8, 14） |

```
sage sagemath/check/shift-char-orbit-factorization/check.sage
```
