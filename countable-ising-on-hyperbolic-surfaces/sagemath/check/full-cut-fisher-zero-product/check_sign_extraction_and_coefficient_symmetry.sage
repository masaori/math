# 対象ラベル: theorem_full_cut_fisher_zero_product
# 式ペア: Omega_G(|E|) product_j (-alpha_j)
#          = Omega_G(|E|)(-1)^|E| product_j alpha_j
#          = Omega_G(0)(-1)^|E| product_j alpha_j

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-product/_prelude.sage")

for data in example_data:
    polynomial = data["polynomial"]
    edge_count = data["edge_count"]
    roots = data["roots_with_multiplicity"]
    leading_times_negative_roots = polynomial[edge_count] * prod(-alpha for alpha in roots)
    extracted_sign = polynomial[edge_count] * (-1)^edge_count * prod(roots)
    symmetric_constant = polynomial[0] * (-1)^edge_count * prod(roots)
    assert leading_times_negative_roots == extracted_sign, data["name"]
    assert polynomial[edge_count] == polynomial[0], data["name"]
    assert extracted_sign == symmetric_constant, data["name"]

print("RESULT: PASS — sign extraction and full-cut coefficient symmetry agree in every exact example")
