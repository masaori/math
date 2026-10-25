# 対象ラベル: claim_matching_pair_first_enumeration
# 各昇順対の重複なし・全対被覆・端点列の復元を整数で厳密に検算する。
from itertools import permutations
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

checked = 0
for tau, upsilon, p, q in CASES:
    C = set(color(tau, p))
    actual_pairs = {(min(i, tau[i]), max(i, tau[i])) for i in range(len(tau))}
    for w in permutations(sorted(C)):
        oriented = [(c, tau[c]) for c in w]
        ascending = [(min(c, tau[c]), max(c, tau[c])) for c in w]
        assert len(ascending) == len(set(ascending))
        assert set(ascending) == actual_pairs
        restored = [(a, b) if a in C else (b, a) for a, b in ascending]
        assert restored == oriented
        assert [x for pair in restored for x in pair] == [x for pair in oriented for x in pair]
        checked += 1

print('RESULT: PASS', checked, 'first-color enumerations including the empty set')
