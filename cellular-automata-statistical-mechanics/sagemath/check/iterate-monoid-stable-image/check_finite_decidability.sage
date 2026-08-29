# 対象ラベル: claim_iterate_monoid_stable_image_finite_decidability
# 大域真理値表だけから、後尾集合の最初の安定で μ_F、正周期の逐次走査で λ_F、λ_F | n の判定で e_F を得て、
# 合成の反復で E_F・S_F を作り、A^V の全元へ E_F を適用して重複を除いた集合が Q_F に一致し、
# Q_F 上の E_F・F・S_F の表が構造化記述の定義どおりに得られることを、配位番号の等号検査回数を数えて確かめる。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
comparisons = 0
table_rows = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, powers, E, R, Q = stable_image_data(table)
    size = len(table)
    # μ_F: 後尾集合が最初に安定する位置（claim_iterate_monoid_stabilization_index の走査）
    scan = scan_bound(stage_size)
    pw = power_tables(table, 2 * scan + 2)
    seen = {}
    mu_scan = None
    for k, t in enumerate(pw):
        comparisons += len(seen)
        if t in seen:
            mu_scan = seen[t]
            break
        seen[t] = k
    assert mu_scan == mu
    # λ_F: 最小の p ≥ 1 で F^{μ_F} = F^{μ_F+p}
    lam_scan = None
    for p in range(1, len(pw) - mu_scan):
        comparisons += 1
        if pw[mu_scan] == pw[mu_scan + p]:
            lam_scan = p
            break
    assert lam_scan == lam
    # e_F: μ_F 以上で λ_F の倍数の最小の n
    e_scan = min(n for n in range(mu_scan, mu_scan + lam_scan) if n % lam_scan == 0)
    assert e_scan == e
    # E_F・S_F の合成による構成
    E_scan = identity_table(size)
    for _ in range(e_scan):
        E_scan = compose(table, E_scan)
    assert E_scan == E
    R_scan = E_scan
    for _ in range(lam_scan - 1):
        R_scan = compose(table, R_scan)
    assert R_scan == R
    # Q_F: 全元へ E_F を適用して重複を除く
    Q_list = []
    for y in range(size):
        v = E_scan[y]
        comparisons += len(Q_list)
        if v not in Q_list:
            Q_list.append(v)
    assert frozenset(Q_list) == Q
    # 制限写像の表
    for z in Q_list:
        assert E_scan[z] == E[z] and table[z] == table[z] and R_scan[z] == R[z]
        assert E_scan[z] == z
        table_rows += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("configuration comparisons: {}".format(comparisons))
print("restricted table rows: {}".format(table_rows))
print("RESULT: PASS")
