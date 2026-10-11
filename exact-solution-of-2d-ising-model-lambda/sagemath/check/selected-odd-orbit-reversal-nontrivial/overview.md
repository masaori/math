# 選んだ奇数軌道の反転の非自明性の検算

**対象ラベル**: `claim_selected_odd_orbit_reversal_nontrivial`

- 状態: 2026-10-11 実行済み、全て PASS。本文46計算行の237,104確認と定義の独立検算、計47本。
- 大きさ0〜6の全874置換と自然順序・逆順を使い、対象集合の172順序付き事例を検査する。空の対象集合も含む。
- 台は無向グラフの探索で独立に計算し、順逆の反復の定義と突き合わせる。
- 背理法内の局所計算には、始点が動き、その二点軌道を反転すると元と一致する局所標本を用いる。そこでは奇数性・全点の不動点排除・最小選択を要求しない。奇数性と一致を同時に要求する空の標本を PASS と数えない。長さ三以上と最終的な非自明性は奇数軌道の標本で検査する。
- 帰納法の行は順・逆の両写像と回数0から集合の大きさの二倍に一を加えた値までを調べる。有限例の厳密検算であり、全回数と任意の有限集合の証明は本文・Lean が担う。浮動小数点を使わない。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_minimum_odd.sage` | 選んだ最小元の奇数点への所属 | PASS | 172 |
| `check_odd_length.sage` | 奇数長の自然数表示 | PASS | 172 |
| `check_zero_iteration.sage` | 始点への零回の反復 | PASS | 1,044 |
| `check_first_successor.sage` | 一回の反復の再帰定義 | PASS | 1,044 |
| `check_first_identity.sage` | 零回の恒等写像 | PASS | 1,044 |
| `check_first_name.sage` | 像の略記 | PASS | 1,044 |
| `check_moved_point.sage` | 始点とその像の相異 | PASS | 1,044 |
| `check_pair_in_orbit.sage` | 二点の台への包含 | PASS | 1,044 |
| `check_pair_card_lower.sage` | 相異なる二点の個数 | PASS | 1,044 |
| `check_card_lower.sage` | 包含から台の個数の下界 | PASS | 1,044 |
| `check_length_name_lower.sage` | 個数による長さの定義 | PASS | 1,044 |
| `check_half_positive.sage` | 二以上の奇数の半分の自然数の下界 | PASS | 172 |
| `check_double_right_addition.sage` | 半分の下界の右への加法 | PASS | 172 |
| `check_double_left_addition.sage` | 半分の下界の左への加法 | PASS | 172 |
| `check_double_one.sage` | 一どうしの和 | PASS | 172 |
| `check_length_odd_substitution.sage` | 長さの奇数表示の代入 | PASS | 172 |
| `check_length_addition_lower.sage` | 二倍の下界に一を加える | PASS | 172 |
| `check_three_value.sage` | 二と一の和 | PASS | 172 |
| `check_inside_inverse.sage` | 台の内側の反転の定義 | PASS | 1,044 |
| `check_reversal_point_name.sage` | 反転の局所的な略記 | PASS | 1,044 |
| `check_assumed_equality_at_point.sage` | 反転が元と一致する仮定の点での評価 | PASS | 872 |
| `check_backward_name.sage` | 像の略記の再代入 | PASS | 1,044 |
| `check_forward_swap.sage` | 逆向きの像の代入 | PASS | 872 |
| `check_forward_cancel.sage` | 順置換による逆写像の相殺 | PASS | 1,044 |
| `check_backward_substitution.sage` | 順向きの像の代入 | PASS | 1,044 |
| `check_backward_cancel.sage` | 逆写像による順置換の相殺 | PASS | 1,044 |
| `check_iteration_base_start.sage` | 帰納法の始点の零回 | PASS | 23,640 |
| `check_iteration_base_neighbor.sage` | 帰納法の隣点の零回 | PASS | 23,640 |
| `check_iteration_start_successor.sage` | 始点の後者回の再帰 | PASS | 23,640 |
| `check_iteration_start_swap.sage` | 始点の一歩を隣点へ替える | PASS | 23,640 |
| `check_iteration_neighbor_hypothesis.sage` | 隣点からの反復の所属 | PASS | 23,640 |
| `check_iteration_neighbor_successor.sage` | 隣点の後者回の再帰 | PASS | 23,640 |
| `check_iteration_neighbor_swap.sage` | 隣点の一歩を始点へ替える | PASS | 23,640 |
| `check_iteration_start_hypothesis.sage` | 始点からの反復の所属 | PASS | 23,640 |
| `check_forward_iteration_membership.sage` | 順方向の到達の所属 | PASS | 11,820 |
| `check_backward_iteration_membership.sage` | 逆方向の到達の所属 | PASS | 11,820 |
| `check_selected_support_definition.sage` | 選んだ台の軌道としての定義 | PASS | 1,044 |
| `check_orbit_in_pair.sage` | 軌道の台の二点への包含 | PASS | 872 |
| `check_length_name_upper.sage` | 個数による長さの定義の再使用 | PASS | 872 |
| `check_card_upper.sage` | 包含から台の個数の上界 | PASS | 872 |
| `check_pair_card_upper.sage` | 相異なる二点の個数の再使用 | PASS | 872 |
| `check_selected_reversal_definition.sage` | 選んだ軌道の反転の定義 | PASS | 172 |
| `check_selected_reversal_support.sage` | 選んだ台の略記 | PASS | 172 |
| `check_selected_reversal_name.sage` | 反転置換の略記 | PASS | 172 |
| `check_nontrivial.sage` | 奇数軌道を選んだ反転の非自明性 | PASS | 172 |
| `check_involution.sage` | 既証の二重反転との接続 | PASS | 172 |
| `check_definition.sage` | 台の独立計算・空の対象集合・局所標本 | PASS | 全874置換・172順序付き対象例・872局所例 |

実行: プロジェクト直下で `sage -c "__file__ = 'sagemath/check/selected-odd-orbit-reversal-nontrivial/check.sage'; load(__file__)"`。
