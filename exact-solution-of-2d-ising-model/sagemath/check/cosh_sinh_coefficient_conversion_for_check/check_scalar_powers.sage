# 対象ラベル: cosh_sinh_coefficient_conversion_for_check
# 証明の準備のうち ℂ の中だけの四つの鎖を、definition_of_cc の ℂ を実数の対で持って（Sage の複素数を使わずに）厳密に確かめる。
#   i i = -1_C、(-1_C)(-1_C) = 1_C の鎖（対の成分は QQ）
#   (†) (i/2)^m (2k)^m = i^m k^m の基底段階と帰納段階（k = (a, b) の a・b を QQ 上の不定元に。m = 0..M_MAX）
#   (‡) i^{2l} (-1_C)^l = 1_C の基底段階と帰納段階（l = 0..L_MAX）
# 冪は冪の約束どおり右から 1 つずつ掛けて作る（cc_power）。2_C^{-1} は (2_R)_C の逆元 (1/2, 0) で、2_C^{-1} 2_C = 1_C も確かめる。
load("_prelude.sage")

M_MAX = 10
L_MAX = 8

# i i と (-1)(-1)
Q = QQ
i_ = (Q(0), Q(1))
one = iota(1, Q)
mone = cc_neg(one, Q)
run_chain([
    ("i i", cc_mul(i_, i_)),
    ("(0,1)(0,1)", cc_mul((Q(0), Q(1)), (Q(0), Q(1)))),
    ("(0·0 - 1·1, 0·1 + 1·0)", (Q(0) * Q(0) - Q(1) * Q(1), Q(0) * Q(1) + Q(1) * Q(0))),
    ("(-1, 0)", (Q(-1), Q(0))),
    ("-1_C", mone),
], "i i = -1_C")
report(cc_add(one, mone) == (Q(0), Q(0)), "-1_C は 1_C の加法の逆元")
run_chain([
    ("(-1_C)(-1_C)", cc_mul(mone, mone)),
    ("(-1,0)(-1,0)", cc_mul((Q(-1), Q(0)), (Q(-1), Q(0)))),
    ("((-1)(-1) - 0·0, (-1)·0 + 0·(-1))", (Q(-1) * Q(-1) - Q(0) * Q(0), Q(-1) * Q(0) + Q(0) * Q(-1))),
    ("(1, 0)", (Q(1), Q(0))),
    ("1_C", one),
], "(-1_C)(-1_C) = 1_C")

# (†)
R = PolynomialRing(QQ, ['a', 'b'])
a, b = R.gens()
k = (a, b)
iR = (R(0), R(1))
two = iota(2, R)
two_inv = (R(1 / 2), R(0))
oneR = iota(1, R)
report(cc_mul(two_inv, two) == oneR, "2_C^{-1} 2_C = 1_C")
ihalf = cc_mul(iR, two_inv)
twok = cc_mul(two, k)
P = lambda z, m: cc_power(z, m, R)
run_chain([
    ("(i/2)^0 (2k)^0", cc_mul(P(ihalf, 0), P(twok, 0))),
    ("1_C 1_C", cc_mul(oneR, oneR)),
    ("i^0 k^0", cc_mul(P(iR, 0), P(k, 0))),
], "(†) 基底")
for m in range(M_MAX):
    report(cc_mul(P(ihalf, m), P(twok, m)) == cc_mul(P(iR, m), P(k, m)), f"(†) m={m}（帰納法の仮定）")
    run_chain([
        ("(i/2)^{m+1}(2k)^{m+1}", cc_mul(P(ihalf, m + 1), P(twok, m + 1))),
        ("((i/2)^m (i/2))((2k)^m(2k))", cc_mul(cc_mul(P(ihalf, m), ihalf), cc_mul(P(twok, m), twok))),
        ("((i/2)^m(2k)^m)((i/2)(2k))", cc_mul(cc_mul(P(ihalf, m), P(twok, m)), cc_mul(ihalf, twok))),
        ("(i^m k^m)((i/2)(2k))", cc_mul(cc_mul(P(iR, m), P(k, m)), cc_mul(ihalf, twok))),
        ("(i^m k^m)((i 2^{-1})(2k))", cc_mul(cc_mul(P(iR, m), P(k, m)), cc_mul(cc_mul(iR, two_inv), cc_mul(two, k)))),
        ("(i^m k^m)((i(2^{-1}2))k)", cc_mul(cc_mul(P(iR, m), P(k, m)), cc_mul(cc_mul(iR, cc_mul(two_inv, two)), k))),
        ("(i^m k^m)((i 1_C)k)", cc_mul(cc_mul(P(iR, m), P(k, m)), cc_mul(cc_mul(iR, oneR), k))),
        ("(i^m k^m)(ik)", cc_mul(cc_mul(P(iR, m), P(k, m)), cc_mul(iR, k))),
        ("(i^m i)(k^m k)", cc_mul(cc_mul(P(iR, m), iR), cc_mul(P(k, m), k))),
        ("i^{m+1}k^{m+1}", cc_mul(P(iR, m + 1), P(k, m + 1))),
    ], f"(†) m={m} 帰納段階")
# 対照: 2 の冪を落とした (i/2)^m k^m は m ≥ 1 で一致しない
report(cc_mul(P(ihalf, 1), P(k, 1)) != cc_mul(P(iR, 1), P(k, 1)), "(†) 対照 (i/2)k ≠ ik")

# (‡)
iQ = i_
PQ = lambda z, m: cc_power(z, m, Q)
run_chain([
    ("i^{2·0}(-1)^0", cc_mul(PQ(iQ, 2 * 0), PQ(mone, 0))),
    ("i^0(-1)^0", cc_mul(PQ(iQ, 0), PQ(mone, 0))),
    ("1_C 1_C", cc_mul(one, one)),
    ("1_C", one),
], "(‡) 基底")
for l in range(L_MAX):
    report(cc_mul(PQ(iQ, 2 * l), PQ(mone, l)) == one, f"(‡) l={l}（帰納法の仮定）")
    report(2 * (l + 1) == (2 * l + 1) + 1, f"(‡) l={l}: 2(l+1) = (2l+1)+1")
    run_chain([
        ("i^{2(l+1)}(-1)^{l+1}", cc_mul(PQ(iQ, 2 * (l + 1)), PQ(mone, l + 1))),
        ("i^{(2l+1)+1}(-1)^{l+1}", cc_mul(PQ(iQ, (2 * l + 1) + 1), PQ(mone, l + 1))),
        ("((i^{2l} i) i)((-1)^l(-1))", cc_mul(cc_mul(cc_mul(PQ(iQ, 2 * l), iQ), iQ), cc_mul(PQ(mone, l), mone))),
        ("(i^{2l}(-1)^l)((i i)(-1))", cc_mul(cc_mul(PQ(iQ, 2 * l), PQ(mone, l)), cc_mul(cc_mul(iQ, iQ), mone))),
        ("1_C((i i)(-1))", cc_mul(one, cc_mul(cc_mul(iQ, iQ), mone))),
        ("1_C((-1)(-1))", cc_mul(one, cc_mul(mone, mone))),
        ("1_C 1_C", cc_mul(one, one)),
        ("1_C", one),
    ], f"(‡) l={l} 帰納段階")
# 対照: 奇数冪では成り立たない
report(cc_mul(PQ(iQ, 1), PQ(mone, 0)) != one, "(‡) 対照 i^1(-1)^0 ≠ 1_C")

print("RESULT: PASS")
