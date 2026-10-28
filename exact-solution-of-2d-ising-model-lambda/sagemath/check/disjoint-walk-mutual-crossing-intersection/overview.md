# 辺を共有しない二本の閉歩道の混合横断数は交差形式に等しい

**対象ラベル**: `claim_disjoint_walk_mutual_crossing_intersection`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_local_halfedges.sage` | 四半辺の六通りの局所等式 | PASS（2026-10-28） |
| `check_finite_tori.sage` | 辺長一から三の偶辺鎖対での横断数と交差形式 | PASS（2026-10-28） |

有限検算は本文の一般の辺長についての証明を代用しない。整数の偶奇だけを使う。
