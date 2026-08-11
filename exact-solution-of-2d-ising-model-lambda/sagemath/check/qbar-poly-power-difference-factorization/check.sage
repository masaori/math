# 対象ラベル: claim_qbar_poly_power_difference_factorization
#            def_qbar_polynomial_ring / def_qbar_constant_embedding
#
# 主張: w を代数的数、n を自然数とし、K_0(w) = 0、K_{n+1}(w) = K_n(w) ŵ + t^n と置くと
#       (t - ŵ) K_n(w) = t^n - ŵ^n である（ŵ は w を定数多項式として送ったもの）。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar 係数の多項式環）で確かめる。
# 浮動小数点は使わない。

R.<t> = PolynomialRing(QQbar)


def const(a):
    # 定数として送る写像 a ↦ â（def_qbar_constant_embedding）。
    return R(a)


def pow_rec(f, k):
    # f^k を定義どおり反復で作る（f^0 = 1、f^{j+1} = f^j f）。
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def k_rec(w, n):
    # K_0 = 0、K_{n+1} = K_n ŵ + t^n。本文の約束をそのまま反復する。
    acc = R.zero()
    for j in range(n):
        acc = acc * const(w) + pow_rec(t, j)
    return acc


def check_embedding(samples):
    # 定数として送る写像が和・積・単位元・零元を保つこと（def_qbar_constant_embedding）。
    print("0. 定数として送る写像（â の性質）")
    for a in samples:
        assert const(a).degree() <= 0
        assert const(a)[0] == a
        for b in samples:
            assert const(a + b) == const(a) + const(b)
            assert const(a * b) == const(a) * const(b)
    assert const(QQbar(1)) == R.one()
    assert const(QQbar(0)) == R.zero()
    print("   通過")


def check_prep(kmax):
    # 準備の段。t t^k = t^k t（積の結合則と単位元だけから出る）。
    print("1. 準備（t t^k = t^k t）")
    for k in range(0, kmax + 1):
        tk = pow_rec(t, k)
        assert t * tk == tk * t
        assert tk * t == pow_rec(t, k + 1)
    print("   通過（k = 0,...,%d）" % kmax)


def check_base(samples):
    print("2. 出発点（(t-ŵ) K_0(w) = t^0 - ŵ^0 = 0）")
    for w in samples:
        assert k_rec(w, 0) == R.zero()
        assert (t - const(w)) * k_rec(w, 0) == pow_rec(t, 0) - pow_rec(const(w), 0)
    print("   通過")


def check_step(samples, nmax):
    print("3. 一歩（鎖の各段）")
    for w in samples:
        cw = const(w)
        for n in range(0, nmax + 1):
            kn = k_rec(w, n)
            kn1 = k_rec(w, n + 1)
            tn = pow_rec(t, n)
            wn = pow_rec(cw, n)
            # 第 1 の等号（K_{n+1} の約束）
            assert kn1 == kn * cw + tn
            # 第 2 の等号（分配則）
            assert (t - cw) * kn1 == (t - cw) * (kn * cw) + (t - cw) * tn
            # 第 3 の等号（積の結合則）
            assert (t - cw) * (kn * cw) == ((t - cw) * kn) * cw
            # 第 4 の等号（帰納法の仮定を、その n で成り立つ事実として使う）
            assert (t - cw) * kn == tn - wn
            # 第 5 の等号（分配則）
            assert (tn - wn) * cw == tn * cw - wn * cw
            # 第 6 の等号（冪の約束 ŵ^{n+1} = ŵ^n ŵ）
            assert wn * cw == pow_rec(cw, n + 1)
            # 第 7 の等号（分配則）
            assert (t - cw) * tn == t * tn - cw * tn
            # 第 8・第 9 の等号（準備の等式 t t^n = t^n t と冪の約束 t^{n+1} = t^n t）
            assert t * tn == tn * t
            assert tn * t == pow_rec(t, n + 1)
            # 第 10 の等号（t と ŵ の可換性。係数どうしの積が可換だから出る）
            assert cw * tn == tn * cw
    print("   通過（n = 0,...,%d）" % nmax)


def check_claim(samples, nmax):
    print("4. 主張そのもの（(t-ŵ) K_n(w) = t^n - ŵ^n）")
    for w in samples:
        for n in range(0, nmax + 1):
            assert (t - const(w)) * k_rec(w, n) == pow_rec(t, n) - pow_rec(const(w), n)
    print("   通過（n = 0,...,%d）" % nmax)


def check_specialization(samples, nmax):
    # Qbar の 2 元についての主張（claim_qbar_power_difference_factorization）と同じ鎖であること。
    # 多項式へ値を入れて（v を代入して）両者が一致することを見る。
    print("5. Qbar の 2 元についての版との一致（t に値を入れる）")
    for w in samples:
        for z in samples:
            for n in range(0, nmax + 1):
                h = QQbar(0)
                for j in range(n):
                    h = h * w + z ** j
                assert k_rec(w, n)(z) == h
                assert (z - w) * h == z ** n - w ** n
    print("   通過（n = 0,...,%d）" % nmax)


def check_factor_use(samples, nmax):
    # 使い道。w を根に持つ多項式から (t - ŵ) をくくり出せること（因数定理の足場）。
    # ここでは各単項式 t^n - ŵ^n が (t - ŵ) で割り切れることだけを見る。
    print("6. 使い道（t^n - ŵ^n が t - ŵ で割り切れる）")
    for w in samples:
        for n in range(0, nmax + 1):
            f = pow_rec(t, n) - pow_rec(const(w), n)
            q, r = f.quo_rem(t - const(w))
            assert r == R.zero()
            assert q == k_rec(w, n)
    print("   通過（n = 0,...,%d）" % nmax)


print("=== claim_qbar_poly_power_difference_factorization ===")

samples = [
    QQbar(0), QQbar(1), QQbar(-1), QQbar(2), QQbar(1) / 3,
    QQbar.zeta(3), QQbar.zeta(5) ** 2, QQbar(2).sqrt(), QQbar(-1).sqrt(),
]

check_embedding(samples)
check_prep(6)
check_base(samples)
check_step(samples, 6)
check_claim(samples, 6)
check_specialization(samples, 4)
check_factor_use(samples, 6)

print("すべて通過")
