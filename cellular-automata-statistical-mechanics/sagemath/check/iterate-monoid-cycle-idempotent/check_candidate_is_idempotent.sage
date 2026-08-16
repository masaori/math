# 対象ラベル: claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent
# 併せて検証するラベル: def_iterate_monoid_cycle_idempotent_candidate
# E_F = F^{e_F} が巡回部 C_F に属し、周期の伝播 F^{e_F} = F^{e_F + qλ_F}（e_F = qλ_F）を経て E_F∘E_F = E_F となることを、
# 人手証明の各段（e_F+e_F = e_F+qλ_F、伝播の逐次適用）に分けて検査する。
# 帰属: 有限集合の写像の等号、非負整数の演算だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
propagation_steps = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, powers = mu_lambda_powers(table)
    e = min(k for k in range(mu * lam + 1) if mu <= k and k % lam == 0)
    q = e // lam
    assert e == q * lam and mu <= e
    candidate = powers[e]
    # E_F ∈ C_F（安定後尾は一周期分で尽くされる）
    assert candidate in cycle_part(mu, lam, powers)
    # 周期の伝播を e_F, e_F+λ_F, ..., e_F+(q-1)λ_F に順に適用
    for d in range(q):
        assert powers[e + d * lam] == powers[e + (d + 1) * lam]
        propagation_steps += 1
    assert powers[e] == powers[e + q * lam]
    # E_F ∘ E_F = F^{e_F+e_F} = F^{e_F+qλ_F} = F^{e_F} = E_F
    assert compose(candidate, candidate) == powers[e + e]
    assert e + e == e + q * lam
    assert powers[e + e] == powers[e]
    assert compose(candidate, candidate) == candidate
    instances += 1

print("global maps checked: {}".format(instances))
print("period propagation steps checked: {}".format(propagation_steps))
print("RESULT: PASS")
