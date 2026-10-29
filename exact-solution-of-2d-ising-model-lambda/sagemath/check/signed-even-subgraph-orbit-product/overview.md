# 符号付き偶部分グラフ多項式の軌道ごとの明示積

**対象ラベル**: `claim_signed_even_subgraph_orbit_product`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_product_square_distribution.sage` | 有限積の平方と定数項 | PASS（2026-10-29） |
| `check_fixed_mode_substitution.sage` | 一元軌道の平方を分散因子へ置換 | PASS（2026-10-29） |
| `check_orbit_multiplicity.sage` | 軌道の元数に応じた冪を軌道内積へ置換 | PASS（2026-10-29） |
| `check_partition_reindex.sage` | 軌道分割によるモード積への再添字付け | PASS（2026-10-29） |

辺長一から四の全ねじれについて `QQbar` の厳密等号で検算する。最後のモード積と行列式の一致は `claim_dispersion_mode_product` の検証を引く。一般の辺長での証明は本文の軌道分割と平方根の一意性による。
