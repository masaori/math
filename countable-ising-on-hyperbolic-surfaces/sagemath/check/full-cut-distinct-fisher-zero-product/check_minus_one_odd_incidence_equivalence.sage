# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 式: -1 in Z_G iff an odd incident-edge-count vertex exists
# 帰属: 有限集合、NN、ZZ、QQbar

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data in example_data:
    minus_one_is_root = QQbar(-1) in data["root_support"]
    assert minus_one_is_root == data["odd_incident_vertex_exists"], data["name"]

print("RESULT: PASS — membership of -1 is equivalent to an odd incident-edge-count vertex")
