# 線型代数の定義（def_subspace・def_linear_combination・def_spanning_family・def_linearly_independent・def_basis・
# def_dimension）の検算が共通に使う道具。check ディレクトリから load("../../_shared/linear_algebra_families.sage") で読む。
# 係数体は Gauss 有理数体 K = QQ(i)（厳密計算。浮動小数点は使わない）。
# 線型結合・有限和は本文の定義どおり「左から順に足す」形で組む（p = 0 の線型結合は零行列）。

K = QuadraticField(-1, 'i')
iK = K.gen()

_COUNT = [0]


def ok(cond, label=""):
    """主張・鎖の一行が成り立つことを数えながら確かめる。"""
    assert cond, label
    _COUNT[0] += 1


def count():
    return _COUNT[0]


def zero(m, n, R=K):
    return matrix(R, m, n, 0)


def fsum(Xs):
    """def_finite_sum_of_matrices / def_finite_sum_of_complex_numbers: 左から順に足す（r ≥ 1）。"""
    assert len(Xs) >= 1
    out = Xs[0]
    for X in Xs[1:]:
        out = out + X
    return out


def lincomb(cs, us, m, n, R=K):
    """def_linear_combination: p = 0 なら O、p ≥ 1 なら Σ_{t=1}^{p} (c_t u_t)。"""
    assert len(cs) == len(us)
    if len(us) == 0:
        return zero(m, n, R)
    return fsum([cs[t] * us[t] for t in range(len(us))])


def flat(X):
    return vector(X.base_ring(), X.list())


def rank_of(us, m, n):
    if len(us) == 0:
        return 0
    return matrix(K, [flat(u) for u in us]).rank()


def is_independent(us, m, n):
    """def_linearly_independent（p 個の元の族の、平らにした行列の階数が p）。"""
    return rank_of(us, m, n) == len(us)


def in_span(x, us, m, n):
    """x が族 us の線型結合か（def_linear_combination。p = 0 なら x = O かどうか）。"""
    if len(us) == 0:
        return x == zero(m, n)
    return rank_of(list(us) + [x], m, n) == rank_of(us, m, n)


def coefficients_in(x, us, m, n):
    """x = Σ c_t u_t となる係数を一組返す（us が線型独立なら一意）。"""
    if len(us) == 0:
        assert x == zero(m, n)
        return []
    A = matrix(K, [flat(u) for u in us]).transpose()
    return list(A.solve_right(flat(x)))


def small_K(rng):
    return K(rng.randint(-3, 3)) + K(rng.randint(-3, 3)) * iK


def rand_mat(rng, m, n):
    return matrix(K, m, n, [small_K(rng) for _ in range(m * n)])


def rand_vec_list(rng, k):
    return [small_K(rng) for _ in range(k)]


def matrix_unit(m, n, i, j):
    """matrix_units_form_basis の E^{(m,n)}_{ij}（添字は 0 始まりで持つ）。"""
    E = zero(m, n)
    E[i, j] = 1
    return E


def standard_basis(n):
    return [matrix_unit(n, 1, t, 0) for t in range(n)]
