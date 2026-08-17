# SageMath Check: ずらした自由族の Galois 群が非同型である

**対象ラベル**: `claim_shifted_free_family_galois_group_does_not_determine_limit_quantity`
（ずらした自由族 $Z'_L:=Z_{L+1}$ について、$L=2$ で分解体の Galois 群 $G_2$ と $G'_2=G_3$ が
同型でないのに極限量は一致する主張。この検証はそのうち有限判定できる部分——$G_2\cong C_2\times C_2$
の厳密決定と、$G_3$ の位数が 40 の倍数であること——を確かめる。極限一致は既存の末尾ずらし定理）

自由境界の $Z_2,Z_3$ を層転送＋補間で `ZZ[x]` 上に厳密に作り（共通定義
`sagemath/_shared/defs.sage` の `free_box_edges` / `partition_polynomial_by_layer_transfer`）、
`QQ` 上の因数分解・分解体・Galois 群で確かめる。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $Z_2=2(x+1)^4(x^2+1)^2(x^4-4x^3+8x^2-4x+1)$ | `ZZ[x]` の等式 | PASS |
| $Z_2$ の根基の分解体は次数 4、Galois 群は位数 4・可換・非巡回（ゆえに $C_2\times C_2$） | `splitting_field` / `galois_group` | PASS |
| $Z_3=c\,(x+1)^{14}\,g$、$g$ は既約 40 次。分解体の群は 40 個の根へ推移的に作用するので位数は 40 の倍数 | `QQ` 上の `factor` / `is_irreducible` | PASS |
| 位数 4 は 40 の倍数でないので $G_2\not\cong G_3$ | 整数の割り切り | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/galois-group-shifted-free-family-nonisomorphic/check.sage
```

**2026-08-18 実行: すべて通過。**
