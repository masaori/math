# SageMath Check: 有理点 2 では点数乗表示は末尾で成り立たない

**対象ラベル**: `claim_eventual_power_form_at_two_is_impossible`

本文の三段（破れ数零と一の多重度、有限和の法 4 への簡約、点数乗表示との矛盾）を、
実際の自由境界の箱の分配多項式と `ZZ` の有限標本で段ごとに検証した。

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_multiplicity_of_zero_and_one.sage` | 破れ数零の多重度が 2、破れ数一の多重度が 0 であること | PASS | `RESULT: PASS` |
| `check_partition_value_at_two_is_two_mod_four.sage` | 有限和の先頭二項を分けると残りが 4 で割れ、有限箱値が法 4 で 2 になること | PASS | `RESULT: PASS` |
| `check_power_form_contradicts_two_mod_four.sage` | 正の自然数の点数乗は奇数か 4 の倍数であり、法 4 で 2 にならないこと | PASS | `RESULT: PASS` |

係数まで要る検査は全配位を列挙できる一辺 2 の箱で行う。値だけで足りる検査は層転送で
一辺 3 の箱まで広げる（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-26。3 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/eventual-power-form-at-two-impossible/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
