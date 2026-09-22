# SageMath 検算: 有限反交換係数表の符号付き係数抽出

## 対象

**対象ラベル**: `claim_finite_signed_coefficient_extraction_decidable`

- 併せて検証するラベル: `claim_finite_exterior_generators_square_zero_anticommute`、`claim_finite_exterior_word_adjacent_swap_sign`、`claim_finite_exterior_basis_permutation_top_sign`、`def_finite_top_coefficient_matrix`、`claim_finite_top_coefficient_matrix_not_automatically_update`。
- 有限反交換積、有限語の隣接交換符号、全基底置換の最高次係数、有限族からの整数係数行列、零一指示行列との非対応を別々に検算する。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_generator_relations.sage` | 五元全順序集合の全一元基底について平方零、全ての相異なる順序付き二元基底対について反交換関係を検査する | PASS | 5 個の平方零と 20 個の順序付き反交換関係 |
| `check_permutation_sign.sage` | 元数一から六までの全置換について最高次係数の符号を検査し、全隣接交換について符号反転を検査する | PASS | 873 置換と 4,166 隣接交換、整数符号 `-1,1` |
| `check_top_coefficient_matrix.sage` | 三元状態集合上の九つの係数表から最高次成分を読み、指定した整数係数行列と全成分で照合する | PASS | 9 係数表・9 行列成分 |
| `check_indicator_matrix_noncorrespondence.sage` | 係数 `-1` を持つ一セル反例を、二元集合上の全四自己写像の零一指示行列と比較する | PASS | 全 4 自己写像で不一致、反例係数は `-1` |

## 範囲と限界

- 検算は明示した有限範囲を全数走査する。任意の有限全順序集合についての一般証明は構造化本文が担い、この有限検算は代用しない。
- 最高次係数行列の検算は、最高次以外にも非零成分を持つ九つの係数表を使い、抽出が最高次成分だけを読むことを確かめる。
- 零一指示行列との非対応は、構造化本文と同じ係数 `-1` の有限反例を使う。有限更新写像との比較写像や Pfaffian 表現は検算しない。
- 有限集合の列挙と整数の加法・乗法・等号比較だけを使う。対数、除算、極限、実数体、複素数体、浮動小数点は使わない。
- これは明示した有限範囲のプログラミングによる検証であり、一般命題の証明とは区別する。

## 実行方法

```bash
for file in cellular-automata-statistical-mechanics/sagemath/check/finite-signed-coefficient-extraction/check_*.sage; do sage "$file"; done
```
