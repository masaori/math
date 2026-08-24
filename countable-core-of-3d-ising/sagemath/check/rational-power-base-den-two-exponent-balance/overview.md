# SageMath Check: 素数 2 の指数の釣り合い式

**対象ラベル**: `claim_rational_power_base_den_two_exponent_balance`

本文の整数等式を満たす正整数の有限標本について、式変形の各等号を別々のファイルで `ZZ` の素因子指数として検証した。

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_denominator_and_numerator_parity.sage` | 既約性と分母の素因子条件から得る 2 に関する整除・非整除 | PASS |
| `check_left_power_valuation.sage` | 左辺の冪の指数法則 | PASS |
| `check_left_product_valuation.sage` | 左辺の積の指数法則 | PASS |
| `check_integer_equality_valuation.sage` | 整数等式による両辺の指数の一致 | PASS |
| `check_right_product_valuation.sage` | 右辺の積の指数法則 | PASS |
| `check_right_power_valuation.sage` | 右辺の冪の指数法則 | PASS |
| `check_zero_numerator_valuation.sage` | $2\nmid u$ による項の消去と最終的な釣り合い式 | PASS |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25。7 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/rational-power-base-den-two-exponent-balance/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
