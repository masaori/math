# 対象ラベル: claim_critical_point_positive
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
    chain = [
        xc,
        s - 1,
        (s - 1) * 1,
        (s - 1) * ((s + 1) * (vinv * vinv)),
        ((s - 1) * (s + 1)) * (vinv * vinv),
        (s * s - 1) * (vinv * vinv),
        (AA(2) - 1) * (vinv * vinv),
        AA(1) * (vinv * vinv),
        vinv * vinv,
    ]
    assert all(left == right for left, right in zip(chain, chain[1:]))
    assert vinv != AA(0)
    assert xc == vinv * vinv
    assert xc > 0
    print("臨界点の正値性: 本文の平方表示と全等式を AA で厳密検査して通過", flush=True)


main()
