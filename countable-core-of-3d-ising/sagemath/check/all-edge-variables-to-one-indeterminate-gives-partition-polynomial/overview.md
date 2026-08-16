# SageMath Check: 多変数分配多項式の全辺変数を一つの不定元へ置くと自由境界の分配多項式になる

**対象ラベル**: `claim_all_edge_variables_to_one_indeterminate_gives_partition_polynomial`

多変数分配多項式 $\mathcal Z_L=\sum_\sigma\prod_{e\in B(\sigma)}X_e$ の全辺変数を一つの不定元 $X$ に置く
環準同型 $\kappa_L$ の像が $Z_L(X)=\sum_m\Omega_L(m)X^m$ に一致することを、箱の辺 $L=1,2$ で
$\mathbb Z[X_e]$ と $\mathbb Z[X]$ の厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $\kappa_L(\mathcal Z_L)=Z_L(X)$（証明の第一段から最終段） | `PolynomialRing(ZZ, X_e).hom([X]*n, ZZ[X])` で像を計算し多重度から作った $Z_L(X)$ と比較 | PASS（$L=1$: $2$、$L=2$: $2X^{12}+16X^9+30X^8+48X^7+64X^6+48X^5+30X^4+16X^3+2$） |
| $\kappa_L(\mathcal Z_L)=\sum_\sigma X^{m_L(\sigma)}$（$\#B(\sigma)=m_L(\sigma)$ の段） | 配位ごとの単項式の次数の和として再計算し比較 | PASS |

浮動小数点、実数、極限は使わない。

```sh
sage sagemath/check/all-edge-variables-to-one-indeterminate-gives-partition-polynomial/check.sage
```
