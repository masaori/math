# 対象ラベル: claim_iterate_monoid_stable_period_multiple_exists
# 併せて検証するラベル: def_iterate_monoid_stable_period_multiple_exponents, def_iterate_monoid_minimal_stable_period_multiple
# 証人 μ_F·λ_F が D_F に属すること、D_F を有限範囲で列挙した最小元 e_F が μ_F 以上で λ_F の倍数であることを検査する。
# 帰属: 非負整数の乗法・除法・大小比較だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_common.sage'))

instances = 0
witnesses = 0
for stage_size, rule, table in exhaustive_instances():
    mu, lam, powers = mu_lambda_powers(table)
    n = mu * lam
    assert n % lam == 0
    assert mu <= n
    witnesses += 1
    # D_F を 0..(μ_F·λ_F) の有限範囲で列挙する。証人 μ_F·λ_F が属するので min はこの範囲で確定する。
    admissible = [k for k in range(mu * lam + 1) if mu <= k and k % lam == 0]
    assert len(admissible) >= 1
    e = min(admissible)
    assert mu <= e and e % lam == 0
    assert all(not (mu <= k and k % lam == 0) for k in range(e))
    instances += 1

print("global maps checked: {}".format(instances))
print("witnesses mu*lambda in D_F: {}".format(witnesses))
print("RESULT: PASS")
