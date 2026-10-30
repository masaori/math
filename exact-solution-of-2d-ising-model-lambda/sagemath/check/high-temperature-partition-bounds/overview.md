# 自己双対点より高温側での分配多項式の両側評価

**対象ラベル**: `claim_high_temperature_partition_bounds`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_dual_point.sage` | 双対点を低温側へ移す恒等式 | PASS（2026-10-30 再実行） |
| `check_lower_bound.sage` | 非負セクター和と低温側の下界を組み合わせる | PASS（2026-10-30 再実行） |
| `check_upper_bound.sage` | 四項の三角不等式と最大値による上界 | PASS（2026-10-30 再実行） |

一般の辺長と四つの多項式の関係は本文で証明する。検算は有理数の厳密計算であり、実数体への脱出はない。
