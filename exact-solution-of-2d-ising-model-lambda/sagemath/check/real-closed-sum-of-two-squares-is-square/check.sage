# 対象ラベル: claim_real_closed_sum_of_two_squares_is_square, claim_two_is_square_in_real_closed
#
# 主張 1: x, y ∈ R について、ある c ∈ R が存在して x*x + y*y = c*c（平方の和は平方）。
# 主張 2: 2 は R の零でない元の平方であり、-2 は R の平方でない。
#
# 本文の証明は、Qbar の代数閉性で u*u = x + y ω を満たす u を取り、u = a + b ω と一意表示して
#   x = a*a - b*b,  y = 2*a*b,  c := a*a + b*b
# と読み、恒等式 (a²-b²)² + (2ab)² = (a²+b²)² を使う。R のモデルとして AA、ω のモデルとして
# QQbar(I) を取り、各段を厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)


def decompose(u):
    """def_real_closed_subfield の第 4 条件: u = a + b ω を満たす (a, b) ∈ AA × AA。"""
    a = u.real()
    b = u.imag()
    assert u == QQbar(a) + QQbar(b) * OMEGA
    return a, b


def main():
    xs = [AA(0), AA(1), AA(-1), AA(2) / 3, AA(2).sqrt(), -AA(5).sqrt() / 7]

    print("1. 恒等式 (a²-b²)² + (2ab)² = (a²+b²)²（必要十分版の中身）")
    for a in xs:
        for b in xs:
            assert (a * a - b * b) ** 2 + (2 * a * b) ** 2 == (a * a + b * b) ** 2
    print("   通過")

    print("2. u*u = x + y ω を満たす u の一意表示から x = a²-b², y = 2ab")
    for x in xs:
        for y in xs:
            z = QQbar(x) + QQbar(y) * OMEGA
            u = z.sqrt()                      # Qbar の代数閉性のモデル
            assert u * u == z
            a, b = decompose(u)
            assert a * a - b * b == x
            assert 2 * a * b == y
            c = a * a + b * b
            assert c in AA
            assert x * x + y * y == c * c     # 主張 1
    print("   通過")

    print("3. 主張 2: 2 は AA の零でない元の平方、-2 は AA の平方でない")
    z = QQbar(1) + QQbar(1) * OMEGA
    u = z.sqrt()
    a, b = decompose(u)
    s = a * a + b * b
    assert s != AA(0)
    assert s * s == AA(2)
    assert AA(2).is_square()
    assert not AA(-2).is_square()
    # 三分法のうち成り立つのは第 2 の場合だけであること
    assert AA(2) != AA(0)
    assert any(w * w == AA(2) for w in [s, -s])
    assert not any(w * w == AA(-2) for w in [s, -s, AA(0), AA(1)])
    print("   通過")

    print("4. R の外では -2 も平方になる（仮定 w ∈ R が本質であることの確認）")
    wq = QQbar(-2).sqrt()
    assert wq * wq == QQbar(-2)
    assert wq not in AA
    print("   通過")


main()
