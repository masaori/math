# 式ペア: Omega_L(0)=2 かつ Omega_L(1)=0。
# 帰属: ZZ。全配位の有限列挙だけを使う。
load("_prelude.sage")
for L, Z, coefficients in COEFFICIENT_CASES:
    assert coefficients[0] == ZZ(2)
    assert coefficients[1] == ZZ(0)
print("RESULT: PASS")
