# 対象ラベル: Z_Y_generate_algebra
# Step 3 の A の展開 A = κ_0 I + κ_x σ^x + κ_y σ^y + κ_z σ^z（κ は def_complex_quotient の商 /2_C）について、
# 右辺 R の 4 成分 R_11, R_12, R_21, R_22 の鎖を一行ずつ確かめ、鎖が引く計算公式の章の主張
# （twice_times_inverse_of_two_is_original_in_cc・sum_plus_difference_is_twice_first_in_cc・
#  sum_minus_difference_is_twice_second_in_cc・i_times_i_is_minus_one_in_cc・negative_i_times_i_is_one_in_cc）の
# 当てはめ（文字の置き換えどおり）を確かめる。主張そのものの鎖は各主張の検算が確かめる。
# 鎖は a11, a12, a21, a22 を不定元にした QQ(i) 上の有理関数体で確かめる。浮動小数点なし。
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
R.<a11, a12, a21, a22> = PolynomialRing(K0)
F = R.fraction_field()
a11, a12, a21, a22 = [F(t) for t in (a11, a12, a21, a22)]
one, zero, two, m1 = F(1), F(0), F(2), F(-1)
i = F(I0)
ti = two^-1
neg = lambda x: m1 * x          # multiply_by_minus_one: -x := (-1_C) x
sub = lambda x, y: x + neg(y)   # def_complex_difference: x - y := x + (-y)

# 2_C ∈ C^×: 2_C = (2, 0) の第 1 成分が 2 ≠ 0
check(QQ(2) != 0 and two != 0, "2_C = (2,0) ≠ (0,0)")

# 成分の鎖が引く主張の当てはめ（文字の置き換えどおり）
for x in (a11, a12, a21, a22):
    check((two * x) * ti == x, f"根拠 twice_times_inverse_of_two_is_original_in_cc（z → {x}）")
for (a, b) in ((a11, a22), (a12, a21)):
    check((a + b) + sub(a, b) == two * a, f"根拠 sum_plus_difference_is_twice_first_in_cc（a → {a}, b → {b}）")
    check(sub(a + b, sub(a, b)) == two * b, f"根拠 sum_minus_difference_is_twice_second_in_cc（a → {a}, b → {b}）")
check(i * i == m1, "根拠 i_times_i_is_minus_one_in_cc: ii = -1_C（R_21 の鎖）")
check(neg(i) * i == one, "根拠 negative_i_times_i_is_one_in_cc: (-i)i = 1_C（R_12 の鎖）")

# 係数（def_complex_quotient の商 /2_C）と行列
k0 = (a11 + a22) / two
kx = (a12 + a21) / two
ky = (i * sub(a12, a21)) / two
kz = sub(a11, a22) / two
MS = MatrixSpace(F, 2, 2)
Id = MS.identity_matrix()
sx = MS([[0, 1], [1, 0]])
sy = MS([[0, -i], [i, 0]])
sz = MS([[1, 0], [0, -1]])
A = MS([[a11, a12], [a21, a22]])
Rm = ((k0 * Id + kx * sx) + ky * sy) + kz * sz
delta = lambda p, q: one if p == q else zero

def first_line(p, q):
    return ((k0 * Id[p, q] + kx * sx[p, q]) + ky * sy[p, q]) + kz * sz[p, q]

def sum_line(p, q):
    return (((k0 * Id)[p, q] + (kx * sx)[p, q]) + (ky * sy)[p, q]) + (kz * sz)[p, q]

for (p, q) in [(0, 0), (0, 1), (1, 0), (1, 1)]:
    check(Rm[p, q] == first_line(p, q), f"R_{p+1}{q+1} の def_matrix_scalar_multiple の行（R の定義・def_matrix_sum の行の先）")
    check(Id[p, q] == delta(p, q), f"I_{p+1}{q+1} = δ_{p+1}{q+1}（def_identity_matrix・def_kronecker_delta）")

# R_11
chain_check([Rm[0, 0], (((k0 * Id + kx * sx) + ky * sy) + kz * sz)[0, 0], sum_line(0, 0), first_line(0, 0),
    ((k0 * delta(0, 0) + kx * sx[0, 0]) + ky * sy[0, 0]) + kz * sz[0, 0],
    ((k0 * one + kx * sx[0, 0]) + ky * sy[0, 0]) + kz * sz[0, 0],
    ((k0 * one + kx * zero) + ky * zero) + kz * one,
    ((k0 * one + zero) + zero) + kz * one,
    k0 * one + kz * one, k0 + kz,
    (a11 + a22) / two + sub(a11, a22) / two,
    (a11 + a22) * ti + sub(a11, a22) * ti,
    ((a11 + a22) + sub(a11, a22)) * ti,
    (two * a11) * ti, a11], "R_11 の鎖")
# R_12・R_21 の鎖の加法の単位元の 2 行: 右から足す 0_C を消す行（complex_numbers_form_a_field の z + 0_C = z）と、
# 左から足す 0_C を消す行（complex_zero_plus_is_original の 0_C + z = z、z → κ_x 1_C）
for kyv in (ky * neg(i), ky * i):
    check(((zero + kx * one) + kyv) + zero == (zero + kx * one) + kyv, "根拠 加法の単位元 z + 0_C = z（R_12・R_21 の鎖）")
    check(zero + kx * one == kx * one, "根拠 complex_zero_plus_is_original（z → κ_x 1_C。R_12・R_21 の鎖）")

# R_12
u = sub(a12, a21)
chain_check([Rm[0, 1], (((k0 * Id + kx * sx) + ky * sy) + kz * sz)[0, 1], sum_line(0, 1), first_line(0, 1),
    ((k0 * delta(0, 1) + kx * sx[0, 1]) + ky * sy[0, 1]) + kz * sz[0, 1],
    ((k0 * zero + kx * sx[0, 1]) + ky * sy[0, 1]) + kz * sz[0, 1],
    ((k0 * zero + kx * one) + ky * neg(i)) + kz * zero,
    ((zero + kx * one) + ky * neg(i)) + zero,
    (zero + kx * one) + ky * neg(i),
    kx * one + ky * neg(i), kx + ky * neg(i),
    (a12 + a21) / two + ((i * u) / two) * neg(i),
    (a12 + a21) * ti + ((i * u) * ti) * neg(i),
    (a12 + a21) * ti + neg(i) * ((i * u) * ti),
    (a12 + a21) * ti + (neg(i) * (i * u)) * ti,
    (a12 + a21) * ti + ((neg(i) * i) * u) * ti,
    (a12 + a21) * ti + (one * u) * ti,
    (a12 + a21) * ti + u * ti,
    ((a12 + a21) + u) * ti,
    (two * a12) * ti, a12], "R_12 の鎖")
# R_21
chain_check([Rm[1, 0], (((k0 * Id + kx * sx) + ky * sy) + kz * sz)[1, 0], sum_line(1, 0), first_line(1, 0),
    ((k0 * delta(1, 0) + kx * sx[1, 0]) + ky * sy[1, 0]) + kz * sz[1, 0],
    ((k0 * zero + kx * sx[1, 0]) + ky * sy[1, 0]) + kz * sz[1, 0],
    ((k0 * zero + kx * one) + ky * i) + kz * zero,
    ((zero + kx * one) + ky * i) + zero,
    (zero + kx * one) + ky * i,
    kx * one + ky * i, kx + ky * i,
    (a12 + a21) / two + ((i * u) / two) * i,
    (a12 + a21) * ti + ((i * u) * ti) * i,
    (a12 + a21) * ti + i * ((i * u) * ti),
    (a12 + a21) * ti + (i * (i * u)) * ti,
    (a12 + a21) * ti + ((i * i) * u) * ti,
    (a12 + a21) * ti + (m1 * u) * ti,
    (a12 + a21) * ti + neg(u) * ti,
    ((a12 + a21) + neg(u)) * ti,
    sub(a12 + a21, u) * ti,
    (two * a21) * ti, a21], "R_21 の鎖")
# R_22
v = sub(a11, a22)
chain_check([Rm[1, 1], (((k0 * Id + kx * sx) + ky * sy) + kz * sz)[1, 1], sum_line(1, 1), first_line(1, 1),
    ((k0 * delta(1, 1) + kx * sx[1, 1]) + ky * sy[1, 1]) + kz * sz[1, 1],
    ((k0 * one + kx * sx[1, 1]) + ky * sy[1, 1]) + kz * sz[1, 1],
    ((k0 * one + kx * zero) + ky * zero) + kz * m1,
    ((k0 * one + zero) + zero) + kz * m1,
    k0 * one + kz * m1, k0 + kz * m1, k0 + m1 * kz,
    (a11 + a22) / two + m1 * (v / two),
    (a11 + a22) * ti + m1 * (v * ti),
    (a11 + a22) * ti + (m1 * v) * ti,
    (a11 + a22) * ti + neg(v) * ti,
    ((a11 + a22) + neg(v)) * ti,
    sub(a11 + a22, v) * ti,
    (two * a22) * ti, a22], "R_22 の鎖")

check(Rm == A, "R = A（4 成分が等しい）")

# 否定の対照: 分母の 2 を落とす・σ^y の係数の i を落とす・σ^z の係数の符号を逆にする
check(((a11 + a22) * Id + kx * sx + ky * sy + kz * sz) != A, "否定の対照: κ_0 の /2_C を落とすと A にならない")
check((k0 * Id + kx * sx + (u / two) * sy + kz * sz) != A, "否定の対照: κ_y の i を落とすと A にならない")
check((k0 * Id + kx * sx + ky * sy + (sub(a22, a11) / two) * sz) != A, "否定の対照: κ_z の符号を逆にすると A にならない")

print(f"-- Z_Y_generate_algebra の Step 3 の展開の鎖: {n_check - n_fail}/{n_check} PASS")
if n_fail:
    print("RESULT: FAIL")
    sys.exit(1)
print("RESULT: PASS")
