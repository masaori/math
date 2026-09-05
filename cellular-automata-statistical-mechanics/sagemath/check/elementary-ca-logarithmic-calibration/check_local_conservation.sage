# 対象ラベル: def_binary_ca_integer_conserved_observable
# 式ペア・判定: 真理値表の局所制限と整数値写像の保存判定
# 帰属: 有限集合・ZZ・QQ・素数上の有限台整数ベクトル。実数複素数への脱出なし。
import os
load(os.path.join(os.path.dirname(os.path.abspath(__file__)), '_prelude.sage'))
accepted = rejected = 0
rules_by_size = {size: [] for size in SIZES}
for size, rule, configs, mapping in elementary_maps():
    # 符号化 enc(x)=Σ[x(v)=1] 2^(L-1-v) による別経路の大域表。
    for x, y in zip(configs, mapping):
        bits = []
        for v in range(size):
            neighborhood = {(v-1)%size, v, (v+1)%size}
            restriction = {w: x[w] for w in neighborhood}
            k = 4*restriction[(v-1)%size]+2*restriction[v]+restriction[(v+1)%size]
            bits.append((ZZ(rule)//(ZZ(2)**k)) % 2)
        encoded = sum(z*(2**(size-1-v)) for v,z in enumerate(bits))
        assert encoded == y
    for slope in SLOPES:
        H = observable(configs,slope)
        witnesses = [x for x in range(len(mapping)) if H[mapping[x]] != H[x]]
        assert conserved(mapping,H) == (len(witnesses) == 0)
        if witnesses:
            assert slope != 0
            rejected += 1
        else:
            accepted += 1
            if slope == 1:
                rules_by_size[size].append(rule)
assert accepted + rejected == len(SIZES)*256*len(SLOPES)
assert accepted > 0 and rejected > 0
print('accepted:', accepted, 'rejected:', rejected)
print('count-preserving rules:', rules_by_size)

print("RESULT: PASS")
