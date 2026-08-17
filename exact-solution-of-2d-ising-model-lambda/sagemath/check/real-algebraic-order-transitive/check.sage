# 対象ラベル: claim_real_algebraic_order_transitive
#
# 主張: a <_R b かつ b <_R c ならば a <_R c（<_R は「差が零でない元の平方」）。
# 本文の証明は c - a = u*u + v*v を平方の和が平方であること（claim_real_closed_sum_of_two_squares_is_square）
# で w*w へ書き直し、w != 0 を平方の和が零なら両方零であること（claim_real_closed_sum_of_two_squares_zero）
# から出す。R のモデルは AA。厳密計算のみ。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def lt_R(a, b):
    """def_real_algebraic_strict_order のモデル: b - a が零でない元の平方であること。"""
    d = b - a
    return d != AA(0) and d.is_square()


def main():
    xs = [AA(0), AA(1), AA(-1), AA(2) / 3, AA(2).sqrt(), -AA(5).sqrt() / 7, AA(3)]

    print("1. 推移律そのもの")
    for a in xs:
        for b in xs:
            for c in xs:
                if lt_R(a, b) and lt_R(b, c):
                    assert lt_R(a, c), (a, b, c)
    print("   通過")

    print("2. 鎖 c - a = (c - b) + (b - a) = v*v + u*u = u*u + v*v の各段")
    for a in xs:
        for b in xs:
            for c in xs:
                if not (lt_R(a, b) and lt_R(b, c)):
                    continue
                u = (b - a).sqrt()
                v = (c - b).sqrt()
                assert u != AA(0) and v != AA(0)
                assert u * u == b - a and v * v == c - b
                assert c - a == (c - b) + (b - a)
                assert (c - b) + (b - a) == v * v + u * u
                assert v * v + u * u == u * u + v * v
                # 平方の和が平方であること、および証人が零でないこと
                w = (u * u + v * v).sqrt()
                assert w in AA
                assert w * w == u * u + v * v
                assert w != AA(0)
    print("   通過")

    print("3. 反射的でない・非対称であること（順序の形の確認。主張の前提が空虚でないこと）")
    assert not lt_R(AA(1), AA(1))
    assert lt_R(AA(0), AA(1)) and not lt_R(AA(1), AA(0))
    print("   通過")


main()
