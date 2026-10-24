from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit').is_dir())
load(str(_dir / '_prelude.sage'))
for tau, upsilon, C, i in DATA:
    e = sequence(tau, upsilon, C, i)
    for n, j in enumerate(e):
        assert (j in C) == ((n % 2 == 0) == (i in C))
print('PASS parity', len(DATA))
