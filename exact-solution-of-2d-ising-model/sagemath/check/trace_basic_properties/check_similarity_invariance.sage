# 対象ラベル: trace_basic_properties
# (4) P'P = I なら tr(P(AP')) = tr(A) の鎖を一行ずつ。A の成分を QQ(i) 上の不定元に置き、
# P は QQ(i) の具体の可逆行列、P' は Sage の inverse で求めた行列とする（仮定 P'P = I を成分の式の積で確かめる）。
# 一般の P, P' で P'P = I を不定元のまま課すことは多項式環ではできないので、代入の行は具体の P で確かめる。
# 結合律の行と (2) の行は、P, P' も不定元に置いた一般の等式としても確かめる。
load("_prelude.sage")

for n in SIZES:
    Ring, _, (A,) = generic(n, ["A"], base=K)
    IK = body_identity(Ring, n)
    for seed in SEEDS:
        P = concrete_invertible(n, seed).change_ring(Ring)
        Pp = concrete_invertible(n, seed).inverse().change_ring(Ring)
        assert body_product(Pp, P) == IK                                  # 仮定 P'P = I
        PA = body_product(P, A)
        lines = [
            body_trace(body_product(P, body_product(A, Pp))),              # tr(PAP')（P(AP') の順に組む）
            body_trace(body_product(PA, Pp)),                              # tr((PA)P')
            body_trace(body_product(Pp, PA)),                              # tr(P'(PA))      ((2))
            body_trace(body_product(body_product(Pp, P), A)),              # tr((P'P)A)      (結合律)
            body_trace(body_product(IK, A)),                               # tr(I A)         (P'P = I)
            body_trace(A),                                                 # tr(A)           (左単位元)
        ]
        for t in range(len(lines) - 1):
            assert lines[t] == lines[t + 1], (n, seed, t)
        assert lines[0] == (P * A * Pp).trace() and lines[-1] == A.trace()
    # 結合律の行と (2) の行を、P, P', A をすべて不定元に置いた一般の等式で
    Ring2, _, (Ag, Pg, Ppg) = generic(n, ["A", "P", "Q"])
    PAg = body_product(Pg, Ag)
    assert body_product(Pg, body_product(Ag, Ppg)) == body_product(PAg, Ppg)
    assert body_trace(body_product(PAg, Ppg)) == body_trace(body_product(Ppg, PAg))
    assert body_product(Ppg, PAg) == body_product(body_product(Ppg, Pg), Ag)
    assert body_product(body_identity(Ring2, n), Ag) == Ag
    print(f"n = {n}: 具体の P {len(SEEDS)} 個で鎖の 5 個の等号と主張、結合律・(2)・左単位元の行を不定元で確かめた")

print("RESULT: PASS")
