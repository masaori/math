import os
load(os.path.join(directory, '_prelude.sage'))
# claim_torus_quadratic_sign_polarization: 合同式から符号の積へ。
for a, b, h1, v1, h2, v2 in cases():
    h, v = parity(h1+h2), parity(v1+v2)
    lhs = (-1)^exponent(a,b,h,v)
    via_congruence = (-1)^(exponent(a,b,h1,v1)+exponent(a,b,h2,v2)+h1*v2+h2*v1)
    product_sign = (-1)^exponent(a,b,h1,v1) * (-1)^exponent(a,b,h2,v2) * (-1)^(h1*v2+h2*v1)
    assert lhs == via_congruence
    assert via_congruence == product_sign
