# 対象ラベル: claim_matching_pair_term_equality
# 帰属: 有限集合、整数の符号、QQ[x] の厳密な多項式等号。
from itertools import permutations
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

P = PolynomialRing(QQ, 'x')
x = P.gen()

def sign(word):
    assert sorted(word) == list(range(len(word)))
    return ZZ(-1) ** sum(word[i] > word[j]
                          for i in range(len(word)) for j in range(i + 1, len(word)))

def ascending(mate, chosen):
    return [(min(i, mate[i]), max(i, mate[i])) for i in chosen]

def entry(a, b):
    if a == b:
        return P.zero()
    if a > b:
        return -entry(b, a)
    return P(a + 1) + P((a + 1) * (b + 2)) * x + P(b + 1) * x**2

checked = 0
for tau, upsilon, p, q in CASES:
    C = set(color(tau, p))
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    for w in permutations(sorted(C)):
        w2 = [tau[i] for i in w]
        first = ascending(tau, w)
        second = ascending(upsilon, w2)
        alpha_tau = prod(ZZ(1) if a in C else ZZ(-1) for a, b in first)
        alpha_upsilon = prod(ZZ(1) if a not in C else ZZ(-1) for a, b in second)
        c_tau = sign([j for pair in first for j in pair])
        c_upsilon = sign([j for pair in second for j in pair])
        b_tau = prod(entry(a, b) for a, b in first)
        b_upsilon = prod(entry(a, b) for a, b in second)
        split = prod(entry(i, tau[i]) for i in C) * prod(entry(i, upsilon[i]) for i in range(len(tau)) if i not in C)
        assert prod(entry(i, sigma[i]) for i in range(len(tau))) == split
        assert split == P(alpha_tau * alpha_upsilon) * b_tau * b_upsilon
        assert sign(sigma) == alpha_tau * alpha_upsilon * c_tau * c_upsilon
        assert P(sign(sigma)) * prod(entry(i, sigma[i]) for i in range(len(tau))) == P(c_tau * c_upsilon) * b_tau * b_upsilon
        checked += 1

print('RESULT: PASS', checked, 'term identities including the empty set')
