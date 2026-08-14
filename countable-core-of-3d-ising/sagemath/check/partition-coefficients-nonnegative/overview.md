# SageMath Check: 分配多項式の係数の非負性（帰無モデル）

**対象ラベル**: `claim_partition_coefficients_nonnegative`

本文の証明の各行を、小さい箱の全数列挙で一行ずつ確かめる。すべて `ZZ`・`ZZ[X]` と
有限集合の列挙による厳密計算であり、浮動小数点は使わない。多項式 $Z_L(X)$ は
`PolynomialRing(ZZ, "X")` の元として作り、係数 $[X^m]Z_L(X)$ は多項式から取る。

| 確かめた行 | 本文のラベル | 方法 |
| --- | --- | --- |
| $[X^m]Z_L(X)=[X^m]\sum_r\Omega_L(r)X^r$ | `def_partition_polynomial` | $L=1,2$ の全 $m$ |
| $[X^m]\sum_r\Omega_L(r)X^r=\sum_r\Omega_L(r)\delta_{r,m}$（係数を取る写像の有限和に対する加法性。単項式ごとに $[X^m]\,\Omega_L(r)X^r=\Omega_L(r)\delta_{r,m}$ を確認してから足す） | — | $L=1,2$ の全 $m$ |
| $\sum_r\Omega_L(r)\delta_{r,m}=\Omega_L(m)$（$0\le m\le\#E_L$） | — | $L=1,2$ の全 $m$ |
| $\Omega_L(m)\in\mathbb N$ | `def_multiplicity`・`claim_partition_coefficients_nonnegative` | $L=1,2$ 全数列挙、$L=3$ 層転送 |

箱の選び方：$L=1$ が台の縮退（辺なし、$Z_1(X)=2$）、$L=2$ が一般の最小の場合
（$\#E_2=12$、全 13 係数）。$L=3$（配位 $2^{27}$）は全数列挙では届かないので、
層ごとの転送（`free-boundary-palindrome` の検証で $L=2$ の全数列挙との一致を
確認済みの独立な第二の方法）で多重度を厳密に数え、全 55 係数について
同じ 4 行の順で $[X^m]Z_3(X)=\Omega_3(m)\in\mathbb N$ を確認した。

```sh
sage sagemath/check/partition-coefficients-nonnegative/check.sage
```

**2026-08-14 実行: すべて通過。**
