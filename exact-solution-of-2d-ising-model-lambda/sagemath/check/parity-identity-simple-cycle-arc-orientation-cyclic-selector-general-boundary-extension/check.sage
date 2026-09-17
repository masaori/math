"""一般の有限内部語へ運べる境界延長規則を有限全探索で検算する。

対象ラベル: claim_cut_flag_congruence_start_recovery
一般の辺長についての証明ではない。
"""

import ast
import itertools
import json
from pathlib import Path

load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-selector-general-boundary-extension/construction.sage")


def word_from_path(side, first_vertex, first_incoming, outgoing_directions):
    """非後戻り方向列と始点から内部語・連結向き・座標列を作る。"""
    vertices = [first_vertex]
    for outgoing in outgoing_directions[:-1]:
        vertices.append(move_vertex(side, vertices[-1], outgoing))
    incoming = first_incoming
    word = []
    internal_outgoing = []
    for index, (vertex, outgoing) in enumerate(zip(vertices, outgoing_directions)):
        assert incoming != outgoing
        orientation = tuple(ZZ(direction in (incoming, outgoing))
                            for direction in range(4))
        word.append((
            orientation,
            vertex_wrap_flags_from_coordinate(side, vertex),
            (),
        ))
        if index + 1 < len(vertices):
            internal_outgoing.append(ZZ(outgoing))
            incoming = OPPOSITE_DIRECTION[outgoing]
    traversal = (
        ZZ(first_incoming),
        ZZ(outgoing_directions[-1]),
        tuple(internal_outgoing),
    )
    return tuple(word), traversal, tuple(vertices)


def enumerated_traversal_coordinate_lifts_for_side(side, word, traversal):
    """比較用: 始点を全列挙して切断旗と整合する座標列を返す。"""
    _, _, internal_outgoing = traversal
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


checked_paths = 0
checked_extensions = 0
distinct_words = set()
path_cases = set()
expected_options = {}
for side in range(2, 5):
    for length in range(1, 5):
        for first_incoming in range(4):
            for outgoing_directions in itertools.product(range(4), repeat=length):
                incoming = first_incoming
                nonbacktracking = True
                for outgoing in outgoing_directions:
                    if outgoing == incoming:
                        nonbacktracking = False
                        break
                    incoming = OPPOSITE_DIRECTION[outgoing]
                if not nonbacktracking:
                    continue
                for first_vertex in ((row, column)
                                     for row in range(side)
                                     for column in range(side)):
                    word, traversal, vertices = word_from_path(
                        side, first_vertex, first_incoming,
                        outgoing_directions)
                    distinct_words.add((ZZ(side), word))
                    path_cases.add((ZZ(side), word, traversal, vertices))
                    for boundary_position, boundary_direction, actual_vertex in (
                            (0, first_incoming,
                             move_vertex(side, vertices[-1],
                                         outgoing_directions[-1])),
                            (1, outgoing_directions[-1],
                             move_vertex(side, vertices[0], first_incoming))):
                        key = (ZZ(side), word, ZZ(boundary_position),
                               ZZ(boundary_direction))
                        expected_options.setdefault(key, set()).add(
                            vertex_wrap_flags_from_coordinate(
                                side, actual_vertex))
                        checked_extensions += 1
                    checked_paths += 1

for side, word, traversal, vertices in path_cases:
    lifts = traversal_coordinate_lifts_for_side(side, word, traversal)
    enumerated_lifts = enumerated_traversal_coordinate_lifts_for_side(
        side, word, traversal)
    assert lifts == enumerated_lifts
    assert vertices in lifts
    assert traversal in connected_word_traversals(word)

for key, expected in expected_options.items():
    side, word, boundary_position, boundary_direction = key
    actual = boundary_extension_options_for_side(
        side, word, boundary_position, boundary_direction)
    assert actual == frozenset(expected)


lift_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/"
    "certificate.json")
lifts = json.loads(lift_path.read_text())["lifts"]
checked_observed_incidences = 0
for lift in lifts.values():
    for arc_type in map(ast.literal_eval, lift["arc_support"]):
        if len(arc_type[1]) == 1:
            continue
        orbit_key = arc_cyclic_orbit_key(arc_type)
        selectors = endpoint_boundary_selectors(orbit_key)
        connected_selectors = tuple(
            selector for selector in selectors
            if connected_word_traversals(
                decode_arc_cyclic_encoding(orbit_key, selector)[1]))
        if len(connected_selectors) != 2:
            continue
        for selector in connected_selectors:
            word = decode_arc_cyclic_encoding(orbit_key, selector)[1]
            for incidence in candidate_boundary_incidence_descriptor(
                    orbit_key, selector):
                boundary_position, _, boundary_direction, _ = incidence
                old_options = incidence_other_endpoint_wrap_options(
                    orbit_key, selector, boundary_position,
                    incidence[1], boundary_direction)
                new_options = frozenset().union(*(
                    boundary_extension_options_for_side(
                        side, word, boundary_position, boundary_direction)
                    for side in (2, 3)))
                assert new_options == old_options
                checked_observed_incidences += 1

assert checked_paths == 13920
assert checked_extensions == 27840
assert len(distinct_words) == 13234
assert checked_observed_incidences == 1036

certificate = {
    "kind": "cyclic-selector-general-boundary-extension",
    "checked_side_lengths": list(map(int, range(2, 5))),
    "checked_word_lengths": list(map(int, range(1, 5))),
    "checked_path_count": int(checked_paths),
    "checked_extension_count": int(checked_extensions),
    "distinct_side_and_word_count": int(len(distinct_words)),
    "checked_congruence_system_count": int(len(path_cases)),
    "observed_incidence_agreement_count": int(checked_observed_incidences),
    "rule": "solve the row and column start residues from cumulative direction displacements and every recorded cut-flag congruence, then extend one boundary edge",
}
certificate_path = Path(
    "sagemath/check/"
    "parity-identity-simple-cycle-arc-orientation-cyclic-selector-general-boundary-extension/"
    "certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

print("CHECKED PATHS", checked_paths, flush=True)
print("CHECKED EXTENSIONS", checked_extensions, flush=True)
print("DISTINCT SIDE/WORD PAIRS", len(distinct_words), flush=True)
print("CHECKED CONGRUENCE SYSTEMS", len(path_cases), flush=True)
print("OBSERVED INCIDENCE AGREEMENTS", checked_observed_incidences, flush=True)
print("CERTIFICATE", certificate_path, flush=True)
print("PASS: boundary extension rule applies to arbitrary finite words", flush=True)
