# 対象ラベル: claim_matching_pair_first_word_complete
# 第一色から作る二端点列の重複なし・全点被覆・対合の等号を厳密に検算する。
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage').is_file())
load(str(root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-bijection/_prelude.sage'))

checked = 0
for tau, upsilon, p, q in CASES:
    C = color(tau, p)
    w = sorted(C)
    word = [x for c in w for x in (c, tau[c])]
    assert len(word) == len(set(word))
    assert set(word) == set(range(len(tau)))
    for x in range(len(tau)):
        assert tau[tau[x]] == x
        if x not in C:
            assert tau[x] in C
            assert x == tau[tau[x]]
            c_r = tau[x]
            assert tau[tau[x]] == tau[c_r]
    checked += 1

print('RESULT: PASS', checked, 'matching pairs including the empty set')
