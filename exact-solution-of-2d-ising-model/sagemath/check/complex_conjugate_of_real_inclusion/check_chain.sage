# 対象ラベル: complex_conjugate_of_real_inclusion
# conj(r_C) = r_C の四行を、r を QQ 上の不定元に置いて厳密に確かめる。1_C・0_C（r = 1, 0）も確かめる。
load("../../_shared/complex_as_real_pairs.sage")

P = PolynomialRing(QQ, "r")
r = P.gen()
lines = [
    cc_conj(iota(r, P)),   # conj(r_C)
    cc_conj((r, P(0))),    # conj((r, 0))   (inclusion_rr_to_cc)
    (r, -P(0)),            # (r, -0)        (def_complex_conjugate)
    (r, P(0)),             # (r, 0)         (ℝ で -0 = 0)
    iota(r, P),            # r_C            (inclusion_rr_to_cc)
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
for v in [0, 1, -1, QQ(1) / 2, QQ(-7) / 3]:
    assert cc_conj(iota(v, QQ)) == iota(v, QQ)
    KG = QuadraticField(-1, 'i')
    c = cc_conj(iota(v, QQ))
    assert c[0] + KG.gen() * c[1] == KG(v).conjugate()   # 比べる側: 本文の値を QQ(i) へ送り、Sage の共役と突き合わせる
print("不定元 r と r = 0, 1, -1, 1/2, -7/3 で conj(r_C) = r_C を確かめた")
print("RESULT: PASS")
