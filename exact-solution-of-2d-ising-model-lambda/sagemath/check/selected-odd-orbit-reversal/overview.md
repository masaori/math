# 選んだ奇数軌道の反転の検算

**対象ラベル**: `def_odd_orbit_derangements`, `def_selected_odd_orbit_reversal`, `claim_selected_odd_orbit_reversal_involution`

- 実行日: 2026-10-11
- 状態: PASS。本文18計算行を一行一ファイルで検査し、定義の独立検算と合わせて19本が通過。
- 大きさ0〜6の全874置換を使う。対象集合に入るのは86置換で、外の788置換では反転の呼び出しを拒む。大きさ0・1・2・4では対象集合が空である。
- 自然順序と逆順（大きさ0・1で同一なら一度だけ）を使う。奇数点がある1,275順序付き事例で台の不変性と各点の不動性を調べ、対象集合の172順序付き事例で自己写像の定義と二重反転を確認する。
- 台は無向の隣接リストの探索で求め、順逆の反復による定義と比較する。不動点の同値は、真偽の双方が現れる置換も含めて検査する。浮動小数点は使わない。
- 検算は有限例についての厳密計算であり、一般の証明は本文と Lean が担う。反転が元の置換と異なることは、この検算の対象ではない。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_support_definition_forward.sage` | 選ぶ台の定義（像の所属） | PASS | 7,301 |
| `check_orbit_invariance.sage` | 軌道の台の不変性 | PASS | 7,301 |
| `check_support_definition_backward.sage` | 選ぶ台の定義（元の所属） | PASS | 7,301 |
| `check_inside_definition.sage` | 内側の反転の定義 | PASS | 3,187 |
| `check_inside_injectivity.sage` | 置換の単射性による不動性の同値 | PASS | 3,187 |
| `check_inside_inverse.sage` | 順置換と逆置換の相殺 | PASS | 3,187 |
| `check_inside_symmetry.sage` | 等号の対称性 | PASS | 3,187 |
| `check_outside_definition.sage` | 外側の反転の定義 | PASS | 4,114 |
| `check_derangement_definition_forward.sage` | 反転後の不動点なし集合の所属 | PASS | 1,275 |
| `check_derangement_pointwise.sage` | 各点での不動性の同値 | PASS | 1,275 |
| `check_derangement_definition_backward.sage` | 元の不動点なし集合の所属 | PASS | 1,275 |
| `check_odd_points.sage` | 奇数点の集合の保存 | PASS | 1,275 |
| `check_selected_support.sage` | 選ぶ軌道の台の保存 | PASS | 1,275 |
| `check_double_definition.sage` | 二回目の反転の定義 | PASS | 172 |
| `check_double_support.sage` | 二回目の台を一回目の台へ置換 | PASS | 172 |
| `check_double_abbreviation.sage` | 選ぶ台の略記を戻す | PASS | 172 |
| `check_double_substitution.sage` | 一回目の反転を代入 | PASS | 172 |
| `check_double_cancel.sage` | 同じ台での二重反転 | PASS | 172 |
| `check_definition.sage` | 対象集合・反転の定義、空の場合 | PASS | 874置換・172順序付き対象例 |

行別の確認数は合計 46,000。プロジェクト直下で `sage sagemath/check/selected-odd-orbit-reversal/check.sage` を実行する。
