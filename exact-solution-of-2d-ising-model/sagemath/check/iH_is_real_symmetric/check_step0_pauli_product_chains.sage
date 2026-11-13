# 対象ラベル: iH_is_real_symmetric
# Step 0 の準備の 2 本（(-i)·i = 1、(-i)·(-i) = -1）と、3 本の 2×2 の積の鎖
#   σ^zσ^y = (-i)σ^x、σ^yσ^x = (-i)σ^z、σ^xσ^z = (-i)σ^y
# を 1 行ずつ、ガウス有理数体 QQ[i] の厳密計算で確かめる（浮動小数点は使わない）。
# mat_mult と def_matrix_scalar_multiple は成分の式どおりに組み、Sage の積・スカラー倍（独立な経路）とも比べる。
# ℂ の事実を 1 つずつ使う行（0·z = 0 など）は、Sage が成分をその場で評価するので構成上かならず一致する
# （写し間違いの検出は、各行の行列を本文の字面どおりに書くことと、鎖の両端の比較が担う）。
K.<i> = QuadraticField(-1)
M = MatrixSpace(K, 2, 2)
SX = M([[0, 1], [1, 0]]); SY = M([[0, -i], [i, 0]]); SZ = M([[1, 0], [0, -1]])   # def_pauli_matrices
def smul(a, A):                        # def_matrix_scalar_multiple: (aA)_{jk} = a A_{jk}
    return M([[a*A[r, c] for c in range(2)] for r in range(2)])
def mat_mult(A, B):                    # mat_mult: (AB)_{jk} = A_{j1}B_{1k} + A_{j2}B_{2k}
    return M([[A[r, 0]*B[0, c] + A[r, 1]*B[1, c] for c in range(2)] for r in range(2)])
def neg(z):                            # multiply_by_minus_one: -z := (-1)·z
    return K(-1)*z
count = 0
def check_chain(name, rows):
    global count
    for k in range(1, len(rows)):
        assert rows[k] == rows[k-1], (name, k)
        count += 1
    print(name + f" の {len(rows)-1} 段")
mi = neg(i)
m1 = K(-1)
# 準備
check_chain("(-i)·i = 1", [mi*i, (m1*i)*i, m1*(i*i), m1*m1, K(1)])
check_chain("(-i)·(-i) = -1", [mi*mi, mi*(m1*i), (mi*m1)*i, (m1*mi)*i, m1*(mi*i), m1*1, K(-1)])
assert i*i == -1 and m1*m1 == 1
for A, B in [(SZ, SY), (SY, SX), (SX, SZ)]:
    assert mat_mult(A, B) == A*B
check_chain("σ^zσ^y = (-i)σ^x", [
    SZ*SY,
    mat_mult(M([[1, 0], [0, -1]]), M([[0, mi], [i, 0]])),
    M([[1*0 + 0*i, 1*mi + 0*0], [0*0 + (-1)*i, 0*mi + (-1)*0]]),
    M([[1*0 + 0, 1*mi + 0], [0 + (-1)*i, 0 + (-1)*0]]),
    M([[1*0, 1*mi], [(-1)*i, (-1)*0]]),
    M([[0, 1*mi], [(-1)*i, 0]]),
    M([[mi*0, 1*mi], [(-1)*i, mi*0]]),
    M([[mi*0, mi*1], [(-1)*i, mi*0]]),
    M([[mi*0, mi*1], [mi, mi*0]]),
    M([[mi*0, mi*1], [mi*1, mi*0]]),
    smul(mi, M([[0, 1], [1, 0]])),
    smul(mi, SX),
])
check_chain("σ^yσ^x = (-i)σ^z", [
    SY*SX,
    mat_mult(M([[0, mi], [i, 0]]), M([[0, 1], [1, 0]])),
    M([[0*0 + mi*1, 0*1 + mi*0], [i*0 + 0*1, i*1 + 0*0]]),
    M([[0 + mi*1, 0 + mi*0], [i*0 + 0, i*1 + 0]]),
    M([[mi*1, mi*0], [i*0, i*1]]),
    M([[mi*1, mi*0], [0, i*1]]),
    M([[mi*1, mi*0], [mi*0, i*1]]),
    M([[mi*1, mi*0], [mi*0, i*((-1)*(-1))]]),
    M([[mi*1, mi*0], [mi*0, (i*(-1))*(-1)]]),
    M([[mi*1, mi*0], [mi*0, ((-1)*i)*(-1)]]),
    M([[mi*1, mi*0], [mi*0, mi*(-1)]]),
    smul(mi, M([[1, 0], [0, -1]])),
    smul(mi, SZ),
])
check_chain("σ^xσ^z = (-i)σ^y", [
    SX*SZ,
    mat_mult(M([[0, 1], [1, 0]]), M([[1, 0], [0, -1]])),
    M([[0*1 + 1*0, 0*0 + 1*(-1)], [1*1 + 0*0, 1*0 + 0*(-1)]]),
    M([[0 + 1*0, 0 + 1*(-1)], [1*1 + 0, 1*0 + 0]]),
    M([[1*0, 1*(-1)], [1*1, 1*0]]),
    M([[0, 1*(-1)], [1*1, 0]]),
    M([[0, -1], [1, 0]]),
    M([[mi*0, -1], [1, mi*0]]),
    M([[mi*0, -1], [mi*i, mi*0]]),
    M([[mi*0, mi*mi], [mi*i, mi*0]]),
    smul(mi, M([[0, mi], [i, 0]])),
    smul(mi, SY),
])
for a, A in [(mi, SX), (mi, SZ), (mi, SY), (K(3) + 2*i, M([[1, 2], [i, -1]]))]:
    assert smul(a, A) == a*A
# 否定コントロール: スカラーの符号を取り違えると等式は偽。準備の符号を取り違えても偽
assert SZ*SY != smul(i, SX) and SY*SX != smul(i, SZ) and SX*SZ != smul(i, SY)
assert mi*i != -1 and mi*mi != 1
print(f"判定 {count} 段、否定コントロール 5 件")
print("ALL PASS")
