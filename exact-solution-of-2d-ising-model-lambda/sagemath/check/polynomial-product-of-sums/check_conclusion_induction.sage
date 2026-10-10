# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: prod_A sum_B g = sum_F(A) W_A(f)
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
        yield _fps_product(A, B, g), _fps_sum(_fps_weight(A, g, f) for f in _fps_functions(A, B))

_fps_verify(_fps_rows(), "conclusion_induction")
