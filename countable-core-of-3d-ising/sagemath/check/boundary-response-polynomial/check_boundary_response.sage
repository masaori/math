# 対象ラベル: def_boundary_response_polynomial
# 有限代入の像が、内箱に接する破れ辺だけを保持する直接の有限和と一致することを確認する。
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, "_prelude.sage"))

direct_response = target_ring.zero()
for values in product([ZZ(-1), ZZ(1)], repeat=len(outer_sites)):
    configuration = dict(zip(outer_sites, values))
    monomial = target_ring.one()
    for edge in broken_edges(configuration):
        if edge in active_index:
            monomial *= target_variables[active_index[edge]]
    direct_response += monomial

assert specialization(partition_polynomial) == direct_response
assert direct_response.parent() is target_ring

print("RESULT: PASS")
