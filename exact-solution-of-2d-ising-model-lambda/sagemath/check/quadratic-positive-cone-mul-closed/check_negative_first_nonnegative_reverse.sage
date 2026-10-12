# 対象ラベル: claim_quadratic_positive_cone_mul_closed
# 対象: structured-latex/content/main-text.ts の fisher_zero_claim_quadratic_positive_cone_mul_closed
# 本文の行: 負の第一係数・非負係数: 既証補題による逆順の所属
# 式・判定: \eta\cdot\xi\in P_s
# 帰属: 有理係数と t^2-2 の二次体の二つの根。厳密計算。
from pathlib import Path
import sys

if '_qpm_cases' not in globals():
    _qpm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_qpm_source.parent / '_prelude.sage').is_file():
        _qpm_source = Path(sys.argv[0]).resolve()
    load(str(_qpm_source.parent / '_prelude.sage'))

_checked = 0
for case in _qpm_selected(('negative_first', 'nonnegative')):
    assert _qpm_positive(case.reverse), case
    _checked += 1
_qpm_record('negative_first_nonnegative_reverse', _checked, ('negative_first', 'nonnegative'), 'memberships')
