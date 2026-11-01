# 対象ラベル: real_inclusion_preserves_finite_sum
# Σ_{j=1}^{m} (r_j)_C = (Σ_{j=1}^{m} r_j)_C の帰納法の各行を、r_j を QQ 上の不定元に置いて厳密に確かめる。
load("../../_shared/complex_as_real_pairs.sage")


def fsum_cc(zs):
    """def_finite_sum_of_complex_numbers: Σ^1 := z_1、Σ^{m+1} := (Σ^m) + z_{m+1}。"""
    s = zs[0]
    for q in zs[1:]:
        s = cc_add(s, q)
    return s


def fsum_rr(rs):
    s = rs[0]
    for q in rs[1:]:
        s = s + q
    return s


MAX_M = 8
P = PolynomialRing(QQ, [f"r_{j}" for j in range(1, MAX_M + 2)])
r = P.gens()

# m = 1
lines = [fsum_cc([iota(r[0], P)]), iota(r[0], P), iota(fsum_rr([r[0]]), P)]
assert lines[0] == lines[1] == lines[2]

for m in range(1, MAX_M + 1):
    rs = list(r[:m + 1])
    # 帰納法の仮定（m 項で成り立つこと）をまず確かめる
    assert fsum_cc([iota(q, P) for q in rs[:m]]) == iota(fsum_rr(rs[:m]), P)
    lines = [
        fsum_cc([iota(q, P) for q in rs]),                                  # Σ^{m+1} (r_j)_C
        cc_add(fsum_cc([iota(q, P) for q in rs[:m]]), iota(rs[m], P)),      # (Σ^m (r_j)_C) + (r_{m+1})_C   (def_finite_sum)
        cc_add(iota(fsum_rr(rs[:m]), P), iota(rs[m], P)),                   # (Σ^m r_j)_C + (r_{m+1})_C     (帰納法の仮定)
        cc_add((fsum_rr(rs[:m]), P(0)), (rs[m], P(0))),                     # (Σ^m r_j, 0) + (r_{m+1}, 0)   (inclusion_rr_to_cc)
        (fsum_rr(rs[:m]) + rs[m], P(0) + P(0)),                             # (Σ^m r_j + r_{m+1}, 0+0)      (definition_of_cc の和)
        (fsum_rr(rs), P(0) + P(0)),                                         # (Σ^{m+1} r_j, 0+0)          (ℝ の有限和の定義)
        (fsum_rr(rs), P(0)),                                                # (Σ^{m+1} r_j, 0)            (0 + 0 = 0)
        iota(fsum_rr(rs), P),                                               # (Σ^{m+1} r_j)_C
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (m, t)
    # 比べる側: Sage の QQ(i) へ送った和と、Sage の sum
    KG = QuadraticField(-1, 'i')
    PK = PolynomialRing(KG, P.variable_names())
    assert PK(lines[0][0]) + KG.gen() * PK(lines[0][1]) == PK(sum(rs))
    print(f"m + 1 = {m + 1}: 帰納法の段の 7 個の等号を不定元で確かめた")
print("RESULT: PASS")
