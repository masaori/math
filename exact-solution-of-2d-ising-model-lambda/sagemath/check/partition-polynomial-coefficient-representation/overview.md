# SageMath Check: 分配多項式の係数は多重度である

## 対象

**対象ラベル**: `claim_configuration_partition`, `claim_coefficient_representation`
（structured-latex 側の安定識別子）

- 本文: `structured-latex/content/main-text.ts` の主張
  「配位全体は破れボンド数の値ごとに類別される」と「分配多項式の係数は多重度である」
- 併せて使う定義: `def_configuration` / `def_broken_bond_count` / `def_multiplicity` /
  `def_partition_polynomial`

### 何を確定させるための検証か

本文は分配多項式を定義どおり $Z_L=\sum_{\sigma\in\Sigma_L}x^{b(\sigma)}$ と定め、
その和を破れボンド数の値ごとに束ね直して $Z_L=\sum_{m=0}^{2L^2}\Omega_L(m)x^m$ を示す。
この検証は、その証明の各段を小さい格子で実際に数え上げて固定する。

1. 類 $A_{L,m}=\{\sigma\in\Sigma_L\mid b(\sigma)=m\}$ を総当たりで作り、
   合併が $\Sigma_L$ に一致すること（被覆）と、$m\ne m'$ で共通元を持たないこと（互いに素）を確かめる。
   本文の主張「配位全体は破れボンド数の値ごとに類別される」の被覆と互いに素性に対応する。
2. $\Omega_L(m)=|A_{L,m}|$ を確かめる（係数表示の第 5 の等号にあたる多重度の定義）。
3. 各 $m$ について、類 $A_{L,m}$ の上を走る和が $\Omega_L(m)\,x^m$ に等しいことを確かめる
   （係数表示の第 3・第 4 の等号）。
4. 定義どおりの和として作った $Z_L$ と、多重度から作った $\sum_m\Omega_L(m)x^m$ が
   多項式として一致し、係数も $m$ ごとに一致することを確かめる（係数表示の結論）。
5. 次数が破れボンド数の上界 $2L^2$ を超えないことを確かめる。

### 左辺と右辺を独立に作っていること（この検証が空にならない理由）

`_shared/defs.sage` の `partition_polynomial(L)` は本文の定義そのまま、配位ごとに
単項式 $x^{b(\sigma)}$ を足し上げて作る。多重度から作る側は別関数
`partition_polynomial_from_multiplicity(L)` に分けてある。両者は作り方が独立なので、
一致することがこの主張の内容になる。

以前は `partition_polynomial(L)` 自体が多重度ベクトルから作られていた。
その実装のままだと係数表示は構成から自明であり、この検証は何も確かめないことになる。
2026-08-08 のレビューでこれを見つけ、定義どおりの実装へ直した。

### 計算の厳密性

すべて `ZZ` / `ZZ['x']` の厳密計算で行う。**浮動小数点は使わない。**
本文がこの章で $\mathbb{R}$ へ脱出していないので、検証側にも脱出を持ち込まない。

## 実行

```sh
sage sagemath/check/partition-polynomial-coefficient-representation/check.sage
```

## 実行ステータスと結果

| 項目 | 状態 |
| --- | --- |
| 実行 | 2026-08-08 実行（SageMath, `/usr/local/bin/sage`） |
| 結果 | 全アサーション成立（$L=1,2,3$） |

出力:

| $L$ | 定義どおりの和 $\sum_\sigma x^{b(\sigma)}$ | 多重度から作った $\sum_m\Omega_L(m)x^m$ |
| --- | --- | --- |
| 1 | $2$ | $2$ |
| 2 | $2+12x^4+2x^8$ | $2+12x^4+2x^8$ |
| 3 | $2+18x^4+48x^6+198x^8+144x^{10}+102x^{12}$ | $2+18x^4+48x^6+198x^8+144x^{10}+102x^{12}$ |

奇数の $m$ で $\Omega_L(m)=0$ になるのは、1 つの頂点のスピンを反転させると破れボンド数が
偶数だけ変わるためである（本文ではまだ示していない。ここでは観察として記録するだけで、
主張としては使わない）。
