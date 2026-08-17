# 対象ラベル: claim_square_of_sum_le_twice_sum_of_squares
#
# 主張: u, v ∈ R について (u+v)·(u+v) ≤_R 2·(u·u) + 2·(v·v)。
# ≤_R は「差が零元でない元の平方（<_R）、または等しい」。
#
# 本文の証明は、差 D := (2u²+2v²) − (u+v)² を三段の式変形で (u−v)·(u−v) へ変形し、
# u = v の場合は D = 0（等号の枝）、u ≠ v の場合は w := u−v ≠ 0 が平方の証人（狭義順序の枝）
# とする。R のモデルとして AA を取り、各段を厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def main():
    xs = [AA(0), AA(1), AA(-1), AA(2) / 3, AA(-3) / 5, AA(2).sqrt(), -AA(5).sqrt() / 7]

    print("1. 式変形の各段: D = (2u²+2v²) − (u+v)² が展開・同類項・因数分解で (u−v)² になる")
    for u in xs:
        for v in xs:
            D = (2 * (u * u) + 2 * (v * v)) - (u + v) * (u + v)
            # 展開: (u+v)² = u² + 2uv + v²
            assert (u + v) * (u + v) == u * u + 2 * (u * v) + v * v
            # 同類項をまとめる: D = u² − 2uv + v²
            assert D == u * u - 2 * (u * v) + v * v
            # 因数分解: D = (u−v)²
            assert D == (u - v) * (u - v)
    print("   通過")

    print("2. u = v の場合: 差が零元で両辺が等しい（等号の枝）")
    for u in xs:
        v = u
        D = (2 * (u * u) + 2 * (v * v)) - (u + v) * (u + v)
        assert u - v == AA(0)
        assert D == AA(0)
        assert (u + v) * (u + v) == 2 * (u * u) + 2 * (v * v)
    print("   通過")

    print("3. u ≠ v の場合: w := u−v が零でない証人で、狭義順序の枝が成り立つ")
    count = 0
    for u in xs:
        for v in xs:
            if u == v:
                continue
            w = u - v
            D = (2 * (u * u) + 2 * (v * v)) - (u + v) * (u + v)
            assert w != AA(0)
            assert D == w * w
            # <_R のモデル: 差が零でない元の平方（AA では正であることと同値）
            assert D > AA(0)
            count += 1
    print("   通過（%d 組）" % count)

    print("OK: すべて通過")


main()
