# SageMath Check: 非零の標識付きマッチングの完全マッチングの復元

**対象ラベル**: `claim_tagged_matching_matching_recovery`

選択辺と非選択辺の相手写像を個別に比較し、全域での一致と対の集合の一致を確認する。辺長一では長短の標識を対の二元集合と別に扱う。整数と有限集合のみを使う厳密検算であり、実数体への脱出はない。

| ファイル | 状態 | 結果 |
|---|---|---|
| `check_selected_mate.sage` | PASS（2026-10-25） | 36 件で選択辺の相手を比較。 |
| `check_outside_mate.sage` | PASS（2026-10-25） | 36 件で非選択辺の相手を比較。 |
| `check_matching_from_mates.sage` | PASS（2026-10-25） | 36 件で全域の相手写像と対の集合を比較。 |

実行: `for f in sagemath/check/tagged-matching-matching-recovery/check_*.sage; do sage "$f"; done`
