# 対象ラベル: claim_alternating_neighbor_matchings
# 対象: structured-latex/content/main-text.ts の tools_claim_alternating_neighbor_matchings
# 本文の行: 第一の族と二元軌道の族の一致
# 式・判定: \mathcal E_{\sigma,C}=\mathcal D_\tau
# 帰属: 自然数の有限集合、その部分集合、置換と隣接点写像。丸めなし。
from pathlib import Path
import sys

if '_anm_cases' not in globals():
    _anm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_anm_source.parent / '_prelude.sage').is_file():
        _anm_source = Path(sys.argv[0]).resolve()
    load(str(_anm_source.parent / '_prelude.sage'))

_checked = 0
for case in _anm_cases:
    assert _anm_neighbor_pairs(case.J, case.sigma, case.inverse, case.C) == _anm_involution_pairs(case.J, case.tau), (case,)
    _checked += 1
_anm_record('forward_family_definition', _checked, 747, 'equalities')
