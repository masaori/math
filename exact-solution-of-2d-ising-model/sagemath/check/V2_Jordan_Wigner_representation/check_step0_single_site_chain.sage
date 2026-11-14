# <V2_in_Z_Y>: Step 0 の鎖 σ^zσ^y = -iσ^x を 1 行ずつ、ガウス有理数体 QQ[i] の厳密計算で確かめる（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
M = MatrixSpace(K, 2, 2)
SX = M([[0, 1], [1, 0]]); SY = M([[0, -i], [i, 0]]); SZ = M([[1, 0], [0, -1]])   # def_pauli_matrices
def smul(a, A):                        # def_matrix_scalar_multiple: (aA)_{jk} = a A_{jk}
    return M([[a*A[r, c] for c in range(2)] for r in range(2)])
def mat_mult(A, B):                    # mat_mult: (AB)_{jk} = A_{j1}B_{1k} + A_{j2}B_{2k}
    return M([[A[r, 0]*B[0, c] + A[r, 1]*B[1, c] for c in range(2)] for r in range(2)])
def neg(z):                            # multiply_by_minus_one: -z := (-1)·z
    return K(-1)*z
assert neg(i) == -i
count = 0
def check_chain(name, rows):
    global count
    for k in range(1, len(rows)):
        assert rows[k] == rows[k-1], (name, k)
        count += 1
    print(name + f" の {len(rows)-1} 段")
for A, B in [(SY, SX), (SX, SY), (SZ, SY)]:
    assert mat_mult(A, B) == A*B       # mat_mult の成分の式は Sage の積と一致する
mi = neg(i)
check_chain("σ^zσ^y = -iσ^x", [
    SZ*SY,
    mat_mult(M([[1, 0], [0, -1]]), M([[0, mi], [i, 0]])),
    M([[1*0 + 0*i, 1*mi + 0*0], [0*0 + (-1)*i, 0*mi + (-1)*0]]),
    M([[1*0 + 0, 1*mi + 0], [0 + (-1)*i, 0 + (-1)*0]]),
    M([[1*0 + 0, 1*mi + 0], [(-1)*i, (-1)*0]]),     # complex_zero_plus_is_original（第 2 行の左から足す 0）
    M([[1*0, 1*mi], [(-1)*i, (-1)*0]]),
    M([[0, 1*mi], [(-1)*i, 0]]),
    M([[mi*0, 1*mi], [(-1)*i, mi*0]]),
    M([[mi*0, mi*1], [(-1)*i, mi*0]]),
    M([[mi*0, mi*1], [mi, mi*0]]),
    M([[mi*0, mi*1], [mi*1, mi*0]]),
    smul(mi, M([[0, 1], [1, 0]])),
    smul(mi, SX),
])
for a, A in [(mi, SZ), (i, SZ), (mi, SX), (K(3) + 2*i, M([[1, 2], [i, -1]]))]:
    assert smul(a, A) == a*A           # def_matrix_scalar_multiple の成分の式は Sage のスカラー倍と一致する
# 否定コントロール: スカラーの符号を取り違えると等式は偽
assert SZ*SY != smul(i, SX)
print(f"判定 {count} 段、否定コントロール 1 件")
print("ALL PASS")
