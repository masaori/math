# 自己双対点より高温側での分配多項式の両側評価

**対象ラベル**: `claim_high_temperature_partition_bounds`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_dual_point.sage` | 双対点を低温側へ移す恒等式 | PASS（2026-11-15 再実行） |
| `check_lower_bound.sage` | 非負セクター和と低温側の下界を組み合わせる | PASS（2026-11-15 再実行） |
| `check_upper_bound.sage` | 四項の三角不等式と最大値による上界 | PASS（2026-11-15 再実行） |
| `check_duality_absolute.sage` | 辺長 1〜3 の実際の $Q^{a,b}_L$ で、符号を除いた自己双対性を $x=q$ で評価して $(1+q)^{2N}2^{-N}Q^{a,b}_L(t)=\|Q^{a,b}_L(q)\|$ と最大値の等式を得て、総当たりで数えた $Z_L(q)$ が両側評価を満たすこと | PASS（2026-11-15） |

一般の辺長と四つの多項式の関係は本文で証明する。符号 $\epsilon_L^{a,b}$ の値は使わない（本文は `claim_signed_even_subgraph_duality_up_to_sign` を引く）。検算は有理数の厳密計算であり、実数体への脱出はない。
