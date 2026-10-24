from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-coloring').is_dir())
load(str(_dir.parent / 'matching-pair-orbit-exchange' / '_prelude.sage'))

def component(tau, p, i):
    return orbit(p, i) | orbit(p, tau[i])

def minimum(tau, p, i):
    return min(component(tau, p, i))

def color(tau, p):
    return frozenset(i for i in range(len(tau)) if i in orbit(p, minimum(tau, p, i)))

BASEPOINT_ROWS = [(tau, upsilon, p, q, i, j) for tau, upsilon, p, q, i in ROWS for j in component(tau, p, i)]
FIRST_ROWS = [row for row in ROWS if row[-1] in orbit(row[2], minimum(row[0], row[2], row[-1]))]
SECOND_ROWS = [row for row in ROWS if row not in FIRST_ROWS]
assert len(BASEPOINT_ROWS) == 6424
assert len(FIRST_ROWS) == len(SECOND_ROWS) == 694
