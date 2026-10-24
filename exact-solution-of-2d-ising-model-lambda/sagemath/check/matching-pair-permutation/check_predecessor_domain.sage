# 対象ラベル: claim_matching_pair_permutation
# 本文の行: predecessor(tau, upsilon, C, i) in range(len(tau))
# 帰属: 有限番号集合。整数と集合の厳密比較。
from pathlib import Path
_perm_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation').is_dir())
load(str(_perm_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in ROWS:
    C = color(tau, p)
    assert predecessor(tau, upsilon, C, i) in range(len(tau))
print('RESULT: PASS predecessor_domain', len(ROWS))
