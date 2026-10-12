# 対象ラベル: claim_alternating_neighbor_matchings
# 対象: structured-latex/content/main-text.ts の tools_claim_alternating_neighbor_matchings
# 本文の行: 順序付き対の直積所属
# 式・判定: (\mathcal E_{\sigma,C},\mathcal E_{\sigma^{-1},C})\in\mathcal M(\mathcal J)\times\mathcal M(\mathcal J)
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
    ordered_pair = (
        _anm_neighbor_pairs(case.J, case.sigma, case.inverse, case.C),
        _anm_neighbor_pairs(case.J, case.inverse, case.sigma, case.C))
    assert len(ordered_pair) == 2 and all(_anm_is_matching(case.J, family) for family in ordered_pair), (case,)
    _checked += 1
_anm_record('ordered_pair', _checked, 747, 'judgments')
