"""一辺二の単純閉路鍵の二項を D と E の相対配置統計で書く。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

parity-identity-simple-cycle-key-terms では、一辺二の単純閉路鍵について
頂点項と非共有端点対項が閉路の方向列だけでは決まらないことが分かった。
そこで各頂点に接する四つの基底辺スロットについて、D と E の所属、および
切断への隣接を記録した局所署名を作る。各署名を持つ頂点数の偶奇を相対配置
統計とし、頂点項がその F_2 線型結合で書けるかを厳密に解く。

一辺二では動辺数が常に偶数であるから、頂点項が書ければ
非共有端点対項 = 標的指数 + 頂点項
により同じ統計と既知の標的指数から対項も書ける。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-simple-cycle-relative-configuration/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
pair_terms = []
rows = []
target_terms = []
vertex_terms = []

for doubled, single in cycle_keys:
    vertices = sorted({
        endpoint
        for edge in doubled.union(single)
        for endpoint in base_endpoints(side, edge)
    })
    counts = {
        signature: GF(2)(sum(
            1 for vertex in vertices
            if relative_vertex_signature(side, vertex, doubled, single)
            == signature
        ))
        for signature in all_signatures
    }
    rows.append(tuple(counts[signature] for signature in all_signatures))
    moved, vertex, pair, target = key_terms(side, doubled, single)
    assert moved == 0
    assert (vertex + pair) % 2 == target
    vertex_terms.append(GF(2)(vertex))
    pair_terms.append(GF(2)(pair))
    target_terms.append(GF(2)(target))
selected_signatures = [
    signature
    for index, signature in enumerate(all_signatures)
    if vertex_solution[index] != 0
]

for row, vertex, pair, target in zip(
        rows, vertex_terms, pair_terms, target_terms):
    relative_value = sum(
        row[index] * vertex_solution[index]
        for index in range(len(all_signatures))
    )
    assert relative_value == vertex
    assert pair == target + relative_value

print("L=2: simple-cycle-keys=%d signatures=%d matrix-rank=%d "
      "selected-signatures=%d"
      % (len(cycle_keys), len(all_signatures), statistic_matrix.rank(),
         len(selected_signatures)))
for signature in selected_signatures:
    print("SELECTED: %s" % (signature,))

assert len(cycle_keys) == 320
assert selected_signatures
print("PASS: 一辺二の単純閉路鍵の頂点項は D と E の頂点局所相対配置署名の"
      " F_2 線型結合で書け、非共有端点対項は標的指数との和で書ける")
