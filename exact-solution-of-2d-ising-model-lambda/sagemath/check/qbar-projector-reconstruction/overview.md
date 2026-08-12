# SageMath Check: 固有空間へ落とす写像から列ベクトルを復元できる

**対象ラベル**: `claim_qbar_projector_reconstruction`

$L=1,2,3,4$ について、$2^L$ 次元の代数的数を成分とする行列 $A$ と列ベクトル $v$ を作り、

$$
\sum_{z\in\mu_L}\frac1L P_{A,z}(v)=v
$$

を `QQbar` で厳密に確かめる。同時に、証明の鍵である
$\sum_{z\in\mu_L}z^{L-k}=L$ ($k=0$) および $0$ ($1\le k<L$) を各 $k$ で確かめる。
浮動小数点は使わない。

```sh
sage sagemath/check/qbar-projector-reconstruction/check.sage
```

**2026-08-12 実行: すべて通過。**
