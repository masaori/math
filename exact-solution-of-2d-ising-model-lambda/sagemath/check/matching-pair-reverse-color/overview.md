# SageMath Check: 復元したマッチング対の第一色

**対象ラベル**: `claim_matching_pair_reverse_color`

要素数 0・2・4・6 の偶数軌道だけを持つ置換から二つのマッチングを作り、元の軌道の最小元からの第一色と、復元した二歩軌道の最小元を含む第一色を比較する。有限検算は一般証明の代用ではない。

| ファイル | 本文との対応 | ステータス |
|---|---|---|
| `check_minimum.sage` | 軌道と合併の最小元の一致 | PASS |
| `check_base_color.sage` | 最小元が両方の第一色に属する | PASS |
| `check_alternation.sage` | 両色の一歩での反転 | PASS |
| `check_color_equality.sage` | 第一色の一致 | PASS |
| `check.sage` | 全条件の統合 | PASS |

有限集合と整数の厳密演算のみを使う。実数体への脱出はない。
実行日: 2026-10-24。SageMath 10.9 で 1,388 始点について通過。
