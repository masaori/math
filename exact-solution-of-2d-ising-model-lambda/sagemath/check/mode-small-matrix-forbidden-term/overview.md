# 逆方向を選ぶ置換項の零因子

**対象ラベル**: `claim_opposite_direction_permutation_term_zero`

| 検査 | 結果 |
|---|---|
| `check_selected_entry.sage` | PASS（2026-10-28、選んだ逆方向成分への添字代入） |
| `check_zero_factor.sage` | PASS（2026-10-28、逆方向成分の零化） |
| `check_product_zero.sage` | PASS（2026-10-28、零因子を持つ有限積） |
| `check.sage` | PASS（2026-10-28、辺長 1〜3 の全モード・全置換を円分体上で厳密検算） |

成分を円分体上で厳密に計算し、辺長 1〜3 の全モードと全置換について零因子を確かめる。実数体への脱出はない。
