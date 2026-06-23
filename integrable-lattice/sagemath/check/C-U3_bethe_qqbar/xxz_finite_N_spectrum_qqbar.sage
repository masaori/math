# C-U3 検証: 相互作用可積分模型(XXZ 鎖 = 六頂点の対数微分)の
# 有限 N スペクトルが ℚ̄ に住み、最小多項式 witness で決定可能であることの実証。
#
# 立場(lambda-statement-program): 可積分 ⇒ 有限 N の対象が代数的(ℚ̄, 決定可能)。
# XXZ の熱力学極限の相関等は閉形式が困難(未解決母集団)だが、有限 N スペクトルは
# 整数/有理係数行列の固有値 = 整係数特性多項式の根 ⇒ ℚ̄。ℝ は使わない。
#
# H_XXZ = sum_j ( X_j X_{j+1} + Y_j Y_{j+1} + Delta Z_j Z_{j+1} ),  周期境界。
# 異方性 Delta は有理点で取る(ℝ 不使用)。

def pauli():
    X = matrix(QQ, [[0,1],[1,0]])
    Y_over_i = matrix(QQ, [[0,-1],[1,0]])   # Y = i * (this); YY = (i^2)(this)^2 = -(this@this) は QQ
    Z = matrix(QQ, [[1,0],[0,-1]])
    I = identity_matrix(QQ,2)
    return X, Y_over_i, Z, I

def op_at(op, j, N, I):
    # サイト j(0-index) に op、他は I のテンソル積
    mats = [op if k==j else I for k in range(N)]
    M = mats[0]
    for k in range(1,N):
        M = M.tensor_product(mats[k])
    return M

def xxz_hamiltonian(N, Delta):
    X, Yi, Z, I = pauli()
    dim = 2^N
    H = matrix(QQ, dim, dim)
    for j in range(N):
        jp = (j+1) % N
        XX = op_at(X,j,N,I) * op_at(X,jp,N,I)
        # YY = (i*Yi)(i*Yi) = - Yi*Yi
        YY = - op_at(Yi,j,N,I) * op_at(Yi,jp,N,I)
        ZZ = op_at(Z,j,N,I) * op_at(Z,jp,N,I)
        H += XX + YY + Delta*ZZ
    return H

print("="*70)
print("XXZ 有限 N スペクトルの ℚ̄ 帰属 / 最小多項式 witness 検証")
print("="*70)

for Delta in [QQ(1)/2, QQ(2), QQ(-1)/3]:
    print("\n#### 異方性 Delta =", Delta, " (有理点, ℝ 不使用)")
    for N in [2,3,4]:
        H = xxz_hamiltonian(N, Delta)
        cp = H.charpoly()           # ∈ QQ[x]
        # 整数性: Delta が整数なら係数は ℤ。一般有理 Delta では ℚ。
        fac = cp.factor()
        # 固有値を QQbar(代数的数)で厳密に取得
        evs = H.eigenvalues(extend=True)   # QQbar の元
        all_alg = all(ev in QQbar for ev in evs)
        # ℚ̄ 上の最小多項式(witness)の次数の集合
        degs = sorted(set(QQbar(ev).minpoly().degree() for ev in evs))
        print(f"  N={N}: dim={2^N}, charpoly∈QQ[x] deg={cp.degree()}, "
              f"既約分解の因子数={len(list(fac))}, 全固有値∈QQbar={all_alg}, "
              f"固有値の最小多項式次数={degs}")
        if N==3:
            print("     charpoly factor over QQ:", fac)

print("\n" + "="*70)
print("結論:")
print(" - XXZ(相互作用可積分, 熱力学極限の相関は未解決母集団)で、")
print("   有限 N のスペクトルは整係数/有理係数特性多項式の根 = QQbar に住む(厳密)。")
print(" - 各固有値は ℚ̄ 上の最小多項式を witness にもち、等号・順序は根分離で決定可能。")
print(" - ℝ は一切使用していない(Delta は有理, 固有値は代数的数)。")
print(" - ℝ 脱出は N→∞ の極限(相関の閉形式)側にのみ生じ、本計算には現れない。")
print("="*70)
