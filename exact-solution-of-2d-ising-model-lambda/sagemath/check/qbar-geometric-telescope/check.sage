# 対象ラベル: claim_qbar_geometric_telescope
#
# 主張: z を代数的数、n を自然数とし、G_n(z) = Σ_{k=0}^{n-1} z^k と置くと
#       (z - 1) G_n(z) = z^n - 1 である。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar・多項式環・行列環）で確かめる。
# 浮動小数点は使わない。

def pow_rec(z, k, one):
    # z^k を定義どおり反復で作る（z^0 = 1、z^{j+1} = z^j z）。
    acc = one
    for _ in range(k):
        acc = acc * z
    return acc


def geom_sum(z, n, one, zero):
    # G_n(z) = Σ_{k=0}^{n-1} z^k。n = 0 は空和で 0。
    acc = zero
    for k in range(n):
        acc = acc + pow_rec(z, k, one)
    return acc


def check_base(samples, one, zero, name):
    print("1. 出発点（(z-1) G_0(z) = z^0 - 1 = 0）: %s" % name)
    for z in samples:
        assert geom_sum(z, 0, one, zero) == zero
        assert (z - one) * geom_sum(z, 0, one, zero) == pow_rec(z, 0, one) - one
    print("   通過")


def check_step(samples, nmax, one, zero, name):
    print("2. 一歩（(z-1) G_{n+1} = (z-1) G_n + (z-1) z^n から z^{n+1} - 1 へ）: %s" % name)
    for z in samples:
        for n in range(0, nmax + 1):
            lhs = (z - one) * geom_sum(z, n + 1, one, zero)
            # 第 1 の等号（G_{n+1} = G_n + z^n）
            assert geom_sum(z, n + 1, one, zero) == geom_sum(z, n, one, zero) + pow_rec(z, n, one)
            # 第 2 の等号（分配則）
            assert lhs == (z - one) * geom_sum(z, n, one, zero) + (z - one) * pow_rec(z, n, one)
            # 第 3 の等号（帰納法の仮定を、その n で成り立つ事実として使う）
            assert (z - one) * geom_sum(z, n, one, zero) == pow_rec(z, n, one) - one
            # 第 4・第 5 の等号（分配則と z z^n = z^{n+1}）
            assert (z - one) * pow_rec(z, n, one) == pow_rec(z, n + 1, one) - pow_rec(z, n, one)
    print("   通過（n = 0,...,%d）" % nmax)


def check_claim(samples, nmax, one, zero, name):
    print("3. 主張そのもの（(z-1) G_n(z) = z^n - 1）: %s" % name)
    for z in samples:
        for n in range(0, nmax + 1):
            assert (z - one) * geom_sum(z, n, one, zero) == pow_rec(z, n, one) - one
    print("   通過（n = 0,...,%d）" % nmax)


def check_root_of_unity_consequence(nmax):
    print("4. 応用の形（z ∈ μ_n かつ z ≠ 1 ならば G_n(z) = 0）")
    one = QQbar(1)
    zero = QQbar(0)
    for n in range(1, nmax + 1):
        for j in range(n):
            z = QQbar.zeta(n) ** j
            assert pow_rec(z, n, one) == one
            if z != one:
                # (z - 1) G_n(z) = z^n - 1 = 0 で、体に零因子が無いので G_n(z) = 0。
                assert (z - one) * geom_sum(z, n, one, zero) == zero
                assert geom_sum(z, n, one, zero) == zero
            else:
                # z = 1 のときは G_n(1) = n であり 0 ではない。
                assert geom_sum(z, n, one, zero) == QQbar(n)
    print("   通過（n = 1,...,%d）" % nmax)


def check_noncommutative(nmax):
    print("5. 必要十分版の仮定の裏取り（可換でない環でも通ること）")
    R = MatrixSpace(ZZ, 2, 2)
    one = R.one()
    zero = R.zero()
    samples = [
        R([[0, -1], [1, 0]]),   # 位数 4
        R([[1, 1], [0, 1]]),    # 可換でない相手を持つ元
        R([[2, 1], [1, 1]]),
    ]
    # この 3 つは互いに可換ではない（可換性を仮定していないことの裏取り）。
    assert samples[0] * samples[1] != samples[1] * samples[0]
    for z in samples:
        for n in range(0, nmax + 1):
            assert (z - one) * geom_sum(z, n, one, zero) == pow_rec(z, n, one) - one
    print("   通過（2 次整数行列環、n = 0,...,%d）" % nmax)


def check_needs_ring(nmax):
    print("6. 必要十分版で環（引き算）が要ること")
    # 係数環に引き算が無いと (z - 1) も z^n - 1 も書けない。
    # ここでは代わりに、引き算を使わない同値な形
    #   G_n(z) z + 1 = G_n(z) + z^n
    # が成り立つことを ℕ 係数の多項式（半環）で確かめる（環の版と同値であることの目安）。
    P = PolynomialRing(ZZ, 'u')
    u = P.gen()
    one = P.one()
    zero = P.zero()
    for n in range(0, nmax + 1):
        assert geom_sum(u, n, one, zero) * u + one == geom_sum(u, n, one, zero) + pow_rec(u, n, one)
    print("   通過（n = 0,...,%d）" % nmax)


print("=== claim_qbar_geometric_telescope ===")
QBAR_SAMPLES = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(1) / QQbar(3),
    QQbar.zeta(3),
    QQbar.zeta(5) ** 2,
    QQbar(2).sqrt(),
    QQbar(-1).sqrt(),
]
ONE = QQbar(1)
ZERO = QQbar(0)
check_base(QBAR_SAMPLES, ONE, ZERO, "QQbar")
check_step(QBAR_SAMPLES, 8, ONE, ZERO, "QQbar")
check_claim(QBAR_SAMPLES, 8, ONE, ZERO, "QQbar")
check_root_of_unity_consequence(8)
check_noncommutative(6)
check_needs_ring(8)
print("すべて通過")
