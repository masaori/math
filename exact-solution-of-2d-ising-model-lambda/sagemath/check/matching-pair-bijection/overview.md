# SageMath Check: 順序付きマッチング対と偶数軌道の置換の全単射

**対象ラベル**: `claim_matching_pair_bijection`

有限番号集合の大きさ 0・2・4・6 について、全ての順序付き不動点なし対合の対と、全軌道が偶数長の置換を厳密に列挙する。

| ファイル | 本文との対応 | ステータス |
|---|---|---|
| `check_color.sage` | 軌道の最小元で定めた二つの第一色の一致 | PASS |
| `check_left_color_rewrite.sage` | 左逆の式における第一色の置換 | PASS |
| `check_left_recovery.sage` | 第一・第二マッチングの復元を組に適用 | PASS |
| `check_left_inverse.sage` | マッチング対を置換へ移して復元した結果 | PASS |
| `check_right_inverse.sage` | 偶数軌道の置換をマッチング対へ移して復元した結果 | PASS |
| `check.sage` | 全検算の統合実行 | PASS |

自然数と有限集合の厳密演算のみを使い、実数体への脱出はない。
実行日: 2026-10-24。SageMath 10.9 で 236 対と 236 置換について通過。
