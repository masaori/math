# 対象ラベル: claim_critical_point_rational_approximation
#
# R のモデルを AA に取り、本文の挟み込み・平方差・二平方和の各段を厳密に検査する。
# 浮動小数点は使わない。


def main():
    xc = AA(2).sqrt() - 1
    samples = [QQ(1) / 2, QQ(1) / 10, QQ(1) / 100, QQ(3) / 1000]
    for delta in samples:
        N = 1
        while QQ(1) / (N * N) >= delta:
            N += 1
        h = QQ(1) / N
        k = 0
        while AA(QQ(k + 1) / N) <= xc:
            k += 1
        p = QQ(k) / N
        q = QQ(k + 1) / N
        assert 0 < q
        assert AA(p) <= xc < AA(q)
        assert q - p == h

        # 平方証人そのものを重ねて構成すると AA の根体が不要に膨らむため、
        # 各証人の平方を厳密な AA 元として追う。正値性と実閉性が平方証人の存在を与える。
        a2 = AA(q) - xc
        d2 = xc - AA(p)
        e2 = AA(h)
        v2 = e2 + a2
        assert a2 > 0 and d2 >= 0 and e2 > 0 and v2 > 0
        assert AA(h) - a2 == d2
        assert AA(h) + a2 == v2
        assert AA(h) * AA(h) - (AA(q) - xc) * (AA(q) - xc) == d2 * v2

        r2 = AA(delta) - AA(h) * AA(h)
        z2 = r2 + d2 * v2
        assert r2 > 0 and z2 > 0
        assert AA(delta) - (xc - AA(q)) * (xc - AA(q)) == z2
        assert (xc - AA(q)) * (xc - AA(q)) < AA(delta)

    print("挟み込み区間から取る臨界点の有理近似: 各式変形を AA/QQ で厳密検査して通過", flush=True)


main()
