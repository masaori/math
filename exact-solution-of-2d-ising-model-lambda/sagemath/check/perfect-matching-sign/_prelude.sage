from itertools import permutations

def matching_families(vertices):
    if not vertices:
        return [frozenset()]
    a = vertices[0]
    return [D | frozenset((frozenset((a, b)),))
            for b in vertices[1:]
            for D in matching_families(tuple(x for x in vertices if x != a and x != b))]

def oriented_pairs(D):
    return tuple(sorted(tuple(sorted(p)) for p in D))

def pair_word(L):
    return tuple(x for p in L for x in p)

def complete_word(J, w):
    return len(set(w)) == len(w) and set(w) == set(J)

def word_permutation(J, w):
    assert complete_word(J, w)
    return dict(zip(J, w))

def inversion_count(w):
    return sum(w[j] < w[i] for i in range(len(w)) for j in range(i + 1, len(w)))

def word_sign(w):
    return ZZ(-1) ** inversion_count(w)

def permutation_sign(J, p):
    return word_sign(tuple(p[x] for x in J))

def swap_permutation(J, a, b):
    return {x: b if x == a else a if x == b else x for x in J}

def compose(p, q):
    return {x: p[q[x]] for x in q}

def adjacent_route(source, target):
    current = list(source)
    route = [tuple(current)]
    for k, p in enumerate(target):
        i = current.index(p)
        assert i >= k
        while i > k:
            current[i - 1], current[i] = current[i], current[i - 1]
            i -= 1
            route.append(tuple(current))
    assert tuple(current) == target
    return route

_matching_cases = []
_enumeration_cases = []
_word_swap_cases = []
_block_swap_cases = []
for n in range(9):
    J = tuple(3 * i + 2 for i in range(n))
    for D in matching_families(J):
        canonical = oriented_pairs(D)
        _matching_cases.append((J, D, canonical))
        for L in permutations(canonical):
            w = pair_word(L)
            _enumeration_cases.append((J, D, canonical, L, w))
            for i in range(n - 1):
                a, b = w[i:i + 2]
                wp = w[:i] + (b, a) + w[i + 2:]
                _word_swap_cases.append((J, w, wp, a, b))
            for i in range(len(L) - 1):
                a, b = L[i]
                c, d = L[i + 1]
                U, V = w[:2 * i], w[2 * i + 4:]
                w0 = U + (a, b, c, d) + V
                w1 = U + (a, c, b, d) + V
                w2 = U + (c, a, b, d) + V
                w3 = U + (c, a, d, b) + V
                w4 = U + (c, d, a, b) + V
                _block_swap_cases.append((J, w0, w1, w2, w3, w4))
assert len(_matching_cases) == 125
assert len(_enumeration_cases) == 2618
assert len(_word_swap_cases) == 18109
assert len(_block_swap_cases) == 7746
_matching_sign_cases_ready = True
