# 対象ラベル: claim_insufficiency_witness_on_ising_realizable_family
# 実際の Ising 有限箱データから生じる列の族の上での非十分性が、
#「極限量が異なり、かつすべての箱で粗視化値が一致する二点」の存在と同値であることを、
# 有限の模型をすべて数え上げて確認する。
# 帰属: 有限集合・有限写像・ZZ だけを使う。実数の極限、浮動小数点、実対数、指数関数は使わない。
# 主張は論理式の同値なので、極限量 alpha は「有理点へ付いた値のラベル」として有限に模型化する。
# 箱の添字も有限個に切る（同値の証明は L についての量化を素通しするだけなので、
# 有限個の L で成り立たない反例があれば、それは無限個でも反例になる）。

from itertools import product

POINTS = [ZZ(0), ZZ(1), ZZ(2)]     # 有理点 q in Q_alpha の代理（有限個）
BOXES = [ZZ(1), ZZ(2)]             # 箱の添字 L の代理（有限個）
ALPHA_VALUES = [ZZ(0), ZZ(1)]      # 極限量 alpha(q) の値の代理（一致・不一致だけが効く）
PI_VALUES = [ZZ(0), ZZ(1)]         # 粗視化 pi(Z_L(q)) の値の代理

def is_sufficient(alpha, pi):
    # 段 0: 本文の十分性の定義（def_sufficiency_on_ising_realizable_family）そのまま。
    # すべての q, q' について「すべての箱で粗視化値が一致するならば極限量が一致する」。
    for q in POINTS:
        for q2 in POINTS:
            if all(pi[(L, q)] == pi[(L, q2)] for L in BOXES):
                if alpha[q] != alpha[q2]:
                    return False
    return True

def has_witness(alpha, pi):
    # 段 1: 本文の証人の条件そのまま。
    # alpha(q) != alpha(q') かつ すべての箱で pi(Z_L(q)) = pi(Z_L(q'))。
    for q in POINTS:
        for q2 in POINTS:
            if alpha[q] != alpha[q2] and all(pi[(L, q)] == pi[(L, q2)] for L in BOXES):
                return True
    return False

alpha_maps = []
for values in product(ALPHA_VALUES, repeat=len(POINTS)):
    alpha_maps.append({q: values[i] for i, q in enumerate(POINTS)})

pi_keys = [(L, q) for L in BOXES for q in POINTS]
pi_maps = []
for values in product(PI_VALUES, repeat=len(pi_keys)):
    pi_maps.append({pi_keys[i]: values[i] for i in range(len(pi_keys))})

model_count = ZZ(0)
insufficient_count = ZZ(0)
for alpha in alpha_maps:
    for pi in pi_maps:
        model_count += 1
        suff = is_sufficient(alpha, pi)
        wit = has_witness(alpha, pi)
        # 段 2: 主張の同値。「十分でない」ことと「証人が存在する」ことが一致する。
        assert (not suff) == wit
        if not suff:
            insufficient_count += 1

assert model_count == ZZ(len(alpha_maps)) * ZZ(len(pi_maps))
assert insufficient_count > ZZ(0)   # 同値が空虚に成り立っているのではないこと

# 段 3: 一つの箱での粗視化値の衝突だけでは非十分性の証人にならないこと。
# 極限量が異なる二点が、箱 1 では同じ粗視化値を持つが、箱 2 では異なる粗視化値を持つ模型を作る。
alpha_sep = {ZZ(0): ZZ(0), ZZ(1): ZZ(1), ZZ(2): ZZ(1)}
pi_sep = {}
for L in BOXES:
    for q in POINTS:
        pi_sep[(L, q)] = ZZ(0)
pi_sep[(ZZ(2), ZZ(1))] = ZZ(1)      # 箱 2 で点 1 だけが別の粗視化値をとる
pi_sep[(ZZ(2), ZZ(2))] = ZZ(1)      # 点 2 も同じ側へ置き、極限量が一致する対だけを残す
assert alpha_sep[ZZ(0)] != alpha_sep[ZZ(1)]
assert pi_sep[(ZZ(1), ZZ(0))] == pi_sep[(ZZ(1), ZZ(1))]     # 箱 1 では衝突している
assert pi_sep[(ZZ(2), ZZ(0))] != pi_sep[(ZZ(2), ZZ(1))]     # 箱 2 では分かれる
assert not has_witness(alpha_sep, pi_sep)
assert is_sufficient(alpha_sep, pi_sep)

print("PASS: 模型数 %s, うち十分でないもの %s" % (model_count, insufficient_count))
print("PASS: 一つの箱での衝突だけでは非十分性の証人にならない")
