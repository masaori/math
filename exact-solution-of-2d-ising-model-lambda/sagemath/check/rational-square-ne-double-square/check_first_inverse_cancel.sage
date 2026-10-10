# 対象ラベル: claim_rational_square_ne_double_square
# 対象: main-text.ts の有理数の平方と二倍の平方、一つ目の逆元の積を一へ
# 式ペア: QQ(2) * ((b * binv) * (b * binv)) = QQ(2) * (QQ(1) * (b * binv))
# 帰属: a, b, binv, r は QQ、b != 0、binv = b^(-1)、r = a*binv。
import os

if '_rsds_cases' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
_rsds_check_pair(
    lambda a, b, binv, r: QQ(2) * ((b * binv) * (b * binv)),
    lambda a, b, binv, r: QQ(2) * (QQ(1) * (b * binv)),
    '一つ目の逆元の積を一へ')
