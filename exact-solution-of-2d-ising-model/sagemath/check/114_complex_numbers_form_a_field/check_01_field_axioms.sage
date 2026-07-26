# <complex_numbers_form_a_field> と <multiplicative_group_of_cc>
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/operators.sage"))
load(os.path.join(_dir, "_prelude.sage"))
import numpy as np
import math
rng = np.random.default_rng(int(215))
rep = CheckReport("complex_numbers_form_a_field")
def add(a,b): return complex(a.real+b.real, a.imag+b.imag)          # <definition_of_cc> の和
def mul(a,b): return complex(a.real*b.real - a.imag*b.imag,
                             a.real*b.imag + a.imag*b.real)          # <definition_of_cc> の積
zs = sample_complex(rng)[:40]
for a in zs[:20]:
    for b in zs[:20]:
        rep.close(add(a,b), a+b, "和の定義式")
        rep.close(mul(a,b), a*b, "積の定義式")
        rep.close(mul(a,b), mul(b,a), "積の可換性")
        rep.close(add(a,b), add(b,a), "和の可換性")
for a in zs[:12]:
    for b in zs[:12]:
        for c in zs[:6]:
            rep.close(mul(mul(a,b),c), mul(a,mul(b,c)), "積の結合律")
            rep.close(add(add(a,b),c), add(a,add(b,c)), "和の結合律")
            rep.close(mul(a,add(b,c)), add(mul(a,b),mul(a,c)), "分配律")
one = complex(1,0); zero = complex(0,0)
for a in zs:
    rep.close(mul(a,one), a, "1 は積の単位元")
    rep.close(add(a,zero), a, "0 は和の単位元")
    rep.close(add(a, complex(-a.real,-a.imag)), zero, "加法逆元")
    if abs(a) > 1e-12:
        inv = complex(a.real/(a.real**2+a.imag**2), -a.imag/(a.real**2+a.imag**2))
        rep.close(mul(a,inv), one, "乗法逆元（C^x が群）")
        rep.close(inv, 1/a, "逆元の表示 z^{-1} = 1/z")
rep.finish()
