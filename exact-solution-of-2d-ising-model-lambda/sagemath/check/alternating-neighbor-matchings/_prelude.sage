# 対象ラベル: def_alternating_neighbor_pairs, claim_alternating_neighbor_matchings
# 自然数の有限集合・写像・部分集合を厳密に扱う。結論で入力を絞らない。
from collections import Counter, namedtuple
from itertools import combinations, permutations

_AnmCase = namedtuple('_AnmCase', 'J sigma inverse C tau eta')

def _anm_inverse(J, sigma):
    # 各像の原像を探索し、隣接点写像とは独立に逆置換を作る。
    inverse = {i: next(j for j in J if sigma[j] == i) for i in J}
    assert all(inverse[sigma[i]] == i and sigma[inverse[i]] == i for i in J)
    return inverse

def _anm_neighbor_pairs(J, sigma, inverse, C):
    return frozenset(frozenset((i, sigma[i] if i in C else inverse[i])) for i in J)

def _anm_involution_pairs(J, partner):
    return frozenset(frozenset((i, partner[i])) for i in J)

def _anm_is_involution(J, partner):
    return (set(partner) == set(J)
            and all(partner[i] in J for i in J)
            and all(partner[i] != i and partner[partner[i]] == i for i in J))

def _anm_is_matching(J, family):
    # 対合性を使わず、二元性と各点を含む対の存在・一意性を直接調べる。
    return (isinstance(family, frozenset)
            and all(isinstance(pair, frozenset) and len(pair) == 2
                    and pair <= frozenset(J) for pair in family)
            and all(sum(i in pair for pair in family) == 1 for i in J))

def _anm_cycle_type(J, sigma):
    unseen = set(J)
    lengths = []
    while unseen:
        i = min(unseen)
        orbit = set()
        while i not in orbit:
            orbit.add(i)
            i = sigma[i]
        unseen.difference_update(orbit)
        lengths.append(len(orbit))
    return tuple(sorted(lengths))

_anm_cases = []
_anm_candidates_by_size = Counter()
for _anm_n in range(7):
    _anm_J = tuple(3 * i + 2 for i in range(_anm_n))
    for _anm_values in permutations(_anm_J):
        _anm_sigma = dict(zip(_anm_J, _anm_values))
        _anm_inverse_sigma = _anm_inverse(_anm_J, _anm_sigma)
        for _anm_size in range(_anm_n + 1):
            for _anm_subset in combinations(_anm_J, _anm_size):
                _anm_C = frozenset(_anm_subset)
                _anm_candidates_by_size[_anm_n] += 1
                if not all((_anm_sigma[i] in _anm_C) == (i not in _anm_C)
                           for i in _anm_J):
                    continue
                _anm_tau = {i: _anm_sigma[i] if i in _anm_C else _anm_inverse_sigma[i]
                            for i in _anm_J}
                _anm_eta = {i: _anm_inverse_sigma[i] if i in _anm_C else _anm_sigma[i]
                            for i in _anm_J}
                _anm_cases.append(_AnmCase(_anm_J, _anm_sigma, _anm_inverse_sigma,
                                          _anm_C, _anm_tau, _anm_eta))

def _anm_points(color=None):
    for case in _anm_cases:
        for i in case.J:
            if color is None or (i in case.C) == color:
                yield case, i

_anm_results = {}
def _anm_record(name, count, expected, kind):
    assert count == expected, (name, count, expected)
    assert name not in _anm_results, ('duplicate check', name)
    _anm_results[name] = (count, kind)
    print('RESULT: PASS (%s: %d %s)' % (name, count, kind))

def _anm_check_coverage():
    candidates = {n: _anm_candidates_by_size[n] for n in range(7)}
    assert candidates == {0: 1, 1: 2, 2: 8, 3: 48, 4: 384, 5: 3840, 6: 46080}
    sizes = {n: sum(len(case.J) == n for case in _anm_cases) for n in range(7)}
    assert sizes == {0: 1, 1: 0, 2: 2, 3: 0, 4: 24, 5: 0, 6: 720}
    cycles = Counter(_anm_cycle_type(case.J, case.sigma) for case in _anm_cases)
    assert dict(cycles) == {(): 1, (2,): 2, (2, 2): 12, (4,): 12,
                            (2, 2, 2): 120, (2, 4): 360, (6,): 240}
    assert len(_anm_cases) == 747
    assert sum(1 for _ in _anm_points()) == 4420
    assert sum(1 for _ in _anm_points(True)) == 2210
    assert sum(1 for _ in _anm_points(False)) == 2210
    equal_components = 0
    for case in _anm_cases:
        first = _anm_neighbor_pairs(case.J, case.sigma, case.inverse, case.C)
        second = _anm_neighbor_pairs(case.J, case.inverse, case.sigma, case.C)
        ordered_pair = (first, second)
        equal_components += first == second
        if not case.J:
            assert ordered_pair == (frozenset(), frozenset())
        if len(case.J) == 2:
            assert first == second and len(first) == 1 and len(ordered_pair) == 2
        if _anm_cycle_type(case.J, case.sigma) in ((4,), (6,)):
            assert first != second
    assert equal_components == 135
    # 判定器が二元性・存在・一意性をそれぞれ拒否できることも確かめる。
    assert _anm_is_matching((), frozenset())
    assert not _anm_is_matching((2,), frozenset((frozenset((2,)),)))
    assert not _anm_is_matching((2, 5), frozenset())
    assert not _anm_is_matching((2, 5, 8), frozenset((frozenset((2, 5)), frozenset((2, 8)))))
    print('COVERAGE: %d candidates; %d alternating inputs; 4420 points (2210 per color)'
          % (sum(candidates.values()), len(_anm_cases)))
    print('COVERAGE: by size %s; cycle types %s; 135 equal-component ordered pairs'
          % (sizes, dict(cycles)))
