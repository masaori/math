# 対象ラベル: epsilon_is_real_symmetric
# 全成分を QQ に置き、以下の等号判定に浮動小数点は使わない（QQ ⊂ R ⊂ C の包含前に判定する）。

sigma_x = matrix(QQ, [[0, 1], [1, 0]])
identity_two = identity_matrix(QQ, 2)

M_COL_RANGE = [1, 2, 3, 4, 5, 6]


def kronecker_factors(factors):
    """def_kronecker の具体的なクロネッカー積（先頭因子が最上位）。"""
    result = matrix(QQ, [[1]])
    for factor in factors:
        result = result.tensor_product(factor)
    return result


def site_sigma_x(M, site):
    """sigma^x_site = I_2 ⊠ … ⊠ sigma^x（site 番目）⊠ … ⊠ I_2（site は 1 始まり）"""
    return kronecker_factors([sigma_x if j == site else identity_two for j in range(1, M + 1)])


def epsilon_by_definition(M):
    """def_global_spin_flip_matrix: epsilon := sigma^x_1 sigma^x_2 … sigma^x_M（行列の積）"""
    result = identity_matrix(QQ, 2 ** M)
    for site in range(1, M + 1):
        result = result * site_sigma_x(M, site)
    return result


def all_sigma_x_factors(M):
    """epsilon_square_and_eigenvalues の証明で得た表示 sigma^x ⊠ … ⊠ sigma^x"""
    return kronecker_factors([sigma_x for _ in range(M)])
