# 対象ラベル: diagonalization_check_P_D
# Step 4 の 4 行の鎖
#   A(θ~_μ) = A(θ~_μ) I = A(θ~_μ)(P̌_μ P̌_μ^{-1}) = (A(θ~_μ) P̌_μ) P̌_μ^{-1} = (P̌_μ Ď_μ) P̌_μ^{-1}
# を一行ずつ確かめる。
#   (a) 一般の点: A・P̌ の成分を不定元にした QQ(i) 上の有理関数体で、1〜3 行目の等号
#       （identity_matrix_is_right_unit_of_mat_mult・def_invertible_elements_of_R の g g^{-1} = I・mat_mult_associative）。
#       P̌^{-1} は det ≠ 0 の 2×2 行列の逆元（P̌ P̌^{-1} = P̌^{-1} P̌ = I を確かめてから使う）。
#   (b) 実際の値: e^{2K_1}, e^{2K_2} を有理数に取ると c_1, s_1, c_2, s_2, c_2^*, s_2^* は有理数になり、
#       e^{iθ~_μ} = ζ_{2M}^{2μ-1} は QQbar の元なので、A(θ~_μ)・P̌_μ・Ď_μ は QQbar で厳密に書ける。
#       4 行目（Step 2 の A P̌ = P̌ Ď）を含む全行の等号を確かめる（最後の辺と P̌ Ď P̌^{-1} の比較は左結合の読みの確認だけ）。
#   否定の対照: P̌^{-1} Ď P̌ ≠ A(θ~_μ)、A(θ~_μ) P̌ ≠ Ď P̌（積の順序を変えると成り立たない）。浮動小数点なし。

n_check = 0
n_fail = 0
def check(ok, label):
    global n_check, n_fail
    n_check += 1
    if not ok:
        n_fail += 1
    print(("PASS " if ok else "FAIL ") + label)

def chain_check(lines, name):
    for k in range(len(lines) - 1):
        check(lines[k] == lines[k + 1], f"{name} 第 {k+1} 行 = 第 {k+2} 行")

# ---- (a) 一般の点 ----
K0.<I0> = QuadraticField(-1)
Rg = PolynomialRing(K0, 'a11,a12,a21,a22,p11,p12,p21,p22')
Fg = Rg.fraction_field()
a11, a12, a21, a22, p11, p12, p21, p22 = [Fg(x) for x in Rg.gens()]
Ag = matrix(Fg, [[a11, a12], [a21, a22]])
Pg = matrix(Fg, [[p11, p12], [p21, p22]])
Ig = identity_matrix(Fg, 2)
detg = Pg.det()
check(detg != 0, "(a) 一般の点で det P̌ ≠ 0")
Pinv_g = detg^-1 * matrix(Fg, [[p22, -p12], [-p21, p11]])
check(Pg * Pinv_g == Ig and Pinv_g * Pg == Ig, "(a) P̌ P̌^{-1} = I かつ P̌^{-1} P̌ = I（def_invertible_elements_of_R の逆元）")
chain_check([Ag, Ag * Ig, Ag * (Pg * Pinv_g), (Ag * Pg) * Pinv_g], "(a) 一般の点の 1〜3 行目")

# ---- (b) 実際の値 ----
def hyp(x):
    """e^{2K} = x（有理数）のときの (cosh 2K, sinh 2K)"""
    return (x + 1 / x) / 2, (x - 1 / x) / 2

def data(x1, y2, M, mu):
    c1, s1 = hyp(QQ(x1))
    c2, s2 = hyp(QQ(y2))
    c2s, s2s = hyp((QQ(y2) + 1) / (QQ(y2) - 1))    # tanh K_2^* = e^{-2K_2}
    z = QQbar.zeta(2 * M) ^ (2 * mu - 1)             # e^{iθ~_μ}
    I = QQbar.gen()
    cs = (z + z^-1) / 2
    sn = (z - z^-1) / (2 * I)
    g1 = QQbar(c1 * c2s) - QQbar(s1 * s2s) * cs
    def g2(zz, cc, ss):
        return I * zz * QQbar(s2s) * (QQbar(c1) * cc - I * ss - QQbar(s1 * c2))
    a = g2(z, cs, sn)
    b = g2(z^-1, cs, -sn)
    r = QQbar(AA(a * a.conjugate()).sqrt())
    sm = QQbar(AA(M).sqrt())
    A = matrix(QQbar, [[g1, a], [-b, g1]])
    P = matrix(QQbar, [[-r / (2 * sm * b), r / (2 * sm * b)], [1 / (2 * sm), 1 / (2 * sm)]])
    D = matrix(QQbar, [[g1 + r, 0], [0, g1 - r]])
    return A, P, D

for (x1, y2) in [(3, 2), (2, 5)]:
    for M in [2, 3, 4]:
        for mu in range(1, M + 1):
            A, P, D = data(x1, y2, M, mu)
            I2 = identity_matrix(QQbar, 2)
            tag = f"(b) e^(2K1)={x1}, e^(2K2)={y2}, M_col={M}, μ={mu}"
            check(P.det() != 0, tag + ": det P̌ ≠ 0")
            Pinv = P.inverse()
            check(P * Pinv == I2 and Pinv * P == I2, tag + ": P̌ P̌^{-1} = I かつ P̌^{-1} P̌ = I")
            lines = [A, A * I2, A * (P * Pinv), (A * P) * Pinv, (P * D) * Pinv]
            chain_check(lines, tag + " の鎖")
            check(lines[-1] == P * D * Pinv, tag + ": 最後の辺 (P̌Ď)P̌^{-1} と Sage の左結合の積 P̌*Ď*P̌^{-1} が同じ式（読み方の確認で、新しい数学的内容は無い）")
            check(Pinv * D * P != A, tag + ": 否定の対照 P̌^{-1} Ď P̌ ≠ A")
            check(A * P != D * P, tag + ": 否定の対照 A P̌ ≠ Ď P̌")

print(f"-- diagonalization_check_P_D の Step 4 の鎖: {n_check - n_fail}/{n_check} PASS")
print("RESULT: " + ("PASS" if n_fail == 0 else "FAIL"))
