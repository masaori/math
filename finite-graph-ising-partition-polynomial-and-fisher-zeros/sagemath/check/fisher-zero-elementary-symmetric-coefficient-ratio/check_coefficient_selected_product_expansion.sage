# 対象ラベル: theorem_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: Omega_G(d-k) = Omega_G(d) sum_{|I|=k} prod_{j in I}(-alpha_j)

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    polynomial = data["polynomial"]
    degree = data["degree"]
    for cardinality in range(degree + 1):
        selected_sum = selected_products(data["roots"], cardinality, sign=ZZ(-1))
        assert polynomial[degree - cardinality] == polynomial[degree] * selected_sum, (
            data["name"],
            cardinality,
        )

print("RESULT: PASS — every coefficient equals the leading coefficient times all signed selected-root products")
