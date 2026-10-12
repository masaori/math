# 対象ラベル: claim_quadratic_positive_cone_add_closed
# 対象: structured-latex/content/main-text.ts の fisher_zero_claim_quadratic_positive_cone_add_closed
# 本文の行: 逆順の和の表示
# 式・判定: (a'+a,b'+b)=\mathrm{rep}_s(\eta+\xi)
# 帰属: 有理係数と t^2-2 の二次体の二つの根。厳密計算。
from pathlib import Path
import sys

if '_qpa_cases' not in globals():
    _qpa_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_qpa_source.parent / '_prelude.sage').is_file():
        _qpa_source = Path(sys.argv[0]).resolve()
    load(str(_qpa_source.parent / '_prelude.sage'))

_checked = 0
for case in _qpa_selected(None):
    assert (case.ap + case.a, case.bp + case.b) == case.reverse, case
    _checked += 1
_qpa_record('representation_reverse_add', _checked, None, 'equalities')
