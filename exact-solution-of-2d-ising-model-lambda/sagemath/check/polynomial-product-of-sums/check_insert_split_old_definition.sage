# 対象ラベル: claim_polynomial_product_of_sums
# 式ペア: ins(spl(h))(i) = ins(h(i0),h|S)(i), i in S
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
        for h in _fps_functions(Sp, B):
            for i in S:
                yield _fps_at(_fps_insert(S, i0, *_fps_split(S, i0, h)), Sp, i), _fps_at(_fps_insert(S, i0, _fps_at(h, Sp, i0), _fps_restrict(h, Sp, S)), Sp, i)

_fps_verify(_fps_rows(), "insert_split_old_definition")
