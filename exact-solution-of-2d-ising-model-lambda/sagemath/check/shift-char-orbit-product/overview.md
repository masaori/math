# SageMath Check: シフト行列の特性多項式が軌道ごとの和の積であること

## 対象

**対象ラベル**: `claim_shift_char_orbit_product`（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の章「固有値の代数性」の主張
  $\chi_U=\prod_{O\in\mathcal{O}_L}\bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)\bigr)$
- 併せて使う定義・主張: `def_permutation_sign` / `def_constant_polynomial` /
  `def_second_constant_embedding` / `def_second_determinant` / `def_characteristic_matrix` /
  `def_characteristic_polynomial` / `def_shift_matrix` / `def_row_config_shift` /
  `def_row_config_order` / `def_row_config_orbit` / `def_row_config_orbit_set` /
  `def_orbit_permutation_sign` / `def_orbit_term_factor` / `def_orbit_bijection_set` /
  `def_orbit_permutation_family` / `def_orbit_family_on_subset` /
  `claim_shift_char_sum_family` / `claim_orbit_family_distributive`

### 何を確定させるための検証か

$\chi_U$ を軌道ごとの因子の積へ組み替える道筋の最後の組み替えである。前のセクションで
分配則が任意の $s\subset\mathcal{O}_L$ について示されたので、ここでは $s=\mathcal{O}_L$ と
取って $\chi_U$ へ当てる。$2^{L}$ 個の行配位にわたる置換の全体についての和として定義された
特性多項式が、軌道ごとに閉じた和の積になる。

本文の式変形の 3 段を**別々に**確かめる。最終の等式だけを見ると、複数の段が同時に誤っていて
辻褄が合う場合を見逃す。

1. $\chi_U=\sum_{\alpha\in\mathfrak{A}_L}\prod_{O}W_{O}(\mathrm{ch}(U),\alpha(O))$
   （前セクションの主張。$\chi_U$ は $\mathfrak{S}_L$ の全列挙から定義どおりに作る）。
2. $\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$（和の添字の集合そのものが一致すること）。
   **個数の一致では足りない**ので、元の全体を突き合わせている。
3. 分配則を $s=\mathcal{O}_L$ と取った段
   （$\sum_{\alpha\in\mathfrak{A}(\mathcal{O}_L)}\prod_{O}W_{O}=\prod_{O}\sum_{\psi\in\mathfrak{B}_O}W_{O}$）。

### 主張が空でないことの確認（走らせた L ごとに記録する）

軌道ごとの和のどれか 1 つが零元なら積は零元になり、「$0=0$」を見ているだけになる。
そこで**すべての軌道について和が零元でないこと**を assert している。
2026-08-09 の実行では次のとおりであった。

| $L$ | $\lvert\mathcal{O}_L\rvert$ | $\lvert\mathfrak{A}(\mathcal{O}_L)\rvert$ | 零元でない軌道の和 | $\chi_U$ を作った項数 |
|---|---|---|---|---|
| 1 | 2 個 | 1 個 | 2 個（全部） | 2 個（$\mathfrak{S}_L$ の全列挙） |
| 2 | 3 個 | 2 個 | 3 個（全部） | 24 個 |
| 3 | 4 個 | 36 個 | 4 個（全部） | 40320 個 |
| 4 | 6 個 | 27648 個 | 6 個（全部） | 走らせていない |

$\chi_U\ne0$ も走らせたすべての $L$ で確かめている。

### 走らせた範囲（打ち切りを隠さない）

| 主張 | 走らせた範囲 |
|---|---|
| $\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$ | $L=1,2,3,4$ |
| 分配則の $s=\mathcal{O}_L$ の場合 | $L=1,2,3,4$ |
| $\chi_U$ を定義から作る段と主張そのもの | $L=1,2,3$ |

$\chi_U$ を定義から作る段が $L=3$ までなのは、$\mathfrak{S}_L$ を全列挙しているためである
（$L=3$ で $8!=40320$ 通り、$L=4$ では $16!$ 通りで走らせられない）。
$\mathfrak{S}_L$ を要さない 2 つは $L=4$ まで走らせた。

### 計算の厳密性

有限集合の元の比較と数え上げ、整数 $-1$ の冪、および $\mathbb{Z}[x][t]$ の有限和と有限積だけである。
**浮動小数点は使わない。** 本文がこの範囲で $\mathbb{R}$ へ脱出していないので、
検証側にも脱出を持ち込まない。

## 実行結果

| 実行日 | 結果 |
|---|---|
| 2026-08-09 | すべて通過（$\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L$・分配則の $s=\mathcal{O}_L$ の場合・$\chi_U$ が軌道ごとの和の積であること） |

```
sage sagemath/check/shift-char-orbit-product/check.sage
```
