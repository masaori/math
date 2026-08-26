# SageMath Check: 有理点 2 分の 1 では点数乗表示は末尾で成り立たない

**対象ラベル**: `claim_eventual_power_form_at_one_half_is_impossible`

本文の三段（回文性による有限箱の等式、辺の個数からの 4 の可除性、法 4 の矛盾）を、
実際の自由境界の箱の分配多項式と `ZZ`・`QQ` の有限標本で段ごとに検証した。

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_palindrome_relates_one_half_to_two.sage` | 回文性と有限和の添字変更で $2^{\#E_L}Z_L(1/2)=Z_L(2)$ が成り立つこと | PASS | `RESULT: PASS` |
| `check_edge_count_gives_four_divides.sage` | $\#E_L=3L^2(L-1)$ であり、$L\ge2$ なら $\#E_L\ge2$、ゆえに $4\mid2^{\#E_L}c^{L^3}$ となること | PASS | `RESULT: PASS` |
| `check_two_mod_four_contradiction.sage` | $Z_L(2)\equiv2\pmod4$ であり、4 で割り切れることと両立しないこと | PASS | `RESULT: PASS` |

係数と有理点 2 分の 1 の値まで要る検査は全配位を列挙できる一辺 2 の箱で行う。
有理点 2 の値だけで足りる検査は層転送で一辺 3 の箱まで広げる（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。
辺の個数の等式は一辺 5 の箱まで確かめる。

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-26。3 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/eventual-power-form-at-one-half-impossible/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
