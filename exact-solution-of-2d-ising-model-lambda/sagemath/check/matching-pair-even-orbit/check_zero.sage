from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, C, i in DATA:
    assert sequence(tau, upsilon, C, i)[0] == i
print('PASS zero', len(DATA))
