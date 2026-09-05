# 対象ラベル: claim_fixed_point_count_decomposition
# 式ペア・判定: 直接反復の不動点集合と独立な軌道走査の周期整除を照合
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = zero = positive = 0
for size, rule, configs, mapping in elementary_maps():
    periodic = {}
    for x in range(len(mapping)):
        seen = {}
        y = x
        while y not in seen:
            seen[y] = len(seen)
            y = mapping[y]
        if y == x:
            periodic[x] = len(seen)
    current = tuple(range(len(mapping)))
    for n in range(1,2*len(mapping)+1):
        current = tuple(mapping[y] for y in current)
        fixed = {x for x,y in enumerate(current) if x == y}
        predicted = {x for x,period in periodic.items() if n % period == 0}
        assert fixed == predicted
        assert len(fixed) == sum(period for period in set(periodic.values()) if n%period == 0
            for _ in range(sum(p == period for p in periodic.values())//period))
        assert 0 <= len(fixed) <= 2**size
        zero += not fixed
        positive += bool(fixed)
        checked += 1
assert checked == sum(256*2*(2**size) for size in SIZES)
assert zero > 0 and positive > 0
print('time inputs:', checked, 'zero:', zero, 'positive:', positive)

print("RESULT: PASS")
