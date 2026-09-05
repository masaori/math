# 対象ラベル: def_binary_ca_integer_conserved_observable
# 式ペア・判定: 全近傍の局所真理値表から大域表を復元
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for size, configs, index, mapping, local in ca_maps():
    assert len(configs) == 2**size
    assert len(index) == len(configs)
    for x in configs:
        assert index[global_value(local,index,x)] == mapping[index[x]]
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
