# SageMath: 各辺が逆向きに二回だけ現れる有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_opposite_edge_occurrences
# 対象: structured-latex/content/finite-cellulation.ts の「辺の逆向き二回出現」
# 帰属: 向きラベルと位置ラベルの有限集合、真偽値だけを用いる。

FORWARD = "forward"
REVERSE = "reverse"
REVERSED_ORIENTATION = {FORWARD: REVERSE, REVERSE: FORWARD}


def cyclic_word(entries):
    positions = []
    edge_at = {}
    orientation_at = {}
    successor = {}
    first_position = None
    previous_position = None
    for position, edge, orientation in entries:
        if first_position is None:
            first_position = position
        if previous_position is not None:
            successor[previous_position] = position
        positions.append(position)
        edge_at[position] = edge
        orientation_at[position] = orientation
        previous_position = position
    assert first_position is not None
    successor[previous_position] = first_position
    return {
        "positions": tuple(positions),
        "successor": successor,
        "edge_at": edge_at,
        "orientation_at": orientation_at,
    }


def opposite_edge_twice(edges, boundary_words):
    for edge in edges:
        orientations = []
        for word in boundary_words.values():
            for position in word["positions"]:
                if word["edge_at"][position] == edge:
                    orientations.append(word["orientation_at"][position])
        if len(orientations) != 2:
            return False
        first_orientation, second_orientation = orientations
        if second_orientation != REVERSED_ORIENTATION[first_orientation]:
            return False
    return True


edges = ("a", "b", "c")

# 三角形の二つの面を反対向きに貼った二次元球面。
sphere_boundary_words = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-c", "c", REVERSE), ("south-b", "b", REVERSE), ("south-a", "a", REVERSE))),
}
assert opposite_edge_twice(edges, sphere_boundary_words)

# 二面が同じ向きなら、二つの向きラベルは反転写像で対応しない。
same_orientation = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-a", "a", FORWARD), ("south-b", "b", FORWARD), ("south-c", "c", FORWARD))),
}
assert not opposite_edge_twice(edges, same_orientation)

# 出現が一回だけの辺があれば、二回出現条件を満たさない。
missing_occurrence = {
    "north": cyclic_word((("north-a", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD))),
    "south": cyclic_word((("south-c", "c", REVERSE), ("south-b", "b", REVERSE))),
}
assert not opposite_edge_twice(edges, missing_occurrence)

# 両方の向きラベルが現れても、出現が四回なら二回出現条件を満たさない。
four_occurrences = {
    "north": cyclic_word((("north-a-forward", "a", FORWARD), ("north-b", "b", FORWARD), ("north-c", "c", FORWARD), ("north-a-reverse", "a", REVERSE))),
    "south": cyclic_word((("south-c", "c", REVERSE), ("south-b", "b", REVERSE), ("south-a-forward", "a", FORWARD), ("south-a-reverse", "a", REVERSE))),
}
assert not opposite_edge_twice(edges, four_occurrences)

print("RESULT: PASS — opposite two-occurrence predicate accepted the sphere and rejected three malformed inputs")
