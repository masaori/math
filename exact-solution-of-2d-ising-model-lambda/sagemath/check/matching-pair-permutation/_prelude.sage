from pathlib import Path
_perm_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-permutation').is_dir())
load(str(_perm_dir.parent / 'matching-pair-coloring' / '_prelude.sage'))

def successor(tau, upsilon, C, i):
    return tau[i] if i in C else upsilon[i]

def predecessor(tau, upsilon, C, i):
    return upsilon[i] if i in C else tau[i]
