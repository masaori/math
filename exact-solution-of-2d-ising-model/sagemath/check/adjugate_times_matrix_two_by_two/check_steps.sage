# adjugate_times_matrix_two_by_two（(adj B) B = (det B) I）の証明の各行の検算。
# 成分は多項式環 QQ[B11, B12, B21, B22, z, w] の元として扱う（浮動小数点は使わない）。

R.<B11, B12, B21, B22, z, w> = PolynomialRing(QQ)
m1 = -1                                         # (-1_ℂ)。multiply_by_minus_one
neg = lambda u: m1 * u
B = matrix(R, [[B11, B12], [B21, B22]])
adjB = matrix(R, [[B22, neg(B12)], [neg(B21), B11]])   # def_adjugate_two_by_two
detB = B11*B22 - B12*B21                              # def_det_two_by_two
I2 = identity_matrix(R, 2)
delta = lambda i, j: R(1) if i == j else R(0)         # def_kronecker_delta

# 準備 (b) (-z)w = -(zw) の 3 行
b_chain = [neg(z)*w, (m1*z)*w, m1*(z*w), neg(z*w)]
assert all(t == b_chain[0] for t in b_chain), "(b)"
print("準備 (b): 各行が一致")

P = adjB * B
S = detB * I2
ch11 = [P[0,0], adjB[0,0]*B11 + adjB[0,1]*B21, B22*B11 + neg(B12)*B21, B22*B11 + neg(B12*B21),
        B11*B22 + neg(B12*B21), B11*B22 - B12*B21, detB, detB*1, detB*delta(0,0), detB*I2[0,0], S[0,0]]
ch12 = [P[0,1], adjB[0,0]*B12 + adjB[0,1]*B22, B22*B12 + neg(B12)*B22, B22*B12 + neg(B12*B22),
        B22*B12 + neg(B22*B12), neg(B22*B12) + B22*B12, R(0), detB*0, detB*delta(0,1), detB*I2[0,1], S[0,1]]
ch21 = [P[1,0], adjB[1,0]*B11 + adjB[1,1]*B21, neg(B21)*B11 + B11*B21, neg(B21*B11) + B11*B21,
        neg(B21*B11) + B21*B11, R(0), detB*0, detB*delta(1,0), detB*I2[1,0], S[1,0]]
ch22 = [P[1,1], adjB[1,0]*B12 + adjB[1,1]*B22, neg(B21)*B12 + B11*B22, neg(B21*B12) + B11*B22,
        B11*B22 + neg(B21*B12), B11*B22 + neg(B12*B21), B11*B22 - B12*B21, detB, detB*1,
        detB*delta(1,1), detB*I2[1,1], S[1,1]]
for name, ch in [("(1,1)", ch11), ("(1,2)", ch12), ("(2,1)", ch21), ("(2,2)", ch22)]:
    assert all(t == ch[0] for t in ch), name
    print(name, "成分の鎖:", len(ch) - 1, "行が一致")
assert P == S
print("(adj B) B = (det B) I: 多項式の恒等式として成立")

bad = matrix(R, [[B11, neg(B12)], [neg(B21), B22]])     # 対角成分を入れ替え忘れた行列
assert bad * B != S
print("否定コントロール: 対角成分を入れ替えない行列では (…)·B ≠ (det B) I")
print("ALL PASS")
