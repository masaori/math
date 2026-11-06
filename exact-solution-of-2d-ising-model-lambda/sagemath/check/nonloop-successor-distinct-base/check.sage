# 対象ラベル: claim_nonloop_successor_distinct_base
# 非ループの非後退接続で同一基底辺が残らないことを厳密に列挙する。
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
                        if e_source != e_target and e_target == f_source and direction_f != 1 - direction_e:
                            assert False, (L, axis, i, j, direction_e, direction_f)
                if L >= 2:
                    assert source != target
print('RESULT: PASS; nonloop passages and L >= 2 edges for L = 1, 2, 3, 4')
