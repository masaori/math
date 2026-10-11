from itertools import permutations, combinations

def pair(a, b):
    return frozenset((a, b))

def matching_families(vertices):
    if not vertices:
        return [frozenset()]
    a = vertices[0]
    result = []
    for b in vertices[1:]:
        rest = tuple(x for x in vertices if x != a and x != b)
        for D in matching_families(rest):
            result.append(D | frozenset((pair(a, b),)))
    return result

def is_matching(J, D):
    return (all(len(p) == 2 and p <= frozenset(J) for p in D)
            and all(sum(i in p for p in D) == 1 for i in J))

def candidates(J, D, i):
    return [j for j in J if j != i and pair(i, j) in D]

def mate(J, D, i):
    values = candidates(J, D, i)
    assert len(values) == 1
    return values[0]

def involution_pairs(J, tau):
    return frozenset(pair(i, tau[i]) for i in J)

_pm_cases = []
_inv_cases = []
for n in range(9):
    J = tuple(3 * i + 2 for i in range(n))
    _pm_cases.extend((J, D) for D in matching_families(J))
    for values in permutations(J):
        tau = dict(zip(J, values))
        if all(tau[i] != i and tau[tau[i]] == i for i in J):
            _inv_cases.append((J, tau))
assert len(_pm_cases) == 125
assert len(_inv_cases) == 125

def matching_pairs():
    for J, D in _pm_cases:
        for p in D:
            a, b = sorted(p)
            yield J, D, p, a, b

def matching_points():
    for J, D in _pm_cases:
        for i in J:
            yield J, D, i

def involution_points():
    for J, tau in _inv_cases:
        for k in J:
            yield J, tau, k
