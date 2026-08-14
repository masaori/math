# SageMath Check: 分配多項式の 1 での値（帰無モデル）

**対象ラベル**: `claim_partition_value_at_one`

本文の証明の各行を、小さい箱の全数列挙で一行ずつ確かめる。すべて `ZZ`・`ZZ[X]` と
有限集合の列挙による厳密計算であり、浮動小数点は使わない。多項式 $Z_L(X)$ は
`PolynomialRing(ZZ, "X")` の元として作り、多項式とその値（$1$ での代入結果）を区別する。

| 確かめた行 | 本文のラベル | 方法 |
| --- | --- | --- |
| 破れ数はちょうど一つの $m\in\{0,\dots,\#E_L\}$ に等しく、水準集合が $\Sigma_L$ を重複なく分割する | `def_broken_count`・`def_multiplicity` | $L=1,2$ の全配位 |
| $Z_L(1)=\sum_m\Omega_L(m)1^m$（多項式への代入） | `def_partition_polynomial` | $L=1,2$ |
| $\sum_m\Omega_L(m)1^m=\sum_m\Omega_L(m)$（$1^m=1$） | — | $L=1,2$ |
| $\sum_m\Omega_L(m)=\#\Sigma_L$（分割） | `def_multiplicity` | $L=1,2$ |
| $Z_L(1)=2^{\#V_L}$ | `claim_partition_value_at_one` | $L=1,2$ 全数列挙、$L=3$ 層転送 |

箱の選び方：$L=1$ が台の縮退（辺なし、$Z_1(X)=2$）、$L=2$ が一般の最小の場合
（$\#E_2=12$、配位 $2^8$）。$L=3$（配位 $2^{27}$）は全数列挙では届かないので、
層ごとの転送（`free-boundary-palindrome` の検証で $L=2$ の全数列挙との一致を
確認済みの独立な第二の方法）で多重度を厳密に数え、$Z_3(1)=2^{27}$ を確認した。

```sh
sage sagemath/check/partition-value-at-one/check.sage
```

**2026-08-14 実行: すべて通過。**
