# SageMath Check: 二歩置換の軌道と第一の相手の軌道の非交叉

**対象ラベル**: `def_matching_pair_step`, `claim_matching_pair_orbit_separation`

有限番号集合の要素数 0, 2, 4, 6 について、不動点のない対合を全置換から独立に抽出し、順序付き対をすべて列挙する。対の数は順に 1, 1, 9, 225、合計236対である。各対と始点の組は1,388件で、第一・第二の相手が一致する284件も含む。空集合の対も列挙されるが、始点を持たない。

二歩置換と逆向きの写像は、それぞれ相手写像の合成から計算する。軌道は訪問済み集合によって独立に算出し、非交叉の結論を定義に使わない。反復回数の変数は0〜12を検算し、降下計算では最大14回の反復を評価する。整数と有限集合だけの厳密計算であり、実数体・複素数体への脱出はない。

## 行別の検算

対合の挿入・打消し、反復の交換、合成の定義などは、反証仮定なしにも成り立つので全標本で検査する。反証の仮定を代入する行と、その仮定に依存する矛盾の行は、条件を満たす標本が0件であることのみを記録する。対象事例なしの行を等式検証済みとはせず、反証の論理と任意の有限集合・反復回数についての一般の証明は Lean による。

| ファイル | 本文の行 | ステータス | 件数 |
|---|---|---|---|
| `check_left_inverse_expand.sage` | 逆写像の左逆: 定義展開 | PASS | 1388 |
| `check_left_inverse_cancel_second.sage` | 逆写像の左逆: 第二対合の打消し | PASS | 1388 |
| `check_left_inverse_cancel_first.sage` | 逆写像の左逆: 第一対合の打消し | PASS | 1388 |
| `check_right_inverse_expand.sage` | 逆写像の右逆: 定義展開 | PASS | 1388 |
| `check_right_inverse_cancel_first.sage` | 逆写像の右逆: 第一対合の打消し | PASS | 1388 |
| `check_right_inverse_cancel_second.sage` | 逆写像の右逆: 第二対合の打消し | PASS | 1388 |
| `check_forward_zero.sage` | 順反復の零回: 定義 | PASS | 1388 |
| `check_first_mate_fixed_free.sage` | 零回で相手と異なる | PASS | 1388 |
| `check_forward_one_evaluate.sage` | 順反復の一回 | PASS | 1388 |
| `check_forward_one_expand.sage` | 順反復の一回: 合成 | PASS | 1388 |
| `check_second_mate_fixed_free.sage` | 一回で相手と異なる | PASS | 1388 |
| `check_forward_descent_recurse.sage` | 二回減らす降下: 反復の再帰 | PASS | 18044 |
| `check_forward_descent_insert_first.sage` | 二回減らす降下: 第一対合の挿入 | PASS | 18044 |
| `check_forward_descent_insert_second.sage` | 二回減らす降下: 第二対合の挿入 | PASS | 18044 |
| `check_forward_descent_compose.sage` | 二回減らす降下: 合成の定義 | PASS | 18044 |
| `check_forward_descent_commute.sage` | 二回減らす降下: 反復の交換 | PASS | 18044 |
| `check_forward_descent_hypothesis.sage` | 二回減らす降下: 反証仮定の代入 | 対象事例なし | 0 |
| `check_forward_descent_target.sage` | 二回減らす降下: 到達点の表示 | PASS | 18044 |
| `check_forward_descent_contradiction.sage` | 降下先で帰納仮定と矛盾する等号 | 対象事例なし | 0 |
| `check_forward_nonreturn.sage` | 順反復は第一相手へ到達しない | PASS | 18044 |
| `check_inverse_zero.sage` | 逆反復の零回: 定義 | PASS | 1388 |
| `check_inverse_descent_insert_second.sage` | 逆反復の降下: 第二対合の挿入 | PASS | 18044 |
| `check_inverse_descent_insert_first.sage` | 逆反復の降下: 第一対合の挿入 | PASS | 18044 |
| `check_inverse_descent_compose.sage` | 逆反復の降下: 合成の定義 | PASS | 18044 |
| `check_inverse_descent_commute.sage` | 逆反復の降下: 反復の交換 | PASS | 18044 |
| `check_inverse_descent_hypothesis.sage` | 逆反復の降下: 反証仮定の代入 | 対象事例なし | 0 |
| `check_inverse_descent_target.sage` | 逆反復の降下: 対合の打消し | PASS | 18044 |
| `check_inverse_descent_contradiction.sage` | 交換後の順反復の非到達と矛盾する等号 | 対象事例なし | 0 |
| `check_inverse_nonreturn.sage` | 逆反復は第一相手へ到達しない | PASS | 18044 |
| `check_mate_nonmembership.sage` | 第一相手は二歩置換の軌道に属さない | PASS | 1388 |
| `check_orbit_basepoint_left.sage` | 第一軌道の始点変更 | PASS | 3212 |
| `check_orbit_basepoint_right.sage` | 共通点を仮定した第二軌道の始点変更 | 対象事例なし | 0 |
| `check_orbit_equality_contradiction.sage` | 共通点がある場合の両軌道一致 | 対象事例なし | 0 |
| `check_orbit_self_membership.sage` | 相手は自身を始点とする軌道に属する | PASS | 1388 |
| `check_orbit_membership_contradiction.sage` | 軌道一致による相手の所属 | 対象事例なし | 0 |
| `check_orbits_disjoint.sage` | 二歩置換の二つの軌道は交わらない | PASS | 1388 |

`check_first_mate_fixed_free.sage` は順反復・逆反復それぞれの零回の場合に現れる同じ不等号を検査する。`check_orbit_basepoint_left.sage` は共通点の仮定を外し、第一軌道内の全3,212件について始点変更の等号を検査する。共通点を必要とする第二軌道との比較は対象事例なしとして区別する。

## 実行方法

プロジェクト直下から各 `check_*.sage` を単独に実行する。

```sh
for f in sagemath/check/matching-pair-orbit-separation/check_*.sage; do
  sage "$f" || exit
done
```

## 実行結果

2026-10-24: 全36ファイルを別々の Sage プロセスで実行し、全て終了コード0。29ファイルは非空の標本で等号・不等号・所属・非交叉を検査した。残る7ファイルは反証仮定を満たす事例が0件であることだけを確認した。

初回実行では `__file__` からの共通ファイル探索が Sage の起動用ファイルの位置を指し、全36ファイルが読込エラーで停止した。作業ディレクトリを基準とする探索へ直して再実行した。数学的条件・比較式は変更していない。

配置後は、リポジトリ直下・プロジェクト直下・検算ディレクトリ直下の各位置から代表ファイルを単独起動し、共通ファイルの読込と終了コード0を確認した。
