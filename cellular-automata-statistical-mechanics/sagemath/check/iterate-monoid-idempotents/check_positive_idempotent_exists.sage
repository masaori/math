# 対象ラベル: claim_positive_idempotent_iterate_exists
# 正の冪等指数 e の存在を、人手証明の構成（i = 0 なら e = p、i >= 1 なら e = i p）どおりに検査する。
# i = 0 の側は F^p = F^0 と F^0 ∘ F^0 = F^0 の各行、i >= 1 の側は e >= i、加法則 F^{e+e} = F^e ∘ F^e、
# 「以後の周期」を i 回適用する各行 F^{(e+kp)+p} = F^{e+kp} を一行ずつ検査する。
# 帰属: 有限集合の写像の等号と非負整数の四則だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
case_zero = 0
case_positive = 0
period_applications = 0
for stage_size, rule, table in exhaustive_instances():
    scan = scan_bound(stage_size)
    found = first_collision(power_tables(table, scan))
    assert found is not None
    i, j = found
    p = j - i
    assert p >= 1
    if i == 0:
        e = p
        powers = power_tables(table, 2 * e)
        assert e >= 1                                     # e は正
        assert powers[p] == powers[j]                     # p = j（i = 0）
        assert powers[j] == powers[i]                     # 衝突 F^i = F^j
        assert powers[i] == powers[0] == identity_table(2 ** stage_size)  # F^0 = id
        assert compose(powers[e], powers[e]) == compose(powers[0], powers[0])  # F^p = F^0 の代入
        assert compose(powers[0], powers[0]) == powers[0]  # id ∘ id = id
        assert powers[0] == powers[e]                      # F^p = F^0
        case_zero += 1
    else:
        e = i * p
        assert e >= 1 and e >= i                          # p >= 1 より e = i p >= i >= 1
        powers = power_tables(table, 2 * e)
        assert compose(powers[e], powers[e]) == powers[e + e]  # 加法則 F^{e+e} = F^e ∘ F^e
        assert e + e == e + i * p                          # e = i p
        # claim_iterate_collision_gives_repeating_tail を指数 e, e+p, ..., e+(i-1)p に順に適用
        for k in range(i):
            base = e + k * p
            assert base >= i                               # 適用条件 n >= i（e >= i より）
            assert powers[base + p] == powers[base]
            period_applications += 1
        assert powers[e + i * p] == powers[e]              # i 回適用した結論
        case_positive += 1
    # どちらの場合も冪等
    assert compose(powers[e], powers[e]) == powers[e]
    instances += 1

print("global maps checked: {}".format(instances))
print("case i = 0: {}, case i >= 1: {}".format(case_zero, case_positive))
print("eventual-period applications checked: {}".format(period_applications))
print("RESULT: PASS")
