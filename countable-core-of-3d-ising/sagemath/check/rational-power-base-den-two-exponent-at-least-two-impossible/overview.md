# SageMath Check: 既約分母の 2 の指数が 2 以上なら矛盾する

**対象ラベル**: `claim_rational_power_base_den_two_exponent_at_least_two_impossible`

本文の法 4 による有限和の簡約、素数 2 の指数、箱の点数・辺数を入れた整除矛盾を、式変形の段ごとに `ZZ` の有限標本で検証した。

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_lower_terms_divisible_by_four.sage` | 最高次未満の各項が 4 で割れること | PASS | `RESULT: PASS` |
| `check_partition_value_mod_four.sage` | 端係数 2 と奇数の冪から分配多項式値が法 4 で 2 になること | PASS | `RESULT: PASS` |
| `check_partition_value_two_valuation.sage` | 法 4 で 2 なら素数 2 の指数が 1 であること | PASS | `RESULT: PASS` |
| `check_box_counts_balance.sage` | 点数と辺数を指数の釣り合い式へ代入すること | PASS | `RESULT: PASS` |
| `check_square_divisibility_contradiction.sage` | 両辺の差から箱の一辺の長さの二乗が 1 を割る矛盾 | PASS | `RESULT: PASS` |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25。5 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/rational-power-base-den-two-exponent-at-least-two-impossible/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
