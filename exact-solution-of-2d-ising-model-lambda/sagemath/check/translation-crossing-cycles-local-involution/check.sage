"""交差する二つの非可縮一周路を持つ鍵の局所符号反転対合を検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

一辺三のトーラスで、単純通過辺集合 E を第 0 行の水平一周路と第 0 列の
垂直一周路の和とする。この E の巻き付き偶奇は (1,1) であり、E に含まれる
水平一周路との交差文字が非自明である。

D を E の補集合の任意の部分集合とし、D の各辺では両向きを、E の各辺では
片向きを動かす。入次数と出次数が一致し、各頂点の入辺から出辺への非後退な
全単射が存在する全ての動辺集合を調べる。

各頂点の局所全単射全体が、二本の像の交換によって回転数を変えずに完全対合
できる局所方向型を列挙する。この型は「二本の入方向と二本の出方向が同じ曲がり
二方向」である場合に限る。上の全ての動辺集合にはこの型の頂点がちょうど一つ
あるため、その頂点で局所全単射を交換すると、動辺集合とねじれ符号を保ち、
回転位相を保ったまま置換符号だけを反転する不動点のない対合が定まる。

検査は有限集合、整数、有限積の等号だけで行い、浮動小数点を使わない。
全置換を一件ずつ展開せず、各動辺集合の局所全単射数の積として総数と対の数を
厳密に数える。
"""

from itertools import combinations, permutations, product

side = 3


def base_edges():
    return [(kind, i, j)
            for kind in ("h", "v")
            for i in range(side)
            for j in range(side)]


def reversal(edge):
    kind, i, j, orientation = edge
    return (kind, i, j, 1 - orientation)


def endpoints(edge):
    kind, i, j, orientation = edge
    first = (i, j)
    second = ((i, (j + 1) % side) if kind == "h"
              else ((i + 1) % side, j))
    return (first, second) if orientation == 0 else (second, first)


def direction(edge):
    kind, _, _, orientation = edge
    return {
        ("h", 0): 0,
        ("v", 0): 1,
        ("h", 1): 2,
        ("v", 1): 3,
    }[(kind, orientation)]


def quarter_turn(first_direction, second_direction):
    difference = (second_direction - first_direction) % 4
    assert difference in (0, 1, 3)
    return {0: ZZ(0), 1: ZZ(1), 3: ZZ(-1)}[difference]


vertices = list(product(range(side), repeat=2))
all_base_edges = base_edges()
single = frozenset(
    [("h", 0, j) for j in range(side)]
    + [("v", i, 0) for i in range(side)]
)
complement = sorted(set(all_base_edges) - set(single))

assert len(single) == 6
assert len(complement) == 12


def winding_parities(subset):
    return (
        sum(ZZ(kind == "h" and j == side - 1)
            for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == side - 1)
            for kind, i, j in subset) % 2,
    )


horizontal_cycle = frozenset(("h", 0, j) for j in range(side))
assert horizontal_cycle.issubset(single)
assert winding_parities(single) == (1, 1)
assert winding_parities(horizontal_cycle) == (1, 0)
single_winding = winding_parities(single)
horizontal_winding = winding_parities(horizontal_cycle)
assert (single_winding[0] * horizontal_winding[1]
        + single_winding[1] * horizontal_winding[0]) % 2 == 1


def in_out_lists(moved, vertex):
    incoming = sorted(edge for edge in moved if endpoints(edge)[1] == vertex)
    outgoing = sorted(edge for edge in moved if endpoints(edge)[0] == vertex)
    return incoming, outgoing


def local_bijections(incoming, outgoing):
    return [
        image_tuple for image_tuple in permutations(outgoing)
        if all(image != reversal(source)
               for source, image in zip(incoming, image_tuple))
    ]


def phase_preserving_transposition(incoming, first, second):
    changed = [position for position in range(len(first))
               if first[position] != second[position]]
    if len(changed) != 2:
        return False
    left, right = changed
    if first[left] != second[right] or first[right] != second[left]:
        return False
    before = (
        quarter_turn(direction(incoming[left]), direction(first[left]))
        + quarter_turn(direction(incoming[right]), direction(first[right]))
    )
    after = (
        quarter_turn(direction(incoming[left]), direction(second[left]))
        + quarter_turn(direction(incoming[right]), direction(second[right]))
    )
    return before == after


def perfect_matching(adjacency, remaining):
    if not remaining:
        return {}
    first = min(remaining)
    for second in sorted(adjacency[first].intersection(remaining)):
        rest = perfect_matching(adjacency, remaining - {first, second})
        if rest is not None:
            return {first: second, second: first, **rest}
    return None


def local_matching(incoming, outgoing):
    choices = local_bijections(incoming, outgoing)
    adjacency = {index: set() for index in range(len(choices))}
    for first, second in combinations(range(len(choices)), 2):
        if phase_preserving_transposition(
            incoming, choices[first], choices[second]
        ):
            adjacency[first].add(second)
            adjacency[second].add(first)
    matching = perfect_matching(adjacency, set(adjacency))
    return choices, matching


# 四方向の全局所型を独立に列挙する。完全対合できるのは、二本の入方向と
# 二本の出方向が同じ曲がり二方向である四型だけである。
matchable_direction_types = set()
for size in range(1, 5):
    for incoming_directions in combinations(range(4), size):
        for outgoing_directions in combinations(range(4), size):
            incoming = tuple(("direction", value, 0, 0)
                             for value in incoming_directions)
            outgoing = tuple(("direction", value, 0, 0)
                             for value in outgoing_directions)

            def symbolic_direction(edge):
                return edge[1]

            choices = [
                image_tuple for image_tuple in permutations(outgoing)
                if all((symbolic_direction(image)
                        - symbolic_direction(source)) % 4 != 2
                       for source, image in zip(incoming, image_tuple))
            ]
            adjacency = {index: set() for index in range(len(choices))}
            for first, second in combinations(range(len(choices)), 2):
                changed = [position for position in range(size)
                           if choices[first][position] != choices[second][position]]
                if len(changed) != 2:
                    continue
                left, right = changed
                if (choices[first][left] != choices[second][right]
                        or choices[first][right] != choices[second][left]):
                    continue
                before = sum(
                    quarter_turn(symbolic_direction(incoming[position]),
                                 symbolic_direction(choices[first][position]))
                    for position in changed
                )
                after = sum(
                    quarter_turn(symbolic_direction(incoming[position]),
                                 symbolic_direction(choices[second][position]))
                    for position in changed
                )
                if before == after:
                    adjacency[first].add(second)
                    adjacency[second].add(first)
            matching = perfect_matching(adjacency, set(adjacency))
            if choices and matching is not None:
                matchable_direction_types.add(
                    (incoming_directions, outgoing_directions)
                )

assert matchable_direction_types == {
    ((0, 1), (0, 1)),
    ((0, 3), (0, 3)),
    ((1, 2), (1, 2)),
    ((2, 3), (2, 3)),
}


# E の均衡する向きは四つである。
balanced_single_orientations = []
for orientation_bits in product((0, 1), repeat=len(single)):
    moved = {
        base + (orientation,)
        for base, orientation in zip(sorted(single), orientation_bits)
    }
    if all(
        len(in_out_lists(moved, vertex)[0])
        == len(in_out_lists(moved, vertex)[1])
        for vertex in vertices
    ):
        balanced_single_orientations.append(moved)
assert len(balanced_single_orientations) == 4


nonempty_key_count = ZZ(0)
valid_moved_set_count = ZZ(0)
permutation_count = ZZ(0)
pair_count = ZZ(0)

for doubled_bits in product((0, 1), repeat=len(complement)):
    doubled = {
        base for base, included in zip(complement, doubled_bits) if included
    }
    doubled_oriented = {
        base + (orientation,)
        for base in doubled
        for orientation in (0, 1)
    }
    key_permutation_count = ZZ(0)

    for single_orientation in balanced_single_orientations:
        moved = doubled_oriented.union(single_orientation)
        local_data = []
        moved_set_permutation_count = ZZ(1)
        for vertex in vertices:
            incoming, outgoing = in_out_lists(moved, vertex)
            assert len(incoming) == len(outgoing)
            choices, matching = local_matching(incoming, outgoing)
            moved_set_permutation_count *= len(choices)
            local_data.append((incoming, outgoing, choices, matching))

        if moved_set_permutation_count == 0:
            continue

        matchable_vertices = []
        for vertex, (incoming, outgoing, choices, matching) in zip(
            vertices, local_data
        ):
            direction_type = (
                tuple(sorted(direction(edge) for edge in incoming)),
                tuple(sorted(direction(edge) for edge in outgoing)),
            )
            if direction_type in matchable_direction_types:
                assert matching is not None
                assert len(choices) == 2
                assert matching == {0: 1, 1: 0}
                matchable_vertices.append(vertex)

        # 対合を施す頂点は動辺集合だけから一意に決まり、局所全単射の選択に依らない。
        assert len(matchable_vertices) == 1
        valid_moved_set_count += 1
        key_permutation_count += moved_set_permutation_count
        permutation_count += moved_set_permutation_count
        assert moved_set_permutation_count % 2 == 0
        pair_count += moved_set_permutation_count // 2

    if key_permutation_count != 0:
        nonempty_key_count += 1

assert nonempty_key_count == 1442
assert valid_moved_set_count == 5768
assert permutation_count == 10570752
assert pair_count == 5285376
assert permutation_count == 2 * pair_count

print(f"nonempty keys: {nonempty_key_count}")
print(f"valid moved orientations: {valid_moved_set_count}")
print(f"permutations covered by the local involution: {permutation_count}")
print(f"phase-reversing pairs: {pair_count}")
print("PASS: translation-crossing-cycles-local-involution")
