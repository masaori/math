# 対象ラベル: claim_critical_point_mem_real_closed
#
# 主張: s*s = 2 を満たす s ∈ Qbar は R の元であり、したがって臨界点 x_c = -1 + s も R の元である。
# 本文の証明は s = a + b ω と一意表示して a*a - b*b = 2、2*a*b = 0 を読み、a = 0 の枝を
# 「-2 は R の平方でない」で潰す。R のモデルは AA、ω のモデルは QQbar(I)。厳密計算のみ。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)


def decompose(u):
    a = u.real()
    b = u.imag()
    assert u == QQbar(a) + QQbar(b) * OMEGA
    return a, b


def main():
    roots = [QQbar(2).sqrt(), -QQbar(2).sqrt()]

    print("1. s*s = 2 の根は 2 つあり、どちらも AA の元である（= R の元）")
    for s in roots:
        assert s * s == QQbar(2)
        a, b = decompose(s)
        assert b == AA(0)          # b = 0 の枝
        assert a == s
        assert s in AA
    print("   通過")

    print("2. 一意表示から読める 2 つの等式 a*a - b*b = 2, 2*a*b = 0")
    for s in roots:
        a, b = decompose(s)
        assert a * a - b * b == AA(2)
        assert 2 * a * b == AA(0)
    print("   通過")

    print("3. a = 0 の枝は起きない（-2 は AA の平方でない）")
    assert not AA(-2).is_square()
    # 仮に a = 0 とすると -(b*b) = 2、すなわち b*b = -2 になるが、そのような b は AA に無い
    bs = [AA(0), AA(1), AA(-1), AA(2).sqrt(), AA(3).sqrt(), AA(2) / 5]
    assert all(b * b != AA(-2) for b in bs)
    print("   通過")

    print("4. 臨界点 x_c = -1 + s も AA の元であり、自己双対方程式の根である")
    for s in roots:
        xc = -1 + s
        assert xc in AA
        assert xc * xc + 2 * xc - 1 == QQbar(0)
    print("   通過")

    print("5. R の外の平方根（-2 の平方根）は自己双対方程式の根を R の外へ出す")
    w = QQbar(-2).sqrt()
    assert w * w == QQbar(-2)
    assert w not in AA
    print("   通過")


main()
