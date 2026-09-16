"""境界方向外の端点所属ビットを相対方向ごとに取り出す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-incidence/construction.sage")


CLOCKWISE_DIRECTION = (3, 2, 0, 1)
OPPOSITE_DIRECTION = (1, 0, 3, 2)
COUNTERCLOCKWISE_DIRECTION = (2, 3, 1, 0)
RELATIVE_DIRECTIONS = (
    ("clockwise", CLOCKWISE_DIRECTION),
    ("opposite", OPPOSITE_DIRECTION),
    ("counterclockwise", COUNTERCLOCKWISE_DIRECTION),
)
MEMBERSHIP_NAMES = ("in_doubled", "in_single", "in_chosen", "wrap")
OUTSIDE_MEMBERSHIP_FEATURES = tuple(
    (endpoint_role, relative_name, membership_name)
    for endpoint_role in ("aligned", "other")
    for relative_name, _ in RELATIVE_DIRECTIONS
    for membership_name in MEMBERSHIP_NAMES
)


def candidate_boundary_outside_membership_descriptor(
        orbit_key, selector, feature_indices=None):
    """各境界入射に対する境界方向外の所属ビットを返す。"""
    _, _, endpoints = orbit_key
    incidences = candidate_boundary_incidence_descriptor(orbit_key, selector)
    if feature_indices is None:
        feature_indices = tuple(range(len(OUTSIDE_MEMBERSHIP_FEATURES)))
    descriptor = []
    for boundary_position, endpoint_index, boundary_direction, boundary_data in incidences:
        aligned_endpoint = endpoints[ZZ(endpoint_index)]
        other_endpoint = endpoints[1 - ZZ(endpoint_index)]
        outside_bits = []
        for endpoint in (aligned_endpoint, other_endpoint):
            for _, direction_map in RELATIVE_DIRECTIONS:
                direction_data = endpoint_direction_data(
                    endpoint, direction_map[ZZ(boundary_direction)])
                outside_bits.extend(direction_data)
        descriptor.append((
            boundary_position,
            endpoint_index,
            boundary_direction,
            boundary_data,
            tuple(outside_bits[index] for index in feature_indices),
        ))
    return tuple(descriptor)
