# 射影の循環総回転数と歩ベクトルの隣接和

**対象ラベル**: `claim_plane_projection_cyclic_turning`

実際の辺番号と向きから方向を読む。辺長一から四、二つの基点、
長さ一から六の全単位歩列のうち、射影が閉じて循環して非後退となるものを検査する。
平面では閉じない周期路と、長さ一の空の内部和を含む。
整数のみの有限検算であり、一般の長さの証明は Lean が担う。

| ファイル | 対象の行 | 状態 |
|---|---|---|
| `check_direction_table.sage` | 射影の四場合と方向の同定 | PASS |
| `check_local_turn_table.sage` | 有効な十二方向対の回転数の同定 | PASS |
| `check_cyclic_definition.sage` | 循環回転数の定義の展開 | PASS |
| `check_total_definition.sage` | 総回転数の定義と零始まりへの添字変換 | PASS |
| `check_internal_substitution.sage` | 内部和への局所等式の代入 | PASS |
| `check_closing_substitution.sage` | 閉じ目への局所等式の代入 | PASS |
| `check_adjacent_definition.sage` | 循環隣接和の定義 | PASS |
| `check_whole_word.sage` | 分解によらない循環添字和による結論 | PASS |

実行: `sage sagemath/check/plane-projection-cyclic-turning/check.sage`

Lean の数値表は逆向きの対に零を割り当てて全域に拡張している。
`directionPairTurning_eq_turnValue` が有効な三回転で本文の表と一致することを保証する。
具体版は辺番号の方向表と各有限和の置換を行い、必要十分版は内部隣接対と
閉じ目の重みの一致だけを可換加法モノイドへ抽出する。

2026-10-04 実行: 方向の32例、接続の96例、循環和の各3,536例が全件通過した。
