# matrix_times_adjugate_two_by_two（B adj B = (det B) I）の証明の各行の検算。
# 成分は多項式環 QQ[B11, B12, B21, B22, z, w, x] の元として扱う（浮動小数点は使わない）。
# QQ[...] の乗法は可換なので、ℂ の体の公理（結合律・可換律・単位元・分配律）で移り合う行どうしは多項式として一致する。

R.<B11, B12, B21, B22, z, w, x> = PolynomialRing(QQ)
m1 = -1                                         # (-1_ℂ)。multiply_by_minus_one: -u := (-1_ℂ) u
neg = lambda u: m1 * u
B = matrix(R, [[B11, B12], [B21, B22]])
adjB = matrix(R, [[B22, neg(B12)], [neg(B21), B11]])   # def_adjugate_two_by_two
detB = B11*B22 - B12*B21                              # def_det_two_by_two
I2 = identity_matrix(R, 2)                            # def_identity_matrix（δ_ij）
delta = lambda i, j: R(1) if i == j else R(0)         # def_kronecker_delta

# 準備 (a) z(-w) = -(zw) の 5 行
a_chain = [z*neg(w), z*(m1*w), (z*m1)*w, (m1*z)*w, m1*(z*w), neg(z*w)]
assert all(t == a_chain[0] for t in a_chain), "(a)"
# 準備 (c) (-x) + x = 0 の 8 行。(−1,0)+(1,0) = (−1+1, 0+0) = (0,0) は ℝ の四則
assert (-1 + 1, 0 + 0) == (0, 0)
c_chain = [neg(x) + x, m1*x + x, m1*x + 1*x, (m1 + 1)*x, 0*x, R(0)]
assert all(t == c_chain[0] for t in c_chain) and c_chain[0] == 0, "(c)"
print("準備 (a)・(c): 各行が一致")

P = B * adjB
S = detB * I2
# (1,1) 成分の 9 行
ch11 = [P[0,0], B11*adjB[0,0] + B12*adjB[1,0], B11*B22 + B12*neg(B21), B11*B22 + neg(B12*B21),
        B11*B22 - B12*B21, detB, detB*1, detB*delta(0,0), detB*I2[0,0], S[0,0]]
# (1,2) 成分の 9 行
ch12 = [P[0,1], B11*adjB[0,1] + B12*adjB[1,1], B11*neg(B12) + B12*B11, neg(B11*B12) + B12*B11,
        neg(B11*B12) + B11*B12, R(0), detB*0, detB*delta(0,1), detB*I2[0,1], S[0,1]]
# (2,1) 成分の 10 行
ch21 = [P[1,0], B21*adjB[0,0] + B22*adjB[1,0], B21*B22 + B22*neg(B21), B21*B22 + neg(B22*B21),
        B21*B22 + neg(B21*B22), neg(B21*B22) + B21*B22, R(0), detB*0, detB*delta(1,0), detB*I2[1,0], S[1,0]]
# (2,2) 成分の 11 行
ch22 = [P[1,1], B21*adjB[0,1] + B22*adjB[1,1], B21*neg(B12) + B22*B11, neg(B21*B12) + B22*B11,
        B22*B11 + neg(B21*B12), B11*B22 + neg(B12*B21), B11*B22 - B12*B21, detB, detB*1,
        detB*delta(1,1), detB*I2[1,1], S[1,1]]
for name, ch in [("(1,1)", ch11), ("(1,2)", ch12), ("(2,1)", ch21), ("(2,2)", ch22)]:
    assert all(t == ch[0] for t in ch), name
    print(name, "成分の鎖:", len(ch) - 1, "行が一致")
assert P == S
print("B adj B = (det B) I: 多項式の恒等式として成立")

# 否定コントロール: 余因子行列の非対角成分の符号を落とすと成り立たない
bad = matrix(R, [[B22, B12], [B21, B11]])
assert B * bad != S
print("否定コントロール: 符号を落とした行列では B·(…) ≠ (det B) I")
print("ALL PASS")
