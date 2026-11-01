# nonzero_kernel_iff_det_zero_two_by_two と、それを引く eigenvector_of_A_theta_tilde Step 1 の同値の鎖の検算。
# すべて多項式環 QQ[...] の上の恒等式、または QQ / QQbar の厳密計算で確かめる（浮動小数点は使わない）。

R.<B11, B12, B21, B22, v1, v2, lam> = PolynomialRing(QQ)
B = matrix(R, [[B11, B12], [B21, B22]])
v = vector(R, [v1, v2])
detB = B11*B22 - B12*B21                                   # def_det_two_by_two
assert detB == B.det()
Bv = B * v
assert Bv[0] == B11*v1 + B12*v2 and Bv[1] == B21*v1 + B22*v2   # mat_mult

# (⇒) 第 1 の鎖: 各行が多項式として等しい
chain1 = [
    detB * v1,
    (B11*B22 - B12*B21) * v1,
    B11*B22*v1 - B12*B21*v1,
    B22*B11*v1 - B12*B21*v1,
    B22*B11*v1 - B12*B21*v1 + (B22*B12*v2 - B22*B12*v2),
    B22*B11*v1 - B12*B21*v1 + (B22*B12*v2 - B12*B22*v2),
    B22*B11*v1 + B22*B12*v2 - B12*B21*v1 - B12*B22*v2,
    B22*(B11*v1 + B12*v2) - B12*(B21*v1 + B22*v2),
    B22*Bv[0] - B12*Bv[1],
]
assert all(x == chain1[0] for x in chain1), "chain1"
# (⇒) 第 2 の鎖
chain2 = [
    detB * v2,
    (B11*B22 - B12*B21) * v2,
    B11*B22*v2 - B12*B21*v2,
    B11*B22*v2 - B21*B12*v2,
    B11*B22*v2 - B21*B12*v2 + (B11*B21*v1 - B11*B21*v1),
    B11*B22*v2 - B21*B12*v2 + (B11*B21*v1 - B21*B11*v1),
    B11*B21*v1 + B11*B22*v2 - B21*B11*v1 - B21*B12*v2,
    B11*(B21*v1 + B22*v2) - B21*(B11*v1 + B12*v2),
    B11*Bv[1] - B21*Bv[0],
]
assert all(x == chain2[0] for x in chain2), "chain2"
print("(⇒) 2 本の鎖: 多項式の恒等式として一致")

# (⇐) 1 行目が零でない場合: v = (B12, -B11)
w = B * vector(R, [B12, -B11])
assert w[0] == B11*B12 + B12*(-B11) == B11*B12 - B12*B11 == B11*B12 - B11*B12 == 0
assert w[1] == B21*B12 + B22*(-B11) == B21*B12 - B22*B11 == B12*B21 - B11*B22 == -(B11*B22 - B12*B21) == -detB
# (⇐) 1 行目が零で 2 行目が零でない場合: v = (B22, -B21)
w = B * vector(R, [B22, -B21])
assert w[0] == B11*B22 + B12*(-B21)
assert w[0].subs({B11: 0, B12: 0}) == 0
assert w[1] == B21*B22 + B22*(-B21) == B21*B22 - B22*B21 == B21*B22 - B21*B22 == 0
# (⇐) 1 行目も 2 行目も零の場合: v = (1, 0)
w = B * vector(R, [1, 0])
assert w[0] == B11 and w[1] == B21
print("(⇐) 3 つの場合の成分の鎖: 一致（1 行目が零でない場合の第 2 成分は -det B）")

# 否定コントロール: 1 行目が零でない場合に v = (B12, B11)（符号を落とす）にすると第 1 成分が 0 にならない
w_bad = B * vector(R, [B12, B11])
assert w_bad[0] != 0
print("否定コントロール: v = (B12, B11) では (Bv)_1 =", w_bad[0], "≠ 0")

# 同値そのものを ZZ の小さな成分の全数で確かめる: 成分 ∈ {-2..2} の 2×2 行列 625 個
import itertools
count = 0
for e in itertools.product(range(-2, 3), repeat=4):
    M = matrix(QQ, 2, 2, list(e))
    has_kernel = M.right_kernel().dimension() > 0
    assert has_kernel == (M[0,0]*M[1,1] - M[0,1]*M[1,0] == 0)
    count += 1
print("全数検査:", count, "個の行列で「0 でない核 ⟺ det = 0」")

# eigenvector_of_A_theta_tilde Step 1 の同値の鎖: A v = λ v ⟺ A v - λ v = 0 ⟺ A v - λ (I v) = 0 ⟺ (A - λI) v = 0
A = B
I2 = identity_matrix(R, 2)
assert A*v - lam*v == A*v - lam*(I2*v) == A*v - (lam*I2)*v == (A - lam*I2)*v
print("Step 1 の同値の鎖: Av - λv = Av - λ(Iv) = Av - (λI)v = (A - λI)v（ベクトルの恒等式）")

# 具体例: 固有値の集合と det(A - λI) = 0 の根の一致（QQbar の厳密計算）
for Aex in [matrix(QQ, [[1, 2], [3, 4]]), matrix(QQ, [[2, 0], [0, 2]]), matrix(QQ, [[0, 1], [0, 0]]), matrix(QQ, [[1, -1], [1, 1]])]:
    S.<x> = QQbar[]
    p = (Aex.change_ring(QQbar) - x*identity_matrix(QQbar, 2)).det()
    roots = set(r for r, _ in p.roots())
    eig = set(Aex.change_ring(QQbar).eigenvalues())
    assert roots == eig
    for r in roots:
        assert (Aex.change_ring(QQbar) - r*identity_matrix(QQbar, 2)).right_kernel().dimension() > 0
print("具体例 4 個: det(A - λI) = 0 の根 = 固有値（QQbar）")
print("ALL PASS")
