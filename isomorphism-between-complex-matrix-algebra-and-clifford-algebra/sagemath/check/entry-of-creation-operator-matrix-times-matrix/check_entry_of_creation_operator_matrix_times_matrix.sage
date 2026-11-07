# 対象ラベル: claim_entry_of_creation_operator_matrix_times_matrix
# c_i を def_creation_operator_matrix の成分の式どおりに作り、成分が不定元の行列 A（QQ 上の多項式環）について、
# M=1,2,3 のすべての i, S, U で、証明の各行の等式と主張の式を確かめる。最後に否定コントロールを置く。
from itertools import combinations

def power_set(M):
    base = list(range(1, M + 1))
    return [frozenset(c) for r in range(M + 1) for c in combinations(base, r)]

def N(i, T):                       # def_count_of_subset_elements_below_index の帰納的な式
    if i == 1:
        return 0
    return N(i - 1, T) + 1 if (i - 1) in T else N(i - 1, T)

def sign(n):                       # def_sign_of_nonnegative_integer の帰納的な式
    return 1 if n == 0 else -1 * sign(n - 1)

def delta(x, y):
    return 1 if x == y else 0

negative_control_failed = 0
for M in range(1, 4):
    P = power_set(M)
    names = ["a_%d_%d" % (s, t) for s in range(len(P)) for t in range(len(P))]
    R = PolynomialRing(QQ, names)
    g = R.gens()
    A = {(P[s], P[t]): g[s * len(P) + t] for s in range(len(P)) for t in range(len(P))}
    for i in range(1, M + 1):
        cond = lambda S, T: (i not in T and S == T | {i})
        c = {(S, T): (sign(N(i, T)) if cond(S, T) else 0) for S in P for T in P}
        for S in P:
            for U in P:
                lhs = sum(c[(S, T)] * A[(T, U)] for T in P)      # 行列の積の定義
                if i not in S:
                    for T in P:                                   # i∉S の準備の等式
                        assert not cond(S, T)
                        assert c[(S, T)] * A[(T, U)] == (0 * 1) * 1
                    assert lhs == 0
                else:
                    Sp = frozenset(t for t in range(1, M + 1) if t in S and t != i)
                    assert Sp in P
                    for T in P:
                        assert cond(S, T) == (T == Sp)            # 条件と T=S' の同値
                        assert c[(S, T)] == delta(Sp, T) * sign(N(i, Sp))
                        r_T = sign(N(i, Sp)) * A[(T, U)]
                        assert c[(S, T)] * A[(T, U)] == delta(Sp, T) * r_T
                    assert sum(delta(Sp, T) * sign(N(i, Sp)) * A[(T, U)] for T in P) == sign(N(i, Sp)) * A[(Sp, U)]
                    assert lhs == sign(N(i, Sp)) * A[(Sp, U)]
                    # 否定コントロール: 符号を落とした式は、符号が -1 のところで一致しないはず
                    if sign(N(i, Sp)) == -1 and lhs != A[(Sp, U)]:
                        negative_control_failed += 1
    print("M=%d: PASS" % M)
assert negative_control_failed > 0
print("negative control (sign dropped) rejected in %d cases" % negative_control_failed)
print("ALL PASS")
