# 対象ラベル: claim_qbar_factor_theorem

R.<t> = PolynomialRing(QQbar)


def qbar_pow(a, k):
    out = QQbar(1)
    for _ in range(k):
        out *= a
    return out


def aev(w, f):
    return sum((f[k] * qbar_pow(w, k) for k in f.dict()), QQbar(0))


def K(w, k):
    out = R.zero()
    for j in range(k):
        out = out * R(w) + t^j
    return out


ROOTED = [
    (t - QQbar(1), QQbar(1)),
    ((t - QQbar(sqrt(2))) * (t + QQbar(1)), QQbar(sqrt(2))),
    ((t - QQbar(I)) * (t^2 + QQbar(2)), QQbar(I)),
    (R.zero(), QQbar(sqrt(-3))),
]


def main():
    print("1. 人手証明の鎖")
    for f, w in ROOTED:
        n = max(0, f.degree())
        assert aev(w, f) == 0
        g = sum((R(f[k]) * K(w, k) for k in range(n + 1)), R.zero())
        line1 = f - R(aev(w, f))
        line2 = sum((R(f[k]) * t^k for k in range(n + 1)), R.zero()) \
            - R(sum((f[k] * qbar_pow(w, k) for k in range(n + 1)), QQbar(0)))
        line3 = sum((R(f[k]) * t^k - R(f[k] * qbar_pow(w, k))
                     for k in range(n + 1)), R.zero())
        line4 = sum((R(f[k]) * (t^k - R(w)^k) for k in range(n + 1)), R.zero())
        line5 = sum((R(f[k]) * (t - R(w)) * K(w, k)
                     for k in range(n + 1)), R.zero())
        line6 = (t - R(w)) * g
        assert f == line1 == line2 == line3 == line4 == line5 == line6
    print("   通過（根を持つ多項式 %d 個）" % len(ROOTED))
    print("2. 因数定理の等式")
    for f, w in ROOTED:
        n = max(0, f.degree())
        g = sum((R(f[k]) * K(w, k) for k in range(n + 1)), R.zero())
        assert f == (t - R(w)) * g
    print("   通過")
    print("すべて通過")


main()
