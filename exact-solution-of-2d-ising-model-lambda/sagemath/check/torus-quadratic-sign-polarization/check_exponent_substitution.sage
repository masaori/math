import os
load(os.path.join(directory, '_prelude.sage'))
# claim_torus_quadratic_sign_polarization: q(h1⊕h2,v1⊕v2) の定義と合同代入。
for a, b, h1, v1, h2, v2 in cases():
    h, v = parity(h1+h2), parity(v1+v2)
    lhs = parity(exponent(a,b,h,v))
    definition = parity(h*v+(1-a)*h+(1-b)*v)
    substituted = parity((h1+h2)*(v1+v2)+(1-a)*(h1+h2)+(1-b)*(v1+v2))
    assert lhs == definition
    assert definition == substituted
