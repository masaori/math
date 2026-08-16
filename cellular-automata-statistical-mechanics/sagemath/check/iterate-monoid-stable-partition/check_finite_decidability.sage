# 対象ラベル: claim_iterate_monoid_stable_fibers_finite_decidability
# 前章の走査（claim_iterate_monoid_stable_image_finite_decidability）で Q_F と E_F の表を得たうえで、
# A^V の各元 y について E_F(y) を読み、等しい q ∈ Q_F のファイバーへ一度だけ加える走査を行い、
# 得られたファイバーと個数が定義どおりの B_F(q) と |B_F(q)| に一致し、各元がちょうど一度加えられることを
# 二値状態（配位番号）の等号検査回数を数えて確かめる。
# 帰属: 有限集合の写像の等号、非負整数だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
comparisons = 0
insertions = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, e, E, Q, fibers = stable_partition_data(table)
    size = len(E)
    # 前章の走査どおり Q_F の表を作る
    Q_list = []
    for y in range(size):
        v = E[y]
        comparisons += len(Q_list)
        if v not in Q_list:
            Q_list.append(v)
    assert frozenset(Q_list) == Q
    # 各 y を E_F(y) と等しい q のファイバーへ一度だけ加える
    scanned = {q: [] for q in Q_list}
    added_count = {y: 0 for y in range(size)}
    for y in range(size):
        v = E[y]
        for q in Q_list:
            comparisons += 1
            if v == q:
                scanned[q].append(y)
                added_count[y] += 1
                insertions += 1
                break
    for y in range(size):
        assert added_count[y] == 1                   # 各元はちょうど一度加えられる
    for q in Q_list:
        assert frozenset(scanned[q]) == fibers[q]    # def_iterate_monoid_stable_fiber
        assert ZZ(len(scanned[q])) == ZZ(len(fibers[q]))
        assert len(scanned[q]) >= 1
    assert sum(len(scanned[q]) for q in Q_list) == size
    instances += 1

print("global maps checked: {}".format(instances))
print("configuration comparisons: {}".format(comparisons))
print("fiber insertions: {}".format(insertions))
print("RESULT: PASS")
