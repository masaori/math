"""有向切断候補を端点局所情報へ射影する厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-directed-boundary/construction.sage")


def candidate_local_boundary_descriptor(orbit_key, selector):
    """内部語を捨て、向きと整合する端点の局所情報だけを残す。"""
    _, _, endpoints = orbit_key
    alignments = candidate_endpoint_alignments(orbit_key, selector)
    return (
        candidate_reversal_orientation(orbit_key, selector),
        tuple(
            (boundary_position,
             compressed_endpoint_signature(endpoint),
             endpoint_chosen_membership(endpoint),
             endpoints.index(endpoint))
            for boundary_position, endpoint in alignments
        ),
    )
