# SageMath Check: 有限個の添字でしか成り立たない交差べき等式は箱サイズ極限の一致に十分でない

**対象ラベル**: `claim_finitely_many_cross_power_equalities_are_not_sufficient_for_limit_quantity`

共終版の十分性（`claim_cofinal_cross_power_equality_is_sufficient_for_limit_quantity`）の仮定を、
「成り立つ添字が空でない」だけへ弱められないことを示す反例を、本文と同じ列で確認する。
交差べき等式が成り立つ添字の集合が $\{1\}$ でしかないのに、二つの乗根列の候補となる極限値が
異なることを、可算側の有限な検査で追う。

| 確かめた段 | 方法 | ステータス |
| --- | --- | --- |
| 交差べき等式が成り立つ添字の集合が $\{1\}$ であること | 各添字で $A^M$ と $B^N$ を `QQ` で厳密比較 | PASS |
| その集合が共終でないこと | $L_1\ge2$ ごとに証人が検査範囲内に無いことを確認 | PASS |
| 乗根列の一致も $L\ge2$ では成り立たないこと | `QQ` の厳密比較 | PASS |
| $a$ が定数列で候補値 $1$ との差が $0$ であること | 各添字で `QQ` の厳密比較 | PASS |
| $b$ が $L\ge2$ で定数 $2$ で候補値 $2$ との差が $0$ であること | 各添字で `QQ` の厳密比較 | PASS |
| 二つの候補値を同時に近づけられないこと | 有理な候補値ごとに幅 $1/2$ での両立不能を厳密比較 | PASS |

極限の存在と値そのものは箱の大きさの極限を使う実数側の言明なので有限検査の対象外である。
浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

```sh
sage sagemath/check/finitely-many-cross-power-equalities-are-not-sufficient-for-limit-quantity/check.sage
```

**2026-08-22 実行: すべて通過。**
