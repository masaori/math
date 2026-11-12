# 対象ラベル: claim_mode_inversion_orbit_cardinality
# 本文の各行を QQbar で厳密に検算する。実数体・複素数体・浮動小数点は使わない。
# - 四点がモード集合に属すること
# - z = z^{-1} の同値の四行（z·z = z·z^{-1}、z^2 = 1、(z-1)(z+1) = 0、z ∈ {1,-1}）
# - n(z) := |{z, z^{-1}}| の場合分け
# - 元数の三行 |O| = |{ϖ,ϖ⁻¹}×{ς,ς⁻¹}| = |{ϖ,ϖ⁻¹}|·|{ς,ς⁻¹}| = n(ϖ)·n(ς)
# - 四通りの積と |O| = 1 の同値の四行
# 軌道の分割（後段の明示積が使う）も引き続き確かめる。
import itertools

lines = 0
negatives = 0

def n_of(z):
    return len({z, z^(-1)})

# 四通りの積（自然数の表）
for n1, n2 in itertools.product((1, 2), repeat=2):
    assert n1 * n2 in (1, 2, 4)
    assert (n1 * n2 == 1) == (n1 == 1 and n2 == 1)
    lines += 2

for length in range(1, 7):
    for a in (0, 1):
        for b in (0, 1):
            U = modes(length, a)
            W = modes(length, b)
            assert len(U) == length and len(W) == length
            for z in set(U) | set(W):
                assert z != 0
                left = (z == z^(-1))
                l1 = (z * z == z * z^(-1))
                l2 = (z^2 == 1)
                l3 = ((z - 1) * (z + 1) == 0)
                l4 = (z in (QQbar(1), QQbar(-1)))
                assert left == l1 == l2 == l3 == l4
                assert z * z^(-1) == 1
                assert (z - 1) * (z + 1) == z^2 - 1
                lines += 6
                # n の場合分け
                assert n_of(z) == (1 if left else 2)
                lines += 1
            for varpi in U:
                for varsigma in W:
                    O = orbit((varpi, varsigma))
                    # 四点の所属
                    for (p, q) in O:
                        assert p in U and q in W
                        lines += 1
                    # 元数の三行
                    prod_set = {(p, q) for p in {varpi, varpi^(-1)} for q in {varsigma, varsigma^(-1)}}
                    assert set(O) == prod_set
                    assert len(prod_set) == len({varpi, varpi^(-1)}) * len({varsigma, varsigma^(-1)})
                    assert len({varpi, varpi^(-1)}) * len({varsigma, varsigma^(-1)}) == n_of(varpi) * n_of(varsigma)
                    lines += 3
                    # |O| ∈ {1,2,4} と |O| = 1 の同値の四行
                    c = len(O)
                    assert c in (1, 2, 4)
                    e0 = (c == 1)
                    e1 = (n_of(varpi) * n_of(varsigma) == 1)
                    e2 = (n_of(varpi) == 1 and n_of(varsigma) == 1)
                    e3 = (varpi == varpi^(-1) and varsigma == varsigma^(-1))
                    e4 = (varpi in (1, -1) and varsigma in (1, -1))
                    assert e0 == e1 == e2 == e3 == e4
                    lines += 5
                    # 否定の対照: 逆元を符号反転に替えた「軌道」では一元の条件が変わる
                    fake = {(varpi, varsigma), (-varpi, varsigma), (varpi, -varsigma), (-varpi, -varsigma)}
                    if (len(fake) == 1) != e4:
                        negatives += 1
            # 軌道の分割（明示積の段で使う）
            points, orbits = orbit_factors(length, a, b)
            assert set().union(*map(set, orbits)) == points
            assert sum(len(group) for group in orbits) == len(points)
            for group in orbits:
                factor = delta(*next(iter(group)))
                assert all(delta(*point) == factor for point in group)
            lines += 2

# 否定の対照: z = 0 は z = z^{-1} 側の同値を壊す（体の中で 0 は逆元を持たない。
# 「0 = 0^{-1}」と読む約束をすると左辺は真で右辺 z ∈ {1,-1} は偽）。L ≥ 1 で z ≠ 0 が要る。
assert QQbar(0)^0 == 1
assert QQbar(0) not in (QQbar(1), QQbar(-1))
negatives += 1
print('lines:', lines, 'negatives:', negatives)
