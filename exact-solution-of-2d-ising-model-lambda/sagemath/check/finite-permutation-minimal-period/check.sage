# 対象ラベル: claim_finite_permutation_positive_return, def_finite_permutation_minimal_period
from pathlib import Path
import sys
_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (_source.parent / '_prelude.sage').is_file():
    _source = Path(sys.argv[0]).resolve()
_directory = _source.parent
load(str(_directory / '_prelude.sage'))
_files = ['check_values_mem.sage', 'check_cardinality_definition.sage', 'check_collision_exists.sage', 'check_difference_positive.sage', 'check_add_difference.sage', 'check_iterate_add.sage', 'check_sum_substitution.sage', 'check_collision_value.sage', 'check_cancel_iteration.sage', 'check_return_set_mem.sage', 'check_period_positive.sage', 'check_period_return.sage', 'check_period_minimal.sage', 'check_cardinality_contradiction.sage']
assert {p.name for p in _directory.glob('check_*.sage')} == set(_files)
for _filename in _files:
    __file__ = str(_directory / _filename)
    load(__file__)
assert len(_fpm_results) == 13
# 単射性を除くと、二点集合上の定値写像の点 1 は正の回数で戻らない。
f = {0: 0, 1: 0}
assert all(_fpm_iter(f, n, 1) != 1 for n in range(1, 20))
assert any(period == 1 for _, _, _, period in _fpm_periods)
assert any(period == 6 for _, _, _, period in _fpm_periods)
print('RESULT: PASS (%d permutations, %d starting points, %d collisions, %d line checks)' %
      (len(_fpm_permutations), len(_fpm_cases), len(_fpm_collisions), sum(_fpm_results.values())))
