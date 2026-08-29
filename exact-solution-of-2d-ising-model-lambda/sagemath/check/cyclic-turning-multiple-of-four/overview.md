# 循環総回転数は 4 の倍数

**対象ラベル**: `claim_step_advances_direction`, `claim_walk_direction_difference`, `claim_cyclic_total_turning_multiple_of_four`
- 実行: `sage sagemath/check/cyclic-turning-multiple-of-four/check.sage`
- 状態: PASS（2026-08-30、接続 660 件・辺列 6,776 件・閉歩道 1,064 件）

`L = 1,...,5` の全非後退接続について `dir(f) = dir(e) + π₄(τ(e,f))` を、
`L = 1,2,3`・辺 1〜5 本の全非後退辺列について `dir(e_m) = dir(e_1) + π₄(t(γ))` を、
そのうち閉じたものについて `π₄(t_circ(γ)) = 0` と `4 | t_circ(γ)` を、
`ℤ/4ℤ`（`Integers(4)`）と `ZZ` で厳密に検査する。浮動小数点は使わない。
