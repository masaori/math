from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reconstructed-orbit' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-reconstructed-orbit').is_dir())
load(str(_dir.parent / 'matching-pair-permutation' / '_prelude.sage'))

def successor_orbit(tau, upsilon, C, i):
    points = set()
    j = i
    while j not in points:
        points.add(j)
        j = successor(tau, upsilon, C, j)
    assert j == i
    return points

DATA = [(tau, upsilon, p, q, i, color(tau, p)) for tau, upsilon, p, q, i in ROWS]
