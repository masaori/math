from pathlib import Path
_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-successor-color').is_dir())
load(str(_dir.parent / 'matching-pair-permutation' / '_prelude.sage'))
