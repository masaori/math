# 対象ラベル: claim_finite_permutation_iterate_injective
from pathlib import Path
import sys

_fpi_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_fpi_source.parent / '_prelude.sage').is_file():
    _fpi_source = Path(sys.argv[0]).resolve()
_fpi_directory = _fpi_source.parent
load(str(_fpi_directory / '_prelude.sage'))
_fpi_files = ('check_base_unfold_left.sage', 'check_base_collision.sage', 'check_base_unfold_right.sage', 'check_successor_fold_left.sage', 'check_successor_collision.sage', 'check_successor_unfold_right.sage', 'check_successor_cancel_iteration.sage', 'check_successor_cancel_permutation.sage')
assert {path.name for path in _fpi_directory.glob('check_*.sage')} == set(_fpi_files)
for _fpi_filename in _fpi_files:
    __file__ = str(_fpi_directory / _fpi_filename)
    load(__file__)
assert len(_fpi_results) == 8
assert sum(_fpi_results.values()) == 728432
_fpi_final_count = 0
for f in _fpi_perms:
    for n in range(10):
        images = [_fpi_iter(f, n, i) for i in f]
        assert len(set(images)) == len(f)
        for i in f:
            for j in f:
                assert (_fpi_iter(f, n, i) == _fpi_iter(f, n, j)) == (i == j)
                _fpi_final_count += 1
assert _fpi_final_count == 293670
constant_map = {2: 2, 5: 2}
assert _fpi_iter(constant_map, 0, 2) != _fpi_iter(constant_map, 0, 5)
assert _fpi_iter(constant_map, 1, 2) == _fpi_iter(constant_map, 1, 5)
print('RESULT: PASS (6 lines: 678042 equalities; 2 hypotheses: 50390 substitutions; 293670 conclusion checks; 874 permutations including empty)')
