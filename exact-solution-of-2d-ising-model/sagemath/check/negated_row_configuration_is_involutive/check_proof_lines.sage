# 対象ラベル: negated_row_configuration_is_involutive
# 証明の 3 行の鎖 (-(-s))(m) = -((-s)(m)) = -(-s(m)) = s(m) と主張 -(-s) = s を、
# M_col = 1, …, 5 の全ての s ∈ 𝔐 と全ての m で整数のまま確かめる。
load("../epsilon_entries_in_row_configuration_numbering/_epsilon_exact.sage")

count = 0
for M in range(1, 6):
    for s in configurations(M):
        ns = neg(s)                                              # def_negated_row_configuration
        nns = neg(ns)
        for m in range(M):
            chain = [nns[m], -(ns[m]), -(-s[m]), s[m]]
            assert all(c == chain[0] for c in chain), (M, s, m)
            count += 1
        assert tuple(nns) == tuple(s), (M, s, "主張")
# 否定コントロール: 符号を 1 回だけ反転したものは元と一致しない
assert all(tuple(neg(s)) != tuple(s) for s in configurations(3))
print(f"{count} 組の (M_col, s, m) で 3 行の鎖が成り立ち、全ての s で -(-s) = s。否定コントロール 1 件")
print("RESULT: PASS")
