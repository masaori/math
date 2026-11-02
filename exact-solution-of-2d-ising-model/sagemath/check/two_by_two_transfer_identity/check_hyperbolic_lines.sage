# 対象ラベル: two_by_two_transfer_identity
# 証明の行:
#   準備: 0 < t < 1、r² = t、q² = 2s_2、r > 0、q > 0。
#   「exp(±K_2^*) を r で書く」: exp(-2K_2^*) の鎖 4 行、(exp(-K_2^*))² の鎖 3 行、exp(-K_2^*) = r、
#     exp(K_2^*) r の鎖 3 行、exp(K_2^*) = 1/r、cosh K_2^* の鎖 4 行、sinh K_2^* の鎖 4 行。
#   1 + t・1 - t の鎖 各 3 行。「前因子」: (q/(2r))² の鎖 9 行と q/(2r) = cosh K_2。
#   「結論」: q cosh K_2^* の鎖 5 行、q sinh K_2^* の鎖 5 行。
# 帰属:
#   - exp・log を含まない等号の行は QQ(E)（E = exp(K_2) の不定元）で、r・q を含む行は K_2 = log x の点の AA で厳密に。
#   - exp(±K_2^*)・exp(-2K_2^*) を含む行は RealBallField(512) へ脱出する（理由: 実対数と指数評価。K_2^* = -(1/2)log t の
#     値は QQ にも AA にも収まらない）。log は有理数の端点の区間、exp は本文の部分和のボール。
#   - K_2 ∈ QQ の点では t・r・q も QQ に収まらないので、全行をボールで確かめる。
load("_prelude.sage")

# ---- QQ(E) で、exp・log を含まない等号の行 ----
cE = cosh_by_definition(E, 1 / E); sE = sinh_by_definition(E, 1 / E)
tE = tanh_by_definition(sE, cE)                                       # def_positive_coupling_tanh
c2E = cosh_by_definition(E^2, 1 / E^2); s2E = sinh_by_definition(E^2, 1 / E^2)   # cosh 2K_2・sinh 2K_2（本文の定義から）
# 1 ± t の鎖
assert 1 + tE == 1 + sE / cE == (cE + sE) / cE == E / cE
assert 1 - tE == 1 - sE / cE == (cE - sE) / cE == (1 / E) / cE
# (q/(2r))² の鎖: q² = 2s_2、r² = t を入れた後の 7 行。s2E は本文の定義 (exp(2K) - exp(-2K))/2 から作り、
# 倍角公式の行の右辺 2 sinh(2K_2/2) cosh(2K_2/2) は exp(K_2) = E から作る（2K_2/2 = K_2 の行）。
chain = [2 * s2E / (4 * tE),                       # 2s_2/(4t)
         2 * s2E / (4 * tE),                       # 2 sinh 2K_2/(4t)（s_2 の略記の展開。同じ元）
         2 * (2 * sE * cE) / (4 * tE),             # 倍角公式 sinh 2K_2 = 2 sinh(2K_2/2) cosh(2K_2/2) を入れ、2K_2/2 = K_2
         sE * cE / tE,
         sE * cE * (cE / sE),
         cE^2]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
assert s2E == 2 * sE * cE                           # sinh_double_angle_formula を x = 2K_2 へ（定義から別々に作った両辺）
print("QQ(E) で、1 ± t の鎖と (q/(2r))² の鎖（q²・r² を入れた後）が一致する")


def check_point(t, two_s2, r, q, cK, sK, eK, emK, inv_r, cKs, sKs, exact):
    """t = tanh K_2、r = √t、q = √(2s_2)、cosh K_2・sinh K_2・exp(±K_2) と、K_2^* から作った
    cosh K_2^*・sinh K_2^* を受け取り、r・q を含む行を確かめる。exact なら AA の等号、そうでなければボールの重なり。"""
    eq = (lambda a, b: a == b) if exact else (lambda a, b: a.overlaps(b))
    assert 0 < t and t < 1 and r > 0 and q > 0
    assert eq(r^2, t) and eq(q^2, two_s2)
    # cosh K_2^*・sinh K_2^* の鎖（exp(K_2^*) = 1/r、exp(-K_2^*) = r を入れた後の 3 行）と、K_2^* から作った値
    ch = [(inv_r + r) / 2, (1 + r^2) / (2 * r), (1 + t) / (2 * r)]
    sh = [(inv_r - r) / 2, (1 - r^2) / (2 * r), (1 - t) / (2 * r)]
    for k in range(2):
        assert eq(ch[k], ch[k + 1]) and eq(sh[k], sh[k + 1]), k
    assert cKs.overlaps(RBF512(ch[0])) if exact else cKs.overlaps(ch[0])
    assert sKs.overlaps(RBF512(sh[0])) if exact else sKs.overlaps(sh[0])
    # 前因子
    pre = [(q / (2 * r))^2, q^2 / (4 * r^2), two_s2 / (4 * r^2), two_s2 / (4 * t)]   # 以降の行は QQ(E) で確かめた
    for k in range(3):
        assert eq(pre[k], pre[k + 1]), k
    assert eq(pre[0], cK^2)
    assert q / (2 * r) > 0 and cK > 0 and eq(q / (2 * r), cK)        # cosh_sinh_basic_properties (4)
    # 結論の鎖
    cc = [q * ch[2], q / (2 * r) * (1 + t), cK * (1 + t), cK * (eK / cK), eK]
    ss = [q * sh[2], q / (2 * r) * (1 - t), cK * (1 - t), cK * (emK / cK), emK]
    for k in range(4):
        assert eq(cc[k], cc[k + 1]) and eq(ss[k], ss[k + 1]), k


def kstar_from_t_enclosure(lt):
    """K_2^* = -(1/2) log t（def_second_dual_coupling_constant）のボールと、exp(±K_2^*)・exp(-2K_2^*) のボール。"""
    Ks = dual_coupling_by_definition(lt)
    return Ks, exp_ball_of_ball(Ks), exp_ball_of_ball(-Ks), exp_ball_of_ball(-2 * Ks)


assert -2 * (-QQ(1) / 2) == 1                                         # exp(-2K_2^*) の鎖の 2 行目の係数

# ---- K_2 = log x の点: t・q² は QQ、r・q は AA ----
for x in X_LOG_POINTS:
    eK = QQ(x); emK = 1 / eK
    cK = cosh_by_definition(eK, emK); sK = sinh_by_definition(eK, emK)
    t = tanh_by_definition(sK, cK)
    assert t == (x^2 - 1) / (x^2 + 1)
    two_s2 = 2 * sinh_by_definition(eK^2, emK^2)
    r = AA(t).sqrt(); q = AA(two_s2).sqrt()
    assert r >= 0 and r^2 == t and q >= 0 and q^2 == two_s2           # definition_of_sqrt_r_positive
    lt = real_log_enclosure(t)                                        # log t を含む区間（本文の exp で確かめた端点）
    Ks, eKs, emKs, em2Ks = kstar_from_t_enclosure(lt)
    rb = RBF512(r)
    # exp(±K_2^*) の行（ボール）
    assert em2Ks.contains_exact(t) or em2Ks.overlaps(RBF512(t))       # exp(-2K_2^*) = exp(log t) = t
    assert (emKs * emKs).overlaps(em2Ks) and (emKs^2).overlaps(RBF512(t))   # (exp(-K_2^*))² = exp(-2K_2^*) = t
    assert emKs > 0 and emKs.overlaps(rb)                             # real_exp_positive と一意性で exp(-K_2^*) = r
    assert (eKs * rb).overlaps(RBF512(1)) and (eKs * emKs).overlaps(exp_ball_of_ball(RBF512(0)))  # exp(K_2^*) r = exp(0) = 1
    assert eKs.overlaps(1 / rb)                                       # exp(K_2^*) = 1/r
    cKs = cosh_by_definition(eKs, emKs); sKs = sinh_by_definition(eKs, emKs)   # def_cosh_sinh（K_2^* のボールから）
    check_point(AA(t), AA(two_s2), r, q, AA(cK), AA(sK), AA(eK), AA(emK), 1 / r, cKs, sKs, exact=True)
print(f"{len(X_LOG_POINTS)} 点の K_2 = log x で、r・q を含む行が AA で、exp(±K_2^*) の行がボールで成り立つ")

# ---- K_2 ∈ QQ の点: 全行をボールで ----
for K0 in K2_RATIONAL_POINTS:
    eK = exp_ball(K0); emK = exp_ball(-K0)
    cK = cosh_by_definition(eK, emK); sK = sinh_by_definition(eK, emK)
    t = tanh_by_definition(sK, cK)
    two_s2 = 2 * sinh_by_definition(exp_ball(2 * K0), exp_ball(-2 * K0))
    r = sqrt_ball(t); q = sqrt_ball(two_s2)
    lt = real_log_enclosure_of_ball(t)
    Ks, eKs, emKs, em2Ks = kstar_from_t_enclosure(lt)
    assert em2Ks.overlaps(t) and (emKs^2).overlaps(t) and emKs.overlaps(r) and (eKs * r).overlaps(RBF512(1))
    cKs = cosh_by_definition(eKs, emKs); sKs = sinh_by_definition(eKs, emKs)
    check_point(t, two_s2, r, q, cK, sK, eK, emK, 1 / r, cKs, sKs, exact=False)
print(f"{len(K2_RATIONAL_POINTS)} 点の K_2 ∈ QQ で、全行がボールで成り立つ")
print("RESULT: PASS")
