# 端末行列の成分

**対象ラベル**: `claim_terminal_matrix_entries`

2026-10-04、SageMath 10.9 で行別29本と独立な行列積の検査がすべて PASS。

`def_terminal_matrix` と、その前提となる実際の端点・方向・切断線・ねじれ符号・回転位相・遷移行列も検査する。

辺長一から四、四つのスピン構造を全て列挙する。円分体の原始八乗根と多項式環だけを使い、不定元を数値へ代入しない。
整数反転行列と多項式行列の積を SageMath で独立に計算し、成分式と比較する。一辺一で二つの条件が重なる全16成分も含む。

| ファイル | 本文の操作 | 状態 | 対象数 |
|---|---|---|---|
| `check_forward_reversal_definition.sage` | 向き零で反転の定義を展開 | PASS | 60辺 |
| `check_forward_target_definition.sage` | 向き一の終点の定義を展開 | PASS | 60辺 |
| `check_forward_source_definition.sage` | 向き零の始点へ書き戻す | PASS | 60辺 |
| `check_backward_reversal_definition.sage` | 向き一で反転の定義を展開 | PASS | 60辺 |
| `check_backward_target_definition.sage` | 向き零の終点の定義を展開 | PASS | 60辺 |
| `check_backward_source_definition.sage` | 向き一の始点へ書き戻す | PASS | 60辺 |
| `check_next_definition.sage` | 後続辺の定義を展開 | PASS | 5,664対 |
| `check_next_target.sage` | 反転辺の終点を始点へ置換 | PASS | 5,664対 |
| `check_next_involution.sage` | 反転の対合性を代入 | PASS | 5,664対 |
| `check_next_symmetry.sage` | 始点の等号の向きを交換 | PASS | 5,664対 |
| `check_off_support_entry.sage` | 反転以外の整数成分を零へ置換 | PASS | 1,229,184組 |
| `check_off_support_integer_embedding.sage` | 整数の零を包含準同型で送る | PASS | 1,229,184組 |
| `check_off_support_embedding.sage` | 代数的数の零を定数多項式へ送る | PASS | 1,229,184組 |
| `check_off_support_zero.sage` | 零元との積 | PASS | 1,229,184組 |
| `check_identity_definition.sage` | 単位行列の成分を展開 | PASS | 22,656成分 |
| `check_identity_symmetry.sage` | 反転辺との等号の向きを交換 | PASS | 22,656成分 |
| `check_coefficient_transition_definition.sage` | 遷移行列の定義を展開 | PASS | 22,656成分 |
| `check_coefficient_next_condition.sage` | 後続辺の同値条件を代入 | PASS | 22,656成分 |
| `check_coefficient_map_cases.sage` | 写像を場合ごとの値へ適用 | PASS | 22,656成分 |
| `check_coefficient_map_zero.sage` | 定数多項式の零を整理 | PASS | 22,656成分 |
| `check_row_product_definition.sage` | 端末行列の積を有限和へ展開 | PASS | 22,656成分 |
| `check_row_sum_single.sage` | 有限和から零項を除く | PASS | 22,656成分 |
| `check_row_selected_entry.sage` | 反転に対応する整数成分を一へ置換 | PASS | 22,656成分 |
| `check_row_integer_unit_embedding.sage` | 整数の一を包含準同型で送る | PASS | 22,656成分 |
| `check_row_unit_embedding.sage` | 代数的数の一を定数多項式へ送る | PASS | 22,656成分 |
| `check_row_unit_product.sage` | 単位元との積 | PASS | 22,656成分 |
| `check_row_polynomial_definition.sage` | Kac--Ward 多項式行列の定義を展開 | PASS | 22,656成分 |
| `check_final_identity_substitution.sage` | 求めた単位成分を代入 | PASS | 22,656成分 |
| `check_final_coefficient_substitution.sage` | 求めた遷移成分を代入 | PASS | 22,656成分 |
| `check.sage` | 行列積と成分式の独立比較、一辺一の重複条件 | PASS | 22,656成分・16重複 |

プロジェクト直下で `sage sagemath/check/terminal-matrix-entries/check_lines.sage` を実行する。各行のファイルも同じディレクトリから単独で実行できる。
有限サイズの検算であり、任意の辺長に対する証明は本文と Lean が担う。
