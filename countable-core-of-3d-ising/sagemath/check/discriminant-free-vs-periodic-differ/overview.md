# SageMath Check: 自由族と周期族の判別式が異なる箱の辺がある

**対象ラベル**: `claim_discriminant_free_vs_periodic_differ_at_L3`（判別式の列 $L\mapsto\mathrm{disc}(Z_L)$ の
「潰れる候補」の判定に向けた有限計算。本文の主張ブロックに付いている）

自由境界の $Z_L$ と周期境界の $Z^{\mathrm{per}}_L:=\sum_m\Omega^{\mathrm{per}}_L(m)x^m$ を `ZZ[x]` で厳密に作り
（$L=2$ は全配位の列挙、$L=2,3$ は層ごとの転送行列を整数点 $x=0,\dots,\#E$ で評価して $\mathbb Q$ 上で
Lagrange 補間）、判別式を比較する。共通定義は `sagemath/_shared/defs.sage` の
`free_box_edges` / `periodic_box_edges` / `partition_polynomial_by_enumeration` /
`partition_polynomial_by_layer_transfer`。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $L=2$ で列挙と層転送が一致し $Z(1)=2^8$ | `ZZ[x]` の等式 | PASS |
| $L=2$ では周期辺が各対に二重に付くので $Z^{\mathrm{per}}_2(x)=Z_2(x^2)$、判別式はどちらも $0$（一致する） | `ZZ[x]` の等式・`discriminant()`・`is_squarefree()` | PASS（**この検査で $L=2$ は判別式が一致することが分かり、主張は $L=3$ で立てる**） |
| $L=3$ で $\mathrm{disc}(Z_3)=0$（$Z_3$ は square-free でない）、$\mathrm{disc}(Z^{\mathrm{per}}_3)\ne0$、ゆえに両者は異なる | `discriminant()`・`is_squarefree()` | PASS |
| 法 $65537$ で $Z_4$ を 145 点から補間すると次数 144 を保ち square-free である。ゆえに $\mathrm{disc}(Z_4)\ne0$ が $\mathbb Z$ 上で従う | `check_z4_mod_prime.sage`、有限体上の Lagrange 補間・`gcd(Z_4,Z'_4)=1` | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。所要は約 5 分（$L=3$ の判別式）。

```sh
sage sagemath/check/discriminant-free-vs-periodic-differ/check.sage
sage sagemath/check/discriminant-free-vs-periodic-differ/check_z4_mod_prime.sage
```

**2026-08-18 実行: すべて通過。**
