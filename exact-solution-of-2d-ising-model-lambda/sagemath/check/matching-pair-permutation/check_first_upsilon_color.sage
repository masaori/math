# 対象ラベル: claim_matching_pair_permutation
# 本文の行: upsilon[i] not in C
# 帰属: 有限番号集合。整数と集合の厳密比較。
from pathlib import Path
_perm_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation').is_dir())
load(str(_perm_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in FIRST_ROWS:
    C = color(tau, p)
    assert upsilon[i] not in C
print('RESULT: PASS first_upsilon_color', len(FIRST_ROWS))
