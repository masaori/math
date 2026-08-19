# SageMath Check: ずらした自由族の零点の集合が異なる

**対象ラベル**: `claim_shifted_free_family_root_set_does_not_determine_limit_quantity`
（ずらした自由族 $Z'_L:=Z_{L+1}$ について、$L=2$ で相異なる零点の有限集合が異なるのに
極限量は一致する主張。この検証は有限判定できる部分——$Z_2$ が最小多項式次数 $2$ の零点を持ち、
$Z'_2=Z_3$ の零点の最小多項式次数は $1$ か $40$ だけであること——を確かめる。
極限一致は既存の末尾ずらし定理）

自由境界の $Z_2,Z_3$ を層転送＋補間で `ZZ[x]` 上に厳密に作り（共通定義
`sagemath/_shared/defs.sage` の `free_box_edges` / `partition_polynomial_by_layer_transfer`）、
`QQ` 上の割り算・因数分解・gcd で零点集合の相違を有限判定する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $X^2+1$ が $Z_2$ を割る | `quo_rem` の剰余零 | PASS |
| $X^2+1$ は `QQ` 上既約（零点の最小多項式次数は $2$） | `is_irreducible` | PASS |
| $Z'_2=Z_3$ の相異なる既約因子の次数は $\{1,40\}$ | `factor` / `is_irreducible` | PASS |
| $\gcd(Z_3,X^2+1)=1$（$X^2+1$ の零点は $Z'_2$ の零点でない） | `gcd` | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/root-set-shifted-free-family-differs/check.sage
```

**2026-08-19 実行: すべて通過。**
