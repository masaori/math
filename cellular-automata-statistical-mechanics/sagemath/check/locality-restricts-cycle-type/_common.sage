# 章「局所性による巡回型の制限」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、自然数、有限多重集合のみ。浮動小数点と R/C 脱出はない。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'reversible-global-map-cycle-type', '_common.sage'))


def configurations(cell_count):
    return tuple(itertools.product((0, 1), repeat=cell_count))


def unary_rules():
    """A -> A の四つの真理値表を (g(0), g(1)) で表す。"""
    return tuple(itertools.product((0, 1), repeat=2))


def global_table(rule_family):
    """自己近傍舞台の局所規則族から大域写像表を作る。"""
    configs = configurations(len(rule_family))
    index = {config: position for position, config in enumerate(configs)}
    return tuple(index[tuple(rule_family[v][config[v]] for v in range(len(rule_family)))]
                 for config in configs)


def self_neighborhood_families(cell_count):
    return tuple(itertools.product(unary_rules(), repeat=cell_count))

