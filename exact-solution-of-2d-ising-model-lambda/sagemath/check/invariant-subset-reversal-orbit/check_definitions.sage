# 対象ラベル: def_finite_permutation_orbit, def_finite_permutation_orbit_length
# 順逆の反復による台・長さを、辺 {k, sigma(k)} の無向到達性と照合する。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_prelude.sage"))

assert len(isro_permutations) == 874
assert len(isr_cases) == 5913
assert () in isro_permutations
assert sum(len(sigma) == 0 for sigma, C, *rest in isr_cases) == 1
assert sum(not C for sigma, C, *rest in isr_cases) == 874
assert sum(C == frozenset(range(len(sigma))) for sigma, C, *rest in isr_cases) == 874

basepoint_count = 0
membership_count = 0
for sigma in isro_permutations:
    inv = inverse_permutation(sigma)
    assert inverse_permutation(inv) == sigma
    for i in range(len(sigma)):
        reachable = undirected_reachable(sigma, i)
        for direction in (sigma, inv):
            trace, repeated = iteration_until_repeat(direction, i)
            assert trace[0] == i
            assert repeated == i
            assert len(trace) == len(set(trace))
            # 閉路を一周し、閉包条件を満たすため、任意回の反復がこの集合に収まる。
            assert tuple(direction[value] for value in trace) == trace[1:] + (i,)
            assert frozenset(trace) == reachable
        pair_trace, pair_repeated = paired_iteration_until_repeat(sigma, inv, i)
        assert pair_trace[0] == (i, i)
        assert pair_repeated == (i, i)
        assert len(pair_trace) == len(set(pair_trace))
        assert tuple((sigma[a], inv[b]) for a, b in pair_trace) == pair_trace[1:] + ((i, i),)
        assert orbit_support(sigma, i) == reachable
        assert orbit_length(sigma, i) == len(reachable)
        assert 1 <= orbit_length(sigma, i) <= len(sigma)
        basepoint_count += 1
        for j in range(len(sigma)):
            assert either_iterate_membership(sigma, inv, i, j) == (j in reachable)
            membership_count += 1

orbit_report("definitions/basepoints", basepoint_count, 5039)
orbit_report("definitions/memberships", membership_count, 29367)
