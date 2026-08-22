# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: |Z_G| = 2 |O_G| + epsilon_G
# 帰属: 有限集合、NN

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    support_cardinality = NN(len(data["root_support"]))
    decomposed_cardinality = 2 * data["inverse_orbit_count"] + data["minus_one_indicator"]
    assert support_cardinality == decomposed_cardinality, data["name"]

print("RESULT: PASS — support cardinality is twice the orbit count plus the -1 indicator")
