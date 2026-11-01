# <scalar_identity_commutes> の証明の鎖を 1 行ずつ、成分を不定元とした多項式環 QQ[i][c, a_ij] の上で厳密に確かめる。
# 積・単位行列・スカラー倍・差・零行列は本文の成分の式（mat_mult, def_identity_matrix, def_matrix_scalar_multiple,
# def_matrix_difference, def_zero_matrix）どおりに書く。
K.<i> = QuadraticField(-1)

def mul(A, B):                      # mat_mult
    n, m, p = len(A), len(B), len(B[0])
    return [[sum(A[r][j]*B[j][k] for j in range(m)) for k in range(p)] for r in range(n)]
def ident(n):                       # def_identity_matrix（δ_{ij}）
    return [[1 if r == k else 0 for k in range(n)] for r in range(n)]
def smul(a, A):                     # def_matrix_scalar_multiple
    return [[a*x for x in row] for row in A]
def sub(A, B):                      # def_matrix_difference
    return [[A[r][k]-B[r][k] for k in range(len(A[0]))] for r in range(len(A))]
def zero(n, p):                     # def_zero_matrix
    return [[0]*p for _ in range(n)]

for n in [1, 2, 3, 4]:
    names = ['c'] + ['a_%d_%d' % (r, k) for r in range(n) for k in range(n)]
    R = PolynomialRing(K, names)
    g = R.gens()
    c = g[0]
    A = [[g[1 + r*n + k] for k in range(n)] for r in range(n)]
    I = ident(n)
    lines = [
        sub(mul(smul(c, I), A), mul(A, smul(c, I))),   # (cI)A - A(cI)          交換子の定義
        sub(smul(c, mul(I, A)), mul(A, smul(c, I))),   # c(IA) - A(cI)          左の因子のスカラー倍
        sub(smul(c, mul(I, A)), smul(c, mul(A, I))),   # c(IA) - c(AI)          右の因子のスカラー倍
        sub(smul(c, A), smul(c, mul(A, I))),           # cA - c(AI)             単位行列は左の単位元
        sub(smul(c, A), smul(c, A)),                   # cA - cA                単位行列は右の単位元
        zero(n, n),                                    # O                      差が O ⟺ 等しい
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    # 各段の根拠の主張そのもの
    assert mul(smul(c, I), A) == smul(c, mul(I, A))
    assert mul(A, smul(c, I)) == smul(c, mul(A, I))
    assert mul(I, A) == A and mul(A, I) == A
    print("n=%d: 鎖の 6 行が隣どうし一致し、各段の根拠の 4 つの主張も成り立つ" % n)

# 否定コントロール: cI を一般の行列 W に替えると最初の段の値は O にならない
R2 = PolynomialRing(K, ['w_%d_%d' % (r, k) for r in range(2) for k in range(2)] + ['a_%d_%d' % (r, k) for r in range(2) for k in range(2)])
g2 = R2.gens()
W = [[g2[0], g2[1]], [g2[2], g2[3]]]
A2 = [[g2[4], g2[5]], [g2[6], g2[7]]]
assert sub(mul(W, A2), mul(A2, W)) != zero(2, 2)
print("否定コントロール: 一般の W では [W, A] は O にならない")
print("ALL PASS")
