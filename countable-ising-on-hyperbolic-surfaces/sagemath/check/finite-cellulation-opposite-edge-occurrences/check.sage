# SageMath: 各辺が逆向きに二回だけ現れる有限述語の正例・負例
# 対象ラベル: def_finite_cellulation_opposite_edge_occurrences
# 対象: structured-latex/content/finite-cellulation.ts の「辺の逆向き二回出現」
# 帰属: 有限集合、ZZ、真偽値だけを用いる。


def opposite_edge_twice(edges, boundary_words):
    for edge in edges:
        orientations = []
        for word in boundary_words.values():
            orientations.extend(orientation for current_edge, orientation in word if current_edge == edge)
        if len(orientations) != 2:
            return False
        if sum(ZZ(orientation) for orientation in orientations) != 0:
            return False
    return True


edges = ("a", "b", "c")

# 三角形の二つの面を反対向きに貼った二次元球面。
sphere_boundary_words = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("c", -1), ("b", -1), ("a", -1)),
}
assert opposite_edge_twice(edges, sphere_boundary_words)

# 二面が同じ向きなら、各辺の符号和が零にならない。
same_orientation = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("a", 1), ("b", 1), ("c", 1)),
}
assert not opposite_edge_twice(edges, same_orientation)

# 出現が一回だけの辺があれば、二回出現条件を満たさない。
missing_occurrence = {
    "north": (("a", 1), ("b", 1), ("c", 1)),
    "south": (("c", -1), ("b", -1)),
}
assert not opposite_edge_twice(edges, missing_occurrence)

# 符号和が零でも出現が四回なら、二回出現条件を満たさない。
four_occurrences = {
    "north": (("a", 1), ("b", 1), ("c", 1), ("a", -1)),
    "south": (("c", -1), ("b", -1), ("a", 1), ("a", -1)),
}
assert not opposite_edge_twice(edges, four_occurrences)

print("RESULT: PASS — opposite two-occurrence predicate accepted the sphere and rejected three malformed inputs")
