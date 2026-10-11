# SageMath Check: 非負係数条件と負の第一係数条件の和

**対象ラベル**: `claim_quadratic_positive_add_nonnegative_negative_first`

本文の二つの場合分けを保ち、和の表示から各場合の正錐所属までを一行ずつ検査する。
有理係数は分子零から四・分母一から四の非負値とその負値から取り、仮定を満たす組だけを使う。
和の表示と正錐所属は二次体の実際の加法から正規形の係数を取り出し、生成元とその負元の両方で検査する。
`QQ` と二次体だけを用い、浮動小数点・実数体・複素数体を使わない。

| ファイル | 本文の計算行 | 状態 | 結果 |
|---|---|---|---|
| `check_sum_representation.sage` | 和の表示: `qpf_rep(xi + eta, sign) == (A, b + bp)` | PASS | 21,164件（2026-10-11） |
| `check_nonnegative_second_positive.sage` | 非負分岐の第二係数の正値性: `0 < b + bp` | PASS | 6,600件（2026-10-11） |
| `check_nonnegative_second_nonnegative.sage` | 非負分岐の第二係数の非負性: `0 <= b + bp` | PASS | 6,600件（2026-10-11） |
| `check_nonnegative_pair_nonzero.sage` | 非負分岐の表示の非零性: `(A, b + bp) != (0, 0)` | PASS | 6,600件（2026-10-11） |
| `check_nonnegative_cone_membership.sage` | 非負分岐の正錐所属: `qpf_positive_coefficient(qpf_rep(xi + eta, sign))` | PASS | 13,200件（2026-10-11） |
| `check_negative_first_sign.sage` | 負分岐の第一係数の符号: `A < 0` | PASS | 3,982件（2026-10-11） |
| `check_negative_first_zero_add.sage` | 第一係数に左零元を加える: `ap == 0 + ap` | PASS | 3,982件（2026-10-11） |
| `check_negative_first_add_order.sage` | 第一係数の加法単調性: `0 + ap <= a + ap` | PASS | 3,982件（2026-10-11） |
| `check_negative_first_name.sage` | 第一係数の和の別名: `a + ap == A` | PASS | 3,982件（2026-10-11） |
| `check_negative_first_square_right.sage` | 第一係数の負数の右乗法: `A * A <= ap * A` | PASS | 3,982件（2026-10-11） |
| `check_negative_first_square_left.sage` | 第一係数の負数の左乗法: `ap * A <= ap * ap` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_input_positive.sage` | 入力の第二係数の正値性: `0 < bp` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_zero_add.sage` | 第二係数に左零元を加える: `bp == 0 + bp` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_add_order.sage` | 第二係数の加法単調性: `0 + bp <= b + bp` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_positive.sage` | 負分岐の第二係数の正値性: `0 < b + bp` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_square_right.sage` | 第二係数の平方の右因子を固定: `bp * bp <= (b + bp) * bp` | PASS | 3,982件（2026-10-11） |
| `check_negative_second_square_left.sage` | 第二係数の平方の左因子を固定: `(b + bp) * bp <= (b + bp) * (b + bp)` | PASS | 3,982件（2026-10-11） |
| `check_negative_sum_square_bound.sage` | 第一係数の平方比較の再使用: `A * A <= ap * ap` | PASS | 3,982件（2026-10-11） |
| `check_negative_input_square_gap.sage` | 入力の負の第一係数条件: `ap * ap < 2 * (bp * bp)` | PASS | 3,982件（2026-10-11） |
| `check_negative_weighted_square.sage` | 第二係数の平方を二倍する: `2 * (bp * bp) <= 2 * ((b + bp) * (b + bp))` | PASS | 3,982件（2026-10-11） |
| `check_negative_cone_membership.sage` | 負分岐の正錐所属: `qpf_positive_coefficient(qpf_rep(xi + eta, sign))` | PASS | 7,964件（2026-10-11） |

`check.sage` は分子零から六・分母一から六の既存統合検算である。第二係数の平方を片因子ずつ比較する二行も検査する。
各ファイルは `sage <ファイル名>` で独立に実行できる。

## 実行記録

- 2026-08-14: `sage check.sage` 成功。

- 2026-10-11: 行別21本をそれぞれ `sage <ファイル名>` で実行し、全て PASS（終了コード 0）。計121,858件を確認した。既存統合検算 `check.sage` も181,700組で成功した。
