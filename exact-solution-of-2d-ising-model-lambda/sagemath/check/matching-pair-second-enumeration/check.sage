# 対象ラベル: claim_matching_pair_second_enumeration
# 第二色への全単射、第二マッチングの昇順対の全列挙、端点列の復元を厳密検算する。
from itertools import permutations
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

checked = 0
for tau, upsilon, p, q in CASES:
    C = set(color(tau, p))
    C2 = set(range(len(tau))) - C
    actual_pairs = {(min(i, upsilon[i]), max(i, upsilon[i])) for i in range(len(tau))}
    for w in permutations(sorted(C)):
        w2 = [tau[c] for c in w]
        assert len(w2) == len(set(w2))
        assert set(w2) == C2
        ascending = [(min(d, upsilon[d]), max(d, upsilon[d])) for d in w2]
        assert len(ascending) == len(set(ascending))
        assert set(ascending) == actual_pairs
        restored = [(a, b) if a in C2 else (b, a) for a, b in ascending]
        assert restored == [(d, upsilon[d]) for d in w2]
        checked += 1

print('RESULT: PASS', checked, 'second-color enumerations including the empty set')
