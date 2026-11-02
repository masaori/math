# 対象ラベル: scalar_multiple_of_zero_matrix（aO = O）
# 証明の成分ごとの鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (aO)_ik = a O_ik = a 0_C = 0_C = O_ik
# 複素数は definition_of_cc のとおり実数の組 (p,q) で持ち、積は (p,q)(r,s) := (pr - qs, ps + qr) で組む。
# 帰属: QQ 上の多項式環（a の実部・虚部は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。


def cc_mul(z, w):
    """definition_of_cc の積 (p,q)(r,s) := (pr - qs, ps + qr)。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])


P = PolynomialRing(QQ, ["p", "q"])
p, q = P.gens()
a = (p, q)                                   # a ∈ C
zero_c = (P(0), P(0))                        # 0_C = ι(0) = (0,0)（inclusion_rr_to_cc）

count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        O = {(i, k): zero_c for i in range(m) for k in range(n)}                    # def_zero_matrix
        aO = {(i, k): cc_mul(a, O[i, k]) for i in range(m) for k in range(n)}       # def_matrix_scalar_multiple
        for i in range(m):
            for k in range(n):
                chain = [
                    aO[i, k],                 # (aO)_ik
                    cc_mul(a, O[i, k]),       # a O_ik        (def_matrix_scalar_multiple)
                    cc_mul(a, zero_c),        # a 0_C         (def_zero_matrix)
                    zero_c,                   # 0_C           (complex_times_zero_is_zero, z = a)
                    O[i, k],                  # O_ik          (def_zero_matrix)
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert all(aO[i, k] == O[i, k] for i in range(m) for k in range(n))   # 行列の等号は成分ごと
        # 独立な経路: Sage の行列のスカラー倍（実部と虚部を別の行列で持つ。a·0 の実部 = p·0 - q·0、虚部 = p·0 + q·0）
        Z = matrix(P, m, n, 0)
        assert p * Z - q * Z == Z and p * Z + q * Z == Z
print(f"checked {count} entrywise chains over 9 shapes")
# 対照: 零でない行列のスカラー倍は一般に零行列にならない
assert cc_mul(a, (P(1), P(0))) != zero_c
print("対照: 零でない行列のスカラー倍は零行列と一致しない")
print("RESULT: PASS")
