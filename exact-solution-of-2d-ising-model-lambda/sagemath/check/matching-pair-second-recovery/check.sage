# 対象ラベル: claim_matching_pair_second_recovery
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-recovery').is_dir())
for file in sorted(_dir.glob('check_*.sage')):
    load(str(file))
assert len(DATA) == 1388
assert len(CASES) == 236
print('RESULT: PASS integrated', len(DATA), 'points')
