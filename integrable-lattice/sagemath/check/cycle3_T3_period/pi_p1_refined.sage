# cycle 8 / T3: π(p,1) の精密公式と等号条件。
# Tr T^N mod p = Σ_λ (m_λ mod p) λ^N (λ=相異固有値∈F̄_p, m_λ=代数的重複度)。
# 相異 λ の幾何列 λ^N は一次独立 ⇒ 周期 = lcm{ord(λ): m_λ ≢ 0 mod p}。
# よって π(p,1) = lcm{ord(λ): p ∤ m_λ}。 lcm{全 λ の ord} との等号は『全 order 寄与固有値の mult が p∤』のとき。

def trace_period_mod_p(T,p,maxN=20000):
    R=GF(p); Tm=T.change_ring(R)
    seenM={}; N=0; Pk=identity_matrix(R,T.nrows())
    while N<=maxN:
        Pk=Pk*Tm; N+=1
        key=tuple(Pk.list())
        if key in seenM:
            pre=seenM[key]; per=N-seenM[key]
            tr=[ZZ((Tm^j).trace()) for j in range(1,pre+2*per+1)]
            for d in divisors(per):
                if all(tr[i]==tr[i+d] for i in range(pre,len(tr)-d-1)): return d
            return per
        seenM[key]=N
    return None

def orders_and_mult(T,p):
    # 相異固有値の (ord, 代数的重複度) を F̄_p で
    R=GF(p); cp=T.charpoly().change_ring(R)
    res=[]
    for f,mult in cp.factor():
        d=f.degree(); Fq=GF(p^d,'a')
        for r,_ in f.change_ring(Fq).roots():
            if r==0: res.append((0,mult)); continue
            res.append((r.multiplicative_order(), mult))
    return res

def lcm_all(om):
    L=1
    for o,m in om:
        if o==0: continue
        L=lcm(L,o)
    return L
def lcm_refined(om,p):
    L=1
    for o,m in om:
        if o==0: continue
        if m%p!=0: L=lcm(L,o)
    return L

def L_ops(a,b,c):
    return [[matrix(ZZ,[[a,0],[0,b]]),matrix(ZZ,[[0,0],[c,0]])],
            [matrix(ZZ,[[0,c],[0,0]]),matrix(ZZ,[[b,0],[0,a]])]]
def embed(op,i,L):
    I2=identity_matrix(ZZ,2); m=[op if k==i else I2 for k in range(L)]
    M=m[0]
    for k in range(1,L): M=M.tensor_product(m[k])
    return M
def transfer_matrix(L,a,b,c):
    dim=2^L; Lo=L_ops(a,b,c)
    M=[[identity_matrix(ZZ,dim),zero_matrix(ZZ,dim)],[zero_matrix(ZZ,dim),identity_matrix(ZZ,dim)]]
    for i in range(L):
        Li=[[embed(Lo[r][s],i,L) for s in range(2)] for r in range(2)]
        M=[[M[0][0]*Li[0][0]+M[0][1]*Li[1][0], M[0][0]*Li[0][1]+M[0][1]*Li[1][1]],
           [M[1][0]*Li[0][0]+M[1][1]*Li[1][0], M[1][0]*Li[0][1]+M[1][1]*Li[1][1]]]
    return M[0][0]+M[1][1]

print("="*70)
print("π(p,1) 精密公式: = lcm{ord(λ): p∤mult_λ}")
print("="*70)
ok_ref=0; tot=0; strict=0
for (a,b,c,L) in [(1,1,2,2),(1,1,1,2),(2,1,1,2),(1,1,2,3),(2,1,3,2),(1,1,1,3),(3,2,1,2),(1,3,2,2)]:
    T=transfer_matrix(L,a,b,c); dt=ZZ(T.det())
    for p in [2,3,5,7,11]:
        if dt%p==0: continue
        pi=trace_period_mod_p(T,p)
        if pi is None: continue
        om=orders_and_mult(T,p)
        la=lcm_all(om); lr=lcm_refined(om,p)
        tot+=1
        if pi==lr: ok_ref+=1
        if lr!=la: strict+=1
        mark = "OK" if pi==lr else "✗MISMATCH"
        extra = "  [精密<全: mult≡0 脱落あり]" if lr!=la else ""
        print(f"  ({a},{b},{c})L{L} p={p}: π={pi}, lcm_refined={lr}, lcm_all={la} [{mark}]{extra}")
print(f"\n  合計 {tot}: π=lcm_refined が {ok_ref} 件; lcm_refined<lcm_all(mult≡0脱落) が {strict} 件")
print("\n"+"="*70)
print("結論: π(p,1) = lcm{ord(λ): p∤mult_λ}(一次独立より, rigorous)。")
print(" 等号 π=lcm_all は『order に効く全固有値の重複度が p∤』のとき。")
print(" mult≡0 mod p の固有値はトレース mod p から脱落し周期を下げうる(精密<全)。")
print("="*70)
