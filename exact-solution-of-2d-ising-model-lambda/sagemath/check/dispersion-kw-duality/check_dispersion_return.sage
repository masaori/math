# 対象ラベル: claim_dispersion_kw_duality
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert 4*((1 + x^2)^2 - x*(1 - x^2)*mode_sum) == 4*dispersion(x)
print('RESULT: PASS dispersion return')
