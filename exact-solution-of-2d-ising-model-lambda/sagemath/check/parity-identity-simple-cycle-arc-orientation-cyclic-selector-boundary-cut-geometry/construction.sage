"""六ビット最小集合の切断旗を内部語の両端へ引き戻す厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-outside-membership/construction.sage")


def vertex_wrap_flags_from_coordinate(side, vertex):
    row, column = vertex
    return (
        ZZ(row == 0),
        ZZ(row == side - 1),
        ZZ(column == 0),
        ZZ(column == side - 1),
    )


def move_vertex(side, vertex, direction):
    row, column = vertex
    increments = ((-1, 0), (1, 0), (0, -1), (0, 1))
    row_increment, column_increment = increments[ZZ(direction)]
    return ((row + row_increment) % side,
            (column + column_increment) % side)


def traversal_coordinate_lifts(word, traversal):
    """一辺二・三の語の切断旗と連結向きに整合する座標列を全て返す。"""
    _, _, internal_outgoing = traversal
    lifts = []
    for side in (2, 3):
        first_wrap_flags = word[0][1]
        for first_vertex in ((row, column)
                             for row in range(side)
                             for column in range(side)):
            if vertex_wrap_flags_from_coordinate(
                    side, first_vertex) != first_wrap_flags:
                continue
            vertices = [first_vertex]
            for outgoing in internal_outgoing:
                vertices.append(move_vertex(side, vertices[-1], outgoing))
            if len(vertices) != len(word):
                continue
            if all(vertex_wrap_flags_from_coordinate(side, vertex) == step[1]
                   for vertex, step in zip(vertices, word)):
                lifts.append((ZZ(side), tuple(vertices)))
    return tuple(lifts)


def incidence_other_endpoint_wrap_options(
        orbit_key, selector, boundary_position, endpoint_index,
        boundary_direction):
    """語の座標持ち上げから得る反対端点の切断旗候補を返す。"""
    _, _, endpoints = orbit_key
    decoded_word = decode_arc_cyclic_encoding(orbit_key, selector)[1]
    aligned_endpoint = endpoints[ZZ(endpoint_index)]
    aligned_step = decoded_word[0] if boundary_position == 0 else decoded_word[-1]
    assert compressed_endpoint_signature(aligned_endpoint) == aligned_step
    matching_traversals = tuple(
        traversal for traversal in connected_word_traversals(decoded_word)
        if (traversal[0] if boundary_position == 0 else traversal[1])
        == boundary_direction)
    assert matching_traversals
    derived_other_wrap_flags = set()
    for traversal in matching_traversals:
        first_incoming, last_outgoing, _ = traversal
        for side, vertices in traversal_coordinate_lifts(decoded_word, traversal):
            if boundary_position == 0:
                other_vertex = move_vertex(side, vertices[-1], last_outgoing)
            else:
                other_vertex = move_vertex(side, vertices[0], first_incoming)
            derived_other_wrap_flags.add(
                vertex_wrap_flags_from_coordinate(side, other_vertex))
    return frozenset(derived_other_wrap_flags)
