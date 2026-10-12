# 対象ラベル: claim_alternating_neighbor_matchings
# 対象: structured-latex/content/main-text.ts の tools_claim_alternating_neighbor_matchings
# 本文の行: 逆置換の色反転: 二重否定
# 式・判定: \sigma^{-1}(i)\in C \Longleftrightarrow \neg\neg(\sigma^{-1}(i)\in C)
# 帰属: 自然数の有限集合、その部分集合、置換と隣接点写像。丸めなし。
from pathlib import Path
import sys

if '_anm_cases' not in globals():
    _anm_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_anm_source.parent / '_prelude.sage').is_file():
        _anm_source = Path(sys.argv[0]).resolve()
    load(str(_anm_source.parent / '_prelude.sage'))

_checked = 0
for case, i in _anm_points():
    assert (case.inverse[i] in case.C) == (not (not (case.inverse[i] in case.C))), (case, i)
    _checked += 1
_anm_record('inverse_double_negation', _checked, 4420, 'iff')
