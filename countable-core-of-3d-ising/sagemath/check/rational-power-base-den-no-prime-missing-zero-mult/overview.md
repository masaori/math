# SageMath Check: 底の既約分母を割る素数の排除

**対象ラベル**: `claim_rational_power_base_den_no_prime_missing_zero_mult`

本文の背理法を、正の整数の有限標本について `ZZ` の整除性と素因子指数だけで一行ずつ確認する。

| 確かめた段 | ステータス |
| --- | --- |
| 既約な二つの分数と底の分母の素因子から、有理点と底の分子がその素数で割れないこと | PASS |
| 法 $b$ の合同式と破れ数ゼロの配位数の非整除から、その素数が整数 $P_M$ を割らないこと | PASS |
| 整数等式の両辺の素因子指数が、箱の点数と辺数を係数とする等式を与えること | PASS |
| 隣接する二箱の指数等式が正の二つの指数とは両立しないこと | PASS |

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25（`sage sagemath/check/rational-power-base-den-no-prime-missing-zero-mult/check.sage`、ALL PASS）
