# 対象ラベル: claim_iterate_monoid_cycle_idempotent_unique
# 巡回部 C_F の全元 G = F^{μ_F+r} を走査し、冪等な G について人手証明の各段
# （F^{2n}=F^n、s=(μ_F+2r) mod λ_F、F^{μ_F+r}=F^{μ_F+s}、r=s、λ_F | n、e_F ≤ n、F^n=F^{e_F}）を検査し、
# 巡回部の冪等元がちょうど一つで E_F に等しいことを確認する。
# 帰属: 有限集合の写像の等号、非負整数の除法だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
cycle_elements = 0
idempotents_in_cycle = 0
transient_idempotents = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, powers = mu_lambda_powers(table)
    e = min(k for k in range(mu * lam + 1) if mu <= k and k % lam == 0)
    candidate = powers[e]
    found = []
    for r in range(lam):
        n = mu + r
        g = powers[n]
        cycle_elements += 1
        if compose(g, g) != g:
            continue
        found.append(g)
        # F^{2n} = F^n
        assert powers[2 * n] == g
        assert 2 * n == mu + (mu + 2 * r)
        s = (mu + 2 * r) % lam
        assert 0 <= s < lam
        # 周期の除去: F^{μ_F+(μ_F+2r)} = F^{μ_F+s}
        t0 = (mu + 2 * r) // lam
        for d in range(t0):
            assert powers[mu + s + d * lam] == powers[mu + s + (d + 1) * lam]
        assert powers[mu + r] == powers[mu + s]
        # 一周期分の相異性から r = s
        assert r == s
        assert (mu + r) % lam == 0
        assert n >= mu
        # n ∈ D_F、e_F ≤ n、n = e_F + tλ_F、伝播で F^{e_F} = F^n
        assert e <= n
        assert (n - e) % lam == 0
        t = (n - e) // lam
        for d in range(t):
            assert powers[e + d * lam] == powers[e + (d + 1) * lam]
        assert powers[e] == powers[n]
        assert g == candidate
        idempotents_in_cycle += 1
    assert len(found) == 1
    assert found[0] == candidate
    # 参考: 過渡部の冪等元は恒等写像（指数 0）に限る（主張の外だが反例探索として記録）
    for n in range(mu):
        if compose(powers[n], powers[n]) == powers[n]:
            assert n == 0
            transient_idempotents += 1
    instances += 1

print("global maps checked: {}".format(instances))
print("cycle elements scanned: {}".format(cycle_elements))
print("idempotents found in cycle parts (one per map): {}".format(idempotents_in_cycle))
print("transient idempotents (all are F^0): {}".format(transient_idempotents))
print("RESULT: PASS")
