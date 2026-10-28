import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_substitute_aliases.sage', 'check_clear_denominators.sage', 'check_association.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS algebraic Onsager form')
