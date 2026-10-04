# 四部分列の反復二列を延ばした循環隣接和の差

**対象ラベル**: `claim_four_part_repeated_difference`

整数ベクトルの有限列を直接連結し、本文の各等式の両辺を整数で評価する。
長さ一・二の三種のベクトルによる全20,736組を反復数一・二・三で検査し、
長さ一・三・四と非単位ベクトルの243例を加える。計62,451例には空の内部和、
長さの異なる四列、正負および零の重みが含まれる。
有限検算を一般の列長の証明とは扱わない。

| ファイル | 本文の等式 | 状態 |
|---|---|---|
| `check_lift_first.sage` | 反復列の端点の同定 | PASS |
| `check_lift_last.sage` | 反復列の端点の同定 | PASS |
| `check_return_first.sage` | 反復列の端点の同定 | PASS |
| `check_return_last.sage` | 反復列の端点の同定 | PASS |
| `check_junction_lift_last.sage` | 四接合への一つの端点の代入 | PASS |
| `check_junction_return_first.sage` | 四接合への一つの端点の代入 | PASS |
| `check_junction_return_last.sage` | 四接合への一つの端点の代入 | PASS |
| `check_junction_lift_first.sage` | 四接合への一つの端点の代入 | PASS |
| `check_junction_fixed.sage` | 固定した接合和の定義 | PASS |
| `check_four_part_split.sage` | 四部分分割 | PASS |
| `check_gather_junctions.sage` | 整数の加法の並べ替え | PASS |
| `check_junction_sum_definition.sage` | 接合和の略記の定義 | PASS |
| `check_substitute_fixed_junctions.sage` | 固定した接合和の代入 | PASS |
| `check_normalize_fixed_terms.sage` | 二つの反復内部和と固定項への整理 | PASS |
| `check_difference_successor.sage` | 増やした側への表示の代入 | PASS |
| `check_difference_current.sage` | 元の側への表示の代入 | PASS |
| `check_difference_cancel.sage` | 共通項の消去 | PASS |
| `check_difference_lift.sage` | 第一列の内部和の増分 | PASS |
| `check_difference_return.sage` | 第三列の内部和の増分 | PASS |
| `check_whole_word.sage` | 独立した循環添字和による結論全体 | PASS |

実行: `sage sagemath/check/four-part-repeated-difference/check.sage`

`_prelude.sage` は各中間式を用意し、行別ファイルは隣接する二式を比較する。
`check_whole_word.sage` は内部和と接合への分割を使わず、全連結列の循環添字和を直接評価する。

2026-10-04 実行: 初回の行別18本と独立した全列の検算が、各62,451例ですべて通過した。

2026-10-04 再実行: 並べ替えと略記への置換を分けた行別19本、および独立した全列の検算が、各62,451例ですべて通過した。
