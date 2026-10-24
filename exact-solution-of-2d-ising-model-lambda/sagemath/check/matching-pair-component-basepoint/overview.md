# SageMath Check: 対になった二歩軌道の合併の始点独立性

**対象ラベル**: `claim_matching_pair_component_basepoint`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙する。有限番号と集合の厳密計算だけを用いる。有限検算を一般証明の代用にはしない。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_left_mate_membership.sage` | `tau[j] in orbit(p,tau[i])` | PASS |
| `check_left_expand.sage` | `component(tau,p,j) == orbit(p,j) \| orbit(p,tau[j])` | PASS |
| `check_left_first_basepoint.sage` | `orbit(p,j) \| orbit(p,tau[j]) == orbit(p,i) \| orbit(p,tau[j])` | PASS |
| `check_left_second_basepoint.sage` | `orbit(p,i) \| orbit(p,tau[j]) == orbit(p,i) \| orbit(p,tau[i])` | PASS |
| `check_left_fold.sage` | `orbit(p,i) \| orbit(p,tau[i]) == component(tau,p,i)` | PASS |
| `check_right_mate_membership.sage` | `tau[j] in orbit(p,tau[tau[i]])` | PASS |
| `check_right_cancel.sage` | `tau[tau[i]] == i` | PASS |
| `check_right_transfer.sage` | `tau[j] in orbit(p,i)` | PASS |
| `check_right_expand.sage` | `component(tau,p,j) == orbit(p,j) \| orbit(p,tau[j])` | PASS |
| `check_right_first_basepoint.sage` | `orbit(p,j) \| orbit(p,tau[j]) == orbit(p,tau[i]) \| orbit(p,tau[j])` | PASS |
| `check_right_second_basepoint.sage` | `orbit(p,tau[i]) \| orbit(p,tau[j]) == orbit(p,tau[i]) \| orbit(p,i)` | PASS |
| `check_right_commute.sage` | `orbit(p,tau[i]) \| orbit(p,i) == orbit(p,i) \| orbit(p,tau[i])` | PASS |
| `check_right_fold.sage` | `orbit(p,i) \| orbit(p,tau[i]) == component(tau,p,i)` | PASS |
| `check.sage` | 行別全検算と結論の照合（空集合・共有対を含む） | PASS |

実行時エラーの記録（2026-10-24）: SageMath の `__file__` が入力ファイルを指さず、共通定義の読み込みが失敗した。作業ディレクトリの祖先からプロジェクトの所在を求める形へ修正した。数学的条件は変えていない。

実行日: 2026-10-24。行別13本は各3,212件で PASS。統合検算は236順序付き対・6,424通りの始点変更で PASS。Lean 具体版・必要十分版・導出版の対象ビルドも通過した。
