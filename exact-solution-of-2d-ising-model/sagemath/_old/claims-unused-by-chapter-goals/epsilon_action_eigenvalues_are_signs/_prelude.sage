# 対象ラベル: epsilon_action_eigenvalues_are_signs
# 全成分と固有値は QQ に属し、QQ -> C の包含前に厳密判定する。

sigma_x = matrix(QQ, [[0, 1], [1, 0]])


def kronecker_power_x(M):
    result = matrix(QQ, [[1]])
    for _site in range(M):
        result = result.tensor_product(sigma_x)
    return result


def eigen_cases():
    for M in [1, 2, 3, 4, 5]:
        dimension = 2**M
        epsilon = kronecker_power_x(M)
        first = vector(QQ, [1] + [0] * (dimension - 1))
        last = vector(QQ, [0] * (dimension - 1) + [1])
        for eigenvalue in [QQ(1), QQ(-1)]:
            eigenvector = first + eigenvalue * last
            yield M, epsilon, eigenvector, eigenvalue, 0
