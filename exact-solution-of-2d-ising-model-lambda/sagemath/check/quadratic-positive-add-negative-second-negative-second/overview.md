# SageMath Check: 負の第二係数条件どうしの和

**対象ラベル**: `claim_quadratic_positive_add_negative_second_negative_second`

**結果**: PASS（2026-08-14）

- 二つの負の第二係数条件から交差項の平方を一段ずつ比較し、平方の大小から `2bb' < aa'` を取り出す過程を `QQ` で厳密検査する。
- 交差項を含む平方展開から、和が再び負の第二係数条件を満たすことを検査する。
- 浮動小数点は使わない。
