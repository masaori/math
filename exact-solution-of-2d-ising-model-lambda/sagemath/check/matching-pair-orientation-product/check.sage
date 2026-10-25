# 対象ラベル: claim_matching_pair_orientation_product
from pathlib import Path

root = next(d for d in (Path.cwd(), *Path.cwd().parents)
            if (d / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orientation-product/check_pointwise.sage').is_file())
directory = root / 'exact-solution-of-2d-ising-model-lambda/sagemath/check/matching-pair-orientation-product'
load(str(directory / 'check_pointwise.sage'))
load(str(directory / 'check_finite_product.sage'))
