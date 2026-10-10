# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: sum_B (g(i0,b)*sum_F(S) W_S(f)) = sum_B sum_F(S) g(i0,b)*W_S(f)
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
        yield _fps_sum(g[i0,b]*_fps_sum(_fps_weight(S, g, f) for f in _fps_functions(S, B)) for b in B), _fps_sum(_fps_sum(g[i0, b]*_fps_weight(S, g, f) for f in _fps_functions(S, B)) for b in B)

_fps_verify(_fps_rows(), "induction_mul_sum")
