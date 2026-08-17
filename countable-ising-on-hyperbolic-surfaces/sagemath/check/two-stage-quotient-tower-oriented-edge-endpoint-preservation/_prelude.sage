# SageMath: 商の塔における向き付き辺端点写像の保存の共通有限データ
# 対象ラベル: theorem_quotient_tower_oriented_edge_endpoint_map_preservation
# 帰属: 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(
    _dir,
    "../two-stage-quotient-tower-oriented-edge-representative-selectors/_prelude.sage",
))


def endpoint_cell(edge_cell, representative_selector, roles, stabilizers, kernel, label, endpoint):
    representative = representative_selector(edge_cell)
    if endpoint == "source":
        vertex_representative = representative
    elif endpoint == "target":
        vertex_representative = quotient_product(
            representative,
            roles["edge"],
            kernel,
            label,
        )
    else:
        raise ValueError("endpoint must be source or target")
    return quotient_left_coset(
        vertex_representative,
        stabilizers["vertex"],
        kernel,
        label,
    )


def fine_endpoint_cell(fine_edge_cell, endpoint):
    return endpoint_cell(
        fine_edge_cell,
        fine_representative_selector,
        fine_roles,
        fine_stabilizers,
        fine_kernel,
        FINE,
        endpoint,
    )


def coarse_endpoint_cell(coarse_edge_cell, endpoint):
    return endpoint_cell(
        coarse_edge_cell,
        coarse_representative_selector,
        coarse_roles,
        coarse_stabilizers,
        coarse_kernel,
        COARSE,
        endpoint,
    )
