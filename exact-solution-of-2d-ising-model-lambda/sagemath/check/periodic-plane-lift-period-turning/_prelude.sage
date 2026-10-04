from pathlib import Path
_period_turning_dir = Path('sagemath/check/periodic-plane-lift-period-turning').resolve()
load(str(_period_turning_dir / 'construction.sage'))
_period_turning_rows = list(period_turning_cases())
