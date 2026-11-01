# 対象ラベル: scalar_exp_product
# 主張そのもの exp(x)exp(y) = exp(x+y) を、本文の exp（1 行 1 列の行列の exp の成分）の値を含むボールで
# 具体の点について確かめ、対照として、
# 可換でない 2 行 2 列の行列では exp 積公式が成り立たないことを確かめる。
# R への脱出: exp の値は可算な係数の中に収まらないので、この検算だけ ComplexBallField(512)
# （値と誤差の上界の組。丸めの誤差も包含に入る）を使う。等号は「両辺のボールが重なる」こと、
# 不等号は「重ならない」ことで確かめる。点 x, y は QQ と QQ(i) で厳密に持ち、最後にボールへ移す。
load("../../_shared/one_by_one_matrix.sage")

CBF = ComplexBallField(512)
RBF = RealBallField(512)
ii = GAUSSIAN.gen()
N_BODY = 150


def body_exp_ball(F, x0):
    """本文の exp(x) := (exp([x]_K))_11 を含むボール。中心は 1 行 1 列の行列の部分和 S_N([x]) の成分
    （QQ(i) の中で厳密）、半径は尾の評価 2|x|^{N+1}/(N+1)!（N + 2 ≥ 2|x| のとき成り立つ）。
    本文の exp(x) がこのボールに入る根拠: scalar_exp_is_limit_of_partial_sums により S_M → exp(x)（M → ∞）であり、
    M > N のとき |S_M - S_N| ≤ (|x|^{N+1}/(N+1)!) Σ_k 2^{-k} ≤ 2|x|^{N+1}/(N+1)!（比 |x|/(N+2) ≤ 1/2 の等比級数との比較。
    この尾の評価は本文には無く、検算の側で導いたもの）なので、M → ∞ で |exp(x) - S_N| ≤ 2|x|^{N+1}/(N+1)!。"""
    center = entry11(matrix_partial_sum(one_by_one(F, x0), N_BODY))
    abs_x = CBF(x0).abs()
    assert RBF(N_BODY + 2) >= 2 * abs_x
    radius = (2 * abs_x^(N_BODY + 1) / factorial(N_BODY + 1)).upper()
    return CBF(center).add_error(radius)


pairs = [(QQ, QQ(0), QQ(0)), (QQ, QQ(1), QQ(-1)), (QQ, QQ(3), QQ(5) / 2), (QQ, QQ(-7), QQ(2)),
         (GAUSSIAN, ii, -ii), (GAUSSIAN, 2 - ii, 3 * ii), (GAUSSIAN, -1 + ii / 3, GAUSSIAN(4))]
for F, x0, y0 in pairs:
    left = body_exp_ball(F, x0) * body_exp_ball(F, y0)
    right = body_exp_ball(F, x0 + y0)
    assert left.overlaps(right), (x0, y0)
    assert (left - right).abs().upper() < 2^(-300)
print(f"{len(pairs)} 組の点で、本文の exp の部分和から作ったボールの exp(x)exp(y) と exp(x+y) が重なる（差の上界 < 2^-300）")

# 対照: A = [[0,1],[0,0]]、B = [[0,0],[1,0]] は AB ≠ BA。A^2 = B^2 = 0 なので exp(A) = I + A、exp(B) = I + B は
# 厳密に求まり、(A+B)^2 = I なので exp(A+B) = cosh(1) I + sinh(1)(A+B)。
A = matrix(QQ, [[0, 1], [0, 0]])
B = matrix(QQ, [[0, 0], [1, 0]])
assert A * B != B * A and A^2 == 0 and B^2 == 0 and (A + B)^2 == identity_matrix(QQ, 2)
lhs = (identity_matrix(QQ, 2) + A) * (identity_matrix(QQ, 2) + B)
one = CBF(1)
rhs = [[one.cosh(), one.sinh()], [one.sinh(), one.cosh()]]
assert not CBF(lhs[0, 0]).overlaps(rhs[0][0])
print("対照: 可換でない A, B で exp(A)exp(B) の (1,1) 成分 2 と exp(A+B) の (1,1) 成分 cosh(1) は重ならない")
print("RESULT: PASS")
