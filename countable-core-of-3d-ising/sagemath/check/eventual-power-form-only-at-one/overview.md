# SageMath Check: 末尾で点数乗表示が成り立つ正の有理点は 1 に限られる

**対象ラベル**: `claim_eventual_power_form_only_at_one`

本文の三段（候補の三点への絞り込み、有理点 2 分の 1 と 2 の排除、有理点 1 での逆向き）を、
実際の自由境界の箱の分配多項式と `ZZ`・`QQ` の有限標本で段ごとに検証した。

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_candidate_set_is_three_points.sage` | 絞り込みで残る正の有理点が $q\in\{1/2,1,2\}$ の三つに限られ、分母 2 の点と正の整数の点でこの三点が尽きること | PASS | `RESULT: PASS` |
| `check_one_half_and_two_are_excluded.sage` | 回文性の等式 $2^{\#E_L}Z_L(1/2)=Z_L(2)$、$Z_L(2)\equiv2\pmod4$ で 4 の可除性と両立しないこと、底の有限標本で $Z_L(1/2)$・$Z_L(2)$ がいずれも点数乗にならないこと | PASS | `RESULT: PASS` |
| `check_one_admits_the_power_form.sage` | $q=1$ では $c=2$ として $Z_L(1)=2^{\#V_L}$ が成り立ち、底が 2 に限られること | PASS | `RESULT: PASS` |

係数と有理点 2 分の 1 の値まで要る検査は全配位を列挙できる一辺 2 の箱で行う。
有理点 2 の値だけで足りる検査は層転送で一辺 3 の箱まで広げる（一辺 3 の全配位列挙は $2^{27}$ 通りで回らない）。
有理点 1 の値は層転送で一辺 4 の箱まで広げる。
底の候補は有限標本にとどめる（無限の探索はしない）。

箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-27。3 ファイルすべて `RESULT: PASS`。

実行方法: `for f in sagemath/check/eventual-power-form-only-at-one/check_*.sage; do (cd "$(dirname "$f")" && sage "$(basename "$f")"); done`
