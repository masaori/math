# 反転と方向番号

**対象ラベル**: `claim_reversal_direction_shift`
- 実行: `sage sagemath/check/reversal-direction-shift/check.sage`
- 状態: PASS（2026-08-29）

`L = 1,...,5` の全向き付き辺（計 220 本）について `dir(ι(e)) ≡ dir(e) + 2 (mod 4)` を
整数の合同だけで確かめる。浮動小数点は使っていない。
