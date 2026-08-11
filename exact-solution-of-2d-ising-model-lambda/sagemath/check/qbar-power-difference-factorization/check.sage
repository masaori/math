# 対象ラベル: claim_qbar_power_difference_factorization
#
# 主張: z, w を代数的数、n を自然数とし、H_0(z,w) = 0、H_{n+1}(z,w) = H_n(z,w) w + z^n
#       と置くと (z - w) H_n(z,w) = z^n - w^n である。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar・行列環）で確かめる。
# 浮動小数点は使わない。

def pow_rec(z, k, one):
    # z^k を定義どおり反復で作る（z^0 = 1、z^{j+1} = z^j z）。
    acc = one
    for _ in range(k):
        acc = acc * z
    return acc


def h_rec(z, w, n, one, zero):
    # H_0 = 0、H_{n+1} = H_n w + z^n。本文の約束をそのまま反復する。
    acc = zero
    for k in range(n):
        acc = acc * w + pow_rec(z, k, one)
    return acc


def check_prep(samples, kmax, one, name):
    # 準備の段。z z^k = z^k z（積の結合則と単位元だけから出る。積の可換則は使わない）。
    # 環全体が可換でなくても成り立つことを、行列環でも見る（下の check_prep の呼び出し）。
    print("0. 準備（z z^k = z^k z）: %s" % name)
    for z in samples:
        for k in range(0, kmax + 1):
            zk = pow_rec(z, k, one)
            assert z * zk == zk * z
            assert zk * z == pow_rec(z, k + 1, one)
    print("   通過（k = 0,...,%d）" % kmax)


def check_base(pairs, one, zero, name):
    print("1. 出発点（(z-w) H_0(z,w) = z^0 - w^0 = 0）: %s" % name)
    for (z, w) in pairs:
        assert h_rec(z, w, 0, one, zero) == zero
        assert (z - w) * h_rec(z, w, 0, one, zero) == pow_rec(z, 0, one) - pow_rec(w, 0, one)
    print("   通過")


def check_step(pairs, nmax, one, zero, name):
    print("2. 一歩（鎖の各段）: %s" % name)
    for (z, w) in pairs:
        for n in range(0, nmax + 1):
            hn = h_rec(z, w, n, one, zero)
            hn1 = h_rec(z, w, n + 1, one, zero)
            zn = pow_rec(z, n, one)
            wn = pow_rec(w, n, one)
            # 第 1 の等号（H_{n+1} の約束）
            assert hn1 == hn * w + zn
            # 第 2 の等号（分配則）
            assert (z - w) * hn1 == (z - w) * (hn * w) + (z - w) * zn
            # 第 3 の等号（積の結合則）
            assert (z - w) * (hn * w) == ((z - w) * hn) * w
            # 第 4 の等号（帰納法の仮定を、その n で成り立つ事実として使う）
            assert (z - w) * hn == zn - wn
            # 第 5 の等号（分配則）
            assert (zn - wn) * w == zn * w - wn * w
            # 第 6 の等号（冪の約束 w^{n+1} = w^n w）
            assert wn * w == pow_rec(w, n + 1, one)
            # 第 7 の等号（分配則）
            assert (z - w) * zn == z * zn - w * zn
            # 第 8・第 9 の等号（準備の等式 z z^n = z^n z と冪の約束 z^{n+1} = z^n z）
            assert z * zn == zn * z
            assert zn * z == pow_rec(z, n + 1, one)
            # 第 10 の等号（ここで z と w の可換性が要る。可換性を使うのはこの 1 箇所だけ）
            assert w * zn == zn * w
    print("   通過（n = 0,...,%d）" % nmax)


def check_claim(pairs, nmax, one, zero, name):
    print("3. 主張そのもの（(z-w) H_n(z,w) = z^n - w^n）: %s" % name)
    for (z, w) in pairs:
        for n in range(0, nmax + 1):
            assert (z - w) * h_rec(z, w, n, one, zero) == pow_rec(z, n, one) - pow_rec(w, n, one)
    print("   通過（n = 0,...,%d）" % nmax)


def check_specialization(samples, nmax):
    # w = 1 と取ると H_n(z,1) は G_n(z) = Σ_{k=0}^{n-1} z^k に一致し、
    # 主張は伸縮の等式 (z-1) G_n(z) = z^n - 1 に一致する（本文の最後の注記）。
    print("4. w = 1 の特殊化が伸縮の等式に一致すること")
    one = QQbar(1)
    zero = QQbar(0)
    for z in samples:
        for n in range(0, nmax + 1):
            g = sum([pow_rec(z, k, one) for k in range(n)], zero)
            assert h_rec(z, one, n, one, zero) == g
            assert (z - one) * g == pow_rec(z, n, one) - one
    print("   通過（n = 0,...,%d）" % nmax)


def check_factor_theorem(samples, nmax):
    # 使い道の裏取り。w が z^n - 1 の根（すなわち w ∈ μ_n）のとき、
    # 任意の z について z^n - 1 = (z - w) H_n(z,w) と書ける。
    # これが「根を持てば一次式を因子に持つ」の等式版である。
    print("5. 使い道（w ∈ μ_n のとき z^n - 1 = (z-w) H_n(z,w)）")
    one = QQbar(1)
    zero = QQbar(0)
    for n in range(1, nmax + 1):
        roots = [QQbar.zeta(n) ** j for j in range(n)]
        for w in roots:
            assert pow_rec(w, n, one) == one
            for z in samples:
                assert pow_rec(z, n, one) - one == (z - w) * h_rec(z, w, n, one, zero)
    print("   通過（n = 1,...,%d）" % nmax)


def check_noncommutative_fails(nmax):
    # 必要十分版の仮定の裏取り。z と w が可換でないと主張は成り立たない
    # （本文が z と w の可換性を使う唯一の箇所である第 10 の等号が効かなくなる）。
    # 可換な 2 元では通ることも併せて見る。
    print("6. 必要十分版の仮定の裏取り（可換性が要ること）: 2 次整数行列環")
    M = MatrixSpace(ZZ, 2, 2)
    one = M.one()
    zero = M.zero()
    a = M([[0, -1], [1, 0]])
    b = M([[1, 1], [0, 1]])
    assert a * b != b * a
    # 準備の段は環が可換でなくても成り立つ（同じ元どうしの入れ替えだから）。
    check_prep([a, b], nmax, one, "2 次整数行列環")
    found = False
    for n in range(0, nmax + 1):
        if (a - b) * h_rec(a, b, n, one, zero) != pow_rec(a, n, one) - pow_rec(b, n, one):
            found = True
    assert found, "可換でない 2 元で反例が見つからなかった"
    print("   通過（可換でない 2 元では等式が破れる n がある）")
    # 可換な 2 元（一方が他方の冪）では通る。
    c = a * a
    assert a * c == c * a
    for n in range(0, nmax + 1):
        assert (a - c) * h_rec(a, c, n, one, zero) == pow_rec(a, n, one) - pow_rec(c, n, one)
    print("   通過（可換な 2 元では等式が成り立つ）")


print("=== claim_qbar_power_difference_factorization ===")

one = QQbar(1)
zero = QQbar(0)
samples = [
    QQbar(0), QQbar(1), QQbar(-1), QQbar(2), QQbar(1) / 3,
    QQbar.zeta(3), QQbar.zeta(5) ** 2, QQbar(2).sqrt(), QQbar(-1).sqrt(),
]
pairs = [(z, w) for z in samples for w in samples]

check_prep(samples, 6, one, "QQbar")
check_base(pairs, one, zero, "QQbar")
check_step(pairs, 6, one, zero, "QQbar")
check_claim(pairs, 6, one, zero, "QQbar")
check_specialization(samples, 6)
check_factor_theorem(samples, 6)
check_noncommutative_fails(6)

print("すべて通過")
