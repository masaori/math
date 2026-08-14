# 対象ラベル: claim_rationals_are_real_algebraic, claim_neg_one_not_square,
#              def_real_algebraic_strict_order, def_real_algebraic_nonstrict_order,
#              claim_real_algebraic_order_trichotomy
# QQ・AA・QQbar の厳密計算だけを使う。浮動小数点を使わない。
# モデル: R = AA（実代数的数体）。有限標本での検査であり、普遍量化された主張
# そのものの証明ではない（主張の証明は本文の人手証明と Lean が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# 有理数のサンプル（零・正・負、整数・非整数）
Q_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(7), QQ(-4),
             QQ(1)/2, QQ(-3)/7, QQ(22)/7]

# R = AA の元のサンプル（有理数と次数 2 の無理数を含む）
R_SAMPLES = [AA(0), AA(1), AA(-1), AA(QQ(1)/2), AA(QQ(-3)/7),
             AA(2).sqrt(), AA(2).sqrt() - 1, -AA(3).sqrt()]


def check_rationals_in_R():
    # claim_rationals_are_real_algebraic: 有理数は R の元である。
    # 本文の証明の段（0・1 の所属、加法・加法逆元・乗法逆元・乗法での閉性）を
    # 各サンプルの分子・分母表示 q = k · n^{-1} で再構成して検査する。
    assert AA(0) in AA and AA(1) in AA
    for q in Q_SAMPLES:
        k = ZZ(q.numerator())
        n = ZZ(q.denominator())
        assert n >= 1
        # 自然数の帰納の段: |k| は 1 の加算の繰り返しで R に入る
        acc = AA(0)
        for _ in range(abs(k)):
            acc = acc + AA(1)
        k_in_R = acc if k >= 0 else -acc
        assert k_in_R in AA and k_in_R == AA(k)
        # 乗法逆元の段
        n_inv = AA(n) ** (-1)
        assert n_inv in AA
        # 乗法の段: q = k · n^{-1}
        q_in_R = k_in_R * n_inv
        assert q_in_R in AA and q_in_R == AA(q)
        # QQbar 側の元としても同じ元である
        assert QQbar(q_in_R) == QQbar(q)
    print("有理数の所属: サンプル %d 点で通過" % len(Q_SAMPLES), flush=True)


def check_neg_one_not_square():
    # claim_neg_one_not_square: 零元でない w ∈ R について w·w ≠ -1。
    # サンプルでの直接検査と、AA(-1) が AA の中に平方根を持たないこと
    # （x^2 + 1 の AA での根が空であること）で検査する。
    for w in R_SAMPLES:
        if w != 0:
            assert w * w != AA(-1)
    x = polygen(AA, 'x')
    roots = (x**2 + 1).roots(ring=AA, multiplicities=False)
    assert roots == []
    print("-1 は非零元の平方でない: サンプル %d 点と根の非存在で通過"
          % len([w for w in R_SAMPLES if w != 0]), flush=True)


def check_order_trichotomy():
    # def_real_algebraic_strict_order / claim_real_algebraic_order_trichotomy:
    # a <_R b :⟺ ∃w≠0, b - a = w·w。
    # 各対 (a,b) について「a <_R b」「a = b」「b <_R a」のちょうど 1 つが成り立ち、
    # それが AA の組み込みの厳密順序と一致することを検査する。
    pairs = 0
    for a in R_SAMPLES:
        for b in R_SAMPLES:
            z = b - a
            assert z in AA
            cases = []
            if z == 0:
                cases.append("equal")
            if z > 0:
                w = z.sqrt()
                assert w in AA and w != 0 and w * w == z
                cases.append("a_lt_b")
            if z < 0:
                w = (-z).sqrt()
                assert w in AA and w != 0 and w * w == -z
                cases.append("b_lt_a")
            assert len(cases) == 1
            # 定義の <_R が AA の厳密順序と一致すること（このモデルでの整合性）
            assert ("a_lt_b" in cases) == (a < b)
            assert ("equal" in cases) == (a == b)
            assert ("b_lt_a" in cases) == (b < a)
            pairs += 1
    print("順序の三分法: 対 %d 組で通過" % pairs, flush=True)


check_rationals_in_R()
check_neg_one_not_square()
check_order_trichotomy()
print("実代数的数の順序: 有限標本検査がすべて通過"
      "（普遍量化された主張の証明は本文と Lean が担う）", flush=True)
