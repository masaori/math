# SageMath Check: 粗視化の値の一致から自由境界の分配多項式の値の等式へ

**対象ラベル**: `claim_coarse_graining_values_agree_implies_partition_values_agree`

全辺変数を正の有理数 $q$ に置く代入 $\varepsilon_{L,q}\colon\mathbb Z[X_e]\to\mathbb Q$ が
$\mathrm{ev}_q\circ\kappa_L$ に一致し、$\varepsilon_{L,q}(\mathcal Z_L)=Z_L(q)$ となることを、
箱の辺 $L=1,2$、有理点 $q\in\{1,1/2,2,3/5,7/3\}$ で厳密計算で確認する。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| $\varepsilon_{L,q}=\mathrm{ev}_q\circ\kappa_L$ | 生成元 $X_e$ と $\mathcal Z_L$ で両辺を `hom` で計算し比較 | PASS |
| $\varepsilon_{L,q}(\mathcal Z_L)=Z_L(q)$ | $\kappa_L(\mathcal Z_L)=Z_L(X)$ を経て $\mathbb Q$ の値を比較 | PASS（$L=1,2$ × 5 点） |
| 粗視化の値の一致 $\Rightarrow Z_L(q)=Z_L(q')$ | 5 点の全組で含意を検査 | PASS |

浮動小数点、実数、極限は使わない。

```sh
sage sagemath/check/coarse-graining-values-agree-implies-partition-values-agree/check.sage
```
