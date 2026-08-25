# SageMath Check: 点数乗表示が成り立つ正の有理点の既約分母

**対象ラベル**: `claim_rational_power_point_denominator_divides_two`

本文で既に確定した整除条件の合成を、正の整数の有限標本について `ZZ` と `QQ` だけで一段ずつ確認する。

| 確かめた段 | ステータス |
| --- | --- |
| 奇素数を素因子に持たない底の既約分母が二の冪であること | PASS |
| 二の冪でありながら二で割れない底の既約分母が一であること | PASS |
| 底の既約分母が一なら、破れ数ゼロの配位数から有理点の既約分母が二を割ること | PASS |
| 有理点の既約分母が一または二に限られること | PASS |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25（`sage sagemath/check/rational-power-point-denominator-divides-two/check.sage`、ALL PASS）
