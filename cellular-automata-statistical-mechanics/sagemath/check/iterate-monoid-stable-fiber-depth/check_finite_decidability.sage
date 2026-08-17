# 対象ラベル: claim_iterate_monoid_stable_fiber_depth_finite_decidability
# M := 2^{|V|} に対し、全 y で μ(y) <= M（実際には μ(y)+π(y) <= M と π(y) >= 1）、
# 各 q ∈ Q_F で |B_F(q)| = Σ_{k∈[0,M]} |L_F(q,k)|、および
# 「Q_F と B_F(q) を有限決定し、各配位の μ(y) を走査で決め、各配位を一度だけその層へ加える」手続きが
# 定義どおりの層と個数に一致することを確かめる。
# 帰属: 有限集合の個数と非負整数の加算・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
fibers_checked = 0
scan_comparisons = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    assert M == 2 ** stage_size
    # μ(y) <= M（claim_min_preperiod_period_bound と π >= 1）
    for y in range(M):
        m, p = mp[y]
        assert p >= 1 and m + p <= M and m <= M
    # 走査による μ(y) の決定（claim_min_preperiod_period_finite_decidability の式）
    scanned = {}
    for y in range(M):
        orb = orbit(F, y, M)
        found = None
        for i in range(M + 1):
            for p in range(1, M - i + 1):
                scan_comparisons += 1
                if orb[i + p] == orb[i]:
                    found = i
                    break
            if found is not None:
                break
        assert found is not None and found == mu_of[y]
        scanned[y] = found
    # 各配位を一度だけその値の層へ加える手続き
    built = {q: {k: set() for k in range(M + 1)} for q in Q}
    for y in range(M):
        built[E[y]][scanned[y]].add(y)
    for q in Q:
        for k in range(M + 1):
            assert frozenset(built[q][k]) == layers[q][k]
        # 個数の分解
        assert len(fibers[q]) == sum(len(layers[q][k]) for k in range(M + 1))
        assert len(fibers[q]) == sum(len(built[q][k]) for k in range(M + 1))
        fibers_checked += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("stable fibers checked: {}".format(fibers_checked))
print("scan comparisons: {}".format(scan_comparisons))
print("RESULT: PASS")
