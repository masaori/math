# 対象ラベル: claim_rational_square_ne_double_square
# 対象: main-text.ts の有理数の平方と二倍の平方、二を外側へ出す結合則
# 式ペア: (QQ(2) * (b * b)) * (binv * binv) = QQ(2) * ((b * b) * (binv * binv))
# 帰属: a, b, binv, r は QQ、b != 0、binv = b^(-1)、r = a*binv。
from pathlib import Path
import sys

if '_rsds_cases' not in globals():
    _rsds_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_rsds_source.parent / '_prelude.sage').is_file():
        _rsds_source = Path(sys.argv[0]).resolve()
    load(str(_rsds_source.parent / '_prelude.sage'))
_rsds_check_pair(
    lambda a, b, binv, r: (QQ(2) * (b * b)) * (binv * binv),
    lambda a, b, binv, r: QQ(2) * ((b * b) * (binv * binv)),
    '二を外側へ出す結合則')
