# SageMath Check: 粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である

**対象ラベル**: `claim_partition_value_coarse_graining_is_sufficient_for_limit_quantity`

粗視化 $\pi_L(q):=\varepsilon_{L,q}(\mathcal Z_L)$ について、箱の辺 $L=1,2$ と有理点 6 点で
$\mathbb Q$ の厳密計算で確認する。極限量への移送の段は既存主張への帰着なので検査対象外。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $\pi_L(q)=Z_L(q)>0$ | 全配位の和を `QQ` で計算し `ZZ[X]` の値と比較 | PASS |
| $\pi_L(q)$ は列 $S_q$ の第 $L$ 項 $(\#V_L,\lambda(Z_L(q)))$ から $\prod_p p^{e_p}$ で復元される（粗視化であること） | 素指数データからの復元と比較 | PASS |
| $\pi_L(q)=\pi_L(q')$ ⇒ $Z_L(q)=Z_L(q')$ かつ列の項が一致 | 有理点の全対で `QQ` の等式 | PASS |

浮動小数点、実対数、指数関数、無限和、極限は使わない。

```sh
sage sagemath/check/partition-value-coarse-graining-is-sufficient-for-limit-quantity/check.sage
```

**2026-08-17 実行: すべて通過。**
