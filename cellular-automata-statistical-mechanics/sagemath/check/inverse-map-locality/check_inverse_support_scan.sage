# 対象ラベル: claim_inverse_support_finite_decidability
# 併せて claim_inverse_support_not_in_neighborhood_counterexample の (2) の帰結を検査する。
# 逆写像の各セルの値写像 (F^{-1})_v について、章「本質的依存台の有限決定」の一点反転走査
# （各 u ∈ V、各 x ∈ A^V について (F^{-1})_v(x) ≠ (F^{-1})_v(φ_u x) か）で supp((F^{-1})_v) を求め、
#   - 等号検査の回数が |V|·2^{|V|} = 160 を超えないこと
#   - V∖N(v) ⊆ supp((F^{-1})_v)、よって supp ⊄ N(v)
#   - 順写像 f_v∘ρ^V_{N(v)} の同じ走査による依存台が N(v) に含まれること
# を検査する。観察（主張しない）として supp((F^{-1})_v) の元の個数も出力する。
# 帰属: 有限集合と非負整数の等号・大小比較だけ。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

configurations = all_configurations()
inv = inverse_table()


def support_by_flip_scan(value_map):
    """local truth table (V, value_map) の本質的依存台を一点反転走査で求め、等号検査回数も返す。"""
    support = set()
    comparisons = 0
    for u in V:
        for x in configurations:
            comparisons += 1
            if value_map(x) != value_map(flip(u, x)):
                support.add(u)
                break  # 存在量化なので証人が見つかった時点で u を確定してよい
    return frozenset(support), comparisons


bound = len(V) * 2 ** len(V)
assert bound == 160
observed_sizes = []
for v in V:
    inv_support, comparisons = support_by_flip_scan(lambda x, v=v: inv[x][v])
    assert comparisons <= bound, (v, comparisons)
    outside = frozenset(u for u in V if u not in NEIGHBORHOOD[v])
    assert outside <= inv_support, (v, sorted(inv_support))
    assert not (inv_support <= NEIGHBORHOOD[v]), v
    fwd_support, fwd_comparisons = support_by_flip_scan(lambda x, v=v: global_map(x)[v])
    assert fwd_comparisons <= bound
    assert fwd_support <= NEIGHBORHOOD[v], (v, sorted(fwd_support))
    assert not (inv_support <= fwd_support), v
    observed_sizes.append(len(inv_support))

print("cells checked: {}; comparison bound: {}; observed |supp((F^-1)_v)| per cell (not claimed): {}".format(
    len(V), bound, observed_sizes))
print("RESULT: PASS")
