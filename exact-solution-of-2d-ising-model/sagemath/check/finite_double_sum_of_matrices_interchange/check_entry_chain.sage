# 対象ラベル: finite_double_sum_of_matrices_interchange
# Σ_a Σ_b X_{a,b} = Σ_b Σ_a X_{a,b} の成分の 6 行の鎖（5 等号）を、正方でない形を含む (m, n) ∈ {1,2,3}^2、
# r, s ∈ {1,…,4} の全ての成分 (i, k) で確かめる。有限和は def_finite_sum_of_matrices のとおり左から順に足して組み、
# 複素数の有限和も左から順に足す。
# 帰属: QQ 上の多項式環（X_{a,b} の成分は不定元）。不定元で成り立つ等号は、任意の複素数を代入しても成り立つ。
load("../../_shared/matrix_operations_by_definition.sage")


def sum_left(zs):
    out = zs[0]
    for z in zs[1:]:
        out = out + z
    return out


count = 0
for m in [1, 2, 3]:
    for n in [1, 2, 3]:
        R_MAX, S_MAX = 4, 4
        P, _, mats = generic_ring([(f"X{a}_{b}", m, n) for a in range(R_MAX) for b in range(S_MAX)])
        X = {(a, b): mats[a * S_MAX + b] for a in range(R_MAX) for b in range(S_MAX)}
        for r in range(1, R_MAX + 1):
            for s in range(1, S_MAX + 1):
                lhs = body_finite_sum([body_finite_sum([X[(a, b)] for b in range(s)]) for a in range(r)])
                rhs = body_finite_sum([body_finite_sum([X[(a, b)] for a in range(r)]) for b in range(s)])
                for i in range(m):
                    for k in range(n):
                        lines = [
                            lhs[i, k],
                            sum_left([body_finite_sum([X[(a, b)] for b in range(s)])[i, k] for a in range(r)]),   # entrywise
                            sum_left([sum_left([X[(a, b)][i, k] for b in range(s)]) for a in range(r)]),           # entrywise（各 a）
                            sum_left([sum_left([X[(a, b)][i, k] for a in range(r)]) for b in range(s)]),           # ℂ の有限和の順序交換
                            sum_left([body_finite_sum([X[(a, b)] for a in range(r)])[i, k] for b in range(s)]),   # entrywise（各 b）
                            rhs[i, k],                                                                              # entrywise
                        ]
                        for t in range(len(lines) - 1):
                            assert lines[t] == lines[t + 1], (m, n, r, s, i, k, t)
                assert lhs == sum(sum(X[(a, b)] for b in range(s)) for a in range(r)) == rhs   # Sage の行列演算（独立な経路）
                # 対照: 内側の和だけを取った Σ_b X_{1,b} と Σ_a X_{a,1} は（r, s ≥ 2 で）一致しない
                if r >= 2 and s >= 2:
                    assert body_finite_sum([X[(a, 0)] for a in range(r)]) != body_finite_sum([X[(0, b)] for b in range(s)])
                count += 1
print(f"checked the 5-equality entry chain for all entries, (m, n) in {{1,2,3}}^2, r, s = 1..4 ({count} cases)")
print("RESULT: PASS")
