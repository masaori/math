# 交互閉路による完全マッチングの符号比較

**対象ラベル**: `claim_alternating_cycle_matching_sign`

| 検証 | 内容 | 状態 |
|---|---|---|
| `check.sage` | 八点までの全完全マッチングと共通対の長短標識を列挙し、交互閉路の向き直しの符号を整数で照合 | PASS（2026-10-28、224 件。2026-11-12 再実行） |
| `check.sage`（証明の準備） | 同じ 224 件で、最小元から読んだ閉路が正の偶数長で周期で始点へ戻り重複が無いこと、閉路どうしが交わらず全活動点を覆うこと、活動点以外の点では D と基準マッチングの相手が一致しその相手も活動点でないことを照合 | PASS（2026-11-27） |

一般の有限集合への証明は本文に置く。実数体・複素数体は使わない。Lean 具体版は端点列の符号の段 `KacWard/AlternatingCycleMatchingSign.lean` と実際の交互閉路への接続の段 `KacWard/TaggedAlternatingCycleMatchingSign.lean`、必要十分版は `NecSuf/KacWard/` の同名の二ファイル（2026-11-12）。
