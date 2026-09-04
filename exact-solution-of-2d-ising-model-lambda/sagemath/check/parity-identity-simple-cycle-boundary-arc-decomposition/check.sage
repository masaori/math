"""単純閉路を partial D で切った弧による頂点項の分解可能性を検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

頂点局所署名の和では一辺三の頂点項を書けなかったので、単純閉路 E を
partial D の頂点で切る。各弧には、辞書式最小の選択 C を含む頂点署名を
閉路順に並べた有限列を持たせる（向きの反転は同じ弧型とする）。頂点項が
弧型ごとの値の和として書けるかを合同の F_2 線型系で判定する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-simple-cycle-selector-membership/check.sage")


def cycle_vertex_order(side, single):
    adjacency = {}
    for edge in single:
        endpoints = base_endpoints(side, edge)
        for vertex in endpoints:
            adjacency.setdefault(vertex, []).append(edge)
    assert adjacency and all(len(edges) == 2 for edges in adjacency.values())

    candidates = []
    for start in sorted(adjacency):
        for first_edge in sorted(adjacency[start]):
            vertices = [start]
            edges = []
            current = start
            edge = first_edge
            while True:
                edges.append(edge)
                endpoints = base_endpoints(side, edge)
                following = endpoints[1] if endpoints[0] == current else endpoints[0]
                if following == start:
                    break
                vertices.append(following)
                choices = [candidate for candidate in adjacency[following]
                           if candidate != edge]
                assert len(choices) == 1
                current = following
                edge = choices[0]
            assert len(edges) == len(single)
            candidates.append((tuple(edges), tuple(vertices)))
    return min(candidates)[1]


def boundary_vertices(side, doubled):
    degrees = {}
    for edge in doubled:
        for vertex in base_endpoints(side, edge):
            degrees[vertex] = degrees.get(vertex, ZZ(0)) + 1
    return frozenset(vertex for vertex, degree in degrees.items()
                     if degree % 2 == 1)


def reversal_invariant_word(word):
    reversed_word = tuple(reversed(word))
    return min(word, reversed_word)


def cyclic_reversal_invariant_word(word):
    candidates = []
    for oriented in (word, tuple(reversed(word))):
        for offset in range(len(oriented)):
            candidates.append(oriented[offset:] + oriented[:offset])
    return min(candidates)


def boundary_arc_signatures(side, doubled, single):
    chosen = key_selector(side, doubled, single)
    vertices = cycle_vertex_order(side, single)
    words = tuple(
        selector_vertex_signature(side, vertex, doubled, single, chosen)
        for vertex in vertices)
    boundary = boundary_vertices(side, doubled)
    assert boundary.issubset(set(vertices))
    if not boundary:
        return (cyclic_reversal_invariant_word(words),)

    cuts = [index for index, vertex in enumerate(vertices) if vertex in boundary]
    assert len(cuts) % 2 == 0
    arcs = []
    for position, begin in enumerate(cuts):
        end = cuts[(position + 1) % len(cuts)]
        if begin < end:
            word = words[begin:end]
        else:
            word = words[begin:] + words[:end]
        assert word
        arcs.append(reversal_invariant_word(word))
    return tuple(arcs)


arc_rows = []
arc_terms = []
arc_key_records = []
all_arc_signatures = sorted({
    signature
    for side, doubled, single, _ in joint_keys
    for signature in boundary_arc_signatures(side, doubled, single)
})

for side, doubled, single, term in joint_keys:
    signatures = boundary_arc_signatures(side, doubled, single)
    counts = {signature: GF(2)(signatures.count(signature))
              for signature in all_arc_signatures}
    arc_rows.append(tuple(counts[signature] for signature in all_arc_signatures))
    arc_terms.append(term)
    arc_key_records.append((side, doubled, single))

arc_matrix = matrix(GF(2), arc_rows)
arc_vector = vector(GF(2), arc_terms)
try:
    arc_solution = arc_matrix.solve_right(arc_vector)
    arc_solvable = True
except ValueError:
    arc_solution = None
    arc_solvable = False

row_records = {}
conflicts = []
for row, term, key in zip(arc_rows, arc_terms, arc_key_records):
    if row in row_records and row_records[row][0] != term:
        conflicts.append((row_records[row][1], key))
    elif row not in row_records:
        row_records[row] = (term, key)

boundary_size_distribution = {}
arc_count_distribution = {}
for side, doubled, single, _ in joint_keys:
    boundary_size = len(boundary_vertices(side, doubled))
    arc_count = len(boundary_arc_signatures(side, doubled, single))
    boundary_size_distribution[boundary_size] = (
        boundary_size_distribution.get(boundary_size, ZZ(0)) + 1)
    arc_count_distribution[arc_count] = (
        arc_count_distribution.get(arc_count, ZZ(0)) + 1)

print("ARCS: keys=%d signatures=%d rank=%d solvable=%s direct-conflicts=%d"
      % (len(joint_keys), len(all_arc_signatures), arc_matrix.rank(),
         arc_solvable, len(conflicts)))
print("BOUNDARY-SIZES: %s" % sorted(boundary_size_distribution.items()))
print("ARC-COUNTS: %s" % sorted(arc_count_distribution.items()))

assert len(joint_keys) == 7085
assert not conflicts
assert arc_solvable
for row, term in zip(arc_rows, arc_terms):
    assert sum(coefficient * value
               for coefficient, value in zip(row, arc_solution)) == term

support_size = sum(1 for value in arc_solution if value != 0)
print("PASS: partial D で切った弧の完全な署名列を弧型とすれば、"
      "一辺二・三の全 %d 鍵の頂点項は弧型ごとの値の和として書ける"
      "（一つの解の支持台 %d 弧型）" % (len(joint_keys), support_size))
