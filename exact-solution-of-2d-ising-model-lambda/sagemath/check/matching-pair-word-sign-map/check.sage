# 対象ラベル: claim_matching_pair_word_sign_map
# 有限端点列を置換で写したときの符号の乗法性を整数で検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

def word_sign(word):
    assert sorted(word) == list(range(len(word)))
    inversions = sum(word[i] > word[j]
                     for i in range(len(word)) for j in range(i + 1, len(word)))
    return ZZ(-1) ** inversions

checked = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    w = sorted(C)
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    first = [j for c in w for j in (c, tau[c])]
    second = [j for c in w for j in (tau[c], upsilon[tau[c]])]
    assert sorted(first) == list(range(len(tau)))
    mapped = [sigma[j] for j in first]
    assert second == mapped
    assert word_sign(second) == word_sign(mapped)
    assert word_sign(mapped) == word_sign(sigma) * word_sign(first)
    checked += 1

assert word_sign([]) == 1
print('RESULT: PASS', checked, 'matching pairs and empty word')
