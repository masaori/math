# SageMath Check: 構成した置換の一歩で色が反転する

**対象ラベル**: `claim_matching_pair_successor_color`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙する。有限番号集合と整数の厳密計算だけを使い、実数体への脱出はない。有限検算は一般証明の代用ではない。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_first_successor.sage` | 第一色で写像を展開 | PASS |
| `check_first_mate_color.sage` | 第一色で第一の相手の色 | PASS |
| `check_first_result.sage` | 第一色で写像の値の色 | PASS |
| `check_second_successor.sage` | 第二色で写像を展開 | PASS |
| `check_second_mate_color.sage` | 第二色で第二の相手の色 | PASS |
| `check_second_result.sage` | 第二色で写像の値の色 | PASS |
| `check.sage` | 統合した色反転 | PASS |

実行方法（プロジェクト直下）: `sage sagemath/check/matching-pair-successor-color/check.sage`。

実行日: 2026-10-24。SageMath 10.9 で行別6本は各694件、統合は236対・1,388始点で通過した。空集合と共有対を含む。
