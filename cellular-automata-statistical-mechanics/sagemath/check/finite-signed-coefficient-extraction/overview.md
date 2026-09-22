# SageMath 検算: 有限反交換係数表の符号付き係数抽出

## 対象

**対象ラベル**: `claim_finite_signed_coefficient_extraction_decidable`

- 併せて検証するラベル: `claim_finite_exterior_generators_square_zero_anticommute`、`claim_finite_exterior_word_adjacent_swap_sign`、`claim_finite_exterior_basis_permutation_top_sign`、`def_finite_top_coefficient_matrix`、`claim_finite_top_coefficient_matrix_not_automatically_update`、`def_finite_local_update_coefficient_factor`、`def_finite_ordered_local_factor_product`、`theorem_finite_local_factor_step_matrix_equals_update_indicator`、`claim_finite_local_factor_step_comparison_decidable`。
- 有限反交換積、有限語の隣接交換符号、全基底置換の最高次係数、有限族からの整数係数行列、零一指示行列との非対応に加え、局所係数因子、標準順序積、一段発展行列と大域更新の零一指示行列の一致、有限決定を別々に検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_generator_relations.sage` | 五元全順序集合の全一元基底について平方零、全ての相異なる順序付き二元基底対について反交換関係を検査する | PASS | 5 個の平方零と 20 個の順序付き反交換関係 |
| `check_permutation_sign.sage` | 元数一から六までの全置換について最高次係数の符号を検査し、全隣接交換について符号反転を検査する | PASS | 873 置換と 4,166 隣接交換、整数符号 `-1,1` |
| `check_top_coefficient_matrix.sage` | 三元状態集合上の九つの係数表から最高次成分を読み、指定した整数係数行列と全成分で照合する | PASS | 9 係数表・9 行列成分 |
| `check_indicator_matrix_noncorrespondence.sage` | 係数 `-1` を持つ一セル反例を、二元集合上の全四自己写像の零一指示行列と比較する | PASS | 全 4 自己写像で不一致、反例係数は `-1` |
| `check_local_update_coefficient_factor.sage` | 二セル完全近傍の全真理値表族について、局所更新等号の成立時に一元基底、非成立時に零表となることを検査する | PASS | 256 規則族・8,192 局所因子、成立 4,096・不成立 4,096 |
| `check_ordered_local_factor_product.sage` | 局所係数因子の反交換積と、零一指示値の積に標準順序単項式を掛けた明示式を照合する | PASS | 256 規則族・4,096 順序積 |
| `check_local_step_matrix_indicator.sage` | 最高次係数、局所等号の指示値積、大域更新の指示値、零一指示行列を成分ごとに照合する | PASS | 全 256 大域更新・4,096 成分、一成分 1,024・零成分 3,072 |
| `check_local_comparison_finite_decision.sage` | 一元・二元舞台の全完全近傍真理値表族を走査し、局所係数因子から有限更新行列への比較を決定する | PASS | 260 規則族・4,112 成分。一元 4、二元 256 の全自己写像 |

## 範囲と限界

- 検算は明示した有限範囲を全数走査する。任意の有限全順序集合についての一般証明は構造化本文が担い、この有限検算は代用しない。
- 最高次係数行列の検算は、最高次以外にも非零成分を持つ九つの係数表を使い、抽出が最高次成分だけを読むことを確かめる。
- 零一指示行列との非対応は、構造化本文と同じ係数 `-1` の有限反例を使う。正の比較写像は、一元・二元舞台で全セルが全舞台を見る完全近傍を取り、全ての局所真理値表族を走査する。二元舞台では全 256 自己写像を尽くすが、任意の有限舞台についての一般証明は構造化本文が担う。
- Pfaffian 表現、Rule 150、連続時間発展、連続 Lorentz 対称性は検算しない。
- 有限集合の列挙と整数の加法・乗法・等号比較だけを使う。対数、除算、極限、実数体、複素数体、浮動小数点は使わない。
- これは明示した有限範囲のプログラミングによる検証であり、一般命題の証明とは区別する。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-signed-coefficient-extraction/check_*.sage; do sage "$file"; done
```
