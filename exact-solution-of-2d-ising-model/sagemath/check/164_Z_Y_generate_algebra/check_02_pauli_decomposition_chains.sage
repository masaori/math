# 対象ラベル: Z_Y_generate_algebra
# Step 3 の A の展開 A = κ_0 I + κ_x σ^x + κ_y σ^y + κ_z σ^z（κ は def_complex_quotient の商 /2_C）について、
# 準備 (a)〜(g) の鎖と、右辺 R の 4 成分 R_11, R_12, R_21, R_22 の鎖を一行ずつ確かめる。
# 鎖は a11, a12, a21, a22, z, w を不定元にした QQ(i) 上の有理関数体で確かめる。浮動小数点なし。
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
R.<a11, a12, a21, a22, z, w> = PolynomialRing(K0)
F = R.fraction_field()
a11, a12, a21, a22, z, w = [F(t) for t in (a11, a12, a21, a22, z, w)]
one, zero, two, m1 = F(1), F(0), F(2), F(-1)
i = F(I0)
ti = two^-1
neg = lambda x: m1 * x          # multiply_by_minus_one: -x := (-1_C) x
sub = lambda x, y: x + neg(y)   # def_complex_difference: x - y := x + (-y)

# 2_C ∈ C^×: 2_C = (2, 0) の第 1 成分が 2 ≠ 0
check(QQ(2) != 0 and two != 0, "2_C = (2,0) ≠ (0,0)")
check(i * i == m1, "i i = -1_C（i = (0,1) と ℂ の積）")

# (a) (2z)2^{-1} = z
chain_check([(two * z) * ti, (z * two) * ti, z * (two * ti), z * one, z], "準備 (a)")
# (b) z + z = 2z
chain_check([z + z, one * z + one * z, (one + one) * z, two * z], "準備 (b)")
# (c) z + (-z) = 0
chain_check([z + neg(z), z + m1 * z, one * z + m1 * z, (one + m1) * z, F(1 + (-1)) * z, F(0) * z, zero * z, zero], "準備 (c)")
# (d) (z+w) + (z-w) = 2z
chain_check([(z + w) + sub(z, w), (z + w) + (z + neg(w)), z + (w + (z + neg(w))), z + ((w + z) + neg(w)),
             z + ((z + w) + neg(w)), z + (z + (w + neg(w))), z + (z + zero), z + z, two * z], "準備 (d)")
# (e) (z+w) - (z-w) = 2w
chain_check([sub(z + w, sub(z, w)), (z + w) + neg(sub(z, w)), (z + w) + neg(z + neg(w)), (z + w) + m1 * (z + neg(w)),
             (z + w) + (m1 * z + m1 * neg(w)), (z + w) + (neg(z) + m1 * neg(w)), (z + w) + (neg(z) + m1 * (m1 * w)),
             (z + w) + (neg(z) + (m1 * m1) * w), (z + w) + (neg(z) + one * w), (z + w) + (neg(z) + w),
             (w + z) + (neg(z) + w), w + (z + (neg(z) + w)), w + ((z + neg(z)) + w), w + (zero + w), w + w, two * w], "準備 (e)")
# (f) ii = -1, (g) (-i)i = 1
# (f) ℂ = ℝ^2 の組の積で 4 行（definition_of_cc の積 (a,b)(c,d) = (ac - bd, ad + bc)）
def cmul(x, y):
    return (x[0] * y[0] - x[1] * y[1], x[0] * y[1] + x[1] * y[0])
i_pair = (QQ(0), QQ(1))
check(K0(i_pair[0]) + K0(i_pair[1]) * I0 == I0 and F(I0) == i, "準備 (f) の 1 行目: 虚数単位 i は組 (0, 1)")
f_lines = [cmul(i_pair, i_pair), (0 * 0 - 1 * 1, 0 * 1 + 1 * 0), (QQ(-1), QQ(0)), (QQ(-1), QQ(0))]
chain_check(f_lines, "準備 (f)（実数の組）")
check(K0(f_lines[-1][0]) + K0(f_lines[-1][1]) * I0 == K0(-1), "準備 (f) の最後の行は -1_C = (-1, 0)")
check(i * i == m1, "準備 (f) の結論 ii = -1_C を有理関数体で")
chain_check([neg(i) * i, neg(i * i), neg(m1), m1 * m1, one], "準備 (g)")

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
# R_12
u = sub(a12, a21)
chain_check([Rm[0, 1], (((k0 * Id + kx * sx) + ky * sy) + kz * sz)[0, 1], sum_line(0, 1), first_line(0, 1),
    ((k0 * delta(0, 1) + kx * sx[0, 1]) + ky * sy[0, 1]) + kz * sz[0, 1],
    ((k0 * zero + kx * sx[0, 1]) + ky * sy[0, 1]) + kz * sz[0, 1],
    ((k0 * zero + kx * one) + ky * neg(i)) + kz * zero,
    ((zero + kx * one) + ky * neg(i)) + zero,
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
