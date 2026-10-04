# 対象ラベル: claim_one_sided_closure_period_difference_turning
# 帰属: 整数格子の点・歩と整数の有限和。
from pathlib import Path
_difference_dir = Path('sagemath/check/one-sided-closure-period-difference-turning').resolve()
if '_difference_rows' not in globals():
    load(str(_difference_dir / 'construction.sage'))
    _difference_rows = list(period_difference_cases())
