# 対象ラベル: claim_matching_pair_second_coloring_alternates
# 本文の行: p[tau[i]] == upsilon[tau[tau[i]]]
# 有限番号集合と所属の厳密比較。
from pathlib import Path
_second_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring').is_dir())
load(str(_second_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in ROWS:
    assert p[tau[i]] == upsilon[tau[tau[i]]]
print("RESULT: PASS second_step_definition", len(ROWS))
