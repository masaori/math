# 対象ラベル: claim_finite_permutation_iterate_injective
# 帰納法の仮定で共通の反復を取り消す。有限写像と整数だけによる厳密計算。
from pathlib import Path
import sys

if '_fpi_perms' not in globals():
    _fpi_source = Path(globals().get('__file__', sys.argv[0])).resolve()
    if not (_fpi_source.parent / '_prelude.sage').is_file():
        _fpi_source = Path(sys.argv[0]).resolve()
    load(str(_fpi_source.parent / '_prelude.sage'))

def _fpi_rows():
    for f, n, i, j in _fpi_inputs(True, True):
        assert _fpi_iter(f, n, f[i]) == _fpi_iter(f, n, f[j])
        yield f[i], f[j]

_fpi_check('successor_cancel_iteration', _fpi_rows(), 45351, False)
