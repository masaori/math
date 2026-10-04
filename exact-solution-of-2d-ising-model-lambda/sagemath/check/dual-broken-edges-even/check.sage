# 対象ラベル: claim_dual_broken_edges_even
# 行別検算に続けて、双対像の偶性を全配位から直接確認する。
import os
_dual_even_dir = 'sagemath/check/dual-broken-edges-even'
for _check_name in (
    "check_edge_sign.sage",
    "check_incidence_definition.sage",
    "check_endpoint_incidence.sage",
    "check_dual_preimages.sage",
    "check_boundary_order.sage",
    "check_degree_substitution.sage",
    "check_power_addition.sage",
    "check_edge_products.sage",
    "check_endpoint_products.sage",
    "check_square_regrouping.sage",
    "check_spin_squares.sage",
    "check_unit_product.sage",
    "check_even_count.sage",
):
    load(os.path.join(_dual_even_dir, _check_name))

for L in (1, 2, 3):
    checked = 0
    for sigma in configurations(L):
        broken = broken_edge_set(L, sigma)
        dual_broken = frozenset(dual_edge(L, edge) for edge in broken)
        assert len(dual_broken) == len(broken)
        for i, j in vertices(L):
            local_primal_edges = (
                edge_number_vertical(L, i - 1, j),
                edge_number_horizontal(L, i, j - 1),
                edge_number_vertical(L, i - 1, j - 1),
                edge_number_horizontal(L, i - 1, j - 1),
            )
            local_broken_count = sum(ZZ(edge in broken) for edge in local_primal_edges)
            degree = incidence_count(L, dual_broken, (i, j))
            assert degree == local_broken_count
            assert prod(ZZ(sigma[u]) * ZZ(sigma[v])
                        for edge in local_primal_edges for u, v in [endpoints(L, edge)]) == 1
            assert (-1) ** degree == 1
            assert degree % 2 == 0
        checked += 1
    print("L=%d: %d 配位の全双対頂点で偶次数を確認" % (L, checked))

print("RESULT: PASS")
