# SageMath Check: 分配多項式の臨界点での値は正錐の元である

**対象ラベル**: `claim_critical_partition_value_mem_positive_cone`

辺長一・二・三の全配位から多重度を数え、有理多項式の剰余で各計算行を検算する。
正錐の判定は係数対の三条件を使い、代数的数への評価は平方が二となる両根で行う。
有限例の検算であり一般命題の証明ではない。浮動小数点は使わない。
零項と正項の場合に共通する定義展開・末項分離・部分和への置換は同じ検算を使う。

| ファイル | 本文の行 | 状態 |
|---|---|---|
| `check_constant_configuration.sage` | b(σ₊)=0 | PASS |
| `check_constant_coefficient.sage` | 1≤Ω_L(0) | PASS |
| `check_critical_point.sage` | x_c∈P_s | PASS |
| `check_zero_power.sage` | x_c⁰∈P_s | PASS |
| `check_initial_term.sage` | Ω_L(0)x_c⁰∈P_s | PASS |
| `check_initial_sum_definition.sage` | S₀=Σ_{m=0}⁰ Ω_L(m)x_c^m | PASS |
| `check_initial_singleton.sage` | Σ_{m=0}⁰ Ω_L(m)x_c^m=Ω_L(0)x_c⁰ | PASS |
| `check_initial_sum_positive.sage` | S₀∈P_s | PASS |
| `check_successor_power.sage` | x_c^{n+1}∈P_s | PASS |
| `check_successor_definition.sage` | S_{n+1}=Σ_{m=0}^{n+1} Ω_L(m)x_c^m | PASS |
| `check_split_last_term.sage` | Σ_{m=0}^{n+1} Ω_L(m)x_c^m=Σ_{m=0}^n Ω_L(m)x_c^m+Ω_L(n+1)x_c^{n+1} | PASS |
| `check_partial_sum_substitution.sage` | Σ_{m=0}^n Ω_L(m)x_c^m+Ω_L(n+1)x_c^{n+1}=S_n+Ω_L(n+1)x_c^{n+1} | PASS |
| `check_zero_coefficient_substitution.sage` | S_n+Ω_L(n+1)x_c^{n+1}=S_n+0·x_c^{n+1} | PASS |
| `check_zero_product.sage` | S_n+0·x_c^{n+1}=S_n+0 | PASS |
| `check_add_zero.sage` | S_n+0=S_n | PASS |
| `check_zero_case_positive.sage` | S_n∈P_s（帰納仮定） | PASS |
| `check_positive_next_term.sage` | Ω_L(n+1)x_c^{n+1}∈P_s | PASS |
| `check_positive_sum.sage` | S_n+Ω_L(n+1)x_c^{n+1}∈P_s | PASS |
| `check_polynomial_evaluation.sage` | Z_L(x_c)=Σ_{m=0}^{2L²} Ω_L(m)x_c^m | PASS |
| `check_final_partial_sum.sage` | Σ_{m=0}^{2L²} Ω_L(m)x_c^m=S_{2L²} | PASS |
| `check_final_positive.sage` | S_{2L²}∈P_s | PASS |

2026-10-24: 行別検算21本がすべて PASS。既存の `check.sage` の両根での六組の総合検算も PASS。

```sh
for file in sagemath/check/critical-partition-value-positive-cone/check*.sage; do sage "$file"; done
```

実行時エラーの記録: 初回は Sage CLI の `__file__` が呼出元を指さず補助ファイルを読めなかった。
`sys.argv[0]` からの相対参照へ修正した。数学上の検算条件は変更していない。
