# 対象ラベル: claim_collision_free_coarse_graining_is_sufficient_on_constant_sequences
# 衝突を持たない粗視化が定数列の族の箱サイズ極限に十分であることの有限側を確認する。
# 帰属: QQ・ZZ と有限列だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。

L_TOP = 12
PRIMES = list(primes(2, 60))

def prime_exponent_data(q):
    q = QQ(q)
    return tuple(q.valuation(p) for p in PRIMES)

COARSE_GRAININGS = [
    ("恒等写像", lambda q: QQ(q)),
    ("素指数データ", prime_exponent_data),
]

VALUES = [QQ(n) / QQ(d) for n in range(1, 9) for d in range(1, 9)]

for name, pi in COARSE_GRAININGS:
    # 段 1: 検査する正の有理数の範囲で pi が値の衝突を持たないこと。
    for u in VALUES:
        for w in VALUES:
            if pi(u) == pi(w):
                assert u == w

                # 本文の構成: すべての L で A(L)=u, B(L)=w, M(L)=1。
                for L in range(1, L_TOP + 1):
                    A = u
                    B = w
                    M = ZZ(1)

                    # 段 2: 三つの列の値の帰属。
                    assert A in QQ and A > 0
                    assert B in QQ and B > 0
                    assert M in ZZ and M >= 1

                    # 段 3: 粗視化の一致と衝突なしから元の値が一致すること。
                    assert pi(A) == pi(B)
                    assert A == B

                    # 段 4: M(L)=1 なので乗根列は元の定数列そのものであること。
                    a = A
                    b = B
                    assert a**M == A
                    assert b**M == B
                    assert a == u
                    assert b == w

                    # 段 5: それぞれの候補値との差が 0 で、候補値も一致すること。
                    assert a - u == 0
                    assert b - w == 0
                    assert u == w

# 段 6: 衝突を持つ写像では逆向きが破れること。
collapse = lambda q: ZZ(0)
u = QQ(1)
w = QQ(2)
assert collapse(u) == collapse(w)
assert u != w

print("PASS: 衝突を持たない粗視化は定数列の箱サイズ極限に十分である（有限側の検査）")
