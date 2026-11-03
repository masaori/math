# 対象ラベル: difference_of_real_entry_matrices_has_real_entries
# 人手の鎖 A - B = A + (-B) = A + (-1_C)B = A + (-1)_C B と、続く段落（(-1)_C B の成分が実 → A + (-1)_C B の成分が実）を、
# A, B の成分 s_{pq}, t_{pq} を QQ 上の不定元として、m, n = 1..3 で確かめる。係数は QQ(i) に広げた多項式環で組み、
# 成分が実であることは「多項式の係数がすべて虚部 0」で判定する（ι(r) = r + 0·i）。
KG = QuadraticField(-1, 'i')
iK = KG.gen()
def is_real_matrix(X):
    return all(KG(c).imag() == 0 for e in X.list() for c in e.coefficients())
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        names = [f's_{p}_{q}' for p in range(m) for q in range(n)] + [f't_{p}_{q}' for p in range(m) for q in range(n)]
        P = PolynomialRing(QQ, names)
        PK = P.change_ring(KG)
        g = PK.gens()
        A = matrix(PK, m, n, lambda p, q: g[p * n + q])
        B = matrix(PK, m, n, lambda p, q: g[m * n + p * n + q])
        negB = matrix(PK, m, n, lambda p, q: -B[p, q])                       # def_matrix_negation
        diff = matrix(PK, m, n, lambda p, q: A[p, q] - B[p, q])              # def_matrix_difference
        lines = [
            diff,                                                            # A - B
            A + negB,                                                        # matrix_difference_is_sum_with_negation
            A + KG(-1) * B,                                                  # negation_is_scalar_multiple_by_minus_one（-1_C）
            A + PK(QQ(-1)) * B,                                              # 略記 -1_C = ι(-1)
        ]
        for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
            assert a == b, (m, n, k)
            count += 1
        assert is_real_matrix(A) and is_real_matrix(B)                       # 仮定
        assert is_real_matrix(PK(QQ(-1)) * B)                                # real_scalar_multiple_... (c → -1)
        assert is_real_matrix(A + PK(QQ(-1)) * B)                            # sum_of_real_entry_matrices_has_real_entries
        assert is_real_matrix(diff)                                          # 上の鎖より
        count += 4
# 否定コントロール: B を i 倍すると差の成分は実でない
P1.<a0, b0> = PolynomialRing(QQ)
PK1 = P1.change_ring(KG)
assert not is_real_matrix(matrix(PK1, 1, 1, [PK1(a0) - iK * PK1(b0)]))
print(f"  {count} 段（m, n = 1..3 の 3 行の鎖と、段落の実性 4 件。不定元 s_pq, t_pq。QQ(i) 係数の多項式環の厳密計算）")
print("  否定コントロール 1 件: B の成分を i 倍すると差は実でない")
print("RESULT: PASS")
