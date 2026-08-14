# 対象ラベル: def_distance_squared_to_rational, claim_distance_squared_zero_iff_equal
# QQ・AA・QQbar の厳密計算だけを使う。浮動小数点を使わない。
# モデル: R = AA（実代数的数体）、ω = QQbar(I)。有限標本での検査であり、
# 普遍量化された主張そのものの証明ではない（主張の証明は本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

OMEGA = QQbar(I)

# ξ のサンプル（成分 a, b が次数 2 以下の実代数的数に収まるもの。
# b = 0 の実の元と、b ≠ 0 の虚部を持つ元の両方を含める）
SQRT2 = AA(2).sqrt()
XI_SAMPLES = [
    QQbar(0), QQbar(1), QQbar(QQ(1)/2), QQbar(QQ(-3)/7), QQbar(SQRT2),
    QQbar(SQRT2 - 1),
    OMEGA, QQbar(1) + OMEGA, QQbar(QQ(1)/2) - QQbar(QQ(3)/7) * OMEGA,
    QQbar(SQRT2) * OMEGA, QQbar(SQRT2 - 1) + QQbar(QQ(1)/2) * OMEGA,
]

# q のサンプル（零・正・負、整数・非整数）
Q_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(1)/2, QQ(-3)/7, QQ(22)/7]


def components(xi):
    # 第 4 条件のモデル: ξ = a + b·ω を満たす組 (a, b) ∈ AA × AA。
    # Sage の real()/imag() は QQbar の元から AA の元を返す（厳密）。
    a = xi.real()
    b = xi.imag()
    assert a in AA and b in AA
    # 表示になっていること
    assert xi == QQbar(a) + QQbar(b) * OMEGA
    return a, b


def check_representation_unique():
    # 第 4 条件の一意性のモデル検査: サンプル対で a1+b1·ω = a2+b2·ω ならば
    # (a1,b1) = (a2,b2) であること。
    comps = [components(xi) for xi in XI_SAMPLES]
    pairs = 0
    for i, (a1, b1) in enumerate(comps):
        for j, (a2, b2) in enumerate(comps):
            lhs = QQbar(a1) + QQbar(b1) * OMEGA
            rhs = QQbar(a2) + QQbar(b2) * OMEGA
            if lhs == rhs:
                assert a1 == a2 and b1 == b2
            pairs += 1
    print("一意表示: 対 %d 組で通過" % pairs, flush=True)


def check_dsq_in_R():
    # def_distance_squared_to_rational: dsq(ξ,q) = (a-q)·(a-q) + b·b ∈ R。
    count = 0
    for xi in XI_SAMPLES:
        a, b = components(xi)
        for q in Q_SAMPLES:
            # q ∈ R（claim_rationals_are_real_algebraic のモデル）
            assert AA(q) in AA
            dsq = (a - AA(q)) * (a - AA(q)) + b * b
            assert dsq in AA
            count += 1
    print("dsq の R への所属: 組 %d 組で通過" % count, flush=True)


def check_zero_iff_equal():
    # claim_distance_squared_zero_iff_equal: dsq(ξ,q) = 0 ⟺ ξ = q。
    count = 0
    for xi in XI_SAMPLES:
        a, b = components(xi)
        for q in Q_SAMPLES:
            dsq = (a - AA(q)) * (a - AA(q)) + b * b
            assert (dsq == 0) == (xi == QQbar(q))
            # 第 1 の向きの段の検査: ξ = q なら a = q かつ b = 0
            if xi == QQbar(q):
                assert a == AA(q) and b == 0
            # 第 2 の向きの中の計算の検査: b ≠ 0 なら
            # w := (a-q)·b^{-1} について w·w = -((a-q)·(a-q))·(b·b)^{-1}。
            # dsq = 0 と b ≠ 0 が両立しないこと（w·w = -1 の矛盾の反映）は
            # 上の同値の検査に含まれる。ここでは移項の等式だけを確かめる。
            if b != 0:
                w = (a - AA(q)) * b ** (-1)
                assert w in AA
                assert w * w == ((a - AA(q)) * (a - AA(q))) * (b * b) ** (-1)
            count += 1
    print("零性と一致の同値: 組 %d 組で通過" % count, flush=True)


check_representation_unique()
check_dsq_in_R()
check_zero_iff_equal()
print("零点と有理点の距離の二乗: 有限標本検査がすべて通過"
      "（普遍量化された主張の証明は本文が担う。Lean は未着手）", flush=True)
