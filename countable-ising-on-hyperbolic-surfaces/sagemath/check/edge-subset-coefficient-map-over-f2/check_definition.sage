# SageMath: 辺部分集合から GF(2) 辺係数写像への変換の厳密検算
# 対象ラベル: def_edge_subset_coefficient_map_over_f2
# 対象: homology_sector_definition_edge_subset_coefficient_map の定義式
# 帰属: 形式的な有限辺ラベル集合、有限冪集合、GF(2) 上の有限係数列だけを用いる。

from itertools import combinations, product

edges = ("upper", "lower", "loop")
edge_coefficient_space = VectorSpace(GF(2), len(edges))


def subsets(values):
    values = tuple(values)
    for size in range(len(values) + 1):
        for chosen in combinations(values, size):
            yield frozenset(chosen)


def edge_subset_coefficient_map(chosen):
    return vector(
        GF(2),
        [GF(2).one() if edge in chosen else GF(2).zero() for edge in edges],
    )


for chosen in subsets(edges):
    coefficients = edge_subset_coefficient_map(chosen)
    assert coefficients in edge_coefficient_space
    for index, edge in enumerate(edges):
        expected = GF(2).one() if edge in chosen else GF(2).zero()
        assert coefficients[index] == expected

expected_vectors = {
    tuple(GF(2)(coefficient) for coefficient in coefficients)
    for coefficients in product((0, 1), repeat=len(edges))
}
actual_vectors = {
    tuple(edge_subset_coefficient_map(chosen))
    for chosen in subsets(edges)
}
assert actual_vectors == expected_vectors

print("RESULT: PASS — every finite edge subset has exactly its stated GF(2) coefficient map")
