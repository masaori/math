# 対象ラベル: theorem_full_cut_fisher_zero_reciprocal_multiplicity
# 式ペア: deg(P_G)=|E| および P_G(0)=Omega_G(0) != 0

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-reciprocal-multiplicity/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    assert polynomial.degree() == edge_count, data["name"]
    assert polynomial[0] != 0, data["name"]
    assert polynomial[edge_count] == polynomial[0], data["name"]

print("RESULT: PASS — every full-cut example has degree |E| and a nonzero symmetric constant coefficient")
