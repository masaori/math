# 対象ラベル: psd_cauchy_schwarz
# 場合分けの段を確かめる。
# (A) 等号の行を、a, b, c, t を不定元とする QQ 上の有理関数として厳密に確かめる（a ≠ 0・b ≠ 0 の行は分母に置く）。
# (B) 不等号の行と主張を、具体の対称・半正定値な QQ の行列 P = C^T C（階数が落ちるものを含む）と
#     QQ の x, y で厳密に確かめる。q(t) の値は w(t) から def_real_bilinear_value で直接計算して比べる。
load("real_bilinear_value_by_definition.sage")

F = FractionField(PolynomialRing(QQ, ["a", "b", "c", "t"]))
a, b, c, t = F.gens()
qpoly = lambda tt, aa=a: aa * tt ** 2 + 2 * b * tt + c
# (i) の第一の鎖の等号 3 行
L = [qpoly(-b / a), a * (-b / a) ** 2 + 2 * b * (-b / a) + c, b ** 2 / a - 2 * b ** 2 / a + c, c - b ** 2 / a]
assert all(L[i] == L[i + 1] for i in range(len(L) - 1))
# (i) の第二の鎖の等号: b^2 = a·(b^2/a)
assert b ** 2 == a * (b ** 2 / a)
# (ii): a = 0 の q(t) = 0·t^2 + 2bt + c = 2bt + c
assert qpoly(t, 0) == 0 * t ** 2 + 2 * b * t + c == 2 * b * t + c
# (ii): q(t0) = 2b(-(c+1)/(2b)) + c = -(c+1) + c = -1
t0 = -(c + 1) / (2 * b)
M = [qpoly(t0, 0), 2 * b * t0 + c, -(c + 1) + c, F(-1)]
assert all(M[i] == M[i + 1] for i in range(len(M) - 1))
print("(A) 場合分けの等号の行を有理関数として厳密に確かめた")

set_random_seed(7)
def rand_q():
    return QQ(ZZ.random_element(-9, 10)) / QQ(ZZ.random_element(1, 6))

count_pos = count_zero = 0
for n in [1, 2, 3, 4]:
    for rank in range(0, n + 1):
        for trial in range(5):
            C = [[rand_q() for _ in range(n)] for _ in range(rank)] if rank > 0 else [[QQ(0)] * n]
            Cm = matrix(QQ, C)
            Pm = Cm.transpose() * Cm                    # 比べる側でも対称・半正定値
            P = [[Pm[k, l] for l in range(n)] for k in range(n)]
            assert all(P[k][l] == P[l][k] for k in range(n) for l in range(n))
            K = Pm.right_kernel()
            for s in range(8):
                y = [rand_q() for _ in range(n)]
                # 半分は a = 0 になるよう x を P の核から取る（rank < n のとき）
                if s % 2 == 1 and K.dimension() > 0:
                    x = list(K.random_element())
                else:
                    x = [rand_q() for _ in range(n)]
                aa, bb, cc = bilin(x, P, x), bilin(y, P, x), bilin(y, P, y)
                assert (aa, bb, cc) == (sage_bilin(x, P, x, QQ), sage_bilin(y, P, x, QQ), sage_bilin(y, P, y, QQ))
                assert aa >= 0 and cc >= 0                                   # 半正定値性を x, y に当てはめた行
                q = lambda tt: bilin([y[k] + tt * x[k] for k in range(n)], P, [y[k] + tt * x[k] for k in range(n)])
                if aa > 0:
                    count_pos += 1
                    t1 = -bb / aa
                    chain = [q(t1), aa * (-bb / aa) ** 2 + 2 * bb * (-bb / aa) + cc, cc - bb ** 2 / aa]
                    assert chain[0] == chain[1] == chain[2] and 0 <= chain[0]   # 0 ≤ q(-b/a) = … = c - b²/a
                    assert bb ** 2 / aa <= cc                                    # 移項
                    lhs = [bb ** 2, aa * (bb ** 2 / aa)]
                    assert lhs[0] == lhs[1] and lhs[1] <= aa * cc               # (y^T P x)^2 = b^2 = a(b²/a) ≤ ac
                else:
                    count_zero += 1
                    assert aa == 0
                    for tt in [rand_q() for _ in range(4)]:
                        assert q(tt) == 2 * bb * tt + cc                         # (ii) の q(t) = 2bt + c
                    assert bb == 0                                               # 背理法の結論
                    assert bb ** 2 == 0 == 0 * cc == aa * cc
                assert bb ** 2 <= aa * cc                                        # 主張
print(f"(B) a > 0 の {count_pos} 組、a = 0 の {count_zero} 組で、不等号の行と主張を QQ で厳密に確かめた")

# (ii) の背理法の q(t0) = -1 < 0 が、半正定値でない（a = 0 だが b ≠ 0 になりうる）P で実際に負になることの確認
P = [[QQ(0), QQ(1)], [QQ(1), QQ(0)]]
x, y = [QQ(1), QQ(0)], [QQ(0), QQ(1)]
aa, bb, cc = bilin(x, P, x), bilin(y, P, x), bilin(y, P, y)
assert aa == 0 and bb == 1 and cc == 0
t0 = -(cc + 1) / (2 * bb)
w0 = [y[k] + t0 * x[k] for k in range(2)]
assert bilin(w0, P, w0) == -1
assert bb ** 2 > aa * cc                                                          # 仮定を外すと主張が崩れる
print("半正定値でない P では q(t0) = -1 となり主張が崩れることを確かめた")
print("RESULT: PASS")
