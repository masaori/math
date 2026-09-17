"""任意の辺長と有限内部語に使える境界延長規則の厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-cut-geometry/construction.sage")


def traversal_coordinate_lifts_for_side(side, word, traversal):
    """指定辺長で内部語の切断旗と連結向きに整合する座標列を返す。"""
    side = ZZ(side)
    assert side >= 2
    assert word
    _, _, internal_outgoing = traversal
    assert len(internal_outgoing) + 1 == len(word)
    lifts = []
    for first_vertex in ((row, column)
                         for row in range(side)
                         for column in range(side)):
        vertices = [first_vertex]
        for outgoing in internal_outgoing:
            vertices.append(move_vertex(side, vertices[-1], outgoing))
        if all(vertex_wrap_flags_from_coordinate(side, vertex) == step[1]
               for vertex, step in zip(vertices, word)):
            lifts.append(tuple(vertices))
    return tuple(lifts)


def boundary_extension_options_for_side(
        side, word, boundary_position, boundary_direction):
    """境界方向と整合する座標持ち上げから反対端点の切断旗を返す。"""
    side = ZZ(side)
    boundary_position = ZZ(boundary_position)
    boundary_direction = ZZ(boundary_direction)
    assert side >= 2
    assert word
    assert boundary_position in (0, 1)
    assert boundary_direction in range(4)
    options = set()
    for traversal in connected_word_traversals(word):
        first_incoming, last_outgoing, _ = traversal
        boundary = first_incoming if boundary_position == 0 else last_outgoing
        if boundary != boundary_direction:
            continue
        for vertices in traversal_coordinate_lifts_for_side(
                side, word, traversal):
            if boundary_position == 0:
                other_vertex = move_vertex(side, vertices[-1], last_outgoing)
            else:
                other_vertex = move_vertex(side, vertices[0], first_incoming)
            options.add(vertex_wrap_flags_from_coordinate(side, other_vertex))
    return frozenset(options)


def general_boundary_extension_descriptor(side, word):
    """任意の有限内部語に対する実現可能な境界延長を全て返す。"""
    descriptor = []
    for boundary_position in (0, 1):
        for boundary_direction in range(4):
            options = boundary_extension_options_for_side(
                side, word, boundary_position, boundary_direction)
            if options:
                descriptor.append((
                    ZZ(boundary_position),
                    ZZ(boundary_direction),
                    tuple(sorted(options)),
                ))
    return tuple(descriptor)
