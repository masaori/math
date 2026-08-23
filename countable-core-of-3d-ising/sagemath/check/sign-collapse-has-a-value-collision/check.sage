# 対象ラベル: claim_sign_collapse_has_a_value_collision
# 素指数データの各成分を符号だけへ潰す写像が値の衝突を持つことを、
# 本文と同じ証人 u = 2, w = 4 で確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

# 無限積の成分のうち明示的に検査する有限個の素数。
# 本文は「2 での成分」と「2 以外の素数での成分」に分けているので、
# 後者の計算が p != 2 だけに依存することを、この有限標本で一行ずつ追う。
PRIMES_CHECKED = [ZZ(p) for p in primes(50)]

def sgn(n):
    n = ZZ(n)
    if n > 0:
        return ZZ(1)
    if n < 0:
        return ZZ(-1)
    return ZZ(0)

def sign_collapse_component(a, p):
    return sgn(a.valuation(p))

# 本文の証人。いずれも正の有理数である。
u = QQ(2)
w = QQ(4)
assert u in QQ and w in QQ
assert u > 0 and w > 0

# 段 1: 素数 2 での素指数は 1 と 2 で異なる。
assert ZZ(u.valuation(2)) == ZZ(1)
assert ZZ(w.valuation(2)) == ZZ(2)
assert ZZ(u.valuation(2)) != ZZ(w.valuation(2))

# 段 2: 1 と 2 はともに正なので、符号へ潰した成分は 1 で一致する。
assert sign_collapse_component(u, 2) == ZZ(1)
assert sign_collapse_component(w, 2) == ZZ(1)
assert sign_collapse_component(u, 2) == sign_collapse_component(w, 2)

# 段 3: 2 以外の素数では素指数がともに 0 であり、符号も 0 で一致する。
for p in PRIMES_CHECKED:
    if p == 2:
        continue
    assert ZZ(u.valuation(p)) == ZZ(0)
    assert ZZ(w.valuation(p)) == ZZ(0)
    assert sign_collapse_component(u, p) == ZZ(0)
    assert sign_collapse_component(w, p) == ZZ(0)
    assert sign_collapse_component(u, p) == sign_collapse_component(w, p)

# 段 4: 検査したすべての素数で像が一致する。
image_u = tuple(sign_collapse_component(u, p) for p in PRIMES_CHECKED)
image_w = tuple(sign_collapse_component(w, p) for p in PRIMES_CHECKED)
assert image_u == image_w

# 段 5: w - u = 2 > 0 なので u != w である。
assert w - u == QQ(2)
assert w - u > 0
assert u != w

# 段 6: 潰す前の素指数データは素数 2 の成分で異なる。
prime_exponents_u = tuple(ZZ(u.valuation(p)) for p in PRIMES_CHECKED)
prime_exponents_w = tuple(ZZ(w.valuation(p)) for p in PRIMES_CHECKED)
assert prime_exponents_u != prime_exponents_w

print("すべての段が通過した。")
