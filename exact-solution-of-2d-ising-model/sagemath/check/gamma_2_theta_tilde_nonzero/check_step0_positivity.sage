# Step 0: K_1^*, K_2^* > 0 と c_1, s_1, c_2, s_2^* > 0 を、結合定数の組ごとに QQ で厳密に確かめる。
load("_prelude.sage")
rep = Report("Step 0（正値性）")
for (Y, Z) in COUPLINGS:
    k = couplings(Y, Z)
    tag = f"(Y,Z)=({Y},{Z})"
    # K_i^* > 0 ⟺ exp(2K_i^*) > 1。tanh K_i = (e^{2K_i}-1)/(e^{2K_i}+1) ∈ (0,1) から。
    rep.check(0 < (k['Y'] - 1)/(k['Y'] + 1) < 1 and k['W'] > 1, f"{tag} 0 < tanh K_1 < 1 かつ exp(2K_1^*) > 1（K_1^* > 0）")
    rep.check(0 < (k['Z'] - 1)/(k['Z'] + 1) < 1 and k['X'] > 1, f"{tag} 0 < tanh K_2 < 1 かつ exp(2K_2^*) > 1（K_2^* > 0）")
    # 双対の関係 tanh K_2^* = exp(-2K_2) を照合（X から独立に作った tanh と比べる）
    rep.check((k['X'] - 1)/(k['X'] + 1) == 1/k['Z'], f"{tag} tanh K_2^* = exp(-2K_2)（定義の照合）")
    for name in ['c1', 's1', 'c2', 's2s']:
        rep.check(k[name] > 0, f"{tag} {name} = {k[name]} > 0")
rep.finish()
