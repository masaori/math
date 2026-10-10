# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: (ins(b,f)(i0),ins(b,f)|S) = (b,ins(b,f)|S)
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
        for b in B:
            for f in _fps_functions(S, B):
                yield (_fps_at(_fps_insert(S, i0, b, f), Sp, i0), _fps_restrict(_fps_insert(S, i0, b, f), Sp, S)), (b, _fps_restrict(_fps_insert(S, i0, b, f), Sp, S))

_fps_verify(_fps_rows(), "split_insert_new_value")
