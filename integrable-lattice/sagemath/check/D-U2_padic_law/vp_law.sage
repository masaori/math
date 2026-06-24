# cycle 2 / D-U2: 六頂点 Z_{N,L}=Tr T^N の p 進付値 v_p(Z_N) の N 依存則を探る。
# 立場: Z_N∈ℤ ⇒ Φ_N=log Z_N∈Λ。Φ_N の ℓ_p 係数 = v_p(Z_N)。これが N の関数として
# どんな構造(線形/周期)を持つか = D-U2 の数論的内容。決定可能・ℝ 不使用。
#
# 鍵: T は整数行列。Tr T^N mod p^k は N について最終周期的(T mod p^k が有限モノイド)。
#     ⇒ v_p(Z_N) は「Z_N≡0 mod p^k となる N の集合」で決まり、その集合は周期的。

def L_ops(a,b,c):
    return [[matrix(ZZ,[[a,0],[0,b]]), matrix(ZZ,[[0,0],[c,0]])],
            [matrix(ZZ,[[0,c],[0,0]]), matrix(ZZ,[[b,0],[0,a]])]]

def embed(op,i,L):
    I2=identity_matrix(ZZ,2)
    mats=[op if k==i else I2 for k in range(L)]
    M=mats[0]
    for k in range(1,L): M=M.tensor_product(mats[k])
    return M

def transfer_matrix(L,a,b,c):
    dim=2^L; Lo=L_ops(a,b,c)
    M=[[identity_matrix(ZZ,dim),zero_matrix(ZZ,dim)],
       [zero_matrix(ZZ,dim),identity_matrix(ZZ,dim)]]
    for i in range(L):
        Li=[[embed(Lo[r][s],i,L) for s in range(2)] for r in range(2)]
        N00=M[0][0]*Li[0][0]+M[0][1]*Li[1][0]
        N01=M[0][0]*Li[0][1]+M[0][1]*Li[1][1]
        N10=M[1][0]*Li[0][0]+M[1][1]*Li[1][0]
        N11=M[1][0]*Li[0][1]+M[1][1]*Li[1][1]
        M=[[N00,N01],[N10,N11]]
    return M[0][0]+M[1][1]

def seq_Z(T,M):
    Ts=[]; P=identity_matrix(ZZ,T.nrows())
    for N in range(1,M+1):
        P=P*T; Ts.append(ZZ(P.trace()))
    return Ts

def detect_linear(vs):
    # vs = [v_p(Z_N)] for N=1..; 末尾が一定差分(線形)かを見る
    d=[vs[i+1]-vs[i] for i in range(len(vs)-1)]
    tail=d[len(d)//2:]
    if tail and all(x==tail[0] for x in tail):
        return tail[0]
    return None

def period_mod(seq, m):
    # seq(Z_N mod m) の最終周期を素朴に検出
    r=[x % m for x in seq]
    n=len(r)
    for p in range(1, n//2+1):
        if all(r[i]==r[i+p] for i in range(n-p-1, n-p) ) and all(r[i]==r[i-p] for i in range(n-1, n-p-1, -1)):
            # ざっくり: 末尾窓で周期 p
            if all(r[i]==r[i+p] for i in range(n-2*p, n-p) if i>=0):
                return p
    return None

print("="*70)
print("六頂点 Z_{N,L}=Tr T^N の v_p(Z_N) の N 依存則")
print("="*70)

cases=[(1,1,2,2),(1,1,2,3),(1,1,1,2),(2,1,1,2),(1,2,1,2)]
M=24
for (a,b,c,L) in cases:
    T=transfer_matrix(L,a,b,c)
    cp=T.charpoly()
    Z=seq_Z(T,M)
    print(f"\n#### (a,b,c)=({a},{b},{c}), L={L} ; charpoly(T)={cp.factor()}")
    print(f"   Z_N (N=1..8): {Z[:8]}")
    for p in [2,3,5,7]:
        vs=[ (Z[i].valuation(p) if Z[i]!=0 else None) for i in range(M)]
        if all(v==0 for v in vs):
            continue
        lin=detect_linear([v for v in vs])
        per=period_mod(Z, p)
        head=f"   p={p}: v_p(Z_N) N=1..12 = {vs[:12]}"
        if lin is not None:
            head+=f"  [末尾線形, 傾き {lin}]"
        if per is not None:
            head+=f"  [Z_N mod {p} 周期≈{per}]"
        print(head)

print("\n"+"="*70)
print("観察まとめは README.md に記述。要点: v_p(Z_N) は (i)恒0, (ii)末尾線形,")
print("(iii)周期的(Z_N mod p^k の最終周期に対応) のいずれか。すべて決定可能・ℝ 不使用。")
print("="*70)
