# 対象ラベル: epsilon_square_identity
# 全成分は QQ に属し、以下の等号判定に浮動小数点は使わない。

sigma_x = matrix(QQ, [[0, 1], [1, 0]])
identity_two = identity_matrix(QQ, 2)


def kronecker_factors(factors):
    result = matrix(QQ, [[1]])
    for factor in factors:
        result = result.tensor_product(factor)
    return result


def site_sigma_x(M, site):
    factors = [identity_two for _ in range(M)]
    factors[site] = sigma_x
    return kronecker_factors(factors)


def site_product(M, count=None):
    if count is None:
        count = M
    result = identity_matrix(QQ, 2**M)
    for site in range(count):
        result *= site_sigma_x(M, site)
    return result


def all_sigma_x_factors(M):
    return kronecker_factors([sigma_x for _ in range(M)])


def all_identity_factors(M):
    return kronecker_factors([identity_two for _ in range(M)])


def prefix_sigma_x_factors(M, count):
    return kronecker_factors(
        [sigma_x if site < count else identity_two for site in range(M)]
    )
