# SageMath Check: 第一の相手写像による二歩軌道の交換

**対象ラベル**: `claim_matching_pair_orbit_exchange`

有限番号集合の要素数 0・2・4・6 の順序付き完全マッチング対236組・始点1,388個を厳密列挙する。反復回数は0〜12。浮動小数点は使わない。有限検算は一般証明の代わりではない。

| ファイル | 本文の行 | 結果 |
|---|---|---|
| `check_forward_zero_evaluate.sage` | tau[iterate(p,0,i)] = tau[i] | PASS |
| `check_forward_zero_restore.sage` | tau[i] = iterate(q,0,tau[i]) | PASS |
| `check_backward_zero_evaluate.sage` | tau[iterate(q,0,i)] = tau[i] | PASS |
| `check_backward_zero_restore.sage` | tau[i] = iterate(p,0,tau[i]) | PASS |
| `check_forward_step_recursion.sage` | tau[iterate(p,n+1,i)] = tau[iterate(p,n,p[i])] | PASS |
| `check_forward_step_induction.sage` | tau[iterate(p,n,p[i])] = iterate(q,n,tau[p[i]]) | PASS |
| `check_forward_step_expand.sage` | iterate(q,n,tau[p[i]]) = iterate(q,n,tau[upsilon[tau[i]]]) | PASS |
| `check_forward_step_fold.sage` | iterate(q,n,tau[upsilon[tau[i]]]) = iterate(q,n,q[tau[i]]) | PASS |
| `check_forward_step_finish.sage` | iterate(q,n,q[tau[i]]) = iterate(q,n+1,tau[i]) | PASS |
| `check_backward_step_recursion.sage` | tau[iterate(q,n+1,i)] = tau[iterate(q,n,q[i])] | PASS |
| `check_backward_step_induction.sage` | tau[iterate(q,n,q[i])] = iterate(p,n,tau[q[i]]) | PASS |
| `check_backward_step_expand.sage` | iterate(p,n,tau[q[i]]) = iterate(p,n,tau[tau[upsilon[i]]]) | PASS |
| `check_backward_step_cancel.sage` | iterate(p,n,tau[tau[upsilon[i]]]) = iterate(p,n,upsilon[i]) | PASS |
| `check_backward_step_insert.sage` | iterate(p,n,upsilon[i]) = iterate(p,n,upsilon[tau[tau[i]]]) | PASS |
| `check_backward_step_fold.sage` | iterate(p,n,upsilon[tau[tau[i]]]) = iterate(p,n,p[tau[i]]) | PASS |
| `check_backward_step_finish.sage` | iterate(p,n,p[tau[i]]) = iterate(p,n+1,tau[i]) | PASS |
| `check_forward_exchange.sage` | iterate(q,n,tau[i]) = tau[iterate(p,n,i)] | PASS |
| `check_forward_witness.sage` | tau[iterate(p,n,i)] = tau[j] | PASS |
| `check_backward_exchange.sage` | iterate(p,n,tau[i]) = tau[iterate(q,n,i)] | PASS |
| `check_backward_witness.sage` | tau[iterate(q,n,i)] = tau[j] | PASS |
| `check_mate_membership.sage` | 相手の軌道への所属 | PASS |
| `check_reverse_membership.sage` | 逆の包含の所属 | PASS |
| `check_basepoint_cancel.sage` | 始点の二重相手 | PASS |
| `check_reverse_transfer.sage` | 所属の移し替え | PASS |
| `check_witness_cancel.sage` | 証人の二重相手 | PASS |
| `check.sage` | 像の等号、両側逆、非交叉（空集合・共有対を含む） | PASS |

実行日: 2026-10-24。行別25本と統合検算が通過した。反復を含む20行は各18,044件、所属三行は各3,212件、二重相手の二行は各1,388件。空集合の順序付き対も統合検算の236組に含む。Lean は独立な具体版、対合性だけを残した必要十分版、および導出版を置く。
