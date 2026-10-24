# 対象ラベル: claim_matching_pair_reconstructed_orbit
from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reconstructed-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reconstructed-orbit').is_dir())
for file in sorted(_dir.glob('check_*.sage')):
    load(str(file))
assert len(CASES) == 236
print('RESULT: PASS integrated', len(CASES), 'ordered pairs;', len(DATA), 'points')
