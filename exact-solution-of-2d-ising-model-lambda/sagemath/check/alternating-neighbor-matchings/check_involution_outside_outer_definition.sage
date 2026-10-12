# 対象ラベル: claim_alternating_neighbor_matchings
# 対象: structured-latex/content/main-text.ts の tools_claim_alternating_neighbor_matchings
# 本文の行: 非所属側の対合性: 外側の定義
# 式・判定: \tau(\sigma^{-1}(i))=\sigma(\sigma^{-1}(i))
# 帰属: 自然数の有限集合、その部分集合、置換と隣接点写像。丸めなし。
from pathlib import Path
import sys

if '_anm_cases' not in globals():
    _anm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_anm_source.parent / '_prelude.sage').is_file():
        _anm_source = Path(sys.argv[0]).resolve()
    load(str(_anm_source.parent / '_prelude.sage'))

_checked = 0
for case, i in _anm_points(False):
    assert case.tau[case.inverse[i]] == case.sigma[case.inverse[i]], (case, i)
    _checked += 1
_anm_record('involution_outside_outer_definition', _checked, 2210, 'equalities')
