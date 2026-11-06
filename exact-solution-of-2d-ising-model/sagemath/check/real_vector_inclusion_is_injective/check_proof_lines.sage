# 対象ラベル: real_vector_inclusion_is_injective
# 証明の 3 行の鎖 (x_i)_ℂ = (ι^n(x))_i = (ι^n(y))_i = (y_i)_ℂ と、inclusion_rr_to_cc_is_injective で x_i = y_i を得て
#   x = y とする結びを、大きさ n ∈ {1, 2} で候補の値から独立に選んだ組を総当たりして厳密に確かめる。
# 帰属: ℝ の元は AA、ℂ の元は QQbar。r_ℂ := (r, 0) は QQbar(r)（実部 r・虚部 0）。浮動小数点は使わない。


def incl(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ = (r, 0)。"""
    z = QQbar(r)
    assert z.real() == r and z.imag() == 0
    return z


def iota(x):
    """def_real_vector_inclusion: (ι^n(x))_i := (x_i)_ℂ。"""
    return vector(QQbar, [incl(xi) for xi in x])


import itertools
# 候補の値から独立に作った組 (x, y) を総当たりし、仮定 ι^n(x) = ι^n(y) を満たす組で鎖と結論を、
# 満たさない組では x ≠ y であることを確かめる（ι^n(x) = ι^n(y) ⟺ x = y）。
cands = [AA(-3), AA(-1)/2, AA(0), AA(2)/3, AA(2).sqrt(), AA(3).sqrt(), AA(12).sqrt()/2]
count_eq = 0
count_ne = 0
for n in range(1, 3):
    vecs = [vector(AA, v) for v in itertools.product(cands, repeat=n)]
    for x in vecs:
        for y in vecs:
            if iota(x) == iota(y):                              # 仮定
                for i in range(n):
                    l1 = incl(x[i])
                    l2 = iota(x)[i]
                    l3 = iota(y)[i]
                    l4 = incl(y[i])
                    assert l1 == l2 == l3 == l4, (x, y, i)
                    assert (l1.real(), l1.imag()) == (l4.real(), l4.imag())  # (a,0) = (b,0) の第 1 成分の比較
                    assert x[i] == y[i]                         # inclusion_rr_to_cc_is_injective の結論
                assert x == y                                   # 主張
                count_eq += 1
            else:
                assert x != y                                   # 対偶の向きの確認
                count_ne += 1
# √12/2 と √3 は別の式で書いた同じ実数なので、仮定を満たす組には x と y を別の式で作った組が入る
assert count_eq > sum(len(cands)^n for n in range(1, 3))
print(f"仮定を満たす {count_eq} 組で 3 行の鎖と x = y を、満たさない {count_ne} 組で x ≠ y を確かめた")
print("RESULT: PASS")
