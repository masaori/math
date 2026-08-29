# 対象ラベル: claim_iterate_monoid_depth_layer_branching_finite_decidability
# 局所真理値表から、全ての層 L_F(q,k) の個数と全ての b_F(z) を有限走査で決定し、
# 一段前像数の層別総和（有限加算）が正の層・零層の両保存式を満たすことを、
# 定義どおり（全配位の所属検査・完全逆像）に計算した値との一致で確かめる。
#   - b_F(z) は配位ごとに一度の F 適用の数え上げ走査で得、定義どおりの |Pre_F(z)| と比較する。
#   - 層の個数は既有限決定の層分割（claim_iterate_monoid_stable_fiber_depth_finite_decidability）から得る。
#   - 総和は自然数の有限加算だけで計算し、層の個数（正の層は一つ上、零層は零層と一層の和）と比較する。
# 帰属: 有限集合の写像の等号・所属と非負整数の加算・等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
applications = 0
positive_identities = 0
zero_identities = 0
for stage_size, rule, table in exhaustive_instances():
    F, E, Q, fibers, sigma, mp, mu_of, layers = depth_data(table)
    M = len(F)
    # 配位ごとに一度の F 適用で全ての b_F(z) を数え上げる走査
    scan_count = {z: 0 for z in range(M)}
    for y in range(M):
        scan_count[F[y]] += 1
        applications += 1
    for z in range(M):
        assert scan_count[z] == predecessor_count(F, z)   # 定義どおりの |Pre_F(z)| と一致
    for q in Q:
        # 正の層: 総和（有限加算）が一つ上の層の個数に一致
        for k in range(1, M + 1):
            total = sum(scan_count[z] for z in layers[sigma[q]][k])
            upper = len(layers[q][k + 1]) if k + 1 <= M else 0
            assert total == upper
            assert total == len(full_preimage(F, layers[sigma[q]][k]))  # 定義どおりの完全逆像の個数
            positive_identities += 1
        # 零層: 総和（有限加算）が零層と一層の個数の和に一致
        total0 = sum(scan_count[z] for z in layers[sigma[q]][0])
        assert total0 == len(layers[q][0]) + len(layers[q][1])
        assert total0 == len(full_preimage(F, layers[sigma[q]][0]))     # 定義どおりの完全逆像の個数
        zero_identities += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("F applications in counting scan: {}".format(applications))
print("positive layer identities checked: {}".format(positive_identities))
print("zero layer identities checked: {}".format(zero_identities))
print("RESULT: PASS")
