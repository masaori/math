# 高さ一の境界係数と横方向の切断線上の通過偶奇

**対象ラベル**: `claim_height_one_boundary_horizontal_seam_parity`

横方向の切断線上の辺について、境界係数の支持と高さ差、高さ差と通過偶奇の二行を整数の全四組で検算する。切断線偶奇が零の閉歩道に対する高さの構成は `claim_closed_walk_standard_dual_height_horizontal_seam` の検証で扱う。辺長一も別に検算する。

| 式変形 | 検証ファイル | 状態 |
|---|---|---|
| 境界係数の非零と二値高さの差 | `check_boundary_height.sage` | PASS（2026-11-05、全四組） |
| 切断線一歩の高さ差と通過偶奇 | `check_height_parity.sage` | PASS（2026-11-05、全四組） |
| 辺長一の境界係数と通過偶奇 | `check_single_cell.sage` | PASS（2026-11-06、全二組） |
