"""連結した内部語の境界方向を端点所属へ引き戻す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-connected-cut/construction.sage")


DIRECTION_NAMES = ("up", "down", "left", "right")


def endpoint_direction_data(endpoint, direction):
    """端点の一方向について二重辺・単一辺・選択辺・切断旗を返す。"""
    memberships, wrap_flags = endpoint
    direction_name = DIRECTION_NAMES[direction]
    matches = tuple(entry for entry in memberships if entry[0] == direction_name)
    assert len(matches) == 1
    _, in_doubled, in_single, in_chosen = matches[0]
    return (
        ZZ(in_doubled),
        ZZ(in_single),
        ZZ(in_chosen),
        ZZ(wrap_flags[direction]),
    )


def candidate_boundary_incidence_descriptor(orbit_key, selector):
    """候補の連結向きが端点で使う境界方向と、その所属を全て返す。"""
    _, _, endpoints = orbit_key
    decoded_word = decode_arc_cyclic_encoding(orbit_key, selector)[1]
    traversals = connected_word_traversals(decoded_word)
    assert traversals
    incidences = []
    for boundary_position, endpoint in candidate_endpoint_alignments(
            orbit_key, selector):
        endpoint_index = endpoints.index(endpoint)
        for first_incoming, last_outgoing, _ in traversals:
            boundary_direction = (
                first_incoming if boundary_position == 0 else last_outgoing)
            incidences.append((
                ZZ(boundary_position),
                ZZ(endpoint_index),
                ZZ(boundary_direction),
                endpoint_direction_data(endpoint, boundary_direction),
            ))
    assert incidences
    return tuple(sorted(set(incidences)))
