# 端末行列と Kac--Ward 行列の行列式の一致

**対象ラベル**: `claim_terminal_matrix_determinant`

円分体 $\mathbb Q(\zeta_8)$ とその一変数多項式環で厳密計算する。行列式の全置換展開は、一辺一の反転行列と、空行列・負の定数・非単位の成分を含む四つの対照行列を使う。整数の反転行列の行列式は辺長一から五で調べる。主鎖は辺長一から三と四ねじれの十二行列で、端末行列を成分式からも独立に構成して比較する。一辺一で二つの寄与の条件が重なる場合も含む。有限例の検算であり、一般の辺長の証明は本文と Lean が担う。

実行: `sage sagemath/check/terminal-matrix-determinant/check.sage`

| 式変形 | ファイル | 状態 |
|---|---|---|
| 行指定の置換展開 | `check_lift_row_expansion.sage` | PASS |
| 成分への写像 | `check_lift_entries.sage` | PASS |
| 有限積の保存 | `check_lift_finite_product.sage` | PASS |
| 符号との積の保存 | `check_lift_multiplication.sage` | PASS |
| 有限和の保存 | `check_lift_finite_sum.sage` | PASS |
| 整数行列式への復帰 | `check_lift_integer_determinant.sage` | PASS |
| 整数行列式一の代入 | `check_lift_unit_determinant.sage` | PASS |
| 一の保存 | `check_lift_map_one.sage` | PASS |
| 端末行列の定義 | `check_terminal_definition.sage` | PASS |
| 行列式の乗法性 | `check_determinant_multiplication.sage` | PASS |
| 持ち上げた行列式一の代入 | `check_lift_unit_substitution.sage` | PASS |
| 単位元との積 | `check_one_multiplication.sage` | PASS |
| Kac--Ward 行列式の定義 | `check_kac_ward_definition.sage` | PASS |

2026-10-04 実行: 行別13本、計100等式が通過した。主鎖の十二行列は成分式による独立構成とも一致し、行列式の定数項はいずれも一だった。
