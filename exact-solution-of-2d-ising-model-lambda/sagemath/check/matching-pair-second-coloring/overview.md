# SageMath Check: 第二の相手写像による色反転

**対象ラベル**: `claim_matching_pair_second_coloring_alternates`

要素数0・2・4・6の順序付き完全マッチング対を全列挙する。有限番号と集合の厳密比較であり、実数体への脱出はない。有限検算を一般証明の代用にはしない。

| ファイル | 本文の行 | ステータス |
|---|---|---|
| `check_self_orbit.sage` | `i in orbit(p,i)` | PASS |
| `check_step_orbit.sage` | `p[i] in orbit(p,i)` | PASS |
| `check_step_component.sage` | `p[i] in component(tau,p,i)` | PASS |
| `check_step_minimum.sage` | `minimum(tau,p,p[i]) == minimum(tau,p,i)` | PASS |
| `check_step_color_definition.sage` | `(p[i] in color(tau,p)) == (p[i] in orbit(p,minimum(tau,p,p[i])))` | PASS |
| `check_step_color_minimum.sage` | `(p[i] in orbit(p,minimum(tau,p,p[i]))) == (p[i] in orbit(p,minimum(tau,p,i)))` | PASS |
| `check_step_color_invariant.sage` | `(p[i] in orbit(p,minimum(tau,p,i))) == (i in orbit(p,minimum(tau,p,i)))` | PASS |
| `check_step_color_fold.sage` | `(i in orbit(p,minimum(tau,p,i))) == (i in color(tau,p))` | PASS |
| `check_mate_domain.sage` | `tau[i] in range(len(tau))` | PASS |
| `check_second_step_definition.sage` | `p[tau[i]] == upsilon[tau[tau[i]]]` | PASS |
| `check_second_step_cancel.sage` | `upsilon[tau[tau[i]]] == upsilon[i]` | PASS |
| `check_second_color_step.sage` | `(upsilon[i] in color(tau,p)) == (p[tau[i]] in color(tau,p))` | PASS |
| `check_second_color_invariant.sage` | `(p[tau[i]] in color(tau,p)) == (tau[i] in color(tau,p))` | PASS |
| `check_second_color_alternates.sage` | `(tau[i] in color(tau,p)) == (i not in color(tau,p))` | PASS |
| `check.sage` | 行別全検算と主張の同値（空集合・共有対を含む） | PASS |

検証実装の修正: 初回の統合実行は共通読込先の変数が上書きされ、既存の第一色検算を列挙していた。新しい行別検算の通過とは数えず、専用のディレクトリ変数へ修正して再実行した。主張の統合比較自体は236対で通過した。

再実行時の実装エラー: ディレクトリ変数の改名が `Path.is_dir()` にも及んだため AttributeError となった。メソッド名を修正した後、2026-10-24 に行別14本すべて各1,388件、統合236順序付き対・1,388始点で PASS。Lean 具体版・必要十分版・導出版の対象ビルドも通過した。
