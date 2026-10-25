# 対象ラベル: claim_matching_pair_word_map
# 第一色の端点列を置換で写した等号を、有限番号集合の厳密な整数演算で検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

seen = set()
for tau, upsilon, p, q, i in ROWS:
    key = (tau, upsilon)
    if key in seen:
        continue
    seen.add(key)
    C = color(tau, p)
    w = sorted(C)
    sigma = tuple(successor(tau, upsilon, C, j) for j in range(len(tau)))
    first_word = [part for c in w for part in (c, tau[c])]
    mapped_word = [sigma[j] for j in first_word]
    mapped_first = [part for c in w for part in (sigma[c], sigma[tau[c]])]
    replaced_first = [part for c in w for part in (tau[c], sigma[tau[c]])]
    second_word = [part for c in w for part in (tau[c], upsilon[tau[c]])]
    assert all(sigma[c] == tau[c] for c in w)
    assert all(tau[c] not in C and sigma[tau[c]] == upsilon[tau[c]] for c in w)
    assert mapped_word == mapped_first == replaced_first == second_word

assert [] == [j for j in []]
print('RESULT: PASS', len(seen), 'matching pairs and empty color')
