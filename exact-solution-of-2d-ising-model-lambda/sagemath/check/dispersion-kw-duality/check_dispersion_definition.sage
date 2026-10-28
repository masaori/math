# 対象ラベル: claim_dispersion_kw_duality
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (1 + x)^4*dispersion(kw) == (1 + x)^4*((1 + kw^2)^2 - kw*(1 - kw^2)*mode_sum)
print('RESULT: PASS dispersion definition')
