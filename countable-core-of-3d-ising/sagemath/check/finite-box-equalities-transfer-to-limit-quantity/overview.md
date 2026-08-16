# SageMath Check: 有限箱の等式の族は極限量の等式へ渡る

**対象ラベル**: `claim_finite_box_equalities_transfer_to_limit_quantity`

証明の可算側の段（有限箱の等式から有限箱の列の一致まで）を、箱の辺 $L=1,2$ と、
仮定 $Z_L(q)=Z_L(q')$ を満たす有理点の対 3 組（同じ有理数の異なる表示）で、$\mathbb Q$ の厳密計算で確認する。
最終段（列の一致から極限量の一致）は実数の極限であり、`claim_limit_quantity_depends_only_on_finite_box_sequence` への帰着なので検査対象外。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 仮定 $Z_L(q)=Z_L(q')$ が正の有理数の等式として成り立つ | `ZZ[X]` の分配多項式を `QQ` の点で評価 | PASS |
| 素指数データ $\lambda$ は写像なので $\lambda(Z_L(q))=\lambda(Z_L(q'))$ | 分子分母の素因数分解の有限台の整数列を比較 | PASS |
| $\#V_L$ は $q$ によらず、列の項 $(\#V_L,\lambda(Z_L(q)))$ が一致する | 組の等式 | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/finite-box-equalities-transfer-to-limit-quantity/check.sage
```

**2026-08-16 実行: すべて通過。**
