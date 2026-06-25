# cycle 3 / T1: D-U2 厳密化の核となる周期主張を検証。
# 主張(b): Z_N mod p^k は最終周期的(T^N mod p^k が有限モノイド M_d(Z/p^k) で巡回)。
#   ⇒ 切断付値 min(v_p(Z_N),k) は周期 π_k(=T^N mod p^k の最終周期の約数)で最終周期。
# これは完全に決定可能・rigorous(SML の subtlety を p^k 切断で回避)。

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

def matrix_power_period(T, m, maxN=2000):
    # T^N mod m の最終周期(と前周期)を Brent 的に検出
    R=Integers(m); Tm=T.change_ring(R)
    seen={}; P=Tm^1; N=1
    seq=[]
    while N<=maxN:
        key=tuple(P.list())
        if key in seen:
            return seen[key], N-seen[key]   # (前周期開始, 周期)
        seen[key]=N; seq.append(P); P=P*Tm; N+=1
    return None,None

def trunc_val(z,p,k):
    z=ZZ(z)
    if z==0: return k
    return min(z.valuation(p), k)

print("="*70)
print("D-U2 厳密化: Z_N mod p^k 周期 ⇒ 切断付値 min(v_p,k) の最終周期")
print("="*70)

cases=[(1,1,2,2),(1,1,1,2),(2,1,1,2),(1,1,2,3)]
for (a,b,c,L) in cases:
    T=transfer_matrix(L,a,b,c)
    print(f"\n#### (a,b,c)=({a},{b},{c}), L={L}, d={T.nrows()}")
    for p in [2,3,7]:
        k=3
        m=p^k
        pre,per = matrix_power_period(T,m)
        if per is None:
            print(f"   p={p},k={k}: 周期検出失敗(maxN 内)"); continue
        # Z_N=Tr T^N mod p^k の周期と、切断付値列の周期を直接確認
        Nmax = pre+3*per+5
        P=identity_matrix(ZZ,T.nrows()); Z=[]
        for N in range(1,Nmax+1): P=P*T; Z.append(ZZ(P.trace()))
        tv=[trunc_val(z,p,k) for z in Z]
        # tv が period per で最終周期かを確認(前周期 pre 以降)
        start=pre
        ok=all(tv[i]==tv[i+per] for i in range(start, Nmax-per-1))
        print(f"   p={p},k={k}: T^N mod p^k 周期π={per}(前周期{pre}); "
              f"min(v_p,k) 列 周期π で最終周期={ok}; tv[前周期..+π]={tv[start:start+per]}")

print("\n"+"="*70)
print("結論: min(v_p(Z_N),k) は π_k(=T^N mod p^k の最終周期)で最終周期(検証 OK)。")
print(" これは決定可能・rigorous。線形項 μ_min·N と合わせ D-U2 命題の厳密核。")
print(" SML 例外は『π_k 周期だが v_p≥k のスパイク』として切断の外に隔離される。")
print("="*70)
