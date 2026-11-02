# 対象ラベル: zero_matrix_plus_matrix（O + X = X）
# 証明の成分ごとの鎖の各行を、行に書かれた式どおりに別々に組み、隣り合う項が等しいことを確かめる。
#   (O + X)_ik = O_ik + X_ik = 0_C + X_ik = 0_C + (a,b) = (0,0) + (a,b) = (0+a, 0+b) = (a,b) = X_ik
# 複素数は definition_of_cc のとおり実数の組 (a,b) で持ち、和は成分ごとの和で組む。
# 帰属: QQ 上の多項式環（X の成分の実部・虚部は不定元）。不定元で成り立つ等号は、任意の実数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def cc_add(z, w):
    """definition_of_cc の和 (a,b) + (c,d) := (a+c, b+d)。"""
    return (z[0] + w[0], z[1] + w[1])


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        names = [f"a_{i}_{k}" for i in range(m) for k in range(n)] + [f"b_{i}_{k}" for i in range(m) for k in range(n)]
        P = PolynomialRing(QQ, names)
        a = {(i, k): P(f"a_{i}_{k}") for i in range(m) for k in range(n)}
        b = {(i, k): P(f"b_{i}_{k}") for i in range(m) for k in range(n)}
        X = {(i, k): (a[i, k], b[i, k]) for i in range(m) for k in range(n)}        # X_ik = (a,b)
        O = {(i, k): (P(0), P(0)) for i in range(m) for k in range(n)}               # def_zero_matrix, 0_C = (0,0)
        XplusO = {(i, k): cc_add(O[i, k], X[i, k]) for i in range(m) for k in range(n)}  # def_matrix_sum
        for i in range(m):
            for k in range(n):
                chain = [
                    XplusO[i, k],                                  # (O + X)_ik
                    cc_add(O[i, k], X[i, k]),                      # O_ik + X_ik      (def_matrix_sum)
                    cc_add((P(0), P(0)), X[i, k]),                 # 0_C + X_ik       (def_zero_matrix)
                    cc_add(O[i, k], (a[i, k], b[i, k])),           # 0_C + (a,b)      (a, b の取り方)
                    cc_add((P(0), P(0)), (a[i, k], b[i, k])),      # (0,0) + (a,b)    (inclusion_rr_to_cc)
                    (0 + a[i, k], 0 + b[i, k]),                    # (0+a, 0+b)       (definition_of_cc の和)
                    (a[i, k], b[i, k]),                            # (a,b)            (R で 0+a=a)
                    X[i, k],                                       # X_ik
                ]
                for t in range(len(chain) - 1):
                    assert chain[t] == chain[t + 1], (m, n, i, k, t)
                count += 1
        assert all(XplusO[i, k] == X[i, k] for i in range(m) for k in range(n))   # 行列の等号は成分ごと
        # 独立な経路: Sage の複素行列（QQbar 係数は使わず、実部と虚部を別の行列で持つ）の和
        A = matrix(P, m, n, lambda i, k: a[i, k]); B = matrix(P, m, n, lambda i, k: b[i, k])
        assert matrix(P, m, n, 0) + A == A and matrix(P, m, n, 0) + B == B
print(f"checked {count} entrywise chains over 9 shapes")
# 対照: 零行列の代わりに成分 1 の行列を足すと一致しない
assert cc_add((P(0), P(0)), (P(1), P(0))) != (P(0), P(0))
print("対照: 零でない行列を足すと変わる")
print("RESULT: PASS")
