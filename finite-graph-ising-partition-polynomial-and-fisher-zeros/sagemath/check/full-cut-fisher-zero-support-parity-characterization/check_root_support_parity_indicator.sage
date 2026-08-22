# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: |Z_G| is odd if and only if epsilon_G = 1
# 帰属: NN

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    support_is_odd = NN(len(data["root_support"])) % 2 == 1
    indicator_is_one = data["minus_one_indicator"] == 1
    assert support_is_odd == indicator_is_one, data["name"]

print("RESULT: PASS — odd Fisher support cardinality is equivalent to indicator one")
