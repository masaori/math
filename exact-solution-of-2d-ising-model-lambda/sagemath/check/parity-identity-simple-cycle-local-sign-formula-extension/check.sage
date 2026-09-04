"""一辺二で得た単純閉路鍵の局所符号式を一辺三へ延長して検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-local-sign-formula で得た 16 項の局所式を固定し、
一辺三の自明文字を持つ単純閉路 E と、E と互いに素で |D| <= 2、かつ
選択集合 C_3(D,E) が非空である非空の反転対 D の全てへ代入する。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

from itertools import combinations

load("sagemath/check/parity-identity-simple-cycle-local-sign-formula/check.sage")


def subsets_of_cycle(cycle):
    ordered = tuple(sorted(cycle))
    for size in range(len(ordered) + 1):
        for chosen in combinations(ordered, size):
            yield frozenset(chosen)


def admissible_selectors(side, doubled, single):
    def is_even(edges):
        degrees = {}
        for edge in edges:
            for vertex in base_endpoints(side, edge):
                degrees[vertex] = degrees.get(vertex, ZZ(0)) + 1
        return all(value % 2 == 0 for value in degrees.values())

    return tuple(
        chosen for chosen in subsets_of_cycle(single)
        if is_even(doubled.union(chosen))
    )


def key_selector(side, doubled, single):
    found = admissible_selectors(side, doubled, single)
    assert len(found) == 2
    return min(found, key=lambda item: tuple(sorted(item)))


side = 3
edges = tuple((kind, row, column) for kind in ("h", "v")
              for row in range(side) for column in range(side))
cycles = tuple(sorted((
    single for single in even_subgraphs_three
    if is_simple_cycle(side, single)
    and character_is_trivial_general(side, single)
    and curved_free_orientations(side, single)
), key=lambda item: tuple(sorted(item))))

checked = ZZ(0)
mismatches = []
for single in cycles:
    complement = tuple(edge for edge in edges if edge not in single)
    for size in (1, 2):
        for doubled_tuple in combinations(complement, size):
            doubled = frozenset(doubled_tuple)
            found = admissible_selectors(side, doubled, single)
            if not found:
                continue
            assert len(found) == 2
            _, vertex_term, _, _ = key_terms(side, doubled, single)
            vertices = sorted({
                endpoint
                for edge in doubled.union(single)
                for endpoint in base_endpoints(side, edge)
            })
            formula_value = sum(
                local_formula_value(
                    relative_vertex_signature(side, vertex, doubled, single))
                for vertex in vertices
            ) % 2
            if formula_value != vertex_term:
                mismatches.append((doubled, single, formula_value, vertex_term))
            checked += 1

print("L=3: trivial-character-simple-cycles=%d admissible-nonempty-D-keys=%d "
      "mismatches=%d" % (len(cycles), checked, len(mismatches)))
assert len(cycles) == 312
assert checked == 6453
assert len(mismatches) == 3246
doubled, single, formula_value, vertex_term = mismatches[0]
assert formula_value != vertex_term
print("COUNTEREXAMPLE: D=%s E=%s formula=%s vertex=%s"
      % (tuple(sorted(doubled)), tuple(sorted(single)), formula_value,
         vertex_term))
print("PASS: 一辺二の 16 項局所式は一辺三へ延長できないことを、"
      "許される鍵 3246 件の反例で固定した")
