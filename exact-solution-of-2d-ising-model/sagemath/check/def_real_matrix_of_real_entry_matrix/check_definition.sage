# 対象ラベル: def_real_matrix_of_real_entry_matrix
# 成分がすべて実数の複素行列 B から B_ℝ := ϱ(B) を定め、((B_ℝ)_pq)_ℂ = B_pq と、
# B_pq = r_ℂ を満たす r がただ一つ（= (B_ℝ)_pq）であることを確かめる。
# 帰属: ℂ の元は QQbar（成分が実数とは虚部が 0）、ℝ の元は AA。浮動小数点は使わない。
def iota(x):
    """inclusion_rr_to_cc: r ↦ r_ℂ。"""
    return QQbar(x)


def has_real_entries(B):
    """def_matrix_with_real_entries: すべての成分が ι の像に入る。"""
    return all(B[p, q].imag() == 0 for p in range(B.nrows()) for q in range(B.ncols()))


def varrho(B):
    """def_real_matrix_of_real_entry_matrix: (B_ℝ)_pq := B_pq = r_ℂ を満たす r。"""
    assert has_real_entries(B)
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


set_random_seed(20261106)
cands = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/3, QQ(5)] + [AA(2).sqrt(), -AA(3).sqrt()]
n = 0
for trial in range(40):
    m, k = randint(1, 4), randint(1, 4)
    A = matrix(AA, m, k, lambda p, q: cands[randint(0, len(cands) - 1)])
    B = A.apply_map(iota)                                            # 成分がすべて実数の複素行列
    assert has_real_entries(B)
    BR = varrho(B)
    for p in range(m):
        for q in range(k):
            assert iota(BR[p, q]) == B[p, q]                         # ((B_ℝ)_pq)_ℂ = B_pq
            for r in cands:
                if iota(r) == B[p, q]:
                    assert r == BR[p, q]                             # 一意性（inclusion_rr_to_cc_is_injective）
    assert BR == A                                                   # 実数の行列を埋め込んでから戻すと元に戻る
    n += 1
# 否定コントロール: 虚部が 0 でない成分を持つ行列は定義域に入らない
C = matrix(QQbar, 2, 2, [1, QQbar(I), 0, 2])
assert not has_real_entries(C)
print(f"{n} 個の行列で ((B_ℝ)_pq)_ℂ = B_pq と一意性を確かめ、否定コントロール 1 件が定義域に入らないことを確かめた")
print("RESULT: PASS")
