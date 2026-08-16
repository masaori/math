# 対象ラベル: claim_iterate_monoid_idempotents_finite_decidability
# 冪等元全体 Idem(P_F) が有限真理値表から有限回の 2 値状態の等号検査で決定できることを検査する。
# P_F は衝突による有限代表 {F^0, ..., F^{j-1}} として得て（前章の有限決定）、各 G について
# G ∘ G = G を全配位・全セルの 2 値状態等号へ分解した走査で判定し、その結果が定義
# Idem(P_F) = {G ∈ P_F | G ∘ G = G} と一致すること、等号検査回数が有限で上界どおりであることを見る。
# 帰属: 有限集合の写像の等号と非負整数の数え上げだけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
state_equality_checks = 0
idempotents_found = 0
for stage_size, rule, table in exhaustive_instances():
    confs = configurations(stage_size)
    M = len(confs)
    scan = scan_bound(stage_size)
    found = first_collision(power_tables(table, scan))
    assert found is not None
    i, j = found
    powers = power_tables(table, j)
    representatives = []
    for n in range(j):
        if powers[n] not in representatives:
            representatives.append(powers[n])
    # 前章の有限代表: P_F = {F^n | 0 <= n < j}
    assert set(representatives) == set(powers[:j])

    # 走査による決定: 各 G について G∘G = G を、配位ごと・セルごとの 2 値状態等号の連言として判定する
    scanned = []
    checks_this_instance = 0
    for G in representatives:
        GG = compose(G, G)
        is_idempotent = True
        for c in range(M):
            left = confs[GG[c]]
            right = confs[G[c]]
            for cell in range(stage_size):
                checks_this_instance += 1
                if left[cell] != right[cell]:
                    is_idempotent = False
        if is_idempotent:
            scanned.append(G)

    # 定義どおりの集合 {G ∈ P_F | G∘G = G} と一致する
    definition_set = [G for G in representatives if compose(G, G) == G]
    assert scanned == definition_set
    assert len(scanned) >= 1  # 単位元 F^0 = id は常に冪等
    assert identity_table(M) in scanned

    # 等号検査回数の有限性: 高々 |P_F| * M * |V| 回
    assert checks_this_instance <= len(representatives) * M * stage_size
    state_equality_checks += checks_this_instance
    idempotents_found += len(scanned)
    instances += 1

print("global maps checked: {}".format(instances))
print("idempotents found in total: {}".format(idempotents_found))
print("binary state equality checks: {}".format(state_equality_checks))
print("RESULT: PASS")
