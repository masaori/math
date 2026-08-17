# 対象ラベル: claim_positive_rational_mesh_width
#
# 主張: delta > 0 なら、N >= 1 かつ (1/N)^2 < delta を満たす自然数 N が存在する。
# 本文どおり epsilon := min(delta, 1) とし、1/epsilon より大きい自然数 N を選ぶ。
# QQ の厳密計算だけを使い、浮動小数点は使わない。


def main():
    deltas = [QQ(1) / 10**6, QQ(1) / 17, QQ(1) / 2, QQ(1), QQ(7) / 3, QQ(19)]

    print("正の有理数ごとに、平方がそれより小さい正の有理網幅 1/N を構成する")
    for delta in deltas:
        epsilon = min(delta, QQ(1))
        N = floor(1 / epsilon) + 1
        h = QQ(1) / N
        assert delta > 0
        assert epsilon > 0
        assert N >= 1
        assert h > 0
        assert h < epsilon
        assert h < 1
        assert h * h < h
        assert h * h < delta
    print("OK: %d 個の正の有理数ですべて通過" % len(deltas))


main()
