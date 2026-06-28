# cycle 6 / T3: 六頂点 Wall 検査の大規模化(統計的有意性)。
# 一般(非退化 companion)の Wall 破れ基準率 ≈ 2.1%(cycle5, 10/472)。
# 六頂点を多数検査し、破れ率が有意に低いか(0 が偶然でないか)を見る。

def trace_seq_period(T,m,maxN=20000):
    R=Integers(m); Tm=T.change_ring(R)
    seenM={}; N=0; Pk=identity_matrix(R,T.nrows())
    while N<=maxN:
        Pk=Pk*Tm; N+=1
        key=tuple(Pk.list())
        if key in seenM:
            pre=seenM[key]; per=N-seenM[key]
            tr=[ZZ((Tm^j).trace())%m for j in range(1,pre+2*per+1)]
            for d in divisors(per):
                if all(tr[i]==tr[i+d] for i in range(pre,len(tr)-d-1)): return d
            return per
        seenM[key]=N
    return None
def wall(T,p):
    p1=trace_seq_period(T,p); p2=trace_seq_period(T,p^2)
    if p1 is None or p2 is None: return None
    return p2==p*p1
R.<x>=QQ[]
def nondeg(cp):
    sf=cp.radical()
    for g,_ in sf.factor():
        if g.is_cyclotomic(): return False
    return True
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

print("="*70); print("六頂点 Wall 大規模検査"); print("="*70)
tested=0; fails=0; skipped=0; faillist=[]
for a in range(1,8):
    for b in range(1,8):
        for c in range(1,8):
            T=transfer_matrix(2,a,b,c); cp=T.charpoly(); dt=ZZ(T.det())
            if not nondeg(cp): continue
            for p in [3,5,7]:
                if dt%p==0: continue
                r=wall(T,p)
                if r is None: skipped+=1; continue
                tested+=1
                if r is False: fails+=1; faillist.append((a,b,c,p))
print(f"  六頂点 L=2, 非退化, p∈{{3,5,7}}, p∤det: 検査={tested}, Wall 破れ={fails}, skip={skipped}")
for f in faillist[:20]: print(f"   破れ: a,b,c,p={f}")

# 二項検定的な目安: 基準率 q=0.021 で tested 件中 0 破れの確率
q=0.021
if fails==0 and tested>0:
    pval=(1-q)^tested
    print(f"  基準率 q={q} のとき {tested} 件中 0 破れの確率 = {float(pval):.4f}")
    print(f"  (これが小さいほど『六頂点は有意に Wall を保ちやすい』の証拠)")

print("\n"+"="*70)
print("結論は検査数と破れ数で判断(下の報告に記載)。")
print("="*70)
