"""単純閉路を partial D で切った弧による頂点項の分解可能性を検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-simple-cycle-selector-membership/construction.sage")

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
