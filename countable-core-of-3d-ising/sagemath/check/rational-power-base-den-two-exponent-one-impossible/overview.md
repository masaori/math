# SageMath Check: 既約分母の 2 の指数が 1 の場合を判定する

**対象ラベル**: `claim_rational_power_base_den_two_exponent_one_impossible`

本文の法 4 による有限和の簡約、一つ下の項の消滅、素数 2 の指数、箱の点数・辺数から出る整除矛盾を、式変形の段ごとに `ZZ` の有限標本で検証した。

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_lower_terms_divisible_by_four.sage` | 最高次の二つ下までの各項が 4 で割れること | PASS | `RESULT: PASS` |
| `check_penultimate_term_vanishes.sage` | 回文性と破れ数一の多重度零から一つ下の項が消えること | PASS | `RESULT: PASS` |
| `check_partition_value_two_valuation.sage` | 法 4 で 2 なら素数 2 の指数が 1 であること | PASS | `RESULT: PASS` |
| `check_square_divisibility_contradiction.sage` | 釣り合い式から箱の一辺の長さの二乗が 1 を割る矛盾 | PASS | `RESULT: PASS` |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25。4 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/rational-power-base-den-two-exponent-one-impossible/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
