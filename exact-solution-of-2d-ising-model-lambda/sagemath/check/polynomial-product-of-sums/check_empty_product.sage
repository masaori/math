# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: prod_empty sum_B g = 1
# 帰属: Q(zeta_8)[x]、有限集合と写像。厳密計算。
import os
import sys

if "_fps_cases" not in globals():
    _fps_check_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_fps_check_dir, "_prelude.sage")):
        _fps_check_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_fps_check_dir, "_prelude.sage"))

def _fps_rows():
    for A, B, g in _fps_cases:
        yield _fps_product((), B, g), _fps_ring.one()

_fps_verify(_fps_rows(), "empty_product")
