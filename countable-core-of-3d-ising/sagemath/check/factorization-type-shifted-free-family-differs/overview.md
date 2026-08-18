# SageMath Check: ずらした自由族の既約分解の型が異なる

**対象ラベル**: `claim_shifted_free_family_factorization_type_does_not_determine_limit_quantity`
（ずらした自由族 $Z'_L:=Z_{L+1}$ について、$L=2$ で既約因子の次数と重複度の有限多重集合が
$\{(1,4),(2,2),(4,1)\}\ne\{(1,14),(40,1)\}$ と異なるのに極限量は一致する主張。この検証は
有限判定できる部分——二つの多重集合の決定と非一致——を確かめる。極限一致は既存の末尾ずらし定理）

自由境界の $Z_2,Z_3$ を層転送＋補間で `ZZ[x]` 上に厳密に作り（共通定義
`sagemath/_shared/defs.sage` の `free_box_edges` / `partition_polynomial_by_layer_transfer`）、
`QQ` 上の因数分解で既約因子の $(次数, 重複度)$ の多重集合を決定して比較する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $Z_2$ の既約分解の型は $\{(1,4),(2,2),(4,1)\}$ | `factor` / `is_irreducible` | PASS |
| $Z'_2=Z_3$ の既約分解の型は $\{(1,14),(40,1)\}$ | `factor` / `is_irreducible` | PASS |
| 二つの多重集合は異なる | 有限多重集合の比較 | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/factorization-type-shifted-free-family-differs/check.sage
```

**2026-08-18 実行: すべて通過。**
