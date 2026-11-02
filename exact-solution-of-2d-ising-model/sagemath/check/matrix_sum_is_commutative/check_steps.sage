# 対象ラベル: matrix_sum_is_commutative（A + B = B + A）
# 証明の成分ごとの鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (A + B)_ik = A_ik + B_ik = B_ik + A_ik = (B + A)_ik
# 複素数は definition_of_cc のとおり実数の組 (p,q) で持ち、和は (p,q) + (r,s) := (p + r, q + s) で組む。
# 帰属: QQ 上の多項式環（A, B の各成分の実部・虚部は不定元）。


def cc_add(z, w):
    """definition_of_cc の和 (p,q) + (r,s) := (p + r, q + s)。"""
    return (z[0] + w[0], z[1] + w[1])


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        P = PolynomialRing(QQ, ["%s%d_%d_%s" % (X, i, k, t) for X in "ab" for i in range(m) for k in range(n) for t in "pq"])
        g = iter(P.gens())
        A = {(i, k): (next(g), next(g)) for i in range(m) for k in range(n)}
        B = {(i, k): (next(g), next(g)) for i in range(m) for k in range(n)}
        ApB = {(i, k): cc_add(A[i, k], B[i, k]) for i in range(m) for k in range(n)}   # def_matrix_sum
        BpA = {(i, k): cc_add(B[i, k], A[i, k]) for i in range(m) for k in range(n)}   # def_matrix_sum
        for i in range(m):
            for k in range(n):
                chain = [
                    ApB[i, k],                    # (A + B)_ik
                    cc_add(A[i, k], B[i, k]),     # A_ik + B_ik   (def_matrix_sum)
                    cc_add(B[i, k], A[i, k]),     # B_ik + A_ik   (C の加法の交換律)
                    BpA[i, k],                    # (B + A)_ik    (def_matrix_sum を右辺から左辺へ)
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert all(ApB[key] == BpA[key] for key in ApB)   # 行列の等号は成分ごと
print(f"checked {count} entrywise chains over 9 shapes")
# 対照: 行列の積は一般に可換でない（和の可換則が自明な一致でないことの比較）
a = matrix(QQ, [[0, 1], [0, 0]])
b = matrix(QQ, [[0, 0], [1, 0]])
assert a * b != b * a
print("対照: 行列の積は一般に交換しない")
print("RESULT: PASS")
