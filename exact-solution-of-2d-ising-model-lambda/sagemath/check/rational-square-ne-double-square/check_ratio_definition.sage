# 対象ラベル: claim_rational_square_ne_double_square
# 対象: main-text.ts の有理数の平方と二倍の平方、比の定義
# 式ペア: r * r = (a * binv) * (a * binv)
# 帰属: a, b, binv, r は QQ、b != 0、binv = b^(-1)、r = a*binv。
import os

if '_rsds_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rsds_check_pair(
    lambda a, b, binv, r: r * r,
    lambda a, b, binv, r: (a * binv) * (a * binv),
    '比の定義')
