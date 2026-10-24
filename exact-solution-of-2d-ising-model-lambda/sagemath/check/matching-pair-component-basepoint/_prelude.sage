from pathlib import Path
load(str((next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-component-basepoint').is_dir())).parent / 'matching-pair-orbit-exchange' / '_prelude.sage'))


def component(tau, p, i):
    return orbit(p, i) | orbit(p, tau[i])


LEFT = [(tau, upsilon, p, q, i, j) for tau, upsilon, p, q, i in ROWS
        for j in orbit(p, i)]
RIGHT = [(tau, upsilon, p, q, i, j) for tau, upsilon, p, q, i in ROWS
         for j in orbit(p, tau[i])]
