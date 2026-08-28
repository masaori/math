# SageMath Check: どの閾値の先にもある交差冪等式の破れだけでは極限量の存在を保証しない

**対象ラベル**: `claim_tail_cross_power_failure_not_sufficient_for_limit_quantity`

本文が構成する「箱幅の偶奇で 1 と 2 に交互化する正の有理数列」について、証明の各段を
`ZZ`/`QQ` の厳密計算と有限列挙で一段ずつ確認する。

| 確かめた段 | ステータス |
| --- | --- |
| 構成が定義どおりで各項が正であること | PASS |
| 選んだ二箱が閾値以後にあり $L$ が偶数・$M$ が奇数であること | PASS |
| 選んだ二箱で交差冪等式 $A_L^{\#V_M}=A_M^{\#V_L}$ が破れること | PASS |
| 偶奇の部分列がそれぞれ定数 1 と 2 であり相異なること | PASS |
| どの閾値以後も列が一定にならないこと | PASS |

閾値は 0 から 24 まで、箱幅は 1 から 12 まで有限に走らせる。箱の大きさの極限そのもの、
浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。

実行日: 2026-08-29（`sage sagemath/check/tail-cross-power-failure-not-sufficient-for-limit-quantity/check.sage`、ALL PASS）
