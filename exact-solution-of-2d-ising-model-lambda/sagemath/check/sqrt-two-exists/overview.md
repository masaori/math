# 二の平方根の存在

**対象ラベル**: `claim_sqrt_two_exists`

2026-10-04、SageMath 10.9 で行別17本・計29等式と既存の二根の検査がすべて PASS。

`QQbar[t]` の多項式 $g=t^2+(-2)$ に対する係数の五行と、二根それぞれに対する評価の十二行を厳密に検算する。浮動小数点と根の大小は使わない。
多項式の根の存在と相異なる二根の検査は既存の `check.sage` に残す。検算と本文・Lean による証明は区別する。

| ファイル | 本文の操作 | 状態 | 対象数 |
|---|---|---|---|
| `check_coefficient_definition.sage` | 多項式の定義を展開 | PASS | 1多項式 |
| `check_coefficient_addition.sage` | 和の係数を分ける | PASS | 1多項式 |
| `check_coefficient_power.sage` | 不定元の冪の係数を代入 | PASS | 1多項式 |
| `check_coefficient_constant.sage` | 定数多項式の二次係数を代入 | PASS | 1多項式 |
| `check_coefficient_zero.sage` | 零元との和 | PASS | 1多項式 |
| `check_evaluation_factors.sage` | 不定元の評価を二因子へ代入 | PASS | 2根 |
| `check_evaluation_product.sage` | 評価が積を保つことを適用 | PASS | 2根 |
| `check_evaluation_power_one.sage` | 不定元を一乗へ書き戻す | PASS | 2根 |
| `check_evaluation_power_successor.sage` | 冪の漸化式を適用 | PASS | 2根 |
| `check_evaluation_add_zero.sage` | 零を加える | PASS | 2根 |
| `check_evaluation_inverse.sage` | 加法逆元の取消を逆向きに適用 | PASS | 2根 |
| `check_evaluation_constant.sage` | 定数の値を評価へ書き戻す | PASS | 2根 |
| `check_evaluation_association.sage` | 加法の結合則を適用 | PASS | 2根 |
| `check_evaluation_addition.sage` | 評価が和を保つことを適用 | PASS | 2根 |
| `check_evaluation_definition.sage` | 多項式の定義へ書き戻す | PASS | 2根 |
| `check_evaluation_root.sage` | 根の評価が零であることを代入 | PASS | 2根 |
| `check_evaluation_final_zero.sage` | 零元との和 | PASS | 2根 |
| `check.sage` | 非零な二次係数と根の存在、二根での評価 | PASS | 1多項式・2根 |

プロジェクト直下で `sage sagemath/check/sqrt-two-exists/check_lines.sage` を実行する。行別ファイルも同じディレクトリから単独で実行できる。
