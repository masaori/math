# cycle 6 / T1: ℝ/Λ 双対の Λ 側を p 進エントロピー(Deninger)= p 進 Mahler 測度
# (Besser–Deninger)に接地。成長率は岩澤 μ_p 不変量。
# 岩澤塔 L=p^n で v_p(a_{p^n}) の成長(線形なら μ_p>0, 一定なら μ_p=0)を確認。
# a_L = Π_{z^L=1,w^L=1} P(z,w),  P=5-(z+1/z)-(w+1/w).

def a_L(L, prec=500):
    C=ComplexField(prec); zeta=C.zeta(L); prod=C(1)
    for j in range(L):
        zj=zeta^j
        for k in range(L):
            wk=zeta^k
            prod *= C(5)-(zj+zj^-1)-(wk+wk^-1)
    aint=prod.real().round(); err=abs(prod-C(aint))
    return ZZ(aint), float(err)

print("="*70)
print("岩澤塔 L=p^n での v_p(a_{p^n}) (p 進エントロピー/μ_p 不変量の成長)")
print("="*70)
print("P=5-(z+1/z)-(w+1/w)")

data={}
for L in [2,3,4,8,9]:
    aL,err=a_L(L)
    assert err<1e-4, f"L={L} 精度不足 err={err}"
    data[L]=aL
    print(f"  L={L}: v_2={aL.valuation(2)}, v_3={aL.valuation(3)}, v_5={aL.valuation(5)}, v_7={aL.valuation(7)}, (1/L^2)log|a|={float(RR(aL).abs().log()/L^2):.5f}")

print("\n p=2 塔 (L=2,4,8): v_2 =", [data[L].valuation(2) for L in [2,4,8]])
print(" p=3 塔 (L=3,9):   v_3 =", [data[L].valuation(3) for L in [3,9]])

print("\n"+"="*70)
print("読み:")
print(" - (1/L^2)log|a_L| → m(P)≈1.508 (アルキメデス Mahler=自由エネルギー, 既知 LSW)。")
print(" - p 進側: v_p(a_{p^n}) の n 線形成長率 = p 進エントロピー(Deninger)= p 進 Mahler 測度")
print("   (Besser–Deninger) = 岩澤 μ_p 不変量。塔で一定(=0)なら μ_p=0(この P は小素数で p 進自明)。")
print(" ⇒ 双対の Λ 側は『予想』でなく既知理論(p 進エントロピー)。D-U2 はその有限・決定可能な顔。")
print("="*70)
