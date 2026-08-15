# 対象ラベル: claim_order_iso_not_time_preserving
# 一元舞台・定値規則・tau=1 の反例を構成し、順序保存と時刻非保存を段ごとに検査する。
# 帰属: 2 元状態集合、有限集合、有限関係、非負整数の等号だけを使う。R/C 脱出なし。

import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '_prelude.sage'))

stage = (0,)
neighborhood = {0: (0,)}
local_inputs = ((0,), (1,))
local_rule = {configuration: 0 for configuration in local_inputs}
support = frozenset(
    cell for cell in neighborhood[0]
    if any(local_rule[x] != local_rule[y]
           for x in local_inputs for y in local_inputs
           if all(x[i] == y[i] for i, w in enumerate(neighborhood[0]) if w != cell))
)
assert support == frozenset()

tau = 1
event_set = events(tau, len(stage))
dependency = frozenset()
closure = reachability(event_set, dependency)
order = reflexive_order(event_set, dependency)
assert dependency == frozenset()
assert closure == frozenset()
assert all(((a, b) in order) == (a == b) for a in event_set for b in event_set)

sigma = {(0, 0): (1, 0), (1, 0): (0, 0)}
assert frozenset(sigma) == frozenset(event_set)
assert frozenset(sigma.values()) == frozenset(event_set)
assert all(sigma[sigma[a]] == a for a in event_set)
assert all(((a, b) in order) == ((sigma[a], sigma[b]) in order)
           for a in event_set for b in event_set)
assert any(a[0] != sigma[a][0] for a in event_set)

print("events checked: {}; ordered pairs checked: {}".format(len(event_set), len(event_set) ** 2))
print("RESULT: PASS")
