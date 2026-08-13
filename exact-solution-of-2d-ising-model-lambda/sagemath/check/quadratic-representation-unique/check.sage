# 対象ラベル: claim_quadratic_representation_unique
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# 主張（claim_quadratic_representation_unique）: s·s=2 を満たす s ∈ QQbar と
# 任意の a,b,a',b' ∈ QQ について、a + b·s = a' + b'·s ならば (a,b)=(a',b')。
# 証明の組み立てを一行ずつ突き合わせる:
#   prep:  α := a+(-a') ∈ QQ、β := b+(-b') ∈ QQ。
#   chain: α+β·s を十四段の恒等変形で (a+b·s) + ((-b')·s+(-a')) まで運び、
#          仮定の代入のあと 0 まで落とす。仮定に依存しない段は全標本で、
#          仮定の代入段は仮定が成り立つ標本でだけ検査する。
#   apply: α+β·s=0 と claim_one_s_linearly_independent から α=0 かつ β=0。
#          標本では対偶（(α,β)≠(0,0) なら α+β·s≠0、ゆえに a+b·s ≠ a'+b'·s）で見る。
#   六段の鎖二本: α=0 から a=a'、β=0 から b=b'。

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

BOUND = 2
checked_unique = 0
checked_chain = 0
checked_equal_case = 0

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    # 有理数の標本（分子 -BOUND..BOUND、分母 1..BOUND）。
    samples = sorted(set(QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
                         for q in range(1, BOUND + 1)))

    for a in samples:
        for b in samples:
            for ap in samples:
                for bp in samples:
                    alpha = a + (-ap)
                    beta = b + (-bp)
                    assert alpha in QQ and beta in QQ, "α, β ∈ QQ が壊れている"

                    # 鎖の各段（仮定に依存しない恒等変形）を QQbar の厳密等号で検査する。
                    c0 = QQbar(alpha) + QQbar(beta) * s
                    c1 = (QQbar(a) + QQbar(-ap)) + (QQbar(b) + QQbar(-bp)) * s
                    c2 = (QQbar(a) + QQbar(-ap)) + (QQbar(b) * s + QQbar(-bp) * s)
                    c3 = QQbar(a) + (QQbar(-ap) + (QQbar(b) * s + QQbar(-bp) * s))
                    c4 = QQbar(a) + ((QQbar(b) * s + QQbar(-bp) * s) + QQbar(-ap))
                    c5 = QQbar(a) + (QQbar(b) * s + (QQbar(-bp) * s + QQbar(-ap)))
                    c6 = (QQbar(a) + QQbar(b) * s) + (QQbar(-bp) * s + QQbar(-ap))
                    assert c0 == c1 == c2 == c3 == c4 == c5 == c6, \
                        "α+β·s から (a+b·s)+((-b')·s+(-a')) までの段が壊れている"
                    c8 = QQbar(ap) + (QQbar(bp) * s + (QQbar(-bp) * s + QQbar(-ap)))
                    c9 = QQbar(ap) + ((QQbar(bp) * s + QQbar(-bp) * s) + QQbar(-ap))
                    c10 = QQbar(ap) + ((QQbar(bp) + QQbar(-bp)) * s + QQbar(-ap))
                    c11 = QQbar(ap) + (QQbar(0) * s + QQbar(-ap))
                    c12 = QQbar(ap) + (QQbar(0) + QQbar(-ap))
                    c13 = QQbar(ap) + QQbar(-ap)
                    assert c8 == c9 == c10 == c11 == c12 == c13 == 0, \
                        "(a'+b'·s)+((-b')·s+(-a')) から 0 までの段が壊れている"
                    checked_chain += 1

                    lhs = QQbar(a) + QQbar(b) * s
                    rhs = QQbar(ap) + QQbar(bp) * s
                    if a == ap and b == bp:
                        # 逆向き: 表示が同じなら値も同じ。仮定の代入段 c6 == c8 も成り立つ。
                        assert lhs == rhs, "同じ表示で値が異なる"
                        assert c6 == c8, "仮定の代入段が壊れている"
                        checked_equal_case += 1
                    else:
                        # 主張そのもの（対偶）: (a,b)≠(a',b') なら a+b·s ≠ a'+b'·s。
                        # （α,β)≠(0,0) と claim_one_s_linearly_independent の対偶による。）
                        assert not (alpha == 0 and beta == 0), "表示が違うのに α=β=0"
                        assert lhs != rhs, \
                            f"反例が出た: (a,b)=({a},{b}), (a',b')=({ap},{bp}), s={s}"
                        checked_unique += 1

                    # 六段の鎖二本（α=0 / β=0 の場合にだけ意味を持つ最終二段は、
                    # 恒等変形の段としては全標本で成り立つ）。
                    assert a == (a + 0) == (a + ((-ap) + ap)) == ((a + (-ap)) + ap) \
                        == (alpha + ap), "a の六段の鎖の恒等変形が壊れている"
                    assert b == (b + 0) == (b + ((-bp) + bp)) == ((b + (-bp)) + bp) \
                        == (beta + bp), "b の六段の鎖の恒等変形が壊れている"
                    if alpha == 0:
                        assert alpha + ap == 0 + ap == ap, "α=0 の終段が壊れている"
                    if beta == 0:
                        assert beta + bp == 0 + bp == bp, "β=0 の終段が壊れている"

print(f"OK: 2 根 × 標本で表示の一意性（対偶）を {checked_unique} 組、"
      f"鎖の恒等変形を {checked_chain} 組、同一表示の場合を {checked_equal_case} 組検査した")
