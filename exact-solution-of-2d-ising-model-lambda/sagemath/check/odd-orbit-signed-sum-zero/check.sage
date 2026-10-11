from pathlib import Path
import json
import sys

check_source = Path(globals().get('__file__', sys.argv[0])).resolve()
if not (check_source.parent / '_prelude.sage').is_file():
    check_source = Path(sys.argv[0]).resolve()
check_dir = check_source.parent
check_paths = sorted(check_dir.glob('check_*.sage'))
assert len(check_paths) == 29
for check_path in check_paths:
    __file__ = str(check_path)
    load(__file__)
assert len(oss_results) == 29
assert any(r['n'] == 0 and not r['D'] for r in oss_groups)
assert any(r['n'] == 4 and not r['D'] for r in oss_groups)
assert any(r['n'] == 5 and r['D'] for r in oss_groups)
assert any(r['n'] == 6 and r['D'] for r in oss_groups)
assert any(not r['R'] for r in oss_stages)
assert any(r['R'] for r in oss_stages)
assert any(r['weights'][r['rho']] != 0 for r in oss_terms)
for r in oss_groups:
    assert all(r['A'][j, i] == -r['A'][i, j]
               for i in range(r['n']) for j in range(r['n']))
    assert all(all(r['F'][rho] in S for rho in S) for S in r['subsets'])
for r in oss_stages:
    # 背理法の局所標本は実在するが、残り集合では仮定を満たせない。
    assert r['tau'] not in r['R'] and r['sigma'] not in r['R']
    assert all(r['F'][rho] != r['sigma'] and r['F'][rho] != r['tau']
               for rho in r['R'])
metadata = dict(permutations=oss_permutations,
                ordered_permutations=oss_ordered_permutations,
                targets=oss_targets, matrix_groups=len(oss_groups),
                matrix_terms=len(oss_terms),
                closed_subsets=sum(len(r['subsets']) for r in oss_groups),
                stages=len(oss_stages), remaining_points=len(oss_remaining),
                empty_targets=sum(not r['D'] for r in oss_groups),
                empty_remainders=sum(not r['R'] for r in oss_stages),
                total_checks=sum(oss_results.values()))
print('SAMPLE_COUNTS: ' + json.dumps(metadata, sort_keys=True, default=int))
print('ROW_COUNTS: ' + json.dumps(oss_results, sort_keys=True, default=int))
print('RESULT: PASS (29 rows; ' + str(sum(oss_results.values())) + ' exact checks)')
