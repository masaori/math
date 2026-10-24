from pathlib import Path
_second_dir = next(d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring' for d in (Path.cwd(), *Path.cwd().parents) if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-second-coloring').is_dir())
load(str(_second_dir.parent / 'matching-pair-coloring' / '_prelude.sage'))
