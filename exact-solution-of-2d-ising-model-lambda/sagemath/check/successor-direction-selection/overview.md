# 後続方向の辺の選択の検証

**対象ラベル**: `claim_successor_direction_selection`

辺長 1〜4 の全ての向き付き辺と方向で、本文の一意性と反転方向の除外を厳密な整数計算で照合する。

| ファイル | 検証内容 | 状態 | 結果 |
|---|---|---|---|
| `check_unique_candidate.sage` | 始点と方向から候補が一意 | PASS（2026-10-27） | 辺長 1〜4 の全組 |
| `check_reverse_exclusion.sage` | 反転方向と非後退条件の同値 | PASS（2026-10-27） | 辺長 1〜4 の全組 |
