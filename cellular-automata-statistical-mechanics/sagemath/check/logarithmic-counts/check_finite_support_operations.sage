# 対象ラベル: def_prime_vector_additive_operations
# 式ペア・判定: 和・逆元・整数倍の台と整数係数
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
checked = 0
for a, b in vector_pairs():
    assert set(add(a,b)) <= set(a) | set(b)
    assert set(neg(a)) <= set(a)
    for d in range(-3,4):
        result = scale(d,a)
        assert set(result) <= set(a)
        assert all(z in ZZ for z in result.values())
    assert all(p.is_prime() and z != 0 for p,z in a.items())
    checked += 1
assert checked > 0
print("cases checked:", checked)
print("RESULT: PASS")
