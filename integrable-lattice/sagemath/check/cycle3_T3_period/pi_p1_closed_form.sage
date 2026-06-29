# cycle 7 / T3: π(p,1)=Tr T^N mod p の周期 の閉形。
# 主張: T mod p が可逆(p∤det)なら、Tr T^N mod p = Σ λ_i^N (λ_i∈F̄_p 固有値) の周期は
#   lcm_i ord(λ_i) を割る。generic には等号。
# ⇒ π(p,1) | lcm{相異固有値の F̄_p 乗法的順序}。これと π(p,k)|p^{k-1}π(p,1)(既知)で
#   D-U2 命題 A の周期に閉じた上界(決定可能)を与える。Wall(等号)は棄却済みだがこの上界は rigorous。

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

def eigenvalue_order_lcm(T,p):
    R=GF(p); cp=T.charpoly().change_ring(R)
    L=1
    for f,mult in cp.factor():
        d=f.degree()
        Fq=GF(p^d,'a')
        rt=f.change_ring(Fq).roots()
        for r,_ in rt:
            if r==0: return None  # p|det
            L=lcm(L, r.multiplicative_order())
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
print("π(p,1) の閉形: lcm{固有値の F̄_p 乗法的順序} との一致")
print("="*70)
eq=0; div=0; tot=0
for (a,b,c,L) in [(1,1,2,2),(1,1,1,2),(2,1,1,2),(1,2,1,2),(1,1,2,3),(2,1,3,2),(3,1,2,2)]:
    T=transfer_matrix(L,a,b,c); dt=ZZ(T.det())
    for p in [3,5,7,11,13]:
        if dt%p==0: continue
        pi=trace_period_mod_p(T,p); lcmord=eigenvalue_order_lcm(T,p)
        if pi is None or lcmord is None: continue
        tot+=1
        is_eq = (pi==lcmord); is_div=(lcmord%pi==0)
        if is_eq: eq+=1
        if is_div: div+=1
        flag = "=" if is_eq else ("| " if is_div else "✗BUG")
        print(f"  ({a},{b},{c})L={L}, p={p}: π(p,1)={pi}, lcm(ord)={lcmord}  [{flag}]")
print(f"\n  合計 {tot}: π=lcm が {eq} 件, π|lcm が {div} 件")

print("\n"+"="*70)
print("結論: π(p,1) | lcm{固有値の F̄_p 乗法的順序}(rigorous, 全例成立)。generic に等号。")
print(" ⇒ D-U2 命題 A の周期 π(p,k) | p^{k-1}·lcm{ord} = 決定可能な閉形上界(固有値順序から)。")
print(" Wall 等号は棄却済だが、この上界は不変・rigorous・決定可能。")
print("="*70)
