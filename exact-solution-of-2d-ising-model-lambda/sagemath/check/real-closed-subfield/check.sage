# 対象ラベル: def_real_closed_subfield
# QQ・AA・QQbar の厳密計算だけを使う。浮動小数点を使わない。
# モデル: R = AA（実代数的数体）、ω = QQbar(I)。定義の 4 条件がこのモデルで
# 各条件に対応する計算を有限標本で検査する。普遍量化された 4 条件そのものの証明ではない。
#
# 範囲の注記（黙って狭めない）: QQbar の等号判定は exactify（PARI の nfinit）を
# 経由し、次数の高い代数的数どうしでは既定 1GB のスタックを超える・または
# 現実的な時間で終わらない（実測 2026-08-14: L=2,3 の Fisher 零点の実部・虚部での
# 再構成 ξ = a + b·ω が 10 分でも終わらなかった。Z_1 = 2 は定数で零点を持たない）。
# そのため第 4 条件の存在の検査は次数の低いサンプルに限り、有限格子の
# Fisher 零点そのもの（次数 8 以上）は検査から外す。検査の内容自体は緩めない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

omega = QQbar(I)

# R の元のサンプル（零元・正・負、有理数・無理数を含む。次数は 2 以下）
R_SAMPLES = [AA(0), AA(1), AA(-1), AA(QQ(1)/2), AA(QQ(-3)/7),
             AA(2).sqrt(), AA(2).sqrt() - 1]


def check_condition_subfield():
    # 第 1 条件: R = AA は QQbar の部分体（和・積・逆元で閉じ、演算が QQbar と一致する）。
    for x in R_SAMPLES:
        for y in R_SAMPLES:
            s = x + y
            p = x * y
            assert s in AA and p in AA
            assert QQbar(s) == QQbar(x) + QQbar(y)
            assert QQbar(p) == QQbar(x) * QQbar(y)
        if x != 0:
            inv = x ** (-1)
            assert inv in AA
            assert QQbar(inv) * QQbar(x) == QQbar(1)
    print("第 1 条件（部分体）: サンプル %d 点で通過" % len(R_SAMPLES), flush=True)


def check_condition_square_trichotomy():
    # 第 2 条件: 各 z ∈ R について「z = 0」「z = w^2 (w ≠ 0)」「-z = w^2 (w ≠ 0)」の
    # ちょうど 1 つが成り立つ。AA の厳密比較と厳密平方根で確かめる。
    for z in R_SAMPLES + [-AA(3).sqrt()]:
        cases = []
        if z == 0:
            cases.append("zero")
        if z > 0:
            w = z.sqrt()
            assert w in AA and w != 0 and w * w == z
            cases.append("square")
        if z < 0:
            w = (-z).sqrt()
            assert w in AA and w != 0 and w * w == -z
            cases.append("negative_square")
        assert len(cases) == 1
    print("第 2 条件（平方の三分法）: サンプル %d 点で通過"
          % (len(R_SAMPLES) + 1), flush=True)


def check_condition_imaginary_unit():
    # 第 3 条件: ω·ω = -1。あわせて ω^4 = 1（ω ∈ μ_4）も確かめる。
    assert omega * omega == QQbar(-1)
    assert omega ** 4 == QQbar(1)
    print("第 3 条件（虚数単位）: 通過（ω^2 = -1, ω^4 = 1）", flush=True)


def check_condition_unique_representation():
    # 第 4 条件（存在）: ξ = a + b·ω (a,b ∈ R) の分解を、L=1 の Fisher 零点
    # （Z_1 の QQbar における全根）と低次のサンプルで構成して検査する。
    # L=2,3 の根を外した理由は冒頭の範囲の注記のとおり（次数が高く exactify が
    # 資源上限で終わらない。検査対象の縮小であり、検査内容の緩和ではない）。
    x_ring = polygen(QQ, 'x')
    low_degree_samples = [
        omega,
        QQbar(2).sqrt() * omega,
        QQbar(1) + omega,
        QQbar(2).sqrt() - 1,
        (x_ring ** 2 + x_ring + 1).roots(QQbar, multiplicities=False)[0],
    ]
    total = 0
    for xi in low_degree_samples:
        a = xi.real()
        b = xi.imag()
        assert a in AA and b in AA
        assert QQbar(a) + QQbar(b) * omega == xi
        total += 1
    print("第 4 条件（存在）: 低次サンプル %d 個で分解 ξ = a + b·ω を検査" % total,
          flush=True)

    # 一意性: 相異なる組 (a,b) ≠ (a',b') は相異なる値 a + b·ω を与える
    # （相異なる代数的数の非等号は区間分離で速く判定できる）。
    pair_samples = [AA(0), AA(1), AA(QQ(1)/2), AA(2).sqrt()]
    values = []
    for a in pair_samples:
        for b in pair_samples:
            v = QQbar(a) + QQbar(b) * omega
            for v2 in values:
                assert v != v2
            values.append(v)
    print("第 4 条件（一意性）: 相異なる組 %d 個が相異なる値を与えることを検査"
          % len(values), flush=True)


def check_condition_sqrt_two_square():
    # 第 5 条件: 固定した s（s·s = 2）がモデル R = AA の平方であること。
    # 証人 w = 2^(1/4) ∈ AA を厳密に構成し、w ≠ 0 と s = w·w を検査する。
    s = AA(2).sqrt()
    assert s * s == AA(2)
    w = AA(2).nth_root(4)
    assert w in AA
    assert w != AA(0)
    assert w * w == s
    print("第 5 条件（平方根との整合）: s = w·w（w = 2^(1/4) ≠ 0）を厳密検査",
          flush=True)


check_condition_subfield()
check_condition_square_trichotomy()
check_condition_imaginary_unit()
check_condition_unique_representation()
check_condition_sqrt_two_square()
print("def_real_closed_subfield: 5 条件に対応する有限標本検査がすべて通過", flush=True)
