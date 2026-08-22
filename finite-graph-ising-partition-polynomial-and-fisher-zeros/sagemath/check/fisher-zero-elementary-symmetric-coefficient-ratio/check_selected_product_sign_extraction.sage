# 対象ラベル: theorem_fisher_zero_elementary_symmetric_coefficient_ratio
# 式ペア: sum_{|I|=k} prod_{j in I}(-alpha_j) = (-1)^k sum_{|I|=k} prod_{j in I}alpha_j

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-elementary-symmetric-coefficient-ratio/_prelude.sage")

for data in examples:
    degree = data["degree"]
    for cardinality in range(degree + 1):
        signed_sum = selected_products(data["roots"], cardinality, sign=ZZ(-1))
        unsigned_sum = selected_products(data["roots"], cardinality)
        assert signed_sum == (-1) ** cardinality * unsigned_sum, (data["name"], cardinality)

print("RESULT: PASS — extracting one minus sign from each selected factor gives the cardinality sign")
