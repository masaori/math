# 対象ラベル: claim_dispersion_kw_duality
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert 1 + kw^2 == 1 + (1 - x)^2/(1 + x)^2
print('RESULT: PASS KW square substitution')
