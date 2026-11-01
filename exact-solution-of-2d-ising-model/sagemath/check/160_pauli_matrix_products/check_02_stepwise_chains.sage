# pauli_matrix_products の証明の各鎖を 1 行ずつ、ガウス有理数体 QQ[i] の厳密計算で確かめる（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
M = MatrixSpace(K, 2, 2)
SX = M([[0, 1], [1, 0]]); SY = M([[0, -i], [i, 0]]); SZ = M([[1, 0], [0, -1]])
def delta(a, b):                       # def_kronecker_delta
    return K(1) if a == b else K(0)
I2 = M([[delta(a, b) for b in range(2)] for a in range(2)])   # def_identity_matrix
assert I2 == identity_matrix(K, 2)
def neg(A):                            # def_matrix_negation: (-A)_{ik} = -A_{ik}
    return M([[-A[r, c] for c in range(2)] for r in range(2)])

# 準備: (-i)·i = -(i·i) = -(-1) = 1、 i·(-i) = (-i)·i = 1
assert (-i)*i == -(i*i) == -(-1) == 1
assert i*(-i) == (-i)*i == 1
print("準備: (-i)·i = 1、i·(-i) = 1")

D = M([[delta(0, 0), delta(0, 1)], [delta(1, 0), delta(1, 1)]])
# σ^xσ^x = I・σ^yσ^y = I・σ^zσ^z = I の 3 つの鎖
assert SX*SX == M([[1, 0], [0, 1]]) == D == I2
assert SY*SY == M([[(-i)*i, 0], [0, i*(-i)]]) == M([[1, 0], [0, 1]]) == D == I2
assert SZ*SZ == M([[1, 0], [0, (-1)*(-1)]]) == M([[1, 0], [0, 1]]) == D == I2
print("σ^xσ^x = σ^yσ^y = σ^zσ^z = I の各行")

# 反可換性の準備: 右辺に現れる積
XZ = SX*SZ; XY = SX*SY; ZY = SZ*SY
assert XZ == M([[0, -1], [1, 0]])
assert XY == M([[i, 0], [0, -i]])
assert ZY == M([[0, -i], [(-1)*i, 0]]) == M([[0, -i], [-i, 0]])
print("準備: σ^xσ^z, σ^xσ^y, σ^zσ^y の成分")

# 左辺から始まる 3 つの鎖（各行の行列が等しいこと）
chain_zx = [SZ*SX, M([[0, 1], [-1, 0]]), M([[-0, 1], [-1, -0]]), M([[-0, -(-1)], [-1, -0]]),
            neg(M([[0, -1], [1, 0]])), neg(XZ)]
chain_yx = [SY*SX, M([[-i, 0], [0, i]]), M([[-i, -0], [-0, i]]), M([[-i, -0], [-0, -(-i)]]),
            neg(M([[i, 0], [0, -i]])), neg(XY)]
chain_yz = [SY*SZ, M([[0, (-i)*(-1)], [i, 0]]), M([[0, i], [i, 0]]), M([[-0, i], [i, -0]]), M([[-0, -(-i)], [-(-i), -0]]),
            neg(M([[0, -i], [-i, 0]])), neg(ZY)]
for name, ch in [("σ^zσ^x = -σ^xσ^z", chain_zx), ("σ^yσ^x = -σ^xσ^y", chain_yx), ("σ^yσ^z = -σ^zσ^y", chain_yz)]:
    assert all(x == ch[0] for x in ch), name
    print(name + " の各行")
# def_matrix_negation の成分の定義が Sage の -A と一致すること
for A in [XZ, XY, ZY]:
    assert neg(A) == -A
# 否定コントロール: 符号反転を落とすと鎖は成り立たない
assert SZ*SX != XZ and SY*SX != XY and SY*SZ != ZY
print("否定コントロール: σ^zσ^x ≠ σ^xσ^z など")
# I は Mat(2, QQ[i]) の元と可換（identity_matrix_is_left/right_unit_of_mat_mult）
for A in [SX, SY, SZ, XZ, M([[1, 2], [3, i]])]:
    assert I2*A == A == A*I2
print("ALL PASS")
