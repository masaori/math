# 対象ラベル: claim_one_s_linearly_independent
# 帰属: a,b,r は QQ、s は QQbar、包含写像 iota は QQbar(...)。
import os

if "_osi_samples" not in globals():
    _osi_polynomials = PolynomialRing(QQ, "t")
    _osi_t = _osi_polynomials.gen()
    _osi_roots = (_osi_t**2 - 2).roots(QQbar, multiplicities=False)
    assert len(_osi_roots) == 2
    _osi_samples = sorted({QQ(p) / QQ(q)
                           for p in range(-6, 7) for q in range(1, 7)})
    _osi_nonzero = [b for b in _osi_samples if b != 0]
    assert len(_osi_samples) == 47 and len(_osi_nonzero) == 46
    _osi_row_counts = {}
    _osi_assumed_rows = {}

def _osi_nonzero_cases():
    for s in _osi_roots:
        for a in _osi_samples:
            for b in _osi_nonzero:
                yield a, b, s, b**-1 * (-a)

def _osi_zero_cases():
    for s in _osi_roots:
        for a in _osi_samples:
            yield a, QQ(0), s

def _osi_origin_cases():
    for s in _osi_roots:
        yield QQ(0), QQ(0), s

def _osi_report(name, checked):
    assert checked > 0
    assert name not in _osi_row_counts and name not in _osi_assumed_rows
    _osi_row_counts[name] = checked
    print("%s: PASS (%s 等式)" % (name, checked))

def _osi_assumption(name, lean_step):
    assert name not in _osi_row_counts and name not in _osi_assumed_rows
    _osi_assumed_rows[name] = lean_step
    print("%s: 数値例なし・件数対象外; Lean: %s" % (name, lean_step))

