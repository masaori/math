# SageMath Check: 二色で相手写像を切り替えた写像の可逆性

**対象ラベル**: `claim_matching_pair_permutation`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙する。番号の通常の順序で合併の最小元と第一色を構成する。有限集合と整数の厳密計算だけを使い、実数体への脱出はない。有限検算は一般証明の代用ではない。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_successor_domain.sage` | 進む写像の値域 | PASS |
| `check_predecessor_domain.sage` | 戻る写像の値域 | PASS |
| `check_first_tau_color.sage` | 第一色から第一の相手の色 | PASS |
| `check_first_upsilon_color.sage` | 第一色から第二の相手の色 | PASS |
| `check_first_left_unfold.sage` | 第一色で左合成の内側 | PASS |
| `check_first_left_branch.sage` | 第一色で左合成の外側 | PASS |
| `check_first_left_cancel.sage` | 第一色で第一の対合性 | PASS |
| `check_first_right_unfold.sage` | 第一色で右合成の内側 | PASS |
| `check_first_right_branch.sage` | 第一色で右合成の外側 | PASS |
| `check_first_right_cancel.sage` | 第一色で第二の対合性 | PASS |
| `check_second_upsilon_color.sage` | 第二色から第二の相手の色 | PASS |
| `check_second_tau_color.sage` | 第二色から第一の相手の色 | PASS |
| `check_second_left_unfold.sage` | 第二色で左合成の内側 | PASS |
| `check_second_left_branch.sage` | 第二色で左合成の外側 | PASS |
| `check_second_left_cancel.sage` | 第二色で第二の対合性 | PASS |
| `check_second_right_unfold.sage` | 第二色で右合成の内側 | PASS |
| `check_second_right_branch.sage` | 第二色で右合成の外側 | PASS |
| `check_second_right_cancel.sage` | 第二色で第一の対合性 | PASS |
| `check.sage` | 行別全検算、両写像の全単射性と両合成の恒等性 | PASS |

実行方法（プロジェクト直下）: `sage sagemath/check/matching-pair-permutation/check.sage`。空集合と二つのマッチングが共有する対も含む。

実行日: 2026-10-24。行別18本が通過した。値域の2行は各1,388件、各場合の16行は各694件、計13,880確認。統合は236順序付き対・1,388始点で両写像の全単射性と両合成の恒等性が通過した。空集合1対と共有対142個を含む。
