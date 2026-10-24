from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-even-orbit').is_dir())
load(str(_dir.parent / 'matching-pair-permutation' / '_prelude.sage'))

def sequence(tau, upsilon, C, i):
    points = [i]
    j = successor(tau, upsilon, C, i)
    while j != i:
        assert j not in points
        points.append(j)
        j = successor(tau, upsilon, C, j)
    return points

DATA = [(tau, upsilon, color(tau, p), i) for tau, upsilon, p, q, i in ROWS]
