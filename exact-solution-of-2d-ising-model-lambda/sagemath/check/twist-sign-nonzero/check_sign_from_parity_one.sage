# 対象ラベル: claim_twist_sign_nonzero
# 本文の κ=1: ε=(-1)^1。切断線とねじれの全場合を検査。
for a in (0, 1):
    for b in (0, 1):
        for ch in (0, 1):
            for cv in (0, 1):
                n = ZZ(a * ch + b * cv)
                kappa = n % 2
                if kappa == 1:
                    assert ZZ(-1) ** n == ZZ(-1) ** 1
