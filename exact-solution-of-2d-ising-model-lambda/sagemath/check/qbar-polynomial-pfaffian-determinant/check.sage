# 対象ラベル: claim_qbar_polynomial_pfaffian_square_determinant
# 零対角反対称行列の独立な変数で、本文の有限和の各等号を検算する。
from itertools import permutations


def matchings(vertices):
    if not vertices:
        yield ()
        return
    i = vertices[0]
    for k in range(1, len(vertices)):
        j = vertices[k]
        rest = vertices[1:k] + vertices[k + 1:]
        for tail in matchings(rest):
            yield ((i, j),) + tail


def cycles(p):
    seen = set()
    for i in range(len(p)):
        if i in seen:
            continue
        j = i
        length = 0
        while j not in seen:
            seen.add(j)
            length += 1
            j = p[j]
        yield length


def sign(word):
    return (-1) ** sum(word[i] > word[j]
                       for i in range(len(word)) for j in range(i + 1, len(word)))


for n in (0, 2, 4, 6):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    R = PolynomialRing(QQ, ['a_%s_%s' % pair for pair in pairs]) if pairs else QQ
    A = {(i, i): R(0) for i in range(n)}
    for pair, variable in zip(pairs, R.gens() if pairs else ()):
        i, j = pair
        A[i, j], A[j, i] = variable, -variable

    all_terms = R(0)
    derangements = R(0)
    even_terms = R(0)
    odd_terms = R(0)
    for p in permutations(range(n)):
        term = R(sign(p))
        for i in range(n):
            term *= A[i, p[i]]
        all_terms += term
        if all(p[i] != i for i in range(n)):
            derangements += term
            if all(length % 2 == 0 for length in cycles(p)):
                even_terms += term
            else:
                odd_terms += term

    monomials = []
    for matching in matchings(tuple(range(n))):
        word = tuple(v for pair in matching for v in pair)
        term = R(sign(word))
        for i, j in matching:
            term *= A[i, j]
        monomials.append(term)
    pair_sum = sum((u * v for u in monomials for v in monomials), R(0))
    pf = sum(monomials, R(0))
    assert all_terms == derangements
    assert derangements == even_terms + odd_terms
    assert odd_terms == R(0)
    assert even_terms == pair_sum
    assert pair_sum == pf ** 2
    print('PASS: |J| = %s, Pfaffian の平方 = 行列式' % n)
