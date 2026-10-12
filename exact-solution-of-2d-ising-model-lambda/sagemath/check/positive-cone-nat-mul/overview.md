# SageMath Check: 正錐の元の自然数倍は零元または正錐の元である

**対象ラベル**: `claim_quadratic_positive_cone_nat_mul`

本文の場合分けを厳密計算で確認する。$s^2=2$ の二つの根と、正錐の三条件を
覆う四つの表示、零を含む自然数の代表 $c\in\{0,1,2,3,5,7\}$ について、
積 $c\cdot\xi$ の表示が $\overline{\mathbb Q}$ の通常の積に一致し（$Q_s$ への
所属の証人）、$c=0$ では値が零元・表示が $(0,0)$、$1\le c$ では $c$ 自身と積の
表示がともに正錐の条件を満たすことを確かめる。浮動小数点は使わない。

```sh
sage sagemath/check/positive-cone-nat-mul/check.sage
```

**2026-08-18 実行: すべて通過。**

## 一行ずつの対応

包含 ν: N → Q と ι: Q → Qbar を分け、本文の零の場合の十行と正の場合の六行を検査する。
既存の検算と同じ両根・正錐の三条件を覆う四つの係数対・自然数0,1,2,3,5,7を使う。
所属は有理係数の証人を評価して判定し、正錐は有理数の順序と四則で判定する。
独立な Lean 二版は同じ場合分けと中間式を持ち、導出版は正の有理数と乗法の既証導出版へ接続する。

| ファイル | 本文の行・定義の橋 | 状態 | 件数 |
|---|---|---|---|
| `check_zero_substitution.sage` | ι(ν(c))ξ=ι(ν(0_N))ξ | PASS | 8 |
| `check_natural_zero.sage` | ι(ν(0_N))ξ=ι(0_Q)ξ | PASS | 8 |
| `check_embedded_zero.sage` | ι(0_Q)ξ=0_Qbar ξ | PASS | 8 |
| `check_zero_product.sage` | 0_Qbar ξ=0_Qbar | PASS | 8 |
| `check_zero_add.sage` | 0_Qbar=0_Qbar+0_Qbar | PASS | 8 |
| `check_zero_right_product.sage` | 0_Qbar+0_Qbar=0_Qbar+(0_Qbar s) | PASS | 8 |
| `check_zero_first_embedding.sage` | 0_Qbar+(0_Qbar s)=ι(0_Q)+(0_Qbar s) | PASS | 8 |
| `check_zero_second_embedding.sage` | ι(0_Q)+(0_Qbar s)=ι(0_Q)+ι(0_Q)s | PASS | 8 |
| `check_zero_membership.sage` | 0_Qbar∈Q_s | PASS | 8 |
| `check_zero_product_membership.sage` | ι(ν(c))ξ∈Q_s（c=0） | PASS | 8 |
| `check_natural_positive.sage` | 0_N<c | PASS | 40 |
| `check_rational_positive.sage` | 0_Q<ν(c) | PASS | 40 |
| `check_coefficient_membership.sage` | ι(ν(c))∈Q_s | PASS | 40 |
| `check_coefficient_positive.sage` | ι(ν(c))∈P_s | PASS | 40 |
| `check_positive_product_membership.sage` | ι(ν(c))ξ∈Q_s（1≤c） | PASS | 40 |
| `check_positive_product.sage` | ι(ν(c))ξ∈P_s | PASS | 40 |
| `check_value_bridge.sage` | 自然数倍の表示の値=Qbarの通常の積（Leanの定義の橋） | PASS | 48 |

`check_lines.sage` は全行、各行別ファイルはその一行だけを検査する。既存の `check.sage` の48組は残す。

2026-10-12 実行: 本文十六行と値の橋の368確認、既存の48組、統合を含む全19ファイルの通常 CLI での単独起動が通過した。有限個の検算であり、一般の場合の証明は Lean 二版が担う。
