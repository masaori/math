# 対象ラベル: trace_of_idempotent
# 準備の鎖 Q^2 = Q^1 Q = (Q^0 Q)Q = (IQ)Q = QQ を、Q の成分を QQ 上の不定元に置いて n = 1..5 で確かめる。
load("_prelude.sage")

for n in SIZES:
    Ring, _, (Q,) = generic_ring([("Q", n, n)])
    I = body_identity(Ring, n)
    lines = [
        body_power(Q, 2),                                          # Q^2
        body_product(body_power(Q, 1), Q),                         # Q^1 Q        (A^{m+1} := A^m A, m = 1)
        body_product(body_product(body_power(Q, 0), Q), Q),        # (Q^0 Q) Q    (同, m = 0)
        body_product(body_product(I, Q), Q),                       # (I Q) Q      (A^0 := I)
        body_product(Q, Q),                                        # Q Q          (左単位元)
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (n, t)
    assert lines[0] == Q^2 and lines[-1] == Q * Q                  # Sage の冪・行列積と比べる
    print(f"n = {n}: 準備の鎖の 4 個の等号を不定元で確かめた")

print("RESULT: PASS")
