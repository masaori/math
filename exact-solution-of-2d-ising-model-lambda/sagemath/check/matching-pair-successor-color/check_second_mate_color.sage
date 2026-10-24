# 対象ラベル: claim_matching_pair_successor_color
# 第二色で υ(i) は第一色。有限番号集合と整数だけを使う。
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, p, q, i in SECOND_ROWS:
    C = color(tau, p)
    assert upsilon[i] in C
print('RESULT: PASS second_mate_color', len(SECOND_ROWS))
