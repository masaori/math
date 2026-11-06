# 対象ラベル: claim_same_base_successor_is_loop
# 同じ基底辺の二方向を列挙し、非後退接続がループに限ることを確認する。
for L in range(1, 5):
    for axis in range(2):
        for i in range(L):
            for j in range(L):
                source = (i, j)
                target = (i, (j + 1) % L) if axis == 0 else ((i + 1) % L, j)
                for direction_e in range(2):
                    for direction_f in range(2):
                        e_source, e_target = (source, target) if direction_e == 0 else (target, source)
                        f_source, f_target = (source, target) if direction_f == 0 else (target, source)
                        if e_target == f_source and direction_f != 1 - direction_e:
                            assert direction_e == direction_f
                            assert e_source == e_target
print('RESULT: PASS; all same-base successor pairs for L = 1, 2, 3, 4')
