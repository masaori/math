# 対象ラベル: claim_finite_permutation_iterate_injective
# 零回の反復を左で展開。有限写像と整数だけによる厳密計算。
from pathlib import Path
import sys

if '_fpi_perms' not in globals():
    _fpi_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_fpi_source.parent / '_prelude.sage').is_file():
        _fpi_source = Path(sys.argv[0]).resolve()
    load(str(_fpi_source.parent / '_prelude.sage'))

def _fpi_rows():
    for f, n, i, j in _fpi_inputs(False, False):
        yield i, _fpi_iter(f, 0, i)

_fpi_check('base_unfold_left', _fpi_rows(), 29367, False)
