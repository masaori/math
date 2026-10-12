# 対象ラベル: claim_finite_permutation_orbit_enumeration
# 本文の行: σ⁻¹(σ(e_(p-1)))=e_(p-1)
# 帰属: 自然数と有限集合。浮動小数点は使わない。
from pathlib import Path
import sys

if '_orbit_check' not in globals():
    _source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_source.parent / '_prelude.sage').is_file():
        _source = Path(sys.argv[0]).resolve()
    load(str(_source.parent / '_prelude.sage'))

_orbit_check('backward_cancel')
