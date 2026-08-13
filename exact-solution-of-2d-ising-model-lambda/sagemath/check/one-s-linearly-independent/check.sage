# 対象ラベル: claim_one_s_linearly_independent
# 帰属: QQ / QQbar の厳密計算。浮動小数点を使わない。

# 主張（claim_one_s_linearly_independent）: s·s=2 を満たす s ∈ QQbar と
# 任意の a,b ∈ QQ について、a + b·s = 0 ならば (a,b)=(0,0)。
# 証明の組み立てを一行ずつ突き合わせる:
#   prep:   b≠0 なら b^{-1}·b = 1、r := b^{-1}·(-a) ∈ QQ。
#   chain1: b·s = -a（仮定 a+b·s=0 のもとで。標本では仮定が偽なので対偶で見る）
#   chain2: s = b^{-1}·(b·s)（結合則の段。仮定に依存しない部分）
#   chain3: r·r = 2 が矛盾を出す段: r ∈ QQ なので r·r ≠ 2（claim_no_rational_square_two）。
#           したがって s ≠ r であり、a + b·s ≠ 0。
#   b=0 の段: a + 0·s = a なので、a ≠ 0 なら a + b·s ≠ 0。

# s·s = 2 を満たす QQbar の元をすべて列挙する（t^2 - 2 の根。ちょうど 2 個）。
R.<t> = PolynomialRing(QQ)
roots = (t ** 2 - 2).roots(QQbar, multiplicities=False)
assert len(roots) == 2, "t^2 - 2 の QQbar の根がちょうど 2 個でない"

BOUND = 6
checked_nonzero = 0
checked_chain = 0
checked_rearrangement = 0
checked_b_zero = 0

for s in roots:
    assert s * s == 2, "s·s = 2 が壊れている"

    # 有理数の標本（分子 -BOUND..BOUND、分母 1..BOUND）。
    samples = [QQ(p) / QQ(q) for p in range(-BOUND, BOUND + 1)
               for q in range(1, BOUND + 1)]
    sample_set = sorted(set(samples))

    for a in sample_set:
        for b in sample_set:
            if a == 0 and b == 0:
                # 主張の逆向き: (a,b)=(0,0) なら a+b·s=0。
                assert a + b * s == 0, "0 + 0·s = 0 が壊れている"
                continue
            # 主張そのもの（対偶）: (a,b)≠(0,0) なら a + b·s ≠ 0。
            assert a + b * s != 0, f"反例が出た: a = {a}, b = {b}, s = {s}"
            checked_nonzero += 1

            if b != 0:
                # prep: 逆元の等式。
                binv = b ** -1
                assert binv in QQ and binv * b == 1, "b^{-1}·b = 1 が壊れている"
                # r の構成と、矛盾の段の中身。
                r = binv * (-a)
                assert r in QQ, "r = b^{-1}·(-a) ∈ QQ が壊れている"
                # chain1 の五段のうち、仮定に依存しない恒等変形を各段で検査する。
                chain1_0 = QQbar(b) * s
                chain1_1 = QQbar(0) + QQbar(b) * s
                chain1_2 = (QQbar(-a) + QQbar(a)) + QQbar(b) * s
                chain1_3 = QQbar(-a) + (QQbar(a) + QQbar(b) * s)
                assert chain1_0 == chain1_1, "chain1 の加法の単位元の段が壊れている"
                assert chain1_1 == chain1_2, "chain1 の加法の逆元の段が壊れている"
                assert chain1_2 == chain1_3, "chain1 の加法の結合則の段が壊れている"
                if QQbar(a) + QQbar(b) * s == 0:
                    assert chain1_3 == QQbar(-a) + 0, "chain1 の仮定の代入段が壊れている"
                    assert QQbar(-a) + 0 == QQbar(-a), "chain1 の終段が壊れている"
                checked_rearrangement += 1
                # chain2 の結合則の段（仮定に依存しない）: b^{-1}·(b·s) = (b^{-1}·b)·s = s。
                assert QQbar(binv) * (QQbar(b) * s) == s, "積の結合則の段が壊れている"
                # chain3: r ∈ QQ なので r·r ≠ 2（claim_no_rational_square_two）。
                assert r * r != 2, f"r·r = 2 となる有理数が出た: r = {r}"
                # したがって s ≠ r（s·s=2 と r·r≠2 から。QQbar の等号は厳密）。
                assert s != QQbar(r), f"s = r となった: r = {r}"
                checked_chain += 1
            else:
                # b=0 の段: a + 0·s = a ≠ 0。
                assert a + b * s == QQbar(a), "a + 0·s = a が壊れている"
                checked_b_zero += 1

print(f"OK: 2 根 × 標本で a+b·s ≠ 0 を {checked_nonzero} 組、"
      f"移項の恒等変形を {checked_rearrangement} 組、b≠0 の鎖を {checked_chain} 組、"
      f"b=0 の段を {checked_b_zero} 組検査した")
