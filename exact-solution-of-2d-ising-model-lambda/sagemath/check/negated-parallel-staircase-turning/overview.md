# SageMath Check: 符号反転平行階段の循環総回転数零

**対象ラベル**: `claim_negated_parallel_staircase_turning_zero`

正の階段の点を同じ添字順で符号反転し、本文の各等号・不等号を別ファイルで検査する。座標を直接計算した歩列を使い、期待する二区間表示から歩列を生成しない。既存の `reversed-parallel-staircase-turning/construction.sage` から階段の座標と方向番号による回転の定義を共有する。

検査範囲は $L=1,\ldots,5$、$w_{\mathrm h},w_{\mathrm v}\in\{-5,\ldots,5\}$、両巻き付き数が同時に零でない600例。一区間が空の100例と二方向の500例を含む。長さ一の内部和は空和である。座標・回転数はすべて `ZZ` で計算し、浮動小数点を使わない。有限検算自体は一般の場合の証明ではない。

2026-10-03、SageMath 10.9 で全34ファイルを実行し、すべて通過した。

| ファイル | 本文の式ペア・確認対象 | 状態 | 検査件数 |
|---|---|---|---:|
| `check_forward_expand_before.sage` | 正の階段の隣接差を座標式へ展開（before） | PASS | 4,950 |
| `check_forward_reduce_before.sage` | 座標式の差を分配則と相殺で整理（before） | PASS | 4,950 |
| `check_forward_unit_before.sage` | 整数係数の差を計算（before） | PASS | 4,950 |
| `check_forward_expand_boundary.sage` | 正の階段の隣接差を座標式へ展開（boundary） | PASS | 550 |
| `check_forward_reduce_boundary.sage` | 座標式の差を分配則と相殺で整理（boundary） | PASS | 550 |
| `check_forward_unit_boundary.sage` | 整数係数の差を計算（boundary） | PASS | 550 |
| `check_forward_expand_after.sage` | 正の階段の隣接差を座標式へ展開（after） | PASS | 4,400 |
| `check_forward_reduce_after.sage` | 座標式の差を分配則と相殺で整理（after） | PASS | 4,400 |
| `check_forward_unit_after.sage` | 整数係数の差を計算（after） | PASS | 4,400 |
| `check_negated_difference.sage` | 符号反転した点の差を正の隣接差の符号反転へ書換え | PASS | 9,900 |
| `check_negated_block_first.sage` | 同じ添字順の符号反転歩を二区間へ同定（first） | PASS | 4,950 |
| `check_negated_block_last.sage` | 同じ添字順の符号反転歩を二区間へ同定（last） | PASS | 4,950 |
| `check_unit_steps.sage` | 符号反転後も四つの単位歩の一つである | PASS | 9,900 |
| `check_coordinate_substitute.sage` | 平行座標へ歩の隣接差表示を代入 | PASS | 9,900 |
| `check_coordinate_additivity.sage` | 平行座標の加法性と符号反転 | PASS | 9,900 |
| `check_coordinate_negative.sage` | 平行座標の差の符号反転は負 | PASS | 9,900 |
| `check_opposite_substitute.sage` | 反対歩という仮定の平行座標への代入だけを検査 | PASS | 9,900 |
| `check_opposite_negate.sage` | 反対歩の平行座標は元の座標の加法逆元 | PASS | 9,900 |
| `check_opposite_positive.sage` | 反対歩の平行座標は正 | PASS | 9,900 |
| `check_endpoints_substitute.sage` | 階段の両端点を周期ベクトルと零へ置換 | PASS | 600 |
| `check_endpoints_zero.sage` | 零ベクトルの項を消去 | PASS | 600 |
| `check_endpoints_components.sage` | 周期ベクトルの符号反転の成分を確認 | PASS | 600 |
| `check_projection_closed.sage` | 両端点を剰余類へ射影すると一致する | PASS | 600 |
| `check_cyclic_definition.sage` | 循環総回転数を内部の回転数と閉じる回転数へ分割 | PASS | 600 |
| `check_cyclic_table.sage` | 一歩の回転数を整数の回転表へ置換 | PASS | 600 |
| `check_one_direction_constant.sage` | 一方向の全歩を同じ歩で置換 | PASS | 100 |
| `check_one_direction_zero_terms.sage` | 同方向の回転表の値を零へ置換 | PASS | 100 |
| `check_one_direction_zero_sum.sage` | 零の有限和を計算 | PASS | 100 |
| `check_two_direction_internal.sage` | 内部の同方向の零項を除く | PASS | 500 |
| `check_two_direction_closing.sage` | 最後の歩と最初の歩を代入 | PASS | 500 |
| `check_two_direction_negate.sage` | 二つの接合の逆順の値を加法逆元へ置換 | PASS | 500 |
| `check_two_direction_zero.sage` | 整数の加法逆元を相殺 | PASS | 500 |
| `check_cyclic_zero.sage` | 方向番号から循環総回転数零を直接確認 | PASS | 600 |
| `check_order_distinction.sage` | 二方向の場合は逆順の歩列と異なることを確認 | PASS | 500 |

反対歩の仮定の代入は代入操作だけの検査である。非後退性は平行座標の負値と反対歩の正値による本文の矛盾から従う。`check_order_distinction.sage` は二方向の場合の歩順が既存の逆順列とは異なることを検査し、取り違えを防ぐ。

プロジェクト直下から一括実行する。

```sh
sage sagemath/check/negated-parallel-staircase-turning/check.sage
```

`check.sage` は上表の順に実行する。行別ファイルも同じ引数形式で単独実行できる。
