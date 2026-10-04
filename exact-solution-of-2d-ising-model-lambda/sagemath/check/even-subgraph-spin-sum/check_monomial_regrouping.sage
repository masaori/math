# 対象ラベル: claim_even_subgraph_spin_sum
# 式ペア: prod_{e in A} sigma(boundary0(e)) sigma(boundary1(e))
#       = prod_{v in V_L} sigma(v)^d_A(v)
# 帰属: 整数の有限積。自己ループの二つの端点を別々に数える。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

regrouping_checked = 0
for regrouping_L in (1, 2):
    for regrouping_subset in edge_subsets(regrouping_L):
        for regrouping_sigma in configurations(regrouping_L):
            edge_product = spin_monomial(regrouping_L, regrouping_subset, regrouping_sigma)
            vertex_product = vertex_power_monomial(
                regrouping_L, regrouping_subset, regrouping_sigma)
            assert edge_product == vertex_product
            regrouping_checked += 1

assert regrouping_checked == 4104
print("辺積＝頂点冪積: L=1,2 の配位と辺部分集合 %d 組を検査" % regrouping_checked)
print("RESULT: PASS")
