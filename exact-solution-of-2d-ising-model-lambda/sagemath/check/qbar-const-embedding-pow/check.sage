# 対象ラベル: claim_qbar_constant_embedding_pow
#
# 主張: 代数的数 w と n ∈ ℕ について (w^n)^ = ((w)^)^n である
#       （(a)^ は a を定数多項式として送ったもの。左辺の冪は Qbar の約束、
#       右辺の冪は Qbar[t] の約束で、住む環が違う別々の約束である）。
#
# 人手証明の鎖の各段に対応させて、厳密計算（QQbar 係数の多項式環）で確かめる。
# 浮動小数点は使わない。

R.<t> = PolynomialRing(QQbar)


def const(a):
    # (a)^（def_qbar_constant_embedding。代数的数を定数多項式として送る）。
    return R(a)


def pow_rec(f, k):
    # Qbar[t] の元の冪を定義どおり反復で作る（f^0 = 1、f^{j+1} = f^j f）。
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def qbar_pow_rec(a, k):
    # Qbar の元の冪も同じ形の約束（def_root_of_unity_set）で作る。
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


SAMPLE_QBAR = [
    QQbar(0),
    QQbar(1),
    QQbar(-1),
    QQbar(2),
    QQbar(sqrt(2)),
    QQbar(I),
    QQbar(sqrt(2)) - QQbar(1),
    QQbar(-3) / QQbar(2),
    QQbar(sqrt(-3)),
]


def check_base():
    # 1. 出発点（n = 0）の 3 段の鎖。
    print("1. 出発点（(w^0)^ = (1)^ = 1 = ((w)^)^0）")
    for w in SAMPLE_QBAR:
        # 第 1 の等号（Qbar の約束 w^0 = 1）
        assert qbar_pow_rec(w, 0) == QQbar(1)
        # 第 2 の等号（(1)^ = 1）
        assert const(QQbar(1)) == R.one()
        # 第 3 の等号（Qbar[t] の約束 ((w)^)^0 = 1）
        assert pow_rec(const(w), 0) == R.one()
        # 鎖の始点と終点
        assert const(qbar_pow_rec(w, 0)) == pow_rec(const(w), 0)
    print("   通過（標本 %d 個）" % len(SAMPLE_QBAR))


def check_step(nmax):
    # 2. 一歩（n から n+1 へ）の 4 段の鎖。
    print("2. 一歩（(w^{n+1})^ = (w^n w)^ = (w^n)^ (w)^ = ((w)^)^n (w)^ = ((w)^)^{n+1}）")
    for w in SAMPLE_QBAR:
        for n in range(0, nmax + 1):
            # 第 1 の等号（Qbar の約束 w^{n+1} = w^n w）
            assert qbar_pow_rec(w, n + 1) == qbar_pow_rec(w, n) * w
            # 第 2 の等号（(a b)^ = (a)^ (b)^）
            assert const(qbar_pow_rec(w, n) * w) == const(qbar_pow_rec(w, n)) * const(w)
            # 第 3 の等号（帰納法の仮定）
            assert const(qbar_pow_rec(w, n)) == pow_rec(const(w), n)
            # 第 4 の等号（Qbar[t] の約束 ((w)^)^{n+1} = ((w)^)^n (w)^）
            assert pow_rec(const(w), n + 1) == pow_rec(const(w), n) * const(w)
    print("   通過（標本 %d 個、n = 0,...,%d）" % (len(SAMPLE_QBAR), nmax))


def check_claim(nmax):
    # 3. 主張そのもの。
    print("3. 主張そのもの（(w^n)^ = ((w)^)^n）")
    for w in SAMPLE_QBAR:
        for n in range(0, nmax + 1):
            assert const(qbar_pow_rec(w, n)) == pow_rec(const(w), n)
    print("   通過（標本 %d 個、n = 0,...,%d）" % (len(SAMPLE_QBAR), nmax))


def check_usage(nmax):
    # 4. 使い道: (Σ a_k w^k)^ を Σ (a_k)^ ((w)^)^k へ開けること
    #    （因数定理の鎖で (aev_w(f))^ を項ごとに開く段の裏取り）。
    print("4. 使い道（有限和を定数として送ったものが項ごとに開ける）")
    coeffs = [QQbar(1), QQbar(sqrt(2)), QQbar(I), QQbar(-3) / QQbar(2), QQbar(0)]
    for w in SAMPLE_QBAR:
        total = QQbar(0)
        for k in range(0, nmax + 1):
            total = total + coeffs[k % len(coeffs)] * qbar_pow_rec(w, k)
        opened = R.zero()
        for k in range(0, nmax + 1):
            opened = opened + const(coeffs[k % len(coeffs)]) * pow_rec(const(w), k)
        assert const(total) == opened
    print("   通過（標本 %d 個、k = 0,...,%d）" % (len(SAMPLE_QBAR), nmax))


def main():
    check_base()
    check_step(6)
    check_claim(6)
    check_usage(4)
    print("すべて通過")


main()
