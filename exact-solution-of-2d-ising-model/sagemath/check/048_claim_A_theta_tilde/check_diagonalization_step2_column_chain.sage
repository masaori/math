# 対象ラベル: diagonalization_check_P_D
# Step 2 の 6 行の鎖
#   A P̌ = A[v_+ v_-] = [A v_+  A v_-] = [λ_+ v_+  λ_- v_-] = [(Ď)_11 v_+  (Ď)_22 v_-] = [v_+ v_-] Ď = P̌ Ď
# （P̌ = [v_+ v_-]・mat_columnwise・eigenvector_of_A_theta_tilde・Ď の定義・column_matrix_times_diagonal_matrix_scales_columns・P̌ = [v_+ v_-]）
# と前置き（P̌ = [v_+ v_-]、Ď は対角行列で (Ď)_11 = λ_+、(Ď)_22 = λ_-）を一行ずつ確かめる。
#   (a) 一般の点: A = [[g, a], [-b, g]]、ab = -s^2 を満たすよう b := -s^2/a と置き、v_± = c(∓s, b)、λ_± = g ± s とした
#       QQ(i) 上の有理関数体 QQ(i)(g, a, s, c)。
#   (b) 実際の値: check_08 と同じく e^{2K_1}, e^{2K_2} を有理数、e^{iθ~_μ} = ζ_{2M}^{2μ-1} とした QQbar の厳密値（M_col = 2..4、全 μ）。
#       v_± は c(∓r_ℂ, b)（c = 1/(2√M b)）で作り、P̌ は statement の成分の式で別に作る。
#   否定の対照: 列を入れ替えた [v_- v_+] Ď ≠ A[v_- v_+]（対角成分の並びと列の並びが合わないと成り立たない）。浮動小数点なし。

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

def cols(F, u, w):
    """mat_columnwise の列に並べた行列 [u w]（第 k 列の第 j 成分が (b_k)_j）"""
    return matrix(F, 2, 2, lambda j, k: [u, w][k][j])

def run(F, A, P, D, vp, vm, lp, lm, tag):
    check(P == cols(F, vp, vm), tag + ": 前置き P̌ = [v_+ v_-]")
    check(D[0, 1] == 0 and D[1, 0] == 0 and D[0, 0] == lp and D[1, 1] == lm,
          tag + ": 前置き Ď は対角行列で (Ď)_11 = λ_+、(Ď)_22 = λ_-")
    check(A * vp == lp * vp and A * vm == lm * vm, tag + ": eigenvector_of_A_theta_tilde（A v_± = λ_± v_±）")
    lines = [A * P,
             A * cols(F, vp, vm),
             cols(F, A * vp, A * vm),
             cols(F, lp * vp, lm * vm),
             cols(F, D[0, 0] * vp, D[1, 1] * vm),
             cols(F, vp, vm) * D,
             P * D]
    chain_check(lines, tag + " の鎖")
    check(cols(F, vm, vp) * D != A * cols(F, vm, vp), tag + ": 否定の対照 [v_- v_+] Ď ≠ A[v_- v_+]")

# ---- (a) 一般の点 ----
K0.<I0> = QuadraticField(-1)
Rg = PolynomialRing(K0, 'g,a,s,c')
Fg = Rg.fraction_field()
g, a, s, c = [Fg(x) for x in Rg.gens()]
b = -s^2 / a                                         # ab = -s^2（relation_of_gamma_2_theta_tilde (2) の形）
Ag = matrix(Fg, [[g, a], [-b, g]])
vp = c * vector(Fg, [-s, b])
vm = c * vector(Fg, [s, b])
Pg = matrix(Fg, [[-c * s, c * s], [c * b, c * b]])   # 成分の式で別に作る
Dg = matrix(Fg, [[g + s, 0], [0, g - s]])
run(Fg, Ag, Pg, Dg, vp, vm, g + s, g - s, "(a) 一般の点")

# ---- (b) 実際の値 ----
def hyp(x):
    return (x + 1 / x) / 2, (x - 1 / x) / 2

for (x1, y2) in [(3, 2), (2, 5)]:
    for M in [2, 3, 4]:
        for mu in range(1, M + 1):
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
            a_ = g2(z, cs, sn)
            b_ = g2(z^-1, cs, -sn)
            r = QQbar(AA(a_ * a_.conjugate()).sqrt())
            sm = QQbar(AA(M).sqrt())
            cc_ = 1 / (2 * sm * b_)
            A = matrix(QQbar, [[g1, a_], [-b_, g1]])
            P = matrix(QQbar, [[-r / (2 * sm * b_), r / (2 * sm * b_)], [1 / (2 * sm), 1 / (2 * sm)]])
            D = matrix(QQbar, [[g1 + r, 0], [0, g1 - r]])
            vp_ = cc_ * vector(QQbar, [-r, b_])
            vm_ = cc_ * vector(QQbar, [r, b_])
            run(QQbar, A, P, D, vp_, vm_, g1 + r, g1 - r, f"(b) e^(2K1)={x1}, e^(2K2)={y2}, M_col={M}, μ={mu}")

print(f"-- diagonalization_check_P_D の Step 2 の鎖: {n_check - n_fail}/{n_check} PASS")
print("RESULT: " + ("PASS" if n_fail == 0 else "FAIL"))
