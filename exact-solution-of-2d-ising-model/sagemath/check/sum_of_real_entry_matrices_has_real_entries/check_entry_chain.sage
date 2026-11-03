# 対象ラベル: sum_of_real_entry_matrices_has_real_entries
# 人手の成分の鎖 (A+B)_{pq} = A_{pq} + B_{pq} = s_C + t_C = (s,0) + (t,0) = (s+t, 0+0) = (s+t, 0) = (s+t)_C を、
# A, B の成分 s_{pq}, t_{pq} を QQ 上の不定元として、m, n = 1..3 の全成分で 1 行ずつ確かめる。
# 複素数は definition_of_cc のとおり実数の組 (実部, 虚部) で組み、和は成分ごと（definition_of_cc の和）、
# ι(r) := (r, 0)（inclusion_rr_to_cc）とする。行列の和は def_matrix_sum の成分の式 (A+B)_{pq} := A_{pq} + B_{pq} で組む。
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        names = [f's_{p}_{q}' for p in range(m) for q in range(n)] + [f't_{p}_{q}' for p in range(m) for q in range(n)]
        P = PolynomialRing(QQ, names)
        g = P.gens()
        s = {(p, q): g[p * n + q] for p in range(m) for q in range(n)}
        t = {(p, q): g[m * n + p * n + q] for p in range(m) for q in range(n)}
        iota = lambda r: (P(r), P(0))                          # inclusion_rr_to_cc
        cadd = lambda z, w: (z[0] + w[0], z[1] + w[1])         # definition_of_cc の和
        A = {(p, q): iota(s[(p, q)]) for p in range(m) for q in range(n)}   # A_{pq} = (s_{pq})_C（s の取り方）
        B = {(p, q): iota(t[(p, q)]) for p in range(m) for q in range(n)}   # B_{pq} = (t_{pq})_C（t の取り方）
        AB = {(p, q): cadd(A[(p, q)], B[(p, q)]) for p in range(m) for q in range(n)}  # def_matrix_sum
        for p in range(m):
            for q in range(n):
                sp, tq = s[(p, q)], t[(p, q)]
                lines = [
                    AB[(p, q)],                                # (A+B)_{pq}
                    cadd(A[(p, q)], B[(p, q)]),                # def_matrix_sum
                    cadd(iota(sp), iota(tq)),                  # s, t の取り方
                    cadd((sp, P(0)), (tq, P(0))),              # inclusion_rr_to_cc を 2 箇所
                    (sp + tq, P(0) + P(0)),                    # definition_of_cc の和
                    (sp + tq, P(0)),                           # ℝ で 0 + 0 = 0
                    iota(sp + tq),                             # inclusion_rr_to_cc
                ]
                for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                    assert a == b, (m, n, p, q, k)
                    count += 1
                assert AB[(p, q)][1] == 0                      # r := s + t の像（虚部 0）
# 否定コントロール: B の成分を虚部 1 の (t, 1) に替えて同じ成分の鎖を組むと、和は (s+t, 0+1) で、最後の行 (s+t)_C と一致しない
# （仮定「B の成分が実」が効いていること）
P1.<s0, t0> = PolynomialRing(QQ)
iota1 = lambda r: (P1(r), P1(0))
cadd1 = lambda z, w: (z[0] + w[0], z[1] + w[1])
bad = cadd1(iota1(s0), (t0, P1(1)))
assert bad == (s0 + t0, P1(0) + P1(1))
assert bad != iota1(s0 + t0)
print(f"  {count} 段（m, n = 1..3 の全成分、不定元 s_pq, t_pq。実数の組で組んだ ℂ の厳密計算）")
print("  否定コントロール 1 件: B の成分の虚部を 1 にすると和の虚部が 0 でない")
print("RESULT: PASS")
