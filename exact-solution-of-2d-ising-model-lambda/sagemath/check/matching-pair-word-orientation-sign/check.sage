# 対象ラベル: claim_matching_pair_word_orientation_sign
# 有限番号集合と整数の厳密計算。二色を同じ端点交換の論法で検算する。
from pathlib import Path
from itertools import permutations

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

def sign_of_word(word):
    assert set(word) == set(range(len(word))) and len(set(word)) == len(word)
    inversions = sum(word[i] > word[j] for i in range(len(word)) for j in range(i + 1, len(word)))
    result = ZZ(-1) ** inversions
    assert result == ZZ(Permutation([i + 1 for i in word]).signature())
    return result

checked = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    J = set(range(len(tau)))
    for mate, S in ((tau, C), (upsilon, J - C)):
        pairs = tuple(sorted({tuple(sorted((i, mate[i]))) for i in J}))
        canonical_sign = sign_of_word([point for pair in pairs for point in pair])
        for L in permutations(pairs):
            sorted_word = [point for pair in L for point in pair]
            assert len(sorted_word) == len(J) and set(sorted_word) == J
            assert sign_of_word(sorted_word) == canonical_sign
            oriented_word = list(sorted_word)
            orientation_product = ZZ(1)
            for k, (a, b) in enumerate(L):
                assert len({a, b} & S) == 1
                eta = ZZ(1) if a in S else ZZ(-1)
                previous_sign = sign_of_word(oriented_word)
                if eta == -1:
                    oriented_word[2*k], oriented_word[2*k+1] = oriented_word[2*k+1], oriented_word[2*k]
                assert sign_of_word(oriented_word) == eta * previous_sign
                orientation_product *= eta
            assert sign_of_word(oriented_word) == orientation_product * canonical_sign
            checked += 1

assert sign_of_word([]) == 1
print('RESULT: PASS', checked, 'oriented matching words and empty word')
