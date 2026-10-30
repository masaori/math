"""任意の辺長と有限内部語に使える境界延長規則の厳密構成。"""

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-boundary-cut-geometry/construction.sage")


def coordinate_start_residues_from_cut_flags(
        side, displacements, cut_flag_pairs):
    """変位列と 0/L-1 切断旗を満たす始点座標の剰余類を返す。"""
    side = ZZ(side)
    assert side >= 2
    assert len(displacements) == len(cut_flag_pairs)
    forced_residues = set()
    forbidden_residues = set()
    for displacement, cut_flags in zip(displacements, cut_flag_pairs):
        displacement = ZZ(displacement)
        at_zero, at_last = map(ZZ, cut_flags)
        assert at_zero in (0, 1)
        assert at_last in (0, 1)
        assert not (at_zero and at_last)
        zero_residue = ZZ((-displacement) % side)
        last_residue = ZZ((side - 1 - displacement) % side)
        if at_zero:
            forced_residues.add(zero_residue)
        else:
            forbidden_residues.add(zero_residue)
        if at_last:
            forced_residues.add(last_residue)
        else:
            forbidden_residues.add(last_residue)
    if len(forced_residues) > 1:
        return ()
    if forced_residues:
        residue = next(iter(forced_residues))
        return () if residue in forbidden_residues else (residue,)
    return tuple(ZZ(residue) for residue in range(side)
                 if residue not in forbidden_residues)


def traversal_coordinate_lifts_for_side(side, word, traversal):
    """切断旗の合同条件から、整合する座標列を返す。"""
    side = ZZ(side)
    assert side >= 2
    assert word
    _, _, internal_outgoing = traversal
    assert len(internal_outgoing) + 1 == len(word)
    increments = ((-1, 0), (1, 0), (0, -1), (0, 1))
    row_displacements = [ZZ(0)]
    column_displacements = [ZZ(0)]
    for outgoing in internal_outgoing:
        row_increment, column_increment = increments[ZZ(outgoing)]
        row_displacements.append(row_displacements[-1] + row_increment)
        column_displacements.append(
            column_displacements[-1] + column_increment)
    row_starts = coordinate_start_residues_from_cut_flags(
        side, row_displacements,
        tuple((step[1][0], step[1][1]) for step in word))
    column_starts = coordinate_start_residues_from_cut_flags(
        side, column_displacements,
        tuple((step[1][2], step[1][3]) for step in word))
    lifts = []
    for first_row in row_starts:
        for first_column in column_starts:
            vertices = tuple(
                (ZZ((first_row + row_displacement) % side),
                 ZZ((first_column + column_displacement) % side))
                for row_displacement, column_displacement in zip(
                    row_displacements, column_displacements))
            assert all(
                vertex_wrap_flags_from_coordinate(side, vertex) == step[1]
                for vertex, step in zip(vertices, word))
            lifts.append(vertices)
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
