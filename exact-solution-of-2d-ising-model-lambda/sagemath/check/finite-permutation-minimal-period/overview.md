# 有限置換の正の最小周期の行別検算

**対象ラベル**: `claim_finite_permutation_positive_return`, `def_finite_permutation_minimal_period`

零から六点の全874置換・5,039始点を調べる。零点集合も含み、点のラベルは連続しない自然数である。
反復は一歩ずつ計算し、周期や反復の加法則を計算手順に使わない。各始点で零回から点の個数までの値を取り、
値の一致する相異なる添字の全組を調べる。帰還する差の選択で標本を絞らない。
最小性は正の帰還時刻について、点の個数の三倍より一大きい回数まで調べる。

| ファイル | 本文の行 | 実行状態 | 結果 |
|---|---|---|---|
| `check_values_mem.sage` | 反復値の所属 | PASS | 34,406確認 |
| `check_cardinality_definition.sage` | N は点集合の元の個数 | PASS | 5,039確認 |
| `check_collision_exists.sage` | 相異なる添字での反復値の一致 | PASS | 5,039確認 |
| `check_difference_positive.sage` | 二つの添字の正の差 | PASS | 33,231確認 |
| `check_add_difference.sage` | 差を加えると大きい添字になる | PASS | 33,231確認 |
| `check_iterate_add.sage` | 反復の加法則を逆向きに使う | PASS | 33,231確認 |
| `check_sum_substitution.sage` | r+d=t の代入 | PASS | 33,231確認 |
| `check_collision_value.sage` | 選んだ二つの反復値の一致 | PASS | 33,231確認 |
| `check_cancel_iteration.sage` | 共通の反復を単射性で取り消す | PASS | 33,231確認 |
| `check_return_set_mem.sage` | 正の帰還時刻の集合への所属 | PASS | 33,231確認 |
| `check_period_positive.sage` | 最小元の正値性 | PASS | 5,039確認 |
| `check_period_return.sage` | 最小元の帰還 | PASS | 5,039確認 |
| `check_period_minimal.sage` | 任意の正の帰還時刻との比較 | PASS | 36,756確認 |
| `check_cardinality_contradiction.sage` | 単射と仮定したときの個数の不等式 | 数値事例なし | 背理仮定を満たす標本はなく、Lean の個数比較で確認する |

実行はプロジェクト直下で `sage sagemath/check/finite-permutation-minimal-period/check.sage` とする。
各行別ファイルも通常の SageMath CLI で単独起動できる。有限標本の検算は一般の有限集合の証明を代替しない。
独立な Lean 具体版と必要十分版は、元の個数の比較、添字の大小による並べ替え、差の正値性、三等号、反復の単射性、
自然数の整列性の順で証明する。必要十分版では逆写像と全射性を使わず、有限集合上の単射自己写像へ弱める。

2026-10-12: 統合検算が通過。13行323,935確認、全874置換・5,039始点・33,231衝突を検査した。
背理仮定の下での個数の不等式には数値事例がなく、数値PASS件数に含めない。
全14行別ファイルの通常CLI単独起動も通過した（背理仮定の一行は数値事例なし）。
