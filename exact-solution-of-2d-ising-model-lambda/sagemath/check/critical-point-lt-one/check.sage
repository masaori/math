# 対象ラベル: claim_critical_point_lt_one
#
# 固定した s = sqrt(2) と R = AA について、本文の各等式を厳密に検査する。


def main():
    s = AA(2).sqrt()
    w = AA(2).nth_root(4)
    v = (s + 1).sqrt()

    assert s * s == AA(2)
    assert w != AA(0)
    assert s == w * w
    assert s + 1 == w * w + AA(1) * AA(1)
    assert w * w + AA(1) * AA(1) == v * v
    assert v != AA(0)

    xc = s - 1
    vinv = 1 / v
    u = w * vinv
    assert vinv != AA(0)
    assert u != AA(0)

    chain = [
        1 - xc,
        1 - (-1 + s),
        2 - s,
        (2 - s) * 1,
        (2 - s) * ((s + 1) * (vinv * vinv)),
        ((2 - s) * (s + 1)) * (vinv * vinv),
        (2 * s + 2 - s * s - s) * (vinv * vinv),
        (2 * s + 2 - 2 - s) * (vinv * vinv),
        s * (vinv * vinv),
        (w * w) * (vinv * vinv),
        (w * vinv) * (w * vinv),
        u * u,
    ]
    assert all(left == right for left, right in zip(chain, chain[1:]))
    assert 1 - xc == u * u
    assert xc < 1
    print("臨界点の上界: 本文の平方表示と全等式を AA で厳密検査して通過", flush=True)


main()
