# cycle 4 / T3: Wall 等式 π(p,k)=p^{k-1}π(p,1) の系統検証(反例探索)。
# π(p,k) = Tr T^N mod p^k の(最終)周期。等式の破れは π(p,2)=π(p,1)(成長なし)と同値=Wall-Sun-Sun 型。
# 問い: 可積分転送行列で等式は常に成立か? 一般(companion=Lucas 列)では破れるか?
# ⇒ 可積分転送行列群 と 一般 companion 行列群(d=2 は Lucas 列)で π(p,1),π(p,2) を比較。

def trace_seq_period(T, m, maxN=20000):
    R=Integers(m); Tm=T.change_ring(R)
    # Tr T^N の列(N=1..)の最終周期を Floyd 的に: 状態は (T^N mod m) 全体だと重いので
    # トレース列の周期を直接検出(周期は T^N の周期の約数, 安全に maxN まで)
    P=Tm; seq=[]
    seen={}
    Pcur=identity_matrix(R,T.nrows())
    # 行列冪の周期(これがトレース周期の倍数)を使うと安全
    seenM={}; N=0; Pk=identity_matrix(R,T.nrows())
    while N<=maxN:
        Pk=Pk*Tm; N+=1
        key=tuple(Pk.list())
        if key in seenM:
            mat_pre=seenM[key]; mat_per=N-seenM[key]
            # トレース列の周期 = mat_per の約数で、Tr が一致する最小周期
            tr=[ZZ((Tm^j).trace()) % m for j in range(1, mat_pre+2*mat_per+1)]
            # 最終部分で周期検出
            base=mat_pre
            for d in divisors(mat_per):
                if all(tr[i]==tr[i+d] for i in range(base, len(tr)-d-1)):
                    return d
            return mat_per
        seenM[key]=N
    return None

def wall_holds(T, p):
    pi1=trace_seq_period(T,p)
    pi2=trace_seq_period(T,p^2)
    if pi1 is None or pi2 is None: return None,(pi1,pi2)
    return (pi2==p*pi1),(pi1,pi2)

# --- 群1: 一般 companion 行列(d=2: x^2-ax+b = Lucas 列) ---
print("="*70); print("群1: 一般 companion (d=2, Lucas 列) で Wall 等式"); print("="*70)
fails1=[]
for a in range(1,8):
    for b in [1,-1,2,-2,3]:
        C=companion_matrix(x^2 - a*x + b, format='right') if False else matrix(ZZ,[[0,-b],[1,a]])
        for p in [3,5,7,11,13]:
            if ZZ(b)%p==0: continue   # p|det は別扱い
            ok,(pi1,pi2)=wall_holds(C,p)
            if ok is False:
                fails1.append((a,b,p,pi1,pi2))
print(f"  検査(d=2 companion × 素数), Wall 破れ件数={len(fails1)}")
for f in fails1[:10]: print(f"   反例: x^2-{f[0]}x+{f[1]}, p={f[2]}: π(p,1)={f[3]}, π(p,2)={f[4]} (≠ p·π1)")

# --- 群2: 可積分転送行列(六頂点) ---
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

print("\n"+"="*70); print("群2: 可積分転送行列(六頂点) で Wall 等式"); print("="*70)
fails2=[]
for (a,b,c,L) in [(1,1,2,2),(1,1,1,2),(2,1,1,2),(1,2,1,2),(2,1,1,3)]:
    T=transfer_matrix(L,a,b,c); dt=ZZ(T.det())
    for p in [3,5,7,11]:
        if dt%p==0: continue
        ok,(pi1,pi2)=wall_holds(T,p)
        if ok is False: fails2.append((a,b,c,L,p,pi1,pi2))
print(f"  検査(六頂点 × 素数, p∤det), Wall 破れ件数={len(fails2)}")
for f in fails2[:10]: print(f"   反例: {f}")

print("\n"+"="*70)
print("結論(暫定): 一般 companion(Lucas)での Wall 破れ件数と可積分での破れ件数を比較。")
print(" 破れが Lucas で有り・可積分で無し なら『可積分性が Wall 等式を保証』の証拠。")
print(" 両方無し(検査範囲)なら Wall-Sun-Sun の稀少性(既知)と整合し、特別性は未確定。")
print("="*70)
