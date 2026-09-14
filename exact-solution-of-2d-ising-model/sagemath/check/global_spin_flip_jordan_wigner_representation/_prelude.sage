# 対象ラベル: global_spin_flip_jordan_wigner_representation
# 全成分は Gaussian 有理数体に属し、浮動小数点は使わない。

K.<i> = QuadraticField(-1)
sigma_x = matrix(K, [[0, 1], [1, 0]])
sigma_y = matrix(K, [[0, -i], [i, 0]])
sigma_z = matrix(K, [[1, 0], [0, -1]])
identity_two = identity_matrix(K, 2)


def kronecker_factors(factors):
    result = matrix(K, [[1]])
    for factor in factors:
        result = result.tensor_product(factor)
    return result


def site_operator(M, site, factor):
    factors = [identity_two for _ in range(M)]
    factors[site] = factor
    return kronecker_factors(factors)


def sigma_x_prefix(M, count):
    result = identity_matrix(K, 2**M)
    for site in range(count):
        result *= site_operator(M, site, sigma_x)
    return result


def sigma_x_prefix_factors(M, count):
    return kronecker_factors([
        sigma_x if site < count else identity_two for site in range(M)
    ])


def jordan_wigner(M, site, terminal):
    return sigma_x_prefix(M, site) * site_operator(M, site, terminal)


def jordan_wigner_factors(M, site, terminal):
    return kronecker_factors([
        sigma_x if index < site else terminal if index == site else identity_two
        for index in range(M)
    ])


def pair_prefix(M, count):
    result = identity_matrix(K, 2**M)
    for site in range(count):
        result *= jordan_wigner(M, site, sigma_z) * jordan_wigner(M, site, sigma_y)
    return result
