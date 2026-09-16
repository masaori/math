import glob
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
for script in sorted(glob.glob(os.path.join(_dir, 'check_*.sage'))):
    print('=== %s ===' % os.path.basename(script))
    load(script)
