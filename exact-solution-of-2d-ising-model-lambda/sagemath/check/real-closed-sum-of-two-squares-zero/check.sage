# 対象ラベル: claim_real_closed_sum_of_two_squares_zero
#
# 主張: 実閉部分体 R の元 x, y が x*x + y*y = 0 を満たすならば x = 0 かつ y = 0 である。
# 本文の証明は (x + y ω)(x - y ω) = x*x + y*y（ω*ω = -1）と、Qbar が体であること、
# および一意表示（第 4 条件）だけを使う。R のモデルとして実代数的数体 AA、ω のモデルとして
# QQbar(I) を取り、鎖の各段と結論を厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)


def main():
    xs = [AA(0), AA(1), AA(-1), AA(2) / 3, AA(2).sqrt(), -AA(5).sqrt() / 7]

    print("1. ω*ω = -1（第 3 条件のモデル）")
    assert OMEGA * OMEGA == QQbar(-1)
    print("   通過")

    print("2. 鎖 (x + yω)(x - yω) = x*x - y*y*(ω*ω) = x*x + y*y の各段")
    for x in xs:
        for y in xs:
            X = QQbar(x)
            Y = QQbar(y)
            lhs = (X + Y * OMEGA) * (X - Y * OMEGA)
            assert lhs == X * X - (Y * OMEGA) * (Y * OMEGA)
            assert X * X - (Y * OMEGA) * (Y * OMEGA) == X * X - Y * Y * (OMEGA * OMEGA)
            assert X * X - Y * Y * (OMEGA * OMEGA) == X * X - Y * Y * QQbar(-1)
            assert X * X - Y * Y * QQbar(-1) == X * X + Y * Y
    print("   通過")

    print("3. x*x + y*y = 0 を満たすのは x = y = 0 だけである（R = AA のモデル）")
    found_zero_case = False
    for x in xs:
        for y in xs:
            if x * x + y * y == AA(0):
                assert x == AA(0) and y == AA(0)
                found_zero_case = True
            else:
                # 零でない場合は、積が零でないので零因子の議論が空虚でないことも見る
                assert (QQbar(x) + QQbar(y) * OMEGA) * (QQbar(x) - QQbar(y) * OMEGA) != QQbar(0)
    assert found_zero_case
    print("   通過")

    print("4. 一意表示の使い方: 0 = a + b ω を満たす (a, b) ∈ AA × AA は (0, 0) だけ")
    for a in xs:
        for b in xs:
            if QQbar(a) + QQbar(b) * OMEGA == QQbar(0):
                assert a == AA(0) and b == AA(0)
    # 部分体なので -y も R の元であること（第 2 の場合分けで使う）
    for y in xs:
        assert -y in AA
    print("   通過")

    print("5. R の外（虚数単位を含む元）では平方の和が零になりうる（仮定が本質であることの確認）")
    z = OMEGA          # z*z = -1
    assert z * z + QQbar(1) * QQbar(1) == QQbar(0)
    assert z not in AA
    print("   通過")


main()
