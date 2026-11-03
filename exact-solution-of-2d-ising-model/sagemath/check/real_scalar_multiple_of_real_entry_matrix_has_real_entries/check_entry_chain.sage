# 対象ラベル: real_scalar_multiple_of_real_entry_matrix_has_real_entries
# 人手の成分の鎖 (c_C B)_{pq} = c_C B_{pq} = c_C s_C = (cs)_C を、c と B の成分 s_{pq} を QQ 上の不定元として、
# m, n = 1..3 の全成分で 1 行ずつ確かめる。ι(r) := (r, 0) は、係数を QQ(i) に広げた多項式環で r + 0·i として組み、
# 虚部 0 は「i を含まない」（多項式を QQ(i) の基底 1, i で分けた i の側が 0）で判定する。
# スカラー倍は def_matrix_scalar_multiple の成分の式 (aA)_{pq} := a A_{pq} で組む。
KG = QuadraticField(-1, 'i')
iK = KG.gen()
count = 0
for m in range(1, 4):
    for n in range(1, 4):
        names = ['c'] + [f's_{p}_{q}' for p in range(m) for q in range(n)]
        P = PolynomialRing(QQ, names)
        PK = P.change_ring(KG)
        c = P.gen(0)
        s = {(p, q): P.gen(1 + p * n + q) for p in range(m) for q in range(n)}
        iota = lambda r: PK(r)                                   # ι(r) = (r, 0)
        B = matrix(PK, m, n, lambda p, q: iota(s[(p, q)]))        # B_{pq} = (s_{pq})_C（s の取り方）
        cB = matrix(PK, m, n, lambda p, q: iota(c) * B[p, q])    # def_matrix_scalar_multiple（a → c_C）
        for p in range(m):
            for q in range(n):
                lines = [cB[p, q], iota(c) * B[p, q], iota(c) * iota(s[(p, q)]), iota(c * s[(p, q)])]
                for k, (a, b) in enumerate(zip(lines, lines[1:]), start=1):
                    assert a == b, (m, n, p, q, k)
                    count += 1
                # 虚部 0: r := c s_{pq} の像
                assert all(KG(coef).imag() == 0 for coef in cB[p, q].coefficients())
# 否定コントロール: 掛ける数を実数の像でない i に替えて同じ成分の鎖を組むと、鎖の段は成り立つが
# 最後の値 i·s_{pq} は虚部 0 でない（主張の仮定 c ∈ ℝ が効いていること）
negP = PolynomialRing(KG, 's')
sv = negP.gen()
neg_lines = [iK * sv, iK * sv]                               # (iB)_{pq} = i·B_{pq} = i·s
assert neg_lines[0] == neg_lines[1]
assert any(KG(coef).imag() != 0 for coef in neg_lines[-1].coefficients())
print(f"  {count} 段（m, n = 1..3 の全成分、不定元 c, s_pq。QQ(i) 係数の多項式環の厳密計算）")
print("  否定コントロール 1 件: 掛ける数を i にすると虚部 0 でない成分になる")
print("RESULT: PASS")
