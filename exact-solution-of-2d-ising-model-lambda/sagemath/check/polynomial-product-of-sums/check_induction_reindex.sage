# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: sum_{B x F(S)} W_Splus(ins(b,f)) = sum_F(Splus) W_Splus(h)
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
        yield _fps_sum(_fps_weight(Sp, g, _fps_insert(S, i0, b, f)) for b, f in _fps_cartesian(B, _fps_functions(S, B))), _fps_sum(_fps_weight(Sp, g, h) for h in _fps_functions(Sp, B))

_fps_verify(_fps_rows(), "induction_reindex")
