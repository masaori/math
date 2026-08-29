# 非後退辺列の総回転数

**対象ラベル**: `claim_rotation_phase_as_turning_power`, `claim_walk_rotation_phase_total_turning`
- 実行: `sage sagemath/check/walk-rotation-phase-total-turning/check.sage`
- 状態: PASS（2026-08-30）

`L = 1,...,5` の全 660 非後退接続について `ρ(e,f) = ζ₈^τ(e,f)` を、
`L = 1,2,3` の辺 1〜4 本の全 2,240 非後退辺列について `Πρ = ζ₈^{t(γ)}` を、
`QQbar` と `ZZ` で厳密に検査する。浮動小数点は使わない。
