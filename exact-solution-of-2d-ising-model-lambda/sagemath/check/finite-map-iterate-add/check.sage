# 対象ラベル: claim_finite_map_iterate_add
from pathlib import Path
import sys

_fma_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_fma_source.parent / '_prelude.sage').is_file():
    _fma_source = Path(sys.argv[0]).resolve()
_fma_directory = _fma_source.parent
load(str(_fma_directory / '_prelude.sage'))
_fma_files = ('check_base_add_zero.sage', 'check_base_zero_iteration.sage', 'check_successor_add_association.sage', 'check_successor_unfold.sage', 'check_successor_induction.sage', 'check_successor_fold.sage')
assert {path.name for path in _fma_directory.glob('check_*.sage')} == set(_fma_files)
for _fma_filename in _fma_files:
    __file__ = str(_fma_directory / _fma_filename)
    load(__file__)
assert len(_fma_results) == 6
assert sum(_fma_results.values()) == 233940
_final_count = 0
for f, m, n, i in _fma_inputs(True):
    assert _fma_iter(f, m + n, i) == _fma_iter(f, m, _fma_iter(f, n, i))
    _final_count += 1
assert _final_count == 54586
print('RESULT: PASS (6 lines; 233940 line checks; 54586 conclusion checks; 289 maps)')
