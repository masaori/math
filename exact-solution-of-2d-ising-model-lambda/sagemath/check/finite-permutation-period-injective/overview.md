# 最小周期未満の反復回数の一意性の行別検算

**対象ラベル**: `claim_finite_permutation_period_injective`

零から六点までの全874置換・5,039始点を検査する。点のラベルは連続しない自然数とし、
反復は一歩ずつ計算する。周期は正の帰還を最初から探索し、周期による剰余計算を検算手順に使わない。

九つの行をそれぞれ一ファイルで検算する。差と反復の等式には零から点数の二倍までの添字を使う。
周期未満の不等式には `t < p`、反復値の代入・取り消し・最小性には反復値の一致をそれぞれ課す。
これは各行に必要な仮定だけを検査するものであり、背理法の仮定全体を満たす数値例ではない。
`r < t < p` と反復値の一致を同時に満たす例は無いので、最後の矛盾を数値PASSと数えない。
結論は周期未満の全ての添字対で別に検査する。有限標本は一般の証明を代替しない。

| ファイル | 本文の行 | 実行状態 | 結果 |
|---|---|---|---|
| `check_difference_positive.sage` | 差は正である | PASS | 373,837確認 |
| `check_add_difference.sage` | 差を足すと大きい添字になる | PASS | 373,837確認 |
| `check_difference_le_upper.sage` | 差は大きい添字以下である | PASS | 373,837確認 |
| `check_difference_below_period.sage` | 差は最小周期未満である | PASS | 27,866確認 |
| `check_iterate_add.sage` | 反復の加法則を逆向きに使う | PASS | 373,837確認 |
| `check_sum_substitution.sage` | 反復回数の等式を代入する | PASS | 373,837確認 |
| `check_collision_value.sage` | 反復値の一致を代入する | PASS | 137,689確認 |
| `check_cancel_iteration.sage` | 共通する反復を取り消す | PASS | 137,689確認 |
| `check_period_minimal.sage` | 帰還する正の差は最小周期以上である | PASS | 137,689確認 |
| `check_contradiction.sage` | 相反する不等式の矛盾 | 数値事例なし | Lean 二版で検証 |
| `check_interval_injective.sage` | 周期未満の全添字対で結論を検査 | PASS | 72,935確認 |

実行はプロジェクト直下で `sage sagemath/check/finite-permutation-period-injective/check.sage`。
各行別ファイルも通常 CLI で単独起動できる。Lean 具体版と必要十分版は独立に同じ差の論法を記述し、
必要十分版は有限性・全射性・逆写像・帰還の存在を仮定せず、単射性と短い正の帰還が無いという条件だけを使う。

2026-10-12: 九行と結論の計2,383,053確認が通過。全874置換・5,039始点を調べた。矛盾を扱う一行は数値事例なしとして区別した。
通常 CLI で加法則の行を単独起動し、373,837等式が通過した。Lean 三モジュールと全体ビルド、公理依存検査も通過した。
