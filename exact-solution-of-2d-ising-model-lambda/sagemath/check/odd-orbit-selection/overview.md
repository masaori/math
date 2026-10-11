# 奇数軌道の最小元による選択の検算

**対象ラベル**: `def_odd_orbit_selection`, `claim_odd_orbit_selection_invariant`

- 実行日: 2026-10-11
- 状態: PASS。行別12本・299,400確認と、定義の独立検算が通過。
- 本文の12計算行を一行一ファイルで検査する。大きさ0〜6の全874置換・全5,913不変部分集合との組を列挙し、自然な順序と逆順（大きさ0・1では同一なので一度だけ）を使う。
- 行別検算の台は無向辺の隣接リストを探索して求める。定義の検算では順逆の反復列と照合し、奇数性は自然数の和による定義とも比較する。
- 奇数点が無い場合に最小元を取らないことを確認する。空集合の唯一の置換も含む。
- `construction.sage` は定義を再利用するための関数だけを持つ。有限例の厳密検算であり、一般の証明は本文と Lean が担う。実数体・複素数体への脱出はない。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_new_membership.sage` | 反転後の奇数点所属の定義 | PASS | 68,810 |
| `check_odd_length_preserved.sage` | 軌道長の保存による奇数性の一致 | PASS | 68,810 |
| `check_old_membership.sage` | 元の奇数点所属へ戻す | PASS | 68,810 |
| `check_new_min_membership.sage` | 反転後の最小元を元の集合へ移す | PASS | 10,330 |
| `check_old_min_membership.sage` | 元の最小元を反転後の集合へ移す | PASS | 10,330 |
| `check_old_min_le.sage` | 元の集合での最小性 | PASS | 10,330 |
| `check_new_min_le.sage` | 反転後の集合での最小性 | PASS | 10,330 |
| `check_minima_equal.sage` | 反対称律による最小元の一致 | PASS | 10,330 |
| `check_selected_definition.sage` | 反転後の選択台の定義 | PASS | 10,330 |
| `check_support_preserved.sage` | 反転による台の保存 | PASS | 10,330 |
| `check_basepoint_substitution.sage` | 最小元の等号を台の始点へ代入 | PASS | 10,330 |
| `check_selected_return.sage` | 元の選択台へ戻す | PASS | 10,330 |
| `check_definition.sage` | 定義と選択の独立検算、選ばない場合 | PASS | 874置換・5,913組・11,823順序付き事例（非空10,330・空1,493） |

プロジェクト直下で `sage sagemath/check/odd-orbit-selection/check.sage` を実行する。
