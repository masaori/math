# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: prod_Splus sum_B g = (sum_B g(i0,b))*prod_S sum_B g
# 帰属: Q(zeta_8)[x]、有限集合と写像。厳密計算。
import os
import sys

if "_fps_cases" not in globals():
    _fps_check_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.isfile(os.path.join(_fps_check_dir, "_prelude.sage")):
        _fps_check_dir = os.path.dirname(os.path.abspath(sys.argv[0]))
    load(os.path.join(_fps_check_dir, "_prelude.sage"))

def _fps_rows():
    for A, B, g, S, i0, Sp in _fps_steps():
        yield _fps_product(Sp, B, g), _fps_sum(g[i0, b] for b in B)*_fps_product(S, B, g)

_fps_verify(_fps_rows(), "induction_product_insert")
