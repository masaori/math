# 対象ラベル: claim_event_set_cardinality
# E_tau=[0,tau] x V と |E_tau|=(tau+1)|V| の各等号を有限集合として検査する。
# 帰属: 非負整数と有限集合の等号だけを使う。R/C 脱出なし。

tested = 0
for tau in range(8):
    time_interval = tuple(range(tau + 1))
    for stage_size in range(8):
        stage = tuple(range(stage_size))
        event_set = {(t, v) for t in time_interval for v in stage}
        assert len(event_set) == len(time_interval) * len(stage)
        assert len(time_interval) * len(stage) == (tau + 1) * stage_size
        tested += 1

print("event set cardinalities checked: {}".format(tested))
print("RESULT: PASS")
