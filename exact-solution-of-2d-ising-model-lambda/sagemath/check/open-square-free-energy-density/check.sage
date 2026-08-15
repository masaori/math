# 対象ラベル: def_open_square_free_energy_density
#
# 可算側（1/L² ∈ QQ の確定・正値性、Z^op_{L,L}(t) ∈ QQ_{>0}、t = 1 での ψ^op_L(1) = log 2 の
# 記号計算）は厳密に検査する。実対数の値は一般に超越的で厳密の閉形式比較ができないため、
# 実対数に触れる検査だけ RealBallField（ball 算術。丸め誤差を厳密に包含する）を使う。
# ball 算術は「等式の成立」を証明できないので、整合の確認にとどまることを各関数に明記する。
# 有限標本での検査であり、普遍量化された定義の well-formed 性の証明ではない（本文が担う）。

from itertools import product

RBF = RealBallField(256)

L_RANGE = [1, 2, 3]
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


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


def open_configurations(a, b):
    vertices = open_vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        yield dict(zip(vertices, values))


def broken_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))


def partition_value(a, b, t):
    return sum((t ** broken_count(a, b, sigma)
                for sigma in open_configurations(a, b)), QQ.zero())


def check_rational_inverse_square_well_defined():
    # 可算側（厳密）: L ≥ 1 で L² ≠ 0、1/L² ∈ QQ、0 < 1/L²。
    total = 0
    for L in L_RANGE:
        assert L * L != 0, L
        w = QQ(1) / (L * L)
        assert w in QQ and w > 0, L
        total += 1
    print(f"L² ≠ 0 と 1/L² ∈ QQ の確定・正値性（厳密）: {total} 件 OK")
    return total


def check_open_value_positive_and_density_ball():
    # Z^op_{L,L}(t) ∈ QQ かつ Z^op_{L,L}(t) > 0（厳密比較。log_ℝ の定義域に入る）と、
    # ψ^op_L(t) = ι(1/L²)·log_ℝ(Z^op_{L,L}(t)) の ball が有限に確定すること。
    total = 0
    for L in L_RANGE:
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = partition_value(L, L, t)
            assert value in QQ and value > 0, (L, t)
            psi = RBF(w) * RBF(value).log()
            assert psi.is_finite(), (L, t)
            total += 1
    print(f"Z^op_{{L,L}}(t) > 0（厳密）と ψ^op_L(t) の ball の確定: {total} 件 OK")
    return total


def check_open_density_times_size_consistency():
    # 整合検査（証明ではない）: ι(L²)·ψ^op_L(t) − log_ℝ(Z^op_{L,L}(t)) の ball が 0 を含み、
    # 半径が 2^{-200} 未満であること。
    total = 0
    for L in L_RANGE:
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = partition_value(L, L, t)
            log_value = RBF(value).log()
            diff = RBF(L * L) * (RBF(w) * log_value) - log_value
            assert diff.contains_zero(), (L, t)
            assert diff.rad() < RealField(53)(2) ** (-200), (L, t)
            total += 1
    print(f"L²·ψ^op_L(t) − log Z^op_{{L,L}}(t) の ball が 0 を含む（整合。証明ではない）: {total} 件 OK")
    return total


def check_open_density_at_one_symbolic():
    # t = 1（記号計算で厳密）: Z^op_{L,L}(1) = 2^{L²} なので ψ^op_L(1) = log 2（L に依らない）。
    total = 0
    for L in L_RANGE:
        value = partition_value(L, L, QQ(1))
        assert value == 2 ** (L * L), L
        assert bool(log(value) / (L * L) == log(2)), L
        total += 1
    print(f"ψ^op_L(1) = log 2（L に依らない。記号計算で厳密）: {total} 件 OK")
    return total


total = 0
total += check_rational_inverse_square_well_defined()
total += check_open_value_positive_and_density_ball()
total += check_open_density_times_size_consistency()
total += check_open_density_at_one_symbolic()
print(f"開境界正方形の自由エネルギー密度: 合計 {total} 件 OK")
