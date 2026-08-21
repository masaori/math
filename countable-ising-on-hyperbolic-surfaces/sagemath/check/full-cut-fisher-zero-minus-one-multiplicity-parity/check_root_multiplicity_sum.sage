# 対象ラベル: theorem_full_cut_fisher_zero_minus_one_multiplicity_parity
# 式: |E| = sum_{alpha in Z_G} mu_G(alpha)
# 帰属: NN、QQbar、QQbar[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data in example_data:
    multiplicity_sum = NN(sum(data["root_multiplicities"].values()))
    assert NN(data["polynomial"].degree()) == data["edge_count"], data["name"]
    assert multiplicity_sum == data["edge_count"], data["name"]

print("RESULT: PASS — the exact QQbar root multiplicities sum to |E|")
