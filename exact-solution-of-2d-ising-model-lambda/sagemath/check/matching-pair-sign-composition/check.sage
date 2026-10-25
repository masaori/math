# 対象ラベル: claim_matching_pair_sign_composition
# 二色の列符号、向きの積、マッチング符号の合成を整数で検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

def word_sign(word):
    assert sorted(word) == list(range(len(word)))
    return ZZ(-1) ** sum(word[i] > word[j]
                          for i in range(len(word)) for j in range(i + 1, len(word)))

def pairs(m):
    return [(i, m[i]) for i in range(len(m)) if i < m[i]]

def orientation_sign(ps, chosen):
    return prod(ZZ(1) if a in chosen else ZZ(-1) for a, _ in ps)

checked = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    T = set(range(len(tau))) - set(C)
    w = sorted(C)
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    first = [j for c in w for j in (c, tau[c])]
    second = [j for c in w for j in (tau[c], upsilon[tau[c]])]
    assert sorted(first) == sorted(second) == list(range(len(tau)))
    D, E = pairs(tau), pairs(upsilon)
    alpha_D, alpha_E = orientation_sign(D, C), orientation_sign(E, T)
    sign_D = word_sign([j for pair in D for j in pair])
    sign_E = word_sign([j for pair in E for j in pair])
    assert word_sign(first) == alpha_D * sign_D
    assert word_sign(second) == alpha_E * sign_E
    assert word_sign(second) == word_sign(sigma) * word_sign(first)
    assert alpha_D * alpha_D == sign_D * sign_D == 1
    assert word_sign(sigma) == word_sign(sigma) * alpha_D ** 2
    assert word_sign(sigma) == word_sign(sigma) * alpha_D ** 2 * sign_D ** 2
    assert word_sign(sigma) == word_sign(sigma) * (alpha_D * sign_D) ** 2
    assert word_sign(sigma) == word_sign(sigma) * word_sign(first) ** 2
    assert word_sign(sigma) == word_sign(second) * word_sign(first)
    assert word_sign(sigma) == word_sign(second) * alpha_D * sign_D
    assert word_sign(sigma) == alpha_E * sign_E * alpha_D * sign_D
    assert word_sign(sigma) == alpha_D * alpha_E * sign_D * sign_E
    checked += 1

print('RESULT: PASS', checked, 'matching pairs including the empty set')
