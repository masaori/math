# 対象ラベル: zero_scalar_multiple_is_zero_matrix（0_C A = O）
# 証明の成分ごとの鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (0_C A)_ik = 0_C A_ik = 0_C = O_ik
# 複素数は definition_of_cc のとおり実数の組 (p,q) で持ち、積は (p,q)(r,s) := (pr - qs, ps + qr) で組む。
# 帰属: QQ 上の多項式環（A の各成分の実部・虚部は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。


def cc_mul(z, w):
    """definition_of_cc の積 (p,q)(r,s) := (pr - qs, ps + qr)。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P = PolynomialRing(QQ, ["a%d_%d_%s" % (i, k, t) for i in range(m) for k in range(n) for t in "pq"])
        g = iter(P.gens())
        A = {(i, k): (next(g), next(g)) for i in range(m) for k in range(n)}        # A ∈ Mat(m,n,C)
        zero_c = (P(0), P(0))                                                        # 0_C = (0,0)
        O = {(i, k): zero_c for i in range(m) for k in range(n)}                    # def_zero_matrix
        zA = {(i, k): cc_mul(zero_c, A[i, k]) for i in range(m) for k in range(n)}  # def_matrix_scalar_multiple
        for i in range(m):
            for k in range(n):
                chain = [
                    zA[i, k],                     # (0_C A)_ik
                    cc_mul(zero_c, A[i, k]),      # 0_C A_ik      (def_matrix_scalar_multiple)
                    zero_c,                       # 0_C           (complex_zero_times_is_zero, z → A_ik)
                    O[i, k],                      # O_ik          (def_zero_matrix)
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert all(zA[i, k] == O[i, k] for i in range(m) for k in range(n))   # 行列の等号は成分ごと
print(f"checked {count} entrywise chains over 9 shapes")
# 対照: 0 でないスカラー倍は一般に零行列にならない
P1 = PolynomialRing(QQ, ["p", "q"])
p, q = P1.gens()
assert cc_mul((P1(1), P1(0)), (p, q)) != (P1(0), P1(0))
print("対照: 1_C 倍は零行列と一致しない")
print("RESULT: PASS")
