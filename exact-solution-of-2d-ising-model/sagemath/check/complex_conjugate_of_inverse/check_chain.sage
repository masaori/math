# 対象ラベル: complex_conjugate_of_inverse
# w ∈ ℂ^× について conj(w^{-1}) = (conj w)^{-1}。w = (x, y) を QQ(x, y)（有理関数体）に置き、
# 準備の conj(w) ≠ 0 の判定、準備の鎖 3 行、主鎖 5 行を、ℂ を実数の対とその和・積で持って厳密に確かめる。
# 逆元は multiplicative_group_of_cc の証明の (a, b)^{-1} = (a/(a^2+b^2), -b/(a^2+b^2))。
load("../../_shared/complex_as_real_pairs.sage")

R = FractionField(PolynomialRing(QQ, ["x", "y"]))
x, y = R.gens()


def cc_inv(z):
    """multiplicative_group_of_cc の逆元 (a,b)^{-1} = (a/(a^2+b^2), -b/(a^2+b^2))（z ≠ 0）。"""
    n = z[0]^2 + z[1]^2
    assert n != 0
    return (z[0] / n, -z[1] / n)


one = iota(1, R)
w = (x, y)
wi = cc_inv(w)
cw = cc_conj(w)
# 逆元の式が multiplicative_group_of_cc の逆元である（両側）
assert cc_mul(w, wi) == one and cc_mul(wi, w) == one
assert cc_mul(cw, cc_inv(cw)) == one and cc_mul(cc_inv(cw), cw) == one
# 準備: conj(w) = (x, -y) で、(x, -y) = (0, 0) なら (x, y) = (0, 0)
assert cw == (x, -y)
assert cw[0]^2 + cw[1]^2 == w[0]^2 + w[1]^2          # conj(w) の成分の平方和は w のものと同じ（0 でない）
# 準備の鎖: conj(w)conj(w^{-1}) = conj(w w^{-1}) = conj(1_C) = 1_C
prep = [
    cc_mul(cw, cc_conj(wi)),
    cc_conj(cc_mul(w, wi)),
    cc_conj(one),
    one,
]
for t in range(len(prep) - 1):
    assert prep[t] == prep[t + 1], ("prep", t)
# 主鎖 5 行
cwi = cc_inv(cw)
main = [
    cc_conj(wi),                                   # conj(w^{-1})
    cc_mul(one, cc_conj(wi)),                      # 1_C conj(w^{-1})
    cc_mul(cc_mul(cwi, cw), cc_conj(wi)),          # ((conj w)^{-1} conj w) conj(w^{-1})
    cc_mul(cwi, cc_mul(cw, cc_conj(wi))),          # (conj w)^{-1}(conj w conj(w^{-1}))
    cc_mul(cwi, one),                              # (conj w)^{-1} 1_C
    cwi,                                           # (conj w)^{-1}
]
for t in range(len(main) - 1):
    assert main[t] == main[t + 1], ("main", t)
# 具体の w で Sage の QQ(i) の共役・逆元と突き合わせる
KG = QuadraticField(-1, "i")
for (a, b) in [(1, 0), (0, 1), (2, -3), (QQ(1) / 2, QQ(5) / 7), (-4, 0)]:
    v = (QQ(a), QQ(b))
    lhs = cc_conj(cc_inv(v))
    z = KG(a) + KG.gen() * b
    assert lhs[0] + KG.gen() * lhs[1] == (z^(-1)).conjugate() == (z.conjugate())^(-1)
# 否定コントロール: 共役を取らない逆元 w^{-1} は (conj w)^{-1} と一般には異なる
assert cc_inv(w) != cwi
print("w = (x, y) を有理関数体に置いて準備の鎖 3 行・主鎖 5 行を確かめ、具体の w 5 個で QQ(i) と突き合わせた。否定コントロール 1 件")
print("RESULT: PASS")
