# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: Z_G(-1) = 0 iff an odd incident-edge-count vertex exists
# 帰属: 有限集合、NN、ZZ

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    integer_value_is_zero = ZZ(data["polynomial"](-1)) == 0
    assert integer_value_is_zero == data["odd_incident_vertex_exists"], data["name"]

print("RESULT: PASS — a root at -1 is equivalent to an odd incident-edge-count vertex")
