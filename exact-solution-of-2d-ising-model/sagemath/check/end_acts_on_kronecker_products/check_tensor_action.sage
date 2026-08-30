# ---------------------------------------------------------
# SageMath: クロネッカー積で作る行列の作用が各因子の作用に分かれること
# 対象ラベル: end_acts_on_kronecker_products
# 対象: structured-latex/content/004_transfer_matrix.ts
# 帰属: 行列と数ベクトルの成分は QQ。浮動小数点を使わない。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))

rep = CheckReport("end_acts_on_kronecker_products")

def kron_matrices(factors):
    result = matrix(QQ, [[1]])
    for factor in factors:
        result = result.tensor_product(factor)
    return result

def kron_vectors(factors):
    result = vector(QQ, [1])
    for factor in factors:
        result = vector(QQ, [a * b for a in result for b in factor])
    return result

test_matrices = [
    matrix(QQ, [[1, 2], [3, 4]]),
    matrix(QQ, [[0, -1], [2, 1]]),
    matrix(QQ, [[2, 0], [1, -2]]),
    matrix(QQ, [[-1, 3], [0, 2]]),
]
test_vectors = [
    vector(QQ, [1, 2]),
    vector(QQ, [-1, 3]),
    vector(QQ, [2, -2]),
    vector(QQ, [0, 1]),
]

for M in [1, 2, 3, 4]:
    matrices = test_matrices[:M]
    vectors = test_vectors[:M]
    lhs = kron_matrices(matrices) * kron_vectors(vectors)
    rhs = kron_vectors([matrices[index] * vectors[index] for index in range(M)])
    rep.truth(lhs == rhs, f"M={M}: クロネッカー積の作用が各因子の作用に分かれる")

rep.finish()
