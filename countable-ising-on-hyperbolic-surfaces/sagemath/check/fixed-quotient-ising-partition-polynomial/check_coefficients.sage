# SageMath: 固定剰余類格子の Ising 分配多項式係数
# 対象ラベル: theorem_fixed_quotient_ising_partition_polynomial
# 帰属: 有限置換群、有限集合、NN、ZZ[x] だけを用いる

import operator
import os

check_directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(check_directory, "_prelude.sage"))
load(
    os.path.join(
        check_directory,
        "../generated-quotient-cellulation-finite-check/check.sage",
    )
)

vertex_index = {vertex: index for index, vertex in enumerate(vertices)}
edge_pairs = tuple(
    (
        vertex_index[endpoints[edge][SOURCE]],
        vertex_index[endpoints[edge][TARGET]],
    )
    for edge in edges
)
adjacency = [[] for _ in vertices]
for source_index, target_index in edge_pairs:
    adjacency[source_index].append(target_index)
    adjacency[target_index].append(source_index)

assert len(vertices) == 24
assert len(edge_pairs) == 84
assert all(source_index != target_index for source_index, target_index in edge_pairs)
assert all(len(neighbors) == 7 for neighbors in adjacency)

# step -> step xor (step >> 1) は二十四ビット Gray 符号を一度ずつ列挙する。
# 隣り合う二列で反転する一頂点に接する七辺だけを更新する。
coefficient_by_broken_edge_count = [ZZ.zero() for _ in range(85)]
coefficient_by_broken_edge_count[0] = ZZ.one()
previous_configuration = 0
broken_edge_count = 0
configuration_count = 2**len(vertices)

for step in range(1, configuration_count):
    configuration = operator.xor(step, step >> 1)
    changed_mask = operator.xor(previous_configuration, configuration)
    assert changed_mask > 0 and changed_mask & (changed_mask - 1) == 0
    changed_vertex = changed_mask.bit_length() - 1
    previous_value = (previous_configuration >> changed_vertex) & 1

    for neighbor in adjacency[changed_vertex]:
        neighbor_value = (previous_configuration >> neighbor) & 1
        if previous_value == neighbor_value:
            broken_edge_count += 1
        else:
            broken_edge_count -= 1

    coefficient_by_broken_edge_count[broken_edge_count] += 1
    previous_configuration = configuration

assert coefficient_by_broken_edge_count == expected_coefficients
assert sum(coefficient_by_broken_edge_count) == 2**24

polynomial_ring = PolynomialRing(ZZ, "x")
x = polynomial_ring.gen()
partition_polynomial = sum(
    coefficient * x**broken_edge_count
    for broken_edge_count, coefficient in enumerate(coefficient_by_broken_edge_count)
)
expected_polynomial = sum(
    coefficient * x**broken_edge_count
    for broken_edge_count, coefficient in enumerate(expected_coefficients)
)

assert partition_polynomial == expected_polynomial
assert partition_polynomial(1) == 2**24
assert partition_polynomial.degree() == 56

print(
    "RESULT: PASS — all 2^24 spin configurations of the sourced 24-vertex, "
    "84-edge quotient graph give exactly the stated ZZ[x] coefficient data"
)
