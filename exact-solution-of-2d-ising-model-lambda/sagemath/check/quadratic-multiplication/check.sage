# 対象ラベル: claim_quadratic_multiplication_mem, claim_quadratic_multiplication_representation
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# claim_quadratic_multiplication_mem: s·s=2 を満たす s ∈ QQbar、ξ,η ∈ Q_s、
#   (a,b) := rep_s(ξ)、(a',b') := rep_s(η) について、ξ·η ∈ Q_s
#   （証人 (a·a'+2·(b·b'), a·b'+b·a')）。
# claim_quadratic_multiplication_representation: rep_s(ξ·η) = (a·a'+2·(b·b'), a·b'+b·a')。
# 検査すること:
#   mul-compat: QQ の和・積と QQbar の和・積の一致（準備の段の裏取り）。
#   mul-aux:    三つの補助等式
#               a·(b'·s) = (a·b')·s（1 段）
#               (b·s)·a' = b·(s·a') = b·(a'·s) = (b·a')·s（3 段）
#               (b·s)·(b'·s) = ((b·s)·b')·s = (b·(s·b'))·s = (b·(b'·s))·s
#               = ((b·b')·s)·s = (b·b')·(s·s) = (b·b')·2 = 2·(b·b')（7 段）
#               を一段ずつ QQbar の厳密等号で確かめる。
#   mul-chain:  標本の全 ((a,b),(a',b')) で本文の鎖
#               (a+b·s)·(a'+b'·s)
#               = a·(a'+b'·s)+(b·s)·(a'+b'·s)
#               = (a·a'+a·(b'·s))+(b·s)·(a'+b'·s)
#               = (a·a'+a·(b'·s))+((b·s)·a'+(b·s)·(b'·s))
#               = (a·a'+(a·b')·s)+((b·s)·a'+(b·s)·(b'·s))
#               = (a·a'+(a·b')·s)+((b·a')·s+(b·s)·(b'·s))
#               = (a·a'+(a·b')·s)+((b·a')·s+2·(b·b'))
#               = (a·a'+(a·b')·s)+(2·(b·b')+(b·a')·s)
#               = a·a'+((a·b')·s+(2·(b·b')+(b·a')·s))
#               = a·a'+(((a·b')·s+2·(b·b'))+(b·a')·s)
#               = a·a'+((2·(b·b')+(a·b')·s)+(b·a')·s)
#               = a·a'+(2·(b·b')+((a·b')·s+(b·a')·s))
#               = (a·a'+2·(b·b'))+((a·b')·s+(b·a')·s)
#               = (a·a'+2·(b·b'))+(a·b'+b·a')·s
#               を一段ずつ QQbar の厳密等号で確かめる。
#   mul-rep:    終点の表示 (a·a'+2·(b·b'), a·b'+b·a') が ξ·η の表示であること
#               （表示の一意性 claim_quadratic_representation_unique。別の検証で裏取り済み。
#               のもとで、そのまま rep_s(ξ·η) を与える）。

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

# 四つ組を走らせるので標本は小さく取る（分子 -2..2、分母 1..2 の 7 値）。
BOUND = 2
DEN = 2
samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                     for q in range(1, DEN + 1)))
assert len(samples) == 7, f"標本数が想定と違う: {len(samples)}"

checked_mul_compat = 0
checked_mul_chain = 0

# mul-compat: QQ の和・積と QQbar の和・積は同じ元。
for a in samples:
    for ap in samples:
        assert QQbar(a * ap) == QQbar(a) * QQbar(ap), \
            f"積の両立が壊れている: a={a}, a'={ap}"
        assert QQbar(a + ap) == QQbar(a) + QQbar(ap), \
            f"和の両立が壊れている: a={a}, a'={ap}"
        checked_mul_compat += 1

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    for a in samples:
        for b in samples:
            xi = QQbar(a) + QQbar(b) * s
            for ap in samples:
                for bp in samples:
                    eta = QQbar(ap) + QQbar(bp) * s
                    A = QQbar(a)
                    B = QQbar(b)
                    Ap = QQbar(ap)
                    Bp = QQbar(bp)

                    # mul-aux: 三つの補助等式を一段ずつ。
                    assert A * (Bp * s) == (A * Bp) * s, \
                        f"第一の補助等式が壊れている: {(a, b, ap, bp)}"
                    g0 = (B * s) * Ap
                    g1 = B * (s * Ap)
                    g2 = B * (Ap * s)
                    g3 = (B * Ap) * s
                    assert g0 == g1, f"第二の補助等式の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert g1 == g2, f"第二の補助等式の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert g2 == g3, f"第二の補助等式の段 3 が壊れている: {(a, b, ap, bp)}"
                    h0 = (B * s) * (Bp * s)
                    h1 = ((B * s) * Bp) * s
                    h2 = (B * (s * Bp)) * s
                    h3 = (B * (Bp * s)) * s
                    h4 = ((B * Bp) * s) * s
                    h5 = (B * Bp) * (s * s)
                    h6 = (B * Bp) * QQbar(2)
                    h7 = QQbar(2) * (B * Bp)
                    assert h0 == h1, f"第三の補助等式の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert h1 == h2, f"第三の補助等式の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert h2 == h3, f"第三の補助等式の段 3 が壊れている: {(a, b, ap, bp)}"
                    assert h3 == h4, f"第三の補助等式の段 4 が壊れている: {(a, b, ap, bp)}"
                    assert h4 == h5, f"第三の補助等式の段 5 が壊れている: {(a, b, ap, bp)}"
                    assert h5 == h6, f"第三の補助等式の段 6 が壊れている: {(a, b, ap, bp)}"
                    assert h6 == h7, f"第三の補助等式の段 7 が壊れている: {(a, b, ap, bp)}"

                    # mul-chain: 本文の鎖を一段ずつ。
                    e0 = xi * eta
                    e1 = (A + B * s) * (Ap + Bp * s)
                    e2 = A * (Ap + Bp * s) + (B * s) * (Ap + Bp * s)
                    e3 = (A * Ap + A * (Bp * s)) + (B * s) * (Ap + Bp * s)
                    e4 = (A * Ap + A * (Bp * s)) + ((B * s) * Ap + (B * s) * (Bp * s))
                    e5 = (A * Ap + (A * Bp) * s) + ((B * s) * Ap + (B * s) * (Bp * s))
                    e6 = (A * Ap + (A * Bp) * s) + ((B * Ap) * s + (B * s) * (Bp * s))
                    e7 = (A * Ap + (A * Bp) * s) + ((B * Ap) * s + QQbar(2) * (B * Bp))
                    e8 = (A * Ap + (A * Bp) * s) + (QQbar(2) * (B * Bp) + (B * Ap) * s)
                    e9 = A * Ap + ((A * Bp) * s + (QQbar(2) * (B * Bp) + (B * Ap) * s))
                    e10 = A * Ap + (((A * Bp) * s + QQbar(2) * (B * Bp)) + (B * Ap) * s)
                    e11 = A * Ap + ((QQbar(2) * (B * Bp) + (A * Bp) * s) + (B * Ap) * s)
                    e12 = A * Ap + (QQbar(2) * (B * Bp) + ((A * Bp) * s + (B * Ap) * s))
                    e13 = (A * Ap + QQbar(2) * (B * Bp)) + ((A * Bp) * s + (B * Ap) * s)
                    e14 = (A * Ap + QQbar(2) * (B * Bp)) + (A * Bp + B * Ap) * s
                    assert e0 == e1, f"表示の代入が壊れている: {(a, b, ap, bp)}"
                    assert e1 == e2, f"分配則の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert e2 == e3, f"分配則の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert e3 == e4, f"分配則の段 3 が壊れている: {(a, b, ap, bp)}"
                    assert e4 == e5, f"第一の補助等式の適用が壊れている: {(a, b, ap, bp)}"
                    assert e5 == e6, f"第二の補助等式の適用が壊れている: {(a, b, ap, bp)}"
                    assert e6 == e7, f"第三の補助等式の適用が壊れている: {(a, b, ap, bp)}"
                    assert e7 == e8, f"加法の可換則の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert e8 == e9, f"加法の結合則の段 1 が壊れている: {(a, b, ap, bp)}"
                    assert e9 == e10, f"加法の結合則の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert e10 == e11, f"加法の可換則の段 2 が壊れている: {(a, b, ap, bp)}"
                    assert e11 == e12, f"加法の結合則の段 3 が壊れている: {(a, b, ap, bp)}"
                    assert e12 == e13, f"加法の結合則の段 4 が壊れている: {(a, b, ap, bp)}"
                    assert e13 == e14, f"分配則の段 4 が壊れている: {(a, b, ap, bp)}"

                    # mul-rep: 終点の表示が (a·a'+2·(b·b'), a·b'+b·a') であること。
                    assert e0 == QQbar(a * ap + 2 * (b * bp)) + QQbar(a * bp + b * ap) * s, \
                        f"積の表示が壊れている: {(a, b, ap, bp)}"

                    checked_mul_chain += 1

print(f"mul-compat: {checked_mul_compat} 組を検査した")
print(f"mul-aux / mul-chain / mul-rep: {checked_mul_chain} 組を検査した")
print("すべて通過した")
