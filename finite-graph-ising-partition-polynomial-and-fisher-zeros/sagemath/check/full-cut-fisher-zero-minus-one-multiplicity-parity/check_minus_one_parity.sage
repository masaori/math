# 対象ラベル: theorem_full_cut_fisher_zero_minus_one_multiplicity_parity
# 式: mu_G(-1) = |E| mod 2
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data in example_data:
    assert data["minus_one_multiplicity"].mod(2) == data["edge_count"].mod(2), (
        data["name"],
        data["minus_one_multiplicity"],
        data["edge_count"],
    )

print("RESULT: PASS — the multiplicity of -1 has the same parity as |E|")
