# 対象ラベル: claim_iterate_collision_stabilizes_tails
# 衝突 F^i = F^j (i < j) のとき、n >= i なら I_n(F) = I_i(F) を両包含で検査する。
# I_n ⊆ I_i は H = F^{n+k} = F^{i+(d+k)}（n = i + d）。I_i ⊆ I_n は以後の周期を d 回適用した
# F^{i+k+dp} = F^{i+k}、q := k + dp - d >= 0、H = F^{i+k} = F^{i+k+dp} = F^{(i+d)+q} = F^{n+q} を一行ずつ検査する。
# 帰属: 有限集合の写像の等号と非負整数の加減だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

instances = 0
lines = 0
for stage_size, rule, table in exhaustive_instances():
    powers, i, j = monoid_and_collision(table)
    p = j - i
    assert p >= 1
    n_max = i + j + 2
    kmax = j
    powers = power_tables(table, n_max + kmax + (n_max - i) * p + 2)
    assert powers[i] == powers[j]
    for n in range(i, n_max + 1):
        d = n - i
        assert d >= 0 and n == i + d
        tail_n = tail_by_definition(powers, n, n + j)
        tail_i = tail_by_definition(powers, i, i + j)
        for k in range(0, kmax + 1):
            # I_n ⊆ I_i
            H = powers[n + k]
            assert n + k == i + (d + k)                        # n = i + d
            assert H == powers[i + (d + k)] and H in tail_i
            # I_i ⊆ I_n
            H = powers[i + k]
            cur = i + k
            for _ in range(d):                                 # 以後の周期を d 回
                assert powers[cur + p] == powers[cur]
                cur += p
            assert cur == i + k + d * p
            assert powers[i + k + d * p] == powers[i + k]
            assert k + d * p >= d                              # p >= 1, k >= 0
            q = k + d * p - d
            assert q >= 0
            assert i + k + d * p == (i + d) + q                # q の置き方
            assert (i + d) + q == n + q                        # n = i + d
            assert H == powers[n + q] and H in tail_n
            lines += 1
        assert tail_n == tail_i                                # 集合の等号
    instances += 1

print("global maps checked: {}".format(instances))
print("stabilization lines checked: {}".format(lines))
print("RESULT: PASS")
