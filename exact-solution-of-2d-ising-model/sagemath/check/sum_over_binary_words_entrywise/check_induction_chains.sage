# 対象ラベル: sum_over_binary_words_entrywise（{0,1}^r の上の行列の和の成分は成分の和）
# 行列 X_ε の成分を QQ(i) 上の多項式環の不定元に置き、r = 1..4、(m, n) ∈ {(1,1), (2,3), (3,2)} で、
# r = 1 の鎖 3 行、r → r+1 の鎖 4 行（帰納法の仮定の行は、r の主張を X_{ε'} → X_{(ε',1)} + X_{(ε',0)} の族へ当てた値）と主張を厳密に確かめる。
# 行列の和 Σ_ε は def_sum_over_binary_words の帰納的な定義どおりに、複素数の和は def_sum_over_binary_words_of_complex_numbers どおりに組む
# （同じ帰納の形なので、比べる相手として Sage の sum による全ての語の和とも比べる）。
load("../../_shared/matrix_operations_by_definition.sage")

K.<ii> = QuadraticField(-1)
n_eq = 0
n_neg = 0


def words(r):
    return [tuple(w) for w in cartesian_product([[0, 1]] * r)]


def bw_sum_mat(B, r, zero):
    """def_sum_over_binary_words: r = 1 は B_(1) + B_(0)、r+1 は Σ_{ε'} (B_(ε',1) + B_(ε',0))。"""
    if r == 1:
        return body_sum(B[(1,)], B[(0,)])
    C = {w: body_sum(B[w + (1,)], B[w + (0,)]) for w in words(r - 1)}
    return bw_sum_mat(C, r - 1, zero)


def bw_sum_num(z, r):
    """def_sum_over_binary_words_of_complex_numbers（同じ帰納の形）。"""
    if r == 1:
        return z[(1,)] + z[(0,)]
    c = {w: z[w + (1,)] + z[w + (0,)] for w in words(r - 1)}
    return bw_sum_num(c, r - 1)


def eq(a, b, what):
    global n_eq
    assert a == b, what
    n_eq += 1


for r in range(1, 5):
    for (m, n) in [(1, 1), (2, 3), (3, 2)]:
        ws = words(r)
        names = [f"x_{''.join(map(str, w))}_{i}_{k}" for w in ws for i in range(m) for k in range(n)]
        P = PolynomialRing(K, names)
        g = iter(P.gens())
        X = {w: matrix(P, m, n, [next(g) for _ in range(m * n)]) for w in ws}
        S = bw_sum_mat(X, r, None)
        eq(S, sum(X.values()), f"r={r}: 帰納的な和 = 全ての語の和")
        for i in range(m):
            for k in range(n):
                rhs = bw_sum_num({w: X[w][i, k] for w in ws}, r)
                eq(S[i, k], rhs, f"r={r}: 主張")
                if r == 1:
                    l1 = S[i, k]
                    l2 = body_sum(X[(1,)], X[(0,)])[i, k]
                    l3 = X[(1,)][i, k] + X[(0,)][i, k]
                    l4 = rhs
                    for a, b in [(l1, l2), (l2, l3), (l3, l4)]:
                        eq(a, b, "r=1 の鎖")
                else:
                    Y = {w: body_sum(X[w + (1,)], X[w + (0,)]) for w in words(r - 1)}
                    l1 = S[i, k]
                    l2 = bw_sum_mat(Y, r - 1, None)[i, k]
                    l3 = bw_sum_num({w: Y[w][i, k] for w in words(r - 1)}, r - 1)   # 帰納法の仮定（r − 1 の主張）を Y へ当てた値
                    l4 = bw_sum_num({w: X[w + (1,)][i, k] + X[w + (0,)][i, k] for w in words(r - 1)}, r - 1)
                    l5 = rhs
                    for a, b in [(l1, l2), (l2, l3), (l3, l4), (l4, l5)]:
                        eq(a, b, f"r={r}: r−1 → r の鎖")
        # 否定コントロール: 一つの語の項を落とした和は主張の右辺と違う
        drop = ws[0]
        assert S[0, 0] != bw_sum_num({w: (X[w][0, 0] if w != drop else P(0)) for w in ws}, r)
        n_neg += 1

print(f"sum_over_binary_words_entrywise: 等号 {n_eq} 件、否定コントロール {n_neg} 件、失敗 0 件")
print("RESULT: PASS")
