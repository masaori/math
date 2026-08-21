# 対象ラベル: theorem_coefficient_symmetry_characterizes_full_cut
# 式: 全辺二分割の存在と全係数対称性の同値性
# 帰属: 有限集合、NN、ZZ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/coefficient-symmetry-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    _, multiplicities, polynomial = partition_data(vertex_count, edges)
    full_cut_exists = has_full_cut(vertex_count, edges)
    coefficients_are_symmetric = has_symmetric_coefficients(multiplicities)

    assert full_cut_exists == coefficients_are_symmetric
    assert all(
        polynomial[degree] == ZZ(multiplicities[degree])
        for degree in range(len(edges) + 1)
    )

print("RESULT: PASS — full-cut existence and exact ZZ[x] coefficient symmetry agree in every finite example")
