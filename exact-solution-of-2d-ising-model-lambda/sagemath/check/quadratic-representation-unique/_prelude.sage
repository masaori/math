# 対象ラベル: claim_quadratic_representation_unique
# 帰属: a,b,a',b',alpha,beta は QQ、s は QQbar、包含写像は QQbar(...)。
if "_qru_roots" not in globals():
    _qru_ring = PolynomialRing(QQ, "t")
    _qru_t = _qru_ring.gen()
    _qru_roots = (_qru_t**2 - 2).roots(QQbar, multiplicities=False)
    assert len(_qru_roots) == 2
    _qru_samples = sorted({QQ(p)/QQ(q) for p in range(-2,3) for q in range(1,3)})
    assert len(_qru_samples) == 7
    _qru_counts = {}

def _qru_cases(equal_representation=False):
    for s in _qru_roots:
        assert s*s == QQbar(2)
        for a in _qru_samples:
            for b in _qru_samples:
                for ap in _qru_samples:
                    for bp in _qru_samples:
                        if equal_representation and (a != ap or b != bp):
                            continue
                        if equal_representation:
                            assert QQbar(a)+QQbar(b)*s == QQbar(ap)+QQbar(bp)*s
                            assert a + (-ap) == 0 and b + (-bp) == 0
                        yield a,b,ap,bp,s,a+(-ap),b+(-bp)

def _qru_report(name,checked,equal_representation):
    assert checked == (98 if equal_representation else 4802)
    assert name not in _qru_counts
    _qru_counts[name] = checked
    print("%s: PASS (%s 等式)" % (name,checked))
