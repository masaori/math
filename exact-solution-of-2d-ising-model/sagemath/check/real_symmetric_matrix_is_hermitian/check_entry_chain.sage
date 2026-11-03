# 対象ラベル: real_symmetric_matrix_is_hermitian
# 人手の成分の鎖 (A^*)_{kl} = conj(A_{lk}) = conj(r_C) = r_C = A_{lk} = (A^T)_{kl} = A_{kl} の 6 行を、
# n = 1..4 の実対称な複素行列 A（成分は QQ 上の不定元 r_{kl} = r_{lk} の包含 r_C）について、全成分で 1 行ずつ確かめる。
# 複素数は本文 definition_of_cc どおり実数の対で持ち（_shared/complex_as_real_pairs.sage）、Sage の複素数は使わない。
# 共役転置は def_hermitian_positive_definite の (A^*)_{kl} := conj(A_{lk})、転置は def_matrix_transpose の (A^T)_{pq} := A_{qp}。
load("../../_shared/complex_as_real_pairs.sage")

count = 0
for n in range(1, 5):
    names = [f"r_{k}_{l}" for k in range(n) for l in range(k, n)]
    P = PolynomialRing(QQ, names)
    def rr(k, l):                                   # 実対称: r_{kl} = r_{lk}
        a, b = min(k, l), max(k, l)
        return P(f"r_{a}_{b}")
    A = [[iota(rr(k, l), P) for l in range(n)] for k in range(n)]                  # A_{kl} = r_C（def_matrix_with_real_entries）
    At = [[A[l][k] for l in range(n)] for k in range(n)]                           # def_matrix_transpose
    assert At == A                                                                  # A^T = A（def_real_symmetric_complex_matrix）
    Astar = [[cc_conj(A[l][k]) for l in range(n)] for k in range(n)]               # def_hermitian_positive_definite の共役転置
    for k in range(n):
        for l in range(n):
            r = rr(l, k)                                                            # r の取り方 A_{lk} = r_C
            lines = [
                Astar[k][l],            # (A^*)_{kl}
                cc_conj(A[l][k]),       # conj(A_{lk})          （共役転置の定義）
                cc_conj(iota(r, P)),    # conj(r_C)             （r の取り方）
                iota(r, P),             # r_C                   （complex_conjugate_of_real_inclusion）
                A[l][k],                # A_{lk}                （r の取り方）
                At[k][l],               # (A^T)_{kl}            （def_matrix_transpose）
                A[k][l],                # A_{kl}                （A^T = A）
            ]
            for t, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                assert a == b, (n, k, l, t)
                count += 1
    assert Astar == A
# 否定コントロール 1: 成分が実でない 1 行 1 列の行列 (i)（i = (0, 1)）は転置で不変だが、A^* ≠ A
C = [[(QQ(0), QQ(1))]]
assert [[C[l][k] for l in range(1)] for k in range(1)] == C
assert [[cc_conj(C[l][k]) for l in range(1)] for k in range(1)] != C
# 否定コントロール 2: 転置で不変でない実の行列 ((0,1),(0,0)) は、成分が実でも最後の行（A^T = A）が外れ、A^* ≠ A
B = [[iota(0, QQ), iota(1, QQ)], [iota(0, QQ), iota(0, QQ)]]
Bstar = [[cc_conj(B[l][k]) for l in range(2)] for k in range(2)]
assert [[B[l][k] for l in range(2)] for k in range(2)] != B and Bstar != B
print(f"  {count} 段（n = 1..4 の全成分、成分は QQ 上の不定元の包含。実数の対で厳密計算）")
print("  否定コントロール 2 件: 成分が i の行列 (i) は転置で不変だがエルミートでない、転置で不変でない実の行列はエルミートでない")
print("RESULT: PASS")
