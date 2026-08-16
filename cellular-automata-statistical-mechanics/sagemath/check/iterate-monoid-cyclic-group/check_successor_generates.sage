# 対象ラベル: claim_iterate_monoid_cycle_part_is_cyclic_of_order_min_period
# K_F := F^{e_F+1} ∈ C_F、群の冪 K^{<0>}=E_F、K^{<r+1>}=K^{<r>}∘K_F を再帰で計算し、
# 帰納段 F^{e_F+r}∘F^{e_F+1}=F^{2e_F+r+1}=F^{e_F+r+1}（e_F=qλ_F、伝播）で K^{<r>}=F^{e_F+r} を検査する。
# さらに F^{e_F},...,F^{e_F+λ_F-1} が C_F を尽くし互いに異なること（等しければ μ_F からの一周期へ還元して
# 剰余が一致し r=r' となる）、K_F の位数が λ_F であることを検査する。
# 帰属: 有限集合の写像の等号、非負整数の除法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
group_powers_checked = 0
distinct_pairs = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers = cycle_group_data(table)
    cycle = cycle_part(mu, lam, powers)
    cycle_set = frozenset(cycle)
    E = powers[e]
    q = e // lam
    K = powers[e + 1]
    assert e + 1 >= mu and K in cycle_set
    # 群の冪の帰納
    gp = E
    for r in range(lam + 1):
        assert gp == powers[e + r]
        group_powers_checked += 1
        nxt = compose(gp, K)
        assert nxt == powers[2 * e + r + 1]                       # 反復回数の加法
        assert 2 * e + r + 1 == (e + r + 1) + q * lam             # e_F = qλ_F
        assert e + r + 1 >= mu
        assert propagate(powers, e + r + 1, q, lam) == powers[e + r + 1]
        gp = nxt
    # 一周期分が C_F を尽くす: 各 F^{μ_F+s} に対し r := (μ_F+s-e_F) mod λ_F で F^{e_F+r} = F^{μ_F+s}
    listed = [powers[e + r] for r in range(lam)]
    for s in range(lam):
        r = (mu + s - e) % lam
        # e_F + r と μ_F + s の差は λ_F の倍数で、両者とも ≥ μ_F
        lo, hi = sorted((e + r, mu + s))
        assert (hi - lo) % lam == 0 and lo >= mu
        assert propagate(powers, lo, (hi - lo) // lam, lam) == powers[lo]
        assert listed[r] == powers[mu + s]
    assert frozenset(listed) == cycle_set
    # 相異性: F^{e_F+r} = F^{e_F+r'} なら μ_F からの一周期へ還元した剰余が等しく r = r'
    for r in range(lam):
        for r2 in range(r + 1, lam):
            s = (e + r - mu) % lam
            s2 = (e + r2 - mu) % lam
            assert powers[e + r] == powers[mu + s] and powers[e + r2] == powers[mu + s2]
            assert s != s2                                        # 一周期内の相異性の対偶
            assert powers[e + r] != powers[e + r2]
            distinct_pairs += 1
    assert len(frozenset(listed)) == lam
    # 位数 λ_F: K^{<λ_F>} = E_F で、0 < r < λ_F では K^{<r>} ≠ E_F
    assert powers[e + lam] == E
    for r in range(1, lam):
        assert powers[e + r] != E
    instances += 1

print("global maps checked: {}".format(instances))
print("group powers checked against F^(e_F+r): {}".format(group_powers_checked))
print("distinct pairs checked: {}".format(distinct_pairs))
print("RESULT: PASS")
