# SageMath Check: シフト行列の固有空間たちは列ベクトルの全体を張る

**対象ラベル**: `claim_qbar_eigenspaces_span`

$L=1,2,3,4$ について、$L$ 乗が単位行列になる代数的数成分の対角行列を作る。
各 $z\in\mu_L$ に対する $u_z=L^{-1}P_{A,z}(v)$ が $Au_z=zu_z$ を満たすことと、
それらの有限和が $v$ に戻ることを `QQbar` で厳密に確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/qbar-eigenspaces-span/check.sage
```

**2026-08-12 実行: すべて通過。**
