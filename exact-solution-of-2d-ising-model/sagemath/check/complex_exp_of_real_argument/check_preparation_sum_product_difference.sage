# 対象ラベル: complex_exp_of_real_argument
# 準備の三つの鎖を QQ[a, b] の不定元で確かめる。ℂ は definition_of_cc どおり実数の対で持つ。
#   a_C + b_C = (a,0)+(b,0) = (a+b, 0+0) = (a+b, 0) = (a+b)_C
#   a_C b_C = (a,0)(b,0) = (ab - 0·0, a·0 + 0·b) = (ab, 0) = (ab)_C
#   a_C - b_C = a_C + (-b_C) = a_C + (-1)_C b_C = a_C + ((-1)b)_C = (a + (-1)b)_C = (a-b)_C
# 不定元で成り立つ多項式の等号は、a, b へ任意の実数を代入しても成り立つ（代入は環準同型）。
load("../../_shared/complex_as_real_pairs.sage")

R = PolynomialRing(QQ, 'a,b')
a, b = R.gens()
zero = R(0)

# 和の鎖。各行の対を本文の行の形のまま作る。
add_chain = [
    cc_add(iota(a, R), iota(b, R)),
    cc_add((a, zero), (b, zero)),
    (a + b, zero + zero),
    (a + b, zero),
    iota(a + b, R),
]
assert all(c == add_chain[0] for c in add_chain), add_chain
print("和の鎖 a_C + b_C = (a,0)+(b,0) = (a+b,0+0) = (a+b,0) = (a+b)_C が QQ[a,b] で成り立つ")

# 積の鎖。
mul_chain = [
    cc_mul(iota(a, R), iota(b, R)),
    cc_mul((a, zero), (b, zero)),
    (a * b - zero * zero, a * zero + zero * b),
    (a * b, zero),
    iota(a * b, R),
]
assert all(c == mul_chain[0] for c in mul_chain), mul_chain
print("積の鎖 a_C b_C = (a,0)(b,0) = (ab-0·0, a·0+0·b) = (ab,0) = (ab)_C が QQ[a,b] で成り立つ")

# 差の鎖。-1_C は inclusion_rr_to_cc の略記 r_C の r = -1 なので ι(-1) と同じ対。multiply_by_minus_one の -z := (-1_C) z。
sub_chain = [
    cc_sub(iota(a, R), iota(b, R), R),
    cc_add(iota(a, R), cc_neg(iota(b, R), R)),
    cc_add(iota(a, R), cc_mul(iota(-1, R), iota(b, R))),
    cc_add(iota(a, R), iota((-1) * b, R)),
    iota(a + (-1) * b, R),
    iota(a - b, R),
]
assert all(c == sub_chain[0] for c in sub_chain), sub_chain
print("差の鎖 a_C - b_C = a_C + (-b_C) = … = (a-b)_C が QQ[a,b] で成り立つ")

# 対照: 虚部が 0 でない元どうしでは、積の実部に虚部の積が入り、成分ごとの積にはならない。
z, w = (QQ(1), QQ(2)), (QQ(3), QQ(-1))
assert cc_mul(z, w) != (z[0] * w[0], z[1] * w[1])
print("対照: (1,2)(3,-1) は成分ごとの積 (3,-2) と一致しない（積の鎖が虚部 0 に依ることの確認）")
print("RESULT: PASS")
