# 対象ラベル: claim_open_square_block_tiling_logarithm
#
# 開境界正方形のブロック敷き詰め評価を実対数へ移した二場合の不等式を検査する。
# 分配多項式の値と有理数係数は厳密計算し、実対数に触れる比較だけ
# RealBallField（丸め誤差を包含する ball 算術）を使う。

from itertools import product

RBF = RealBallField(256)
T_SAMPLES = [QQ(1) / 10, QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(3) / 2, QQ(3), QQ(5)]
AK_SAMPLES = [(1, 1), (1, 2), (1, 3), (2, 1), (2, 2)]


def open_vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges(a, b):
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_partition_value(a, b, t):
    vertices = open_vertices(a, b)
    total = QQ.zero()
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        sigma = dict(zip(vertices, values))
        broken = sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))
        total += t ** broken
    return total


def assert_ball_le(left, right, data):
    difference = left - right
    assert difference.upper() <= 0 or (
        difference.contains_zero() and difference.rad() < RealField(53)(2) ** (-200)
    ), data


def check_logarithmized_bounds():
    total = 0
    for a, k in AK_SAMPLES:
        assert a >= 1 and k >= 1
        correction_coefficient = QQ(2 * (k - 1)) / (k * a)
        assert correction_coefficient in QQ
        for t in T_SAMPLES:
            small_value = open_partition_value(a, a, t)
            large_value = open_partition_value(k * a, k * a, t)
            assert small_value > 0 and large_value > 0
            psi_small = RBF(1 / QQ(a * a)) * RBF(small_value).log()
            psi_large = RBF(1 / QQ((k * a) ** 2)) * RBF(large_value).log()
            correction = RBF(correction_coefficient) * RBF(t).log()
            if t <= 1:
                assert_ball_le(correction + psi_small, psi_large, (a, k, t, 'lower'))
                assert_ball_le(psi_large, psi_small, (a, k, t, 'upper'))
            if 1 <= t:
                assert_ball_le(psi_small, psi_large, (a, k, t, 'lower'))
                assert_ball_le(psi_large, correction + psi_small, (a, k, t, 'upper'))
            total += 1
    print(f"ブロック敷き詰め評価の対数化（ball による順序分離）: {total} 件 OK")
    return total


def check_coefficient_identity():
    total = 0
    for a, k in AK_SAMPLES:
        left_correction = QQ(1) / ((k * a) ** 2) * (2 * (k - 1) * k * a)
        right_correction = QQ(2 * (k - 1)) / (k * a)
        left_density = QQ(1) / ((k * a) ** 2) * (k ** 2)
        right_density = QQ(1) / (a ** 2)
        assert left_correction == right_correction
        assert left_density == right_density
        total += 2
    print(f"対数化後の有理数係数の約分（厳密）: {total} 件 OK")
    return total


total = check_logarithmized_bounds() + check_coefficient_identity()
print(f"ブロック敷き詰め評価の対数化: 合計 {total} 件 OK")
