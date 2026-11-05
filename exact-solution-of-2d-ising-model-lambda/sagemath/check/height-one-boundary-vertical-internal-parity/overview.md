# 高さ一の境界係数と縦方向の内部辺の通過偶奇

**対象ラベル**: `claim_height_one_boundary_vertical_internal_parity`

縦方向の内部辺について境界係数の支持、高さ差の対称性、閉歩道の内部一歩を整数の全四組で検算する。格子上の高さの構成は既存の `claim_closed_walk_standard_dual_height_vertical_internal` の検証で扱う。

| 式変形 | 検証ファイル | 状態 |
|---|---|---|
| 境界係数の非零と二値高さの差 | `check_boundary_height.sage` | PASS（2026-11-05、全四組） |
| 高さ差の順序反転 | `check_height_order.sage` | PASS（2026-11-05、全四組） |
| 内部一歩の高さ差と通過偶奇 | `check_height_parity.sage` | PASS（2026-11-05、全四組） |
