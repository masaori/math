# 対象ラベル: claim_distinct_direction_dual_inner_zero
for L in range(1, 5):
    for delta in range(4):
        for delta_prime in range(4):
            if delta == delta_prime:
                continue
            for row in range(L):
                for column in range(L):
                    for direction in range(4):
                        dual = (QQbar(2) ** (-column) * QQbar(3) ** (-row)
                                if direction == delta else QQbar(0))
                        primal = (QQbar(5) ** column * QQbar(7) ** row
                                  if direction == delta_prime else QQbar(0))
                        assert dual * primal == 0
