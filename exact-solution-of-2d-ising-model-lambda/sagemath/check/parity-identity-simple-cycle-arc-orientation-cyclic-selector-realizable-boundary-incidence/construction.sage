"""切断線幾何で実現可能な境界入射だけを残す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-cut-geometry/construction.sage")


def candidate_realizable_boundary_incidence_descriptor(
        orbit_key, selector, feature_indices=None):
    """実現可能な境界入射と指定した境界外所属ビットを返す。"""
    if feature_indices is None:
        feature_indices = tuple(range(len(OUTSIDE_MEMBERSHIP_FEATURES)))
    descriptor = []
    for incidence in candidate_boundary_outside_membership_descriptor(
            orbit_key, selector):
        boundary_position, endpoint_index, boundary_direction = incidence[:3]
        options = incidence_other_endpoint_wrap_options(
            orbit_key, selector, boundary_position,
            endpoint_index, boundary_direction)
        if not options:
            continue
        outside_bits = incidence[4]
        descriptor.append(
            incidence[:4] + (tuple(
                outside_bits[index] for index in feature_indices),))
    return tuple(descriptor)
