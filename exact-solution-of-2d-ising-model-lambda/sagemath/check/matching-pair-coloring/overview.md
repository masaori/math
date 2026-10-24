# SageMath Check: 合併の最小元による二色付けと第一の相手による色反転

**対象ラベル**: `claim_matching_pair_coloring_alternates`

要素数 0・2・4・6 の順序付き完全マッチング対を全列挙する。順序は番号の通常の順序とし、有限番号と集合の厳密計算だけを用いる。有限検算を一般証明の代用にはしない。定義内の非空性の確認も行別に含める。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_definition_self.sage` | `i in orbit(p, i)` | PASS |
| `check_definition_component.sage` | `i in component(tau, p, i)` | PASS |
| `check_basepoint_component.sage` | `component(tau,p,j) == component(tau,p,i)` | PASS |
| `check_minimum_source_j.sage` | `minimum(tau,p,j) in component(tau,p,j)` | PASS |
| `check_minimum_transfer_j.sage` | `minimum(tau,p,j) in component(tau,p,i)` | PASS |
| `check_minimum_source_i.sage` | `minimum(tau,p,i) in component(tau,p,i)` | PASS |
| `check_minimum_transfer_i.sage` | `minimum(tau,p,i) in component(tau,p,j)` | PASS |
| `check_minimum_le_from_j.sage` | `minimum(tau,p,j) <= minimum(tau,p,i)` | PASS |
| `check_minimum_le_from_i.sage` | `minimum(tau,p,i) <= minimum(tau,p,j)` | PASS |
| `check_minimum_equal.sage` | `minimum(tau,p,j) == minimum(tau,p,i)` | PASS |
| `check_representative_member.sage` | `m in component(tau,p,i)` | PASS |
| `check_representative_component.sage` | `component(tau,p,m) == component(tau,p,i)` | PASS |
| `check_self_component.sage` | `i in component(tau,p,i)` | PASS |
| `check_self_representative_component.sage` | `i in component(tau,p,m)` | PASS |
| `check_mate_component.sage` | `tau[i] in component(tau,p,i)` | PASS |
| `check_mate_minimum.sage` | `minimum(tau,p,tau[i]) == m` | PASS |
| `check_color_unfold.sage` | `(tau[i] in color(tau,p)) == (tau[i] in orbit(p,minimum(tau,p,tau[i])))` | PASS |
| `check_color_representative.sage` | `(tau[i] in orbit(p,minimum(tau,p,tau[i]))) == (tau[i] in orbit(p,m))` | PASS |
| `check_first_exchange.sage` | `tau[i] in orbit(p,tau[m])` | PASS |
| `check_first_disjoint.sage` | `not (orbit(p,m) & orbit(p,tau[m]))` | PASS |
| `check_first_not_member.sage` | `tau[i] not in orbit(p,m)` | PASS |
| `check_first_false.sage` | `(tau[i] not in color(tau,p)) and (i in color(tau,p))` | PASS |
| `check_second_union.sage` | `i in orbit(p,tau[m])` | PASS |
| `check_second_exchange.sage` | `tau[i] in orbit(p,tau[tau[m]])` | PASS |
| `check_second_cancel.sage` | `tau[tau[m]] == m` | PASS |
| `check_second_member.sage` | `tau[i] in orbit(p,m)` | PASS |
| `check_second_true.sage` | `(tau[i] in color(tau,p)) and (i not in color(tau,p))` | PASS |
| `check.sage` | 行別全検算と色反転の同値（空集合・共有対を含む） | PASS |

実行日: 2026-10-24。行別27本が PASS。最小元の始点独立性は各6,424件、全始点の行は各1,388件、色による各場合の行は各694件で照合した。統合検算は236順序付き対・1,388始点で PASS。空集合の順序付き対1件も列挙に含む。Lean 具体版・必要十分版・導出版の対象ビルドも通過した。
