# Step 2・Step 3: sin θ~_μ = 0 の同値の鎖の各行と、k が奇数であること、cos θ~_μ = cos(kπ) = (-1)^k = -1。
# M_col = 2..40、μ ∈ {1,…,M_col}（def_check_index_set）の全組で、各行の真偽が一致することを厳密に確かめる。
load("_prelude.sage")
rep = Report("Step 2・Step 3（sin θ~_μ = 0 が要求すること）")
MMAX = 40
n_zero = 0
n_mismatch = 0
for M in range(2, MMAX + 1):
    for mu in range(1, M + 1):
        F, I_, E, co, si = cyclotomic_angle(M, mu)
        q = 2 * (QQ(mu) - QQ(1)/2) / M            # θ~_μ / π（組み込みの sin との照合にだけ使う）
        # 行 1: sin θ~_μ = 0（円分体で厳密）。Sage 組み込みの sin と照合
        L1 = (si == 0)
        rep_ok_builtin = (L1 == (QQbar(sin(pi * q)) == 0))
        # ∃k の行は k を範囲 KR で探して判定する。0 < θ~_μ < 2π（1 ≤ μ ≤ M）なので θ~_μ = kπ なら 0 < k < 2 で、
        # 範囲 -5..5 は全ての候補を含む。行 2 と行 3 は定義を代入しただけの行なので同じ記号式から作る。行 4〜6 は QQ・ZZ の等式で別に作る。
        KR = range(-5, 6)
        # 行 2: ∃k: θ~_μ = kπ。θ~_μ は記号式 2π(μ-1/2)/M として作り、kπ との差が 0 かを記号計算で判定
        theta = 2 * pi * (mu - QQ(1)/2) / M
        L2 = any(bool((theta - k * pi).simplify_full() == 0) for k in KR)
        # 行 3: ∃k: 2π(μ-1/2)/M = kπ（定義を代入した形）。両辺を記号式のまま比べる
        L3 = any(bool((2 * pi * (mu - QQ(1)/2) / M) == k * pi) for k in KR)
        # 行 4: ∃k: 2(μ-1/2)/M = k（π で割った。QQ の等式）
        L4 = any(2 * (QQ(mu) - QQ(1)/2) / M == k for k in KR)
        # 行 5: ∃k: 2(μ-1/2) = kM（M 倍した。QQ の等式）
        L5 = any(2 * (QQ(mu) - QQ(1)/2) == k * M for k in KR)
        # 行 6: ∃k: 2μ - 1 = kM（分配則。ZZ の等式）
        rep_distrib = (2 * (QQ(mu) - QQ(1)/2) == 2 * mu - 1)
        L6 = any(2 * mu - 1 == k * M for k in KR)
        ok = (L1 == L2 == L3 == L4 == L5 == L6) and rep_ok_builtin and rep_distrib
        if not ok:
            n_mismatch += 1
            rep.check(False, f"M={M} μ={mu}: 行の真偽 {L1},{L2},{L3},{L4},{L5},{L6} 組み込み照合 {rep_ok_builtin}")
        if L1:
            n_zero += 1
            k = ZZ((2 * mu - 1) / M)
            # 2μ - 1 は奇数、k M も奇数、ゆえに k は奇数
            rep.check(2 * mu - 1 == 2 * (mu - 1) + 1 and (2 * mu - 1) % 2 == 1 and (k * M) % 2 == 1 and k % 2 == 1,
                      f"M={M} μ={mu}: k={k}。2μ-1 = 2(μ-1)+1 は奇数、kM は奇数、k は奇数")
            # Step 3: cos θ~_μ = cos(kπ) = (-1)^k = -1
            cos_kpi = QQbar(cos(k * pi))
            rep.check(QQbar(co) == cos_kpi, f"M={M} μ={mu}: cos θ~_μ = cos(kπ)（θ~_μ = kπ）")
            rep.check(cos_kpi == (-1)**k, f"M={M} μ={mu}: cos(kπ) = (-1)^k")
            rep.check((-1)**k == -1, f"M={M} μ={mu}: (-1)^k = -1（k は奇数）")
rep.check(n_mismatch == 0, f"M_col = 2..{MMAX} の全 μ で Step 2 の六行の真偽が一致（不一致 {n_mismatch} 件）")
rep.check(n_zero > 0, f"sin θ~_μ = 0 となる組は {n_zero} 個あり、Step 2・Step 3 の鎖は空でない")
# 奇偶の論法: k M が奇数なら k は奇数（ℤ/2ℤ の全ての剰余で）
rep.check(all((k * M) % 2 == 0 for l in range(-20, 21) for k in [2 * l] for M in range(2, MMAX + 1)) and
          all(2 * (l * M) == (2 * l) * M for l in range(-20, 21) for M in range(2, MMAX + 1)),
          "k = 2l なら kM = 2(lM) は偶数（l = -20..20、M_col = 2..40）。ゆえに kM が奇数なら k は奇数")
# cos(kπ) = (-1)^k を k = -9..9 で（Step 3 の第 2 行の公式の当てはめの範囲）
rep.check(all(QQbar(cos(k * pi)) == (-1)**k for k in range(-9, 10)), "cos(kπ) = (-1)^k（k = -9..9）")
rep.finish()
