# 対象ラベル: sigma_z_diagonal_action
# 証明の場合分けの二つの鎖:
#   μ(m)=1:  σ^z e_{i_m} = σ^z e_1 = e_1 = 1_C·e_1 = μ(m)_C e_{i_m}
#   μ(m)=-1: σ^z e_{i_m} = σ^z e_2 = -e_2 = (-1_C)·e_2 = μ(m)_C e_{i_m}
# i_m は site_sigma_z_kronecker.sage の iota（def_config_basis_iso）で μ から作る。
# μ(m)_C = ι_{R→C}(μ(m)) は、整数 ±1 を ZZ のまま係数に使う（ZZ → CC の包含は和と積を保つ）。帰属: ZZ。
load("../../_shared/site_sigma_z_kronecker.sage")

count = 0
for s in (1, -1):
    mu = (s,)
    i_m = iota(mu)[0]
    line1 = SIGMA_Z * E[i_m]
    if s == 1:
        assert i_m == 1
        line2 = SIGMA_Z * E[1]
        line3 = E[1]
        line4 = 1 * E[1]
    else:
        assert i_m == 2
        line2 = SIGMA_Z * E[2]
        line3 = -E[2]
        line4 = (-1) * E[2]
    line5 = s * E[i_m]
    assert line1 == line2 == line3 == line4 == line5
    count += 1
# 対照: 逆の符号では成り立たない
assert SIGMA_Z * E[iota((1,))[0]] != (-1) * E[iota((1,))[0]]
print(f"checked {count} cases")
print("RESULT: PASS")
