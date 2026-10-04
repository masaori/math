import os
if "_nrs_positive" not in globals():
    _nrs_positive = [QQ(a) / QQ(b) for a in range(1, 41) for b in range(1, 41)]
    _nrs_negative = [-r for r in _nrs_positive]
    _nrs_high = [ZZ(m) for m in range(1, 81)]
    _nrs_low = [ZZ(m) for m in range(-80, 1)]
    _nrs_checked = 0
    _nrs_assumed = 0

def _nrs_w2(q):
    assert q in QQ and q > 0
    return ZZ(q.numerator()).valuation(2) - ZZ(q.denominator()).valuation(2)

def _nrs_log(q):
    """全素数での有限台の指数。二の valuation を使う w2 と別に構成する。"""
    assert q in QQ and q > 0
    result = {}
    for p, exponent in ZZ(q.numerator()).factor():
        result[p] = ZZ(exponent)
    for p, exponent in ZZ(q.denominator()).factor():
        result[p] = result.get(p, ZZ(0)) - ZZ(exponent)
    return {p: n for p, n in result.items() if n != 0}

def _nrs_add_logs(left, right):
    return {p: left.get(p, ZZ(0)) + right.get(p, ZZ(0))
            for p in set(left) | set(right)}

def _nrs_report(name, checked):
    global _nrs_checked
    assert checked > 0
    _nrs_checked += checked
    print("%s: PASS (%s 等式・不等式)" % (name, checked))

def _nrs_assumption(name, lean_step):
    global _nrs_assumed
    _nrs_assumed += 1
    print("%s: 数値検算対象なし・Leanで仮定代入確認 (%s)" % (name, lean_step))
