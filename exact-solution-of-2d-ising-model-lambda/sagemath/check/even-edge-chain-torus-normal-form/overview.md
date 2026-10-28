# 有限トーラスの偶辺鎖の標準形

**対象ラベル**: `claim_even_edge_chain_torus_normal_form`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_vertical_reduction.sage` | 縦辺の消去と切断線偶奇 | PASS（2026-10-28） |
| `check_horizontal_reduction.sage` | 横辺の行ごとの消去と切断線偶奇 | PASS（2026-10-28） |
| `check_chain_reconstruction.sage` | 正方形境界と基本周回からの復元 | PASS（2026-10-28） |

辺長一から三について、正方形境界と二つの基本周回が生成する全ての偶辺鎖を整数の偶奇で照合する。これは有限検算であり、本文の一般の辺長の証明を代用しない。
