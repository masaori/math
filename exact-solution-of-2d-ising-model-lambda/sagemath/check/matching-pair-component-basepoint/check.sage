# 対象ラベル: claim_matching_pair_component_basepoint
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint').is_dir())
load(str(_dir / '_prelude.sage'))
for file in sorted(_dir.glob('check_*.sage')):
    load(str(file))
count = 0
for tau, upsilon, p, q in CASES:
    for i in range(len(tau)):
        for j in component(tau,p,i):
            assert component(tau,p,j) == component(tau,p,i)
            count += 1
assert len(CASES) == 236
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', count, 'basepoint changes')
