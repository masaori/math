import os
load(os.path.join(directory, '_prelude.sage'))
# claim_torus_quadratic_sign_polarization: 分配律と q の二項への再代入。
for a, b, h1, v1, h2, v2 in cases():
    substituted = parity((h1+h2)*(v1+v2)+(1-a)*(h1+h2)+(1-b)*(v1+v2))
    expanded = parity((h1*v1+(1-a)*h1+(1-b)*v1)
                      +(h2*v2+(1-a)*h2+(1-b)*v2)+h1*v2+h2*v1)
    quadratic = parity(exponent(a,b,h1,v1)+exponent(a,b,h2,v2)+h1*v2+h2*v1)
    assert substituted == expanded
    assert expanded == quadratic
