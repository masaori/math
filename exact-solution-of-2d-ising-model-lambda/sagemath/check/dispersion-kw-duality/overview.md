# 分散因子の自己双対性

**対象ラベル**: `claim_dispersion_kw_duality`

| 検査 | 内容 | 状態 |
|---|---|---|
| `check_kw_square.sage` | 双対変換の平方を代入 | PASS（2026-10-28） |
| `check_kw_square_simplification.sage` | 双対変換の平方を整理 | PASS（2026-10-28） |
| `check_kw_cubic.sage` | 双対変換と平方差の積を代入 | PASS（2026-10-28） |
| `check_kw_cubic_simplification.sage` | 双対変換と平方差の積を整理 | PASS（2026-10-28） |
| `check_dispersion_definition.sage` | 分散因子の定義を展開 | PASS（2026-10-28） |
| `check_substitution.sage` | 準備した二式を代入 | PASS（2026-10-28） |
| `check_cancel_denominator.sage` | 分母を払う | PASS（2026-10-28） |
| `check_difference_of_squares.sage` | 差の平方を整理 | PASS（2026-10-28） |
| `check_dispersion_return.sage` | 分散因子へ戻す | PASS（2026-10-28） |
| `check.sage` | 全検査 | PASS（2026-10-28） |

有理関数体 `QQ(x,p,s)` の厳密な等号で検査する。実数への脱出はない。
