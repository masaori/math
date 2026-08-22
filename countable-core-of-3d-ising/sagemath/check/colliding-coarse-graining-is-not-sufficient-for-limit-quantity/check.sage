# 対象ラベル: claim_colliding_coarse_graining_is_not_sufficient_for_limit_quantity
# 値の衝突を持つ粗視化 pi: QQ_{>0} -> S が箱サイズ極限の一致に十分でないことを、
# 本文と同じ構成（衝突する二つの値をそのまま定数列に取る）で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 検査に使う添字の範囲（有限）。反例の列は定数列なので範囲の取り方に依らない。
L_MAX = 12
L_TOP = L_MAX + 1

def sgn(n):
    n = ZZ(n)
    if n > 0:
        return ZZ(1)
    if n < 0:
        return ZZ(-1)
    return ZZ(0)

# 衝突を持つ粗視化の具体例。いずれも本文の主張が仮定する形（QQ_{>0} 上の写像）である。
# 名前・写像・衝突する二つの値 u, w の組で持つ。
COARSE_GRAININGS = [
    (
        "素数 2 と 3 の素指数だけを見る（有限個の素数へ切り詰める向き）",
        lambda q: (QQ(q).valuation(2), QQ(q).valuation(3)),
        QQ(1), QQ(5),
    ),
    (
        "素指数を高さ 1 で頭打ちにする（値の大きさで切り詰める向き）",
        lambda q: tuple(min(QQ(q).valuation(p), ZZ(1)) for p in primes(2, 60)),
        QQ(2), QQ(4),
    ),
    (
        "素指数の符号だけを残す（大きさを捨てる向き）",
        lambda q: tuple(sgn(QQ(q).valuation(p)) for p in primes(2, 60)),
        QQ(2), QQ(4),
    ),
    (
        "分子と分母の偶奇だけを見る",
        lambda q: (QQ(q).numerator() % 2, QQ(q).denominator() % 2),
        QQ(1), QQ(3),
    ),
    (
        "すべてを一点へ潰す",
        lambda q: 0,
        QQ(1), QQ(2),
    ),
]

for name, pi, u, w in COARSE_GRAININGS:
    # 段 0: この pi が実際に値の衝突を持つこと（u != w かつ pi(u) = pi(w)）。
    assert u in QQ and w in QQ
    assert u > 0 and w > 0
    assert u != w
    assert pi(u) == pi(w)

    # 本文の構成: すべての L で M(L) = 1, A(L) = u, B(L) = w。
    for L in range(1, L_TOP + 1):
        M = ZZ(1)
        A = u
        B = w
        # 段 1: 構成した三つの列が主張の要求する集合に属すること。
        assert A in QQ and B in QQ and A > 0 and B > 0
        assert M in ZZ and M >= 1

        # 段 2: すべての L で粗視化の値が一致すること。
        assert pi(A) == pi(B)

        # 段 3: a(L) = A(L)^{1/M(L)}, b(L) = B(L)^{1/M(L)} が M(L) = 1 なので
        # そのまま有理数 u, w であること（乗根を取らずに済み、QQ の中で確かめられる）。
        a = A
        b = B
        assert a**M == A
        assert b**M == B
        assert a == u
        assert b == w

        # 段 4: 二つの列が定数列であり、それぞれの候補値との差が 0 であること。
        assert a - u == QQ(0)
        assert b - w == QQ(0)

    # 段 5: 二つの候補値は異なるので、幅を |u - w| / 2 に取れば同時に近づけられないこと。
    # 極限の一意性の有限側の芯であり、実数を経由せずに QQ の中で確かめられる。
    gap = abs(u - w)
    assert gap > 0
    half = gap / 2
    assert half in QQ and half > 0
    for L in range(1, L_TOP + 1):
        assert abs(a - u) < half
        assert abs(b - w) < half
    # u を中心とする幅 half の範囲と w を中心とする幅 half の範囲は交わらない。
    assert (u + half) <= (w - half) or (w + half) <= (u - half)

# 段 6: 逆に衝突を持たない粗視化ではこの構成が作れないこと（対偶の側の確認）。
# 恒等写像は QQ_{>0} 上で単射なので、pi(A) = pi(B) を満たす A != B が取れない。
identity = lambda q: QQ(q)
representatives = [QQ(n) / QQ(d) for n in range(1, 8) for d in range(1, 8)]
for x in representatives:
    for y in representatives:
        if identity(x) == identity(y):
            assert x == y

print("PASS: 値の衝突を持つ粗視化は箱サイズ極限の一致に十分でない（有限側の検査）")
