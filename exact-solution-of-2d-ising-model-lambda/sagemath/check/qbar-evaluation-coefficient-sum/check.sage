# 対象ラベル: claim_qbar_evaluation_coefficient_sum
#
# 主張: f in QQbar[t] と n in NN（k > n で ac_k(f) = 0）と w in QQbar について
#   aev_w(f) = sum_{k=0}^{n} ac_k(f) * w^k
# である。人手証明の 5 段の鎖を PolynomialRing(QQbar) の厳密計算で確かめる。

R.<t> = PolynomialRing(QQbar)


def poly_pow_rec(f, k):
    acc = R.one()
    for _ in range(k):
        acc = acc * f
    return acc


def qbar_pow_rec(a, k):
    acc = QQbar(1)
    for _ in range(k):
        acc = acc * a
    return acc


def aev(w, f):
    # def_qbar_poly_evaluation: 係数が零でない項だけの有限和
    total = QQbar(0)
    for k in f.dict():
        total = total + f[k] * qbar_pow_rec(w, k)
    return total


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

SAMPLE_POLY = [
    R.zero(),
    R.one(),
    t,
    t^2 - 1,
    QQbar(sqrt(2)) * t^3 + QQbar(I) * t - QQbar(1),
    (t - QQbar(1)) * (t - QQbar(sqrt(2))),
    QQbar(-3) / QQbar(2) * t^4 + t^2,
    t^5 + QQbar(sqrt(-3)) * t^3 + QQbar(2),
]


def check_chain():
    print("1. 鎖の各段")
    count = 0
    for f in SAMPLE_POLY:
        n = f.degree() if f.degree() >= 0 else 0
        # 仮定: k > n で ac_k(f) = 0
        for k in range(n + 1, n + 4):
            assert f[k] == QQbar(0)
        for w in SAMPLE_QBAR:
            # 第 1 段: f = sum_{k=0}^{n} ac_k(f)^ * t^k（単項式の有限和への分解）
            g = sum((R(f[k]) * poly_pow_rec(t, k) for k in range(n + 1)), R.zero())
            assert f == g
            # 第 2 段: aev_w は和を保つ（項別に開く）
            lhs2 = aev(w, g)
            rhs2 = sum((aev(w, R(f[k]) * poly_pow_rec(t, k)) for k in range(n + 1)), QQbar(0))
            assert lhs2 == rhs2
            # 第 3 段: aev_w は積を保つ（各項へ）
            rhs3 = sum(
                (aev(w, R(f[k])) * aev(w, poly_pow_rec(t, k)) for k in range(n + 1)),
                QQbar(0),
            )
            assert rhs2 == rhs3
            # 第 4 段: aev_w(a^) = a
            rhs4 = sum(
                (f[k] * aev(w, poly_pow_rec(t, k)) for k in range(n + 1)), QQbar(0)
            )
            assert rhs3 == rhs4
            # 第 5 段: aev_w(t^k) = w^k
            rhs5 = sum((f[k] * qbar_pow_rec(w, k) for k in range(n + 1)), QQbar(0))
            assert rhs4 == rhs5
            count += 1
    print("   通過（多項式 %d 個 × 標本 %d 個）" % (len(SAMPLE_POLY), len(SAMPLE_QBAR)))


def check_claim():
    print("2. 主張そのもの（aev_w(f) = sum_{k=0}^{n} ac_k(f) w^k。n を最小より大きく取っても同じ）")
    for f in SAMPLE_POLY:
        deg = f.degree() if f.degree() >= 0 else 0
        for extra in range(0, 3):
            n = deg + extra
            for w in SAMPLE_QBAR:
                rhs = sum((f[k] * qbar_pow_rec(w, k) for k in range(n + 1)), QQbar(0))
                assert aev(w, f) == rhs
    print("   通過（多項式 %d 個 × 標本 %d 個 × n は最小・+1・+2）" % (len(SAMPLE_POLY), len(SAMPLE_QBAR)))


def main():
    check_chain()
    check_claim()
    print("すべて通過")


main()
