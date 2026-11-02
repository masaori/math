# 対象ラベル: matrix_minus_zero_matrix（X - O = X）
# 証明の成分ごとの鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (X - O)_ik = X_ik - O_ik = X_ik - 0_C = X_ik + (-0_C) = X_ik + (-1_C)·0_C = X_ik + (-1,0)·(0,0)
#              = X_ik + ((-1)·0 - 0·0, (-1)·0 + 0·0) = X_ik + (0,0) = X_ik + 0_C = X_ik + O_ik = (X + O)_ik
# 続く鎖 X - O = X + O = X の第 2 段は matrix_plus_zero_matrix（その check で確かめた）。ここでは行列として X + O = X も見る。
# 複素数は definition_of_cc のとおり実数の組で持ち、和・積はその式で組む。差は def_complex_difference、
# 符号反転は multiply_by_minus_one のとおり (-1_C)· で組む。
# 帰属: QQ 上の多項式環（X の成分の実部・虚部は不定元）。
def cc_add(z, w):
    return (z[0] + w[0], z[1] + w[1])                                  # definition_of_cc の和


def cc_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])      # definition_of_cc の積


def cc_neg(z, P):
    return cc_mul((P(-1), P(0)), z)                                    # multiply_by_minus_one


def cc_sub(z, w, P):
    return cc_add(z, cc_neg(w, P))                                     # def_complex_difference


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        names = [f"a_{i}_{k}" for i in range(m) for k in range(n)] + [f"b_{i}_{k}" for i in range(m) for k in range(n)]
        P = PolynomialRing(QQ, names)
        X = {(i, k): (P(f"a_{i}_{k}"), P(f"b_{i}_{k}")) for i in range(m) for k in range(n)}
        zero = (P(0), P(0))                                                # 0_C = (0,0)（inclusion_rr_to_cc）
        O = {(i, k): zero for i in range(m) for k in range(n)}             # def_zero_matrix
        XminusO = {(i, k): cc_sub(X[i, k], O[i, k], P) for i in range(m) for k in range(n)}  # def_matrix_difference
        XplusO = {(i, k): cc_add(X[i, k], O[i, k]) for i in range(m) for k in range(n)}      # def_matrix_sum
        for i in range(m):
            for k in range(n):
                x = X[i, k]
                chain = [
                    XminusO[i, k],                                         # (X - O)_ik
                    cc_sub(x, O[i, k], P),                                 # X_ik - O_ik
                    cc_sub(x, zero, P),                                    # X_ik - 0_C
                    cc_add(x, cc_neg(zero, P)),                            # X_ik + (-0_C)
                    cc_add(x, cc_mul((P(-1), P(0)), zero)),                # X_ik + (-1_C)·0_C
                    cc_add(x, cc_mul((P(-1), P(0)), (P(0), P(0)))),        # X_ik + (-1,0)·(0,0)
                    cc_add(x, ((-1) * P(0) - P(0) * P(0), (-1) * P(0) + P(0) * P(0))),  # 積の式
                    cc_add(x, (P(0), P(0))),                               # X_ik + (0,0)
                    cc_add(x, zero),                                       # X_ik + 0_C
                    cc_add(x, O[i, k]),                                    # X_ik + O_ik
                    XplusO[i, k],                                          # (X + O)_ik
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert XminusO == XplusO                                           # X - O = X + O（成分ごと）
        assert XplusO == X                                                 # X + O = X（matrix_plus_zero_matrix）
        A = matrix(P, m, n, lambda i, k: X[i, k][0])
        assert A - matrix(P, m, n, 0) == A                                 # 独立な経路: Sage の行列の差
print(f"checked {count} entrywise chains over 9 shapes")
# 対照: 零の代わりに 1_C を引くと変わる
P = PolynomialRing(QQ, "a,b"); x = (P("a"), P("b"))
assert cc_sub(x, (P(1), P(0)), P) != x
print("対照: 零でない数を引くと変わる")
print("RESULT: PASS")
