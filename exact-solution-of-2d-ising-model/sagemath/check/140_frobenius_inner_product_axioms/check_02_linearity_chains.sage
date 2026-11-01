# frobenius_inner_product_axioms (2) の 4 本の鎖を 1 行ずつ、ガウス有理数体 QQ[i] の厳密計算で確かめる（浮動小数点は使わない）。
K.<i> = QuadraticField(-1)
def conj(z):                           # def_complex_conjugate: (x, y) ↦ (x, -y)
    x, y = z.vector()
    return K(x) - K(y)*i
def msum(A, B):                        # def_matrix_sum: (A+B)_{ij} = A_{ij} + B_{ij}
    return matrix(K, A.nrows(), A.ncols(), lambda r, c: A[r, c] + B[r, c])
def msmul(a, A):                       # def_matrix_scalar_multiple: (aA)_{ij} = a A_{ij}
    return matrix(K, A.nrows(), A.ncols(), lambda r, c: a*A[r, c])
def S(n, f):                           # Σ_{i,j}
    return sum(f(r, c) for r in range(n) for c in range(n))
def inner(A, B):                       # def_frobenius_inner_product: ⟨A,B⟩ = tr(A^* B)（Sage の共役転置・積・トレース）
    return (A.conjugate_transpose()*B).trace()

set_random_seed(140)
def rnd():
    return K(QQ.random_element(num_bound=9, den_bound=5)) + K(QQ.random_element(num_bound=9, den_bound=5))*i
count = 0
neg_count = 0
for n in [1, 2, 3]:
    for trial in range(4):
        A, B, C = [matrix(K, n, n, lambda r, c: rnd()) for _ in range(3)]
        lam = rnd()
        # 定義の成分の式が Sage の和・スカラー倍と一致すること
        assert msum(B, C) == B + C and msmul(lam, B) == lam*B
        # 各鎖の左辺の B+C・λB・A+B・λA は Sage の標準の演算で作る（定義の段で成分の式と突き合わせる）
        BC = B + C; lB = lam*B; AB = A + B; lA = lam*A
        # ⟨A,B+C⟩ の鎖
        ch1 = [inner(A, BC),
               S(n, lambda r, c: conj(A[r, c])*BC[r, c]),                              # (0)
               S(n, lambda r, c: conj(A[r, c])*(B[r, c] + C[r, c])),                   # def_matrix_sum
               S(n, lambda r, c: conj(A[r, c])*B[r, c] + conj(A[r, c])*C[r, c]),       # 分配律
               S(n, lambda r, c: conj(A[r, c])*B[r, c]) + S(n, lambda r, c: conj(A[r, c])*C[r, c]),
               inner(A, B) + inner(A, C)]
        # ⟨A,λB⟩ の鎖
        ch2 = [inner(A, lB),
               S(n, lambda r, c: conj(A[r, c])*lB[r, c]),                              # (0)
               S(n, lambda r, c: conj(A[r, c])*(lam*B[r, c])),                         # def_matrix_scalar_multiple
               S(n, lambda r, c: lam*(conj(A[r, c])*B[r, c])),
               lam*S(n, lambda r, c: conj(A[r, c])*B[r, c]),
               lam*inner(A, B)]
        # ⟨A+B,C⟩ の鎖
        ch3 = [inner(AB, C),
               S(n, lambda r, c: conj(AB[r, c])*C[r, c]),                              # (0)
               S(n, lambda r, c: conj(A[r, c] + B[r, c])*C[r, c]),                     # def_matrix_sum
               S(n, lambda r, c: (conj(A[r, c]) + conj(B[r, c]))*C[r, c]),
               S(n, lambda r, c: conj(A[r, c])*C[r, c] + conj(B[r, c])*C[r, c]),
               S(n, lambda r, c: conj(A[r, c])*C[r, c]) + S(n, lambda r, c: conj(B[r, c])*C[r, c]),
               inner(A, C) + inner(B, C)]
        # ⟨λA,B⟩ の鎖
        ch4 = [inner(lA, B),
               S(n, lambda r, c: conj(lA[r, c])*B[r, c]),                              # (0)
               S(n, lambda r, c: conj(lam*A[r, c])*B[r, c]),                           # def_matrix_scalar_multiple
               S(n, lambda r, c: conj(lam)*conj(A[r, c])*B[r, c]),
               conj(lam)*S(n, lambda r, c: conj(A[r, c])*B[r, c]),
               conj(lam)*inner(A, B)]
        for name, ch in [("<A,B+C>", ch1), ("<A,λB>", ch2), ("<A+B,C>", ch3), ("<λA,B>", ch4)]:
            for k in range(1, len(ch)):
                assert ch[k] == ch[k-1], (name, n, k)
                count += 1
        # 否定コントロール: 第 1 変数で共役を落とすと（λ が実数でない限り）成り立たない
        if lam != conj(lam) and inner(A, B) != 0:
            assert inner(lA, B) != lam*inner(A, B)
            neg_count += 1
assert neg_count > 0
print("判定した等号の数:", count, "否定コントロールの数:", neg_count)
print("ALL PASS")
