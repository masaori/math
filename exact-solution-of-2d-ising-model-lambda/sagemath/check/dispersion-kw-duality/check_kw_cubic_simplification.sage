# 対象ラベル: claim_dispersion_kw_duality
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert (1 - x)/(1 + x)*(1 - (1 - x)^2/(1 + x)^2) == 4*x*(1 - x)/(1 + x)^3
print('RESULT: PASS KW cubic simplification')
