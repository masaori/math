# 対象ラベル: claim_quadratic_positive_cone_add_closed
# 対象: structured-latex/content/main-text.ts の fisher_zero_claim_quadratic_positive_cone_add_closed
# 本文の行: 負の第二係数・非負係数: 転送後の所属
# 式・判定: \xi+\eta\in P_s
# 帰属: 有理係数と t^2-2 の二次体の二つの根。厳密計算。
from pathlib import Path
import sys

if '_qpa_cases' not in globals():
    _qpa_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_qpa_source.parent / '_prelude.sage').is_file():
        _qpa_source = Path(sys.argv[0]).resolve()
    load(str(_qpa_source.parent / '_prelude.sage'))

_checked = 0
for case in _qpa_selected(('negative_second', 'nonnegative')):
    assert _qpa_positive(case.forward), case
    _checked += 1
_qpa_record('negative_second_nonnegative', _checked, ('negative_second', 'nonnegative'), 'memberships')
