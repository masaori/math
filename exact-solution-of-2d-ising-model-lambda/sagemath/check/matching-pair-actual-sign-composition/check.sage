# 対象ラベル: claim_matching_pair_actual_sign_composition
# 帰属: 有限番号集合の列と整数の符号。厳密な有限演算のみ。
from itertools import permutations
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

def word_sign(word):
    assert sorted(word) == list(range(len(word)))
    return ZZ(-1) ** sum(word[i] > word[j]
                          for i in range(len(word)) for j in range(i + 1, len(word)))

def ascending_pairs(mate, chosen):
    return [(min(c, mate[c]), max(c, mate[c])) for c in chosen]

def oriented_word(pairs, chosen):
    return [j for a, b in pairs for j in ((a, b) if a in chosen else (b, a))]

def orientation_sign(pairs, chosen):
    return prod(ZZ(1) if a in chosen else ZZ(-1) for a, _ in pairs)

checked = 0
for tau, upsilon, p, q in CASES:
    C = set(color(tau, p))
    C2 = set(range(len(tau))) - C
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    for w in permutations(sorted(C)):
        w2 = [tau[c] for c in w]
        first = [j for c in w for j in (c, tau[c])]
        second = [j for d in w2 for j in (d, upsilon[d])]
        pairs_tau = ascending_pairs(tau, w)
        pairs_upsilon = ascending_pairs(upsilon, w2)
        assert sorted(first) == list(range(len(tau)))  # 完全列挙
        assert len(set(pairs_tau)) == len(pairs_tau)
        assert len(set(pairs_upsilon)) == len(pairs_upsilon)
        assert oriented_word(pairs_tau, C) == first  # 第一の列の一致
        assert oriented_word(pairs_upsilon, C2) == second  # 第二の列の一致
        alpha_tau = orientation_sign(pairs_tau, C)
        alpha_upsilon = orientation_sign(pairs_upsilon, C2)
        sign_tau = word_sign([j for pair in pairs_tau for j in pair])
        sign_upsilon = word_sign([j for pair in pairs_upsilon for j in pair])
        assert word_sign(sigma) == alpha_tau * alpha_upsilon * sign_tau * sign_upsilon
        checked += 1

print('RESULT: PASS', checked, 'actual two-color enumerations including the empty set')
