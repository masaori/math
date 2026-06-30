# 構成例で strict ケース(精密公式が lcm_all より真に小)を実演。
# T = block_diag(A,...,A [p 個], B): A の固有値は重複度 p (≡0 mod p)で脱落 → π は B の order のみ。
def trace_period_mod_p(T,p,maxN=20000):
    R=GF(p); Tm=T.change_ring(R); seenM={}; N=0; Pk=identity_matrix(R,T.nrows())
    while N<=maxN:
        Pk=Pk*Tm; N+=1; key=tuple(Pk.list())
        if key in seenM:
            pre=seenM[key]; per=N-seenM[key]
            tr=[ZZ((Tm^j).trace()) for j in range(1,pre+2*per+1)]
            for d in divisors(per):
                if all(tr[i]==tr[i+d] for i in range(pre,len(tr)-d-1)): return d
            return per
        seenM[key]=N
    return None
def om(T,p):
    R=GF(p); cp=T.charpoly().change_ring(R); res=[]
    for f,mult in cp.factor():
        d=f.degree(); Fq=GF(p^d,'a')
        for r,_ in f.change_ring(Fq).roots():
            if r!=0: res.append((r.multiplicative_order(),mult))
    return res
def lcm_all(o): 
    L=1
    for x,m in o: L=lcm(L,x)
    return L
def lcm_ref(o,p):
    L=1
    for x,m in o:
        if m%p!=0: L=lcm(L,x)
    return L
R.<x>=ZZ[]
A=companion_matrix(x^2-3*x+1)   # 固有値 order は p による
B=companion_matrix(x-2)
for p in [5,7,11,13]:
    blocks=[A]*p+[B]
    T=block_diagonal_matrix(blocks)
    pi=trace_period_mod_p(T,p); o=om(T,p)
    print(f" p={p}: T=diag(A×{p},B); π(p,1)={pi}, lcm_refined={lcm_ref(o,p)}, lcm_all={lcm_all(o)}  strict={lcm_ref(o,p)<lcm_all(o)}, π=refined: {pi==lcm_ref(o,p)}")
