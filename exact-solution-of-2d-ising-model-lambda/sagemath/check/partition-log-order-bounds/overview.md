# 分配多項式の両側評価を対数順序群の鎖へ移す

**対象ラベル**: `claim_partition_log_order_bounds`

| ファイル | 検証内容 | 状態 |
|---|---|---|
| `check_rational_cases.sage` | 自己双対二次式に有理根がない | PASS（2026-10-29） |
| `check_lower_order.sage` | 下界の対数順序への移行と加法恒等式 | PASS（2026-10-29） |
| `check_upper_order.sage` | 上界の対数順序への移行と加法恒等式 | PASS（2026-10-29） |
| `check_composed_cases.sage` | 辺長 1〜3 の実際の $Q^{a,b}_L(q)$ と総当たりの $Z_L(q)$ で、符号の二場合の合成（低温側の $M^{\mathrm{abs}}_L=M_L$ と $M_L/2\le Z_L$ からの弱め、両場合の $M^{\mathrm{abs}}_L/4\le Z_L\le2M^{\mathrm{abs}}_L$、$Z_L>0$ と上界からの $M^{\mathrm{abs}}_L>0$） | PASS（2026-11-15） |

有理数の厳密計算と素因数分解を用いる。有限点の検算は一般の辺長の証明には代えず、本文の論証で扱う。実数体への脱出はない。
