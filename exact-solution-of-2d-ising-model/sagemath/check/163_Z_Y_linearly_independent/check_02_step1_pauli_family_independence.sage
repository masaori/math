# 対象ラベル: Z_Y_linearly_independent
# Step 1 の「𝓑 = {I, σ^x, σ^y, σ^z} は線型独立」を成分の比較で示す鎖を一行ずつ確かめる。
# (1) L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z（和は左から結ぶ）の L_11, L_12, L_21, L_22 の鎖
#     （L の定義・def_matrix_sum・def_matrix_scalar_multiple・def_identity_matrix・def_kronecker_delta・
#      def_pauli_matrices の成分・complex_times_zero_is_zero・加法の単位元・積の単位元・積の可換律・
#      negative_i_times_complex_is_negation_of_i_times・multiply_by_minus_one・def_complex_difference）。
#     c_0, c_x, c_y, c_z を不定元にした QQ(i) 上の多項式環の行列で、和・スカラー倍・成分を別々に組む。
# (2) L = O から (p) c_0 + c_z = 0、(q) c_x − ic_y = 0、(r) c_x + ic_y = 0、(s) c_0 − c_z = 0 の各 3 行の鎖。
# (3) c_0, c_z, c_x, ic_y, c_y が零になる 5 本の鎖（twice_times_inverse_of_two_is_original_in_cc・
#     sum_plus_difference_is_twice_first_in_cc・sum_minus_difference_is_twice_second_in_cc・加法の可換律・
#     negation_plus_self_is_zero_in_cc・negative_i_times_i_is_one_in_cc を引く）。仮定を使う行は、前の行で仮定の左辺の式を 0_C に置いた形が
#     後の行であることを恒等式で確かめ、使う仮定を他の仮定に取り替えると移れないことを否定の対照にする。
# 浮動小数点なし。
import sys

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

K0.<I0> = QuadraticField(-1)
R.<c0, cx, cy, cz> = PolynomialRing(K0)
F = R.fraction_field()
c0, cx, cy, cz = [F(t) for t in (c0, cx, cy, cz)]
one, zero, two, m1 = F(1), F(0), F(2), F(-1)
i = F(I0)
ti = two^-1
neg = lambda x: m1 * x          # multiply_by_minus_one: -x := (-1_C) x
sub = lambda x, y: x + neg(y)   # def_complex_difference: x - y := x + (-y)

def delta(a, b):                # def_kronecker_delta
    return one if a == b else zero
Id = matrix(F, 2, 2, lambda a, b: delta(a, b))    # def_identity_matrix
sx = matrix(F, [[0, 1], [1, 0]])                   # def_pauli_matrices
sy = matrix(F, [[0, neg(i)], [i, 0]])
sz = matrix(F, [[1, 0], [0, m1]])
check(sx * sx == Id and sy * sy == Id and sz * sz == Id, "引いた Pauli 行列は pauli_matrix_products の二乗の式を満たす")

def msum(A, B):                 # def_matrix_sum（成分ごと）
    return matrix(F, 2, 2, lambda a, b: A[a, b] + B[a, b])
def msmul(c, A):                # def_matrix_scalar_multiple（成分ごと）
    return matrix(F, 2, 2, lambda a, b: c * A[a, b])

L = msum(msum(msum(msmul(c0, Id), msmul(cx, sx)), msmul(cy, sy)), msmul(cz, sz))
check(L == c0 * Id + cx * sx + cy * sy + cz * sz, "L の定義: 成分ごとの和・スカラー倍で組んだ L が Sage の行列演算と一致")

# (1) 4 成分の鎖（人手の添字 1, 2 は Sage の 0, 1）
def entry_chain(p, q, name, tail):
    lines = [
        L[p, q],
        ((msmul(c0, Id)[p, q] + msmul(cx, sx)[p, q]) + msmul(cy, sy)[p, q]) + msmul(cz, sz)[p, q],
        ((c0 * Id[p, q] + cx * sx[p, q]) + cy * sy[p, q]) + cz * sz[p, q],
        ((c0 * delta(p, q) + cx * sx[p, q]) + cy * sy[p, q]) + cz * sz[p, q],
    ]
    lines += tail
    chain_check(lines, name)

entry_chain(0, 0, "L_11", [
    ((c0 * one + cx * sx[0, 0]) + cy * sy[0, 0]) + cz * sz[0, 0],
    ((c0 * one + cx * zero) + cy * zero) + cz * one,
    ((c0 * one + zero) + zero) + cz * one,
    c0 * one + cz * one,
    c0 + cz,
])
entry_chain(0, 1, "L_12", [
    ((c0 * zero + cx * sx[0, 1]) + cy * sy[0, 1]) + cz * sz[0, 1],
    ((c0 * zero + cx * one) + cy * neg(i)) + cz * zero,
    ((zero + cx * one) + cy * neg(i)) + zero,
    cx * one + cy * neg(i),
    cx + cy * neg(i),
    cx + neg(i) * cy,
    cx + neg(i * cy),
    sub(cx, i * cy),
])
entry_chain(1, 0, "L_21", [
    ((c0 * zero + cx * sx[1, 0]) + cy * sy[1, 0]) + cz * sz[1, 0],
    ((c0 * zero + cx * one) + cy * i) + cz * zero,
    ((zero + cx * one) + cy * i) + zero,
    cx * one + cy * i,
    cx + cy * i,
    cx + i * cy,
])
entry_chain(1, 1, "L_22", [
    ((c0 * one + cx * sx[1, 1]) + cy * sy[1, 1]) + cz * sz[1, 1],
    ((c0 * one + cx * zero) + cy * zero) + cz * m1,
    ((c0 * one + zero) + zero) + cz * m1,
    c0 * one + cz * m1,
    c0 + cz * m1,
    c0 + m1 * cz,
    c0 + neg(cz),
    sub(c0, cz),
])
check(sy[0, 1] == neg(i) and sy[1, 0] == i and sz[1, 1] == m1, "根拠の成分: (σ^y)_12 = -i、(σ^y)_21 = i、(σ^z)_22 = -1_C")
check(neg(i) * cy == neg(i * cy), "根拠: negative_i_times_complex_is_negation_of_i_times（z → c_y）")

# (2) L = O の成分の比較: O の成分は 0_C（def_zero_matrix）
O = matrix(F, 2, 2, lambda a, b: zero)
check(all(O[a, b] == zero for a in range(2) for b in range(2)), "def_zero_matrix: O の 4 成分は 0_C")
# 不定元の 4 つの式 (p)〜(s) が全て零になる係数は (0,0,0,0) だけ: 連立一次方程式の係数行列が正則
A = matrix(K0, [[1, 0, 0, 1], [0, 1, -I0, 0], [0, 1, I0, 0], [1, 0, 0, -1]])  # (p),(q),(r),(s) の係数（列は c0,cx,cy,cz）
check(A.det() != 0, "(p)〜(s) の係数行列は正則（解は零だけ）")
check([L[0, 0], L[0, 1], L[1, 0], L[1, 1]] == [c0 + cz, sub(cx, i * cy), cx + i * cy, sub(c0, cz)],
      "(p)(q)(r)(s) の左辺は L_11, L_12, L_21, L_22")

# (2') (p)〜(s) の 3 行の鎖: L_ij の鎖を右辺から左辺へ（不定元のまま）→ L = O の仮定で O_ij → def_zero_matrix で 0_C
for tag, lhs, (pp, qq) in [("p", c0 + cz, (0, 0)), ("q", sub(cx, i * cy), (0, 1)),
                           ("r", cx + i * cy, (1, 0)), ("s", sub(c0, cz), (1, 1))]:
    check(lhs == L[pp, qq], f"({tag}) の 1 行目 = 2 行目: L_ij の鎖を右辺から左辺へ")
    check(O[pp, qq] == zero, f"({tag}) の 3 行目: def_zero_matrix")

# (3) 係数が零になる 5 本の鎖。仮定 h を使う行は、前の行で h の左辺の式を 0_C に置いた形が後の行であることを、
#     「前の行 = 後の行 + (h の左辺)×(係数)」の恒等式で確かめる（係数は 2_C^{-1}、差の引く側なら -2_C^{-1}、c_y の行は -i）。
#     否定の対照として、使う仮定の左辺を他の仮定の左辺に取り替えると恒等式が成り立たないことを、全ての取り替えで見る。
P, Q, Rr, S = c0 + cz, sub(cx, i * cy), cx + i * cy, sub(c0, cz)
hyps = dict(p=P, q=Q, r=Rr, s=S, iy=i * cy)
def hyp_step(before, after, h, coeff, name):
    check(before == after + hyps[h] * coeff, f"{name}: 仮定 ({h}) の左辺を 0_C に置く行")
    for other in hyps:
        if other != h:
            check(before != after + hyps[other] * coeff, f"{name}: 否定の対照 ({h}) を ({other}) に取り替えると移れない")

chain_check([c0, (two * c0) * ti, (P + S) * ti], "c_0 = 0_C（仮定の前）")
hyp_step((P + S) * ti, (zero + S) * ti, "p", ti, "c_0 = 0_C")
hyp_step((zero + S) * ti, (zero + zero) * ti, "s", ti, "c_0 = 0_C")
chain_check([(zero + zero) * ti, zero * ti, zero], "c_0 = 0_C（仮定の後）")
chain_check([cz, (two * cz) * ti, sub(P, S) * ti], "c_z = 0_C（仮定の前）")
hyp_step(sub(P, S) * ti, sub(zero, S) * ti, "p", ti, "c_z = 0_C")
hyp_step(sub(zero, S) * ti, sub(zero, zero) * ti, "s", -ti, "c_z = 0_C")
chain_check([sub(zero, zero) * ti, (zero + neg(zero)) * ti, (neg(zero) + zero) * ti, zero * ti, zero], "c_z = 0_C（仮定の後）")
chain_check([cx, (two * cx) * ti, (Rr + Q) * ti], "c_x = 0_C（仮定の前）")
hyp_step((Rr + Q) * ti, (zero + Q) * ti, "r", ti, "c_x = 0_C")
hyp_step((zero + Q) * ti, (zero + zero) * ti, "q", ti, "c_x = 0_C")
chain_check([(zero + zero) * ti, zero * ti, zero], "c_x = 0_C（仮定の後）")
chain_check([i * cy, (two * (i * cy)) * ti, sub(Rr, Q) * ti], "ic_y = 0_C（仮定の前）")
hyp_step(sub(Rr, Q) * ti, sub(zero, Q) * ti, "r", ti, "ic_y = 0_C")
hyp_step(sub(zero, Q) * ti, sub(zero, zero) * ti, "q", -ti, "ic_y = 0_C")
chain_check([sub(zero, zero) * ti, (zero + neg(zero)) * ti, (neg(zero) + zero) * ti, zero * ti, zero], "ic_y = 0_C（仮定の後）")
chain_check([cy, one * cy, (neg(i) * i) * cy, neg(i) * (i * cy)], "c_y = 0_C（仮定の前）")
hyp_step(neg(i) * (i * cy), neg(i) * zero, "iy", neg(i), "c_y = 0_C")
chain_check([neg(i) * zero, zero], "c_y = 0_C（仮定の後）")
check(neg(i) * i == one, "根拠 negative_i_times_i_is_one_in_cc: (-i)i = 1_C")
# 係数が零になる鎖が引く主張の当てはめ（文字の置き換えどおり）
for z in (c0, cz, cx, i * cy):
    check((two * z) * ti == z, "根拠 twice_times_inverse_of_two_is_original_in_cc（z → c_0, c_z, c_x, ic_y）")
for a, b in ((c0, cz), (cx, i * cy)):
    check((a + b) + sub(a, b) == two * a, "根拠 sum_plus_difference_is_twice_first_in_cc（a, b の置き換え）")
    check(sub(a + b, sub(a, b)) == two * b, "根拠 sum_minus_difference_is_twice_second_in_cc（a, b の置き換え）")
check(neg(zero) + zero == zero, "根拠 negation_plus_self_is_zero_in_cc（x → 0_C）")

# 否定の対照
check(L[0, 1] != cx + i * cy, "否定の対照: L_12 の符号を + にすると成り立たない（(σ^y)_12 = -i）")
check(L[1, 1] != c0 + cz, "否定の対照: (σ^z)_22 を 1 と読むと L_22 は c_0 + c_z にならない")
check(cz != ((c0 + cz) + sub(c0, cz)) * ti, "否定の対照: c_z の鎖で sum_minus_difference_is_twice_second_in_cc の代わりに sum_plus_difference_is_twice_first_in_cc を使うと成り立たない")
B2 = matrix(K0, [[1, 0, 0, 1], [0, 1, I0, 0], [0, 1, I0, 0], [1, 0, 0, -1]])
check(B2.det() == 0, "否定の対照: (q) の -i を i と読み違えると係数行列は退化し、零以外の解が残る")

print(f"-- Z_Y_linearly_independent の Step 1 の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
