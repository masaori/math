# 対象ラベル: eigenvalues_of_check_Vprime
# eigenvalues_of_check_Vprime の Step 1 の右から掛ける形を一行ずつ確かめる:
#   μ ごとの右の等式 Q̌_ε(ň_μ − ½I) = h(ε(μ))Q̌_ε（ε(μ) によらない 6 行と、ε(μ) = 1・ε(μ) = 0 の 7 行ずつ）と、
#   Q̌_εX̌ から ǧ(ε)Q̌_ε までの 8 行（ǧ(ε) := Σ_{μ∈M̌} γ(θ̃_μ)h(ε(μ))）。
# 鎖の項は _step1_chains.sage が本文の定義で成分から組む。ň_μ と γ_μ は _vprime_settings.sage の chain_settings から取る
# （既定は Jordan–Wigner の模型 n_μ := c_μ^T c_μ と有理数 γ_μ、M = 2, 3, 4。check_with_check_psi.sage からは本文の ψ̌ の ň_μ と不定元 γ_μ）。
# Q̌_ε := Π_μ R_μ^{(ε(μ))}（def_check_Q_epsilon）、ε を全列挙。鎖が使う仮定は check_joint_eigenspace_decomposition (3) だけである。
# 否定コントロール: 不定元の成分の行列 N_μ、Q と不定元 γ_μ では、(3) を引く行（μ ごとの等式の 2 行目と、主鎖の「μ ごとの等式を各項へ」）だけが外れる。
# 帰属: 成分は QQ か、本文の ψ̌ の数体 F 上の多項式環か、QQ 上の多項式環（否定コントロール）（厳密計算）。
load("_vprime_settings.sage")
load("_step1_chains.sage")
count, neg = run_step1("right")
print(f"checked {count} steps (μ ごとの右の等式と Q̌_εX̌ の 8 行の鎖、settings M = 2, 3, 4 with all eps、否定コントロールの等号を含む); 否定コントロール {neg} 本で (3) を引く行だけが外れる")
print("RESULT: PASS")
