# 対象ラベル: claim_sqrt_two_exists
# 帰属: QQbar と QQbar[t]。近似や根の大小を使わない。
sqrt_two_ring = PolynomialRing(QQbar, 't')
sqrt_two_t = sqrt_two_ring.gen()
sqrt_two_two = QQbar(1) + QQbar(1)
sqrt_two_minus = -sqrt_two_two
sqrt_two_g = sqrt_two_t^2 + sqrt_two_ring(sqrt_two_minus)
sqrt_two_roots = sqrt_two_g.roots(multiplicities=False)
assert len(sqrt_two_roots) == 2

def sqrt_two_coefficient_chain():
    t = sqrt_two_t
    return (sqrt_two_g[2],
        (t^2 + sqrt_two_ring(sqrt_two_minus))[2],
        (t^2)[2] + sqrt_two_ring(sqrt_two_minus)[2],
        QQbar(1) + sqrt_two_ring(sqrt_two_minus)[2],
        QQbar(1) + QQbar(0), QQbar(1))

def sqrt_two_evaluation_chain(s):
    t = sqrt_two_t
    c = sqrt_two_ring(sqrt_two_minus)
    two = sqrt_two_two
    return (s * s, t(s) * t(s), (t * t)(s), (t^1 * t)(s),
        (t^2)(s), (t^2)(s) + QQbar(0),
        (t^2)(s) + (sqrt_two_minus + two),
        (t^2)(s) + (c(s) + two),
        ((t^2)(s) + c(s)) + two,
        (t^2 + c)(s) + two, sqrt_two_g(s) + two,
        QQbar(0) + two, two)
