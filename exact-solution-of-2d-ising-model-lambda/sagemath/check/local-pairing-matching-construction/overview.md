# 局所対合と反転対から作る完全マッチング

**対象ラベル**: `claim_local_pairing_matching_construction`

有限な向き付き辺を補辺の二向きとそれ以外に分け、前者の対合と後者の反転対合を貼り合わせる。二回適用、固定点不在、二元軌道による完全被覆、相手写像の一致を、それぞれ厳密な有限集合演算で検算する。辺長一の二つの端点番号を別の元として扱う。辺長一～三で、補辺が二辺以下の全ての場合とその全ての対合を調べる。一般の辺長についての証明は本文と Lean に置く。

| ファイル | 状態 | 結果 |
|---|---|---|
| `check_active_second_application.sage` | PASS（2026-10-25） | 選択辺の対合を二回適用すると元へ戻る |
| `check_reversal_second_application.sage` | PASS（2026-10-25） | 非選択辺の反転を二回適用すると元へ戻る |
| `check_pairing_branches.sage` | PASS（2026-10-25） | 577 件を厳密に検算 |

実行: `sage sagemath/check/local-pairing-matching-construction/check_*.sage`（各ファイルを個別に実行する）。
