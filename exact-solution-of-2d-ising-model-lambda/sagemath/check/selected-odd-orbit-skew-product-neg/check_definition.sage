# 対象ラベル: claim_selected_odd_orbit_skew_product_neg
# 定義を独立な計算と照合し、本文の両結論と標本の非退化性を検査する。
from pathlib import Path
load(str(Path(__file__).with_name("_prelude.sage")))

assert sop_target_counts == {0: 0, 1: 0, 2: 0, 3: 4, 4: 0, 5: 88, 6: 80}
for r in sop_rows:
    sigma, tau, subset = r['sigma'], r['tau'], r['subset']
    n = len(sigma)
    assert tuple(sorted(tau)) == tuple(range(n))
    assert all(sigma[i] != i for i in range(n))
    assert subset == sop_orbit(sigma, r['start'])
    assert {sop_return_time(sigma, i) for i in subset} == {ZZ(len(subset))}
    assert sop_sign(sigma, r['rank']) == Permutation([i + 1 for i in sigma]).signature()
    assert sop_sign(tau, r['rank']) == Permutation([i + 1 for i in tau]).signature()
    assert tau == tuple(r['inverse'][i] if i in subset else sigma[i] for i in range(n))
    assert {sigma[i] for i in subset} == set(subset)
    assert {r['inverse'][i] for i in subset} == set(subset)

for (n, family), A in sop_matrices.items():
    assert A.base_ring() == sop_ring
    assert all(A[j, i] == -A[i, j] for i in range(n) for j in range(n))
    assert sop_product(A, (), tuple(range(n))) == sop_ring.one()

nonzero = {family: 0 for family in ('dense', 'zero', 'sparse')}
for r in sop_matrix_rows:
    assert r['all_tau'] == -r['all_sigma'], r
    assert r['c_tau'] * r['all_tau'] == -(r['c_sigma'] * r['all_sigma']), r
    if r['all_sigma'] != 0:
        nonzero[r['family']] += 1
    if not r['outside']:
        assert r['Q_sigma'] == sop_ring.one() == r['Q_tau']

empty_outside = sum(not r['outside'] for r in sop_rows)
two_odd_orbits = sum(len(set(r['supports'].values())) == 2
                     and all(len(c) % 2 == 1 for c in set(r['supports'].values()))
                     for r in sop_rows)
signs = {sign: sum(sop_sign(r['sigma'], r['rank']) == sign for r in sop_rows)
         for sign in (-1, 1)}
assert nonzero['dense'] == 172 and nonzero['zero'] == 0 and nonzero['sparse'] > 0
assert empty_outside > 0 and two_odd_orbits > 0
assert all(signs[sign] > 0 for sign in (-1, 1))
print('RESULT: PASS definition (874 permutations; 1746 ordered permutations; '
      + str(len(sop_rows)) + ' target rows; ' + str(len(sop_matrix_rows)) + ' matrix rows; '
      + 'nonzero=' + str(nonzero) + '; empty_outside=' + str(empty_outside)
      + '; two_odd_orbits=' + str(two_odd_orbits) + '; signs=' + str(signs) + ')')
