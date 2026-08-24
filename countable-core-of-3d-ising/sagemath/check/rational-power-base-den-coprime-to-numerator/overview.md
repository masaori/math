# SageMath Check: 点数乗表示の底の既約分母は有理点の分子と互いに素である

**対象ラベル**: `claim_rational_power_base_den_coprime_to_num`

本文の背理法を、正の整数の有限標本について `ZZ` の整除性だけで一行ずつ確認する。

| 確かめた段 | ステータス |
| --- | --- |
| 有理点の分子と底の分母の共通素因子が、底の分母の正の冪を割ること | PASS |
| 法 $a$ の合同式を共通素因子の法へ移し、その素因子が底の分子も割ること | PASS |
| 底の分子と分母の既約性を加えると、有理点の分子と底の分母が互いに素になること | PASS |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-24（`sage check/rational-power-base-den-coprime-to-numerator/check.sage`、ALL PASS）
