# 対象ラベル: claim_matching_pair_actual_monomial
# 帰属: 有限集合と QQ[x]。式ごとの比較は厳密な多項式等号。
from itertools import permutations
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

P = PolynomialRing(QQ, 'x')
x = P.gen()

def entry(a, b):
    return P(a + 1) + P((a + 1) * (b + 2)) * x + P(b + 1) * x**2

def pairs_from_matching(mate):
    return {(min(i, mate[i]), max(i, mate[i])) for i in range(len(mate))}

def pairs_from_list(mate, chosen):
    return [(min(i, mate[i]), max(i, mate[i])) for i in chosen]

def product_of_pairs(pairs):
    return prod(entry(a, b) for a, b in pairs)

checked = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    for w in permutations(sorted(C)):
        w2 = [tau[i] for i in w]
        first = pairs_from_list(tau, w)
        second = pairs_from_list(upsilon, w2)
        assert len(first) == len(set(first))
        assert len(second) == len(set(second))
        assert set(first) == pairs_from_matching(tau)
        assert set(second) == pairs_from_matching(upsilon)
        assert product_of_pairs(first) == product_of_pairs(pairs_from_matching(tau))
        assert product_of_pairs(second) == product_of_pairs(pairs_from_matching(upsilon))
        checked += 1

print('RESULT: PASS', checked, 'two-color monomial identities including the empty set')
