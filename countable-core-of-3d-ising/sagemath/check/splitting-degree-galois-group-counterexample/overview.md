# SageMath Check: 分解体の次数と Galois 群だけでは多項式を決めない

**対象ラベル**: `claim_splitting_degree_galois_group_do_not_determine_polynomial`

本文の反例（$A(X)=X-1$ と $B(X)=X-2$）の証明の各段を、$\mathbb Q$ の厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 定数係数が $-1$ と $-2$ なので $A(X)\ne B(X)$ | `QQ[X]` の係数比較 | PASS |
| $A$ の根は有理数 $1$、$B$ の根は有理数 $2$ で、どちらも $\mathbb Q$ 上で一次式へ分解する | `roots(QQ)` と重複度込みの根の個数と次数の一致 | PASS |
| どちらの分解体も $\mathbb Q$ で、次数は $[\mathbb Q:\mathbb Q]=1$ | `splitting_field` の次数 | PASS |
| どちらの Galois 群も一元群で、互いに同型 | 次数 1 の数体表示の `galois_group` の位数 | PASS |

すべて `QQ`・`QQ[X]` の厳密計算であり、浮動小数点、実対数、指数関数、無限和は使わない。

```sh
sage sagemath/check/splitting-degree-galois-group-counterexample/check.sage
```

**2026-08-15 実行: すべて通過。**
