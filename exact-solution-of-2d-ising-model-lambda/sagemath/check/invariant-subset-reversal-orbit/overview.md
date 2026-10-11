# 不変部分集合上の反転と軌道の台・長さの行別検算

**対象ラベル**: `def_finite_permutation_orbit`, `def_finite_permutation_orbit_length`, `claim_invariant_subset_reversal_orbit`, `claim_invariant_subset_reversal_orbit_length`

本文の二十五計算行を一行一ファイルで調べる。空集合から六元集合までの全874置換と、その全不変部分集合との5,913組を既存の反転検算から取る。空の添字集合、空部分集合、全体集合も含み、それぞれの出現件数を定義検算で確認する。有限集合と自然数の厳密計算だけを用い、浮動小数点は使わない。

軌道の台は順向き・逆向きをそれぞれ点の再訪まで走査して求める。本文の存在量化は、二方向の反復の組が再訪するまで走査して評価する。反復回数に任意の上限を設けない。定義検算では各走査が始点へ戻る閉路であり、記録した集合が次の反復でも閉じていることを確認する。別算法として辺 `{k, sigma(k)}` の無向グラフを探索し、逆置換や反復関数を使わずに得た到達集合へ台・長さ・存在判定を照合する。

これらは指定した有限個の入力の検算であり、任意の有限集合に対する一般証明の代用ではない。一般の証明は本文と Lean に置く。

| ファイル | 本文の行 | 条件 | 結果 | 確認数 |
|---|---|---|---|---|
| `check_inverse_orbit_unfold.sage` | 逆置換の軌道の定義を展開 | 全置換・全始点・全判定点 | PASS（2026-10-11） | 29,367 |
| `check_inverse_orbit_double_inverse.sage` | 二重逆置換を取消 | 全置換・全始点・全判定点 | PASS（2026-10-11） | 29,367 |
| `check_inverse_orbit_disjunction.sage` | 存在量化内の選言を交換 | 全置換・全始点・全判定点 | PASS（2026-10-11） | 29,367 |
| `check_inverse_orbit_fold.sage` | 元の軌道の定義へ戻す | 全置換・全始点・全判定点 | PASS（2026-10-11） | 29,367 |
| `check_inverse_inside_backward_map.sage` | 反転の逆置換を補助写像へ展開 | 内側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_inside_select.sage` | 内側で補助写像を元の置換へ展開 | 内側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_inside_double_inverse.sage` | 元の置換を二重逆置換へ置換 | 内側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_inside_fold.sage` | 内側で逆置換の反転へ戻す | 内側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_outside_backward_map.sage` | 反転の逆置換を補助写像へ展開 | 外側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_outside_select.sage` | 外側で補助写像を元の逆置換へ展開 | 外側の点 | PASS（2026-10-11） | 17,203 |
| `check_inverse_outside_fold.sage` | 外側で逆置換の反転へ戻す | 外側の点 | PASS（2026-10-11） | 17,203 |
| `check_orbit_inside_unfold.sage` | 反転の軌道の定義を展開 | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_inside_replace_inverse.sage` | 第二方向を逆置換の反転へ置換 | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_inside_forward_iterate.sage` | 内側で第一方向を元の逆置換へ置換 | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_inside_backward_iterate.sage` | 内側で第二方向を元の二重逆置換へ置換 | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_inside_fold_inverse.sage` | 逆置換の軌道の定義へ戻す | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_inside_original.sage` | 逆置換の軌道から元の軌道へ移す | 内側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_outside_unfold.sage` | 反転の軌道の定義を展開 | 外側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_outside_replace_inverse.sage` | 第二方向を逆置換の反転へ置換 | 外側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_outside_forward_iterate.sage` | 外側で第一方向を元の置換へ置換 | 外側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_outside_backward_iterate.sage` | 外側で第二方向を元の逆置換へ置換 | 外側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_orbit_outside_fold.sage` | 元の軌道の定義へ戻す | 外側の始点・全判定点 | PASS（2026-10-11） | 100,801 |
| `check_length_unfold.sage` | 反転の軌道長を台の濃度へ展開 | 全始点 | PASS（2026-10-11） | 34,406 |
| `check_length_support.sage` | 反転の軌道の台を元の台へ置換 | 全始点 | PASS（2026-10-11） | 34,406 |
| `check_length_fold.sage` | 元の軌道長の定義へ戻す | 全始点 | PASS（2026-10-11） | 34,406 |
| `check_definitions.sage` | 軌道の台・長さの定義 | 全置換 | PASS（2026-10-11） | 5,039始点・29,367所属判定 |

このディレクトリ、またはプロジェクト直下から実行する。

```sh
# このディレクトリ
sage check.sage
# プロジェクト直下
sage sagemath/check/invariant-subset-reversal-orbit/check.sage
```

2026-10-11 に定義検算と行別検算の二十六本すべて通過。本文二十五計算行は合計1,449,918確認で、各行の件数が予定件数に一致することも検査した。定義検算は空集合の場合に始点がないこと、空部分集合と全体集合がそれぞれ874組あることも含む。

