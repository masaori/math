# 対象ラベル: claim_boundary_response_specialization_homomorphism
# 内箱に接する辺の変数を保ち、それ以外を 1 に置く有限代入を確認する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, "_prelude.sage"))

assert len(active_edges) == 3
for edge, variable, image in zip(outer_edges, source_variables, images):
    if edge in active_index:
        assert specialization(variable) == target_variables[active_index[edge]]
    else:
        assert specialization(variable) == target_ring.one()

print("RESULT: PASS")
