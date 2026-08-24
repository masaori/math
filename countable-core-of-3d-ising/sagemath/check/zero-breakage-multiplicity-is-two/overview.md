# SageMath Check: 破れ数ゼロの配位数

**対象ラベル**: `claim_zero_breakage_multiplicity_is_two`

本文の三段を、辺と配位を有限列挙して `ZZ` の厳密計算で確認する。

| 確かめた段 | ステータス |
| --- | --- |
| 破れ数ゼロの配位は全点で原点と同じ値を持つこと | PASS |
| 全上と全下の二つの定値配位は破れ数ゼロであること | PASS |
| 破れ数ゼロの多重度は二であり、奇素数では割り切れないこと | PASS |

箱の一辺を 1 と 2 に固定する。箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-25（`sage sagemath/check/zero-breakage-multiplicity-is-two/check.sage`、ALL PASS）
