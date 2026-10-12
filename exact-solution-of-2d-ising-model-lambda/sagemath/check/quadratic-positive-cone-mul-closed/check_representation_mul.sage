# 対象ラベル: claim_quadratic_positive_cone_mul_closed
# 対象: structured-latex/content/main-text.ts の fisher_zero_claim_quadratic_positive_cone_mul_closed
# 本文の行: 積の表示
# 式・判定: \mathrm{rep}_s(\xi\cdot\eta)=(a\cdot a'+2\cdot(b\cdot b'),a\cdot b'+b\cdot a')
# 帰属: 有理係数と t^2-2 の二次体の二つの根。厳密計算。
from pathlib import Path
import sys

if '_qpm_cases' not in globals():
    _qpm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_qpm_source.parent / '_prelude.sage').is_file():
        _qpm_source = Path(sys.argv[0]).resolve()
    load(str(_qpm_source.parent / '_prelude.sage'))

_checked = 0
for case in _qpm_selected(None):
    assert case.forward == (case.a * case.ap + 2 * (case.b * case.bp), case.a * case.bp + case.b * case.ap), case
    _checked += 1
_qpm_record('representation_mul', _checked, None, 'equalities')
