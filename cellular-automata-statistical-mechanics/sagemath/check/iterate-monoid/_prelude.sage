from itertools import product


def configurations(stage_size):
    return tuple(product((0, 1), repeat=stage_size))


def elementary_local_value(rule, left, center, right):
    return (rule >> (4 * left + 2 * center + right)) & 1


def elementary_global_map(rule, configuration):
    stage_size = len(configuration)
    if stage_size == 0:
        return configuration
    return tuple(
        elementary_local_value(
            rule,
            configuration[(cell - 1) % stage_size],
            configuration[cell],
            configuration[(cell + 1) % stage_size],
        )
        for cell in range(stage_size)
    )


def global_truth_table(rule, stage_size):
    """大域写像 F を、配位番号 -> 配位番号 の有限真理値表（タプル）として返す。"""
    confs = configurations(stage_size)
    index = {c: k for k, c in enumerate(confs)}
    return tuple(index[elementary_global_map(rule, c)] for c in confs)


def identity_table(size):
    return tuple(range(size))


def compose(outer, inner):
    """写像の合成 outer ∘ inner を真理値表で計算する。"""
    return tuple(outer[inner[k]] for k in range(len(inner)))


def power_tables(table, last_exponent):
    """F^0, F^1, ..., F^{last_exponent} を def_finite_self_map_iterate の再帰 F^{n+1} = F ∘ F^n で計算する。"""
    result = [identity_table(len(table))]
    for _ in range(last_exponent):
        result.append(compose(table, result[-1]))
    return tuple(result)


def exhaustive_instances():
    """セル数 0 の唯一の大域写像と、1 <= |V| <= 3 の巡回舞台上の全 256 初等 CA 規則。"""
    yield 0, 0, global_truth_table(0, 0)
    for stage_size in range(1, 4):
        for rule in range(256):
            yield stage_size, rule, global_truth_table(rule, stage_size)


def scan_bound(stage_size):
    """M = 2^|V| 個の点上の写像列 F^n は、指数 M + lcm(1..M) 以内で必ず衝突する（前周期 <= M、周期 <= lcm）。
    ここでは検算用の走査上限としてその値を使う。人手証明の上界 K = M^M より小さいが K 以下であることは別に検査する。"""
    m = 2 ** stage_size
    return m + lcm(range(1, m + 1))


def first_collision(powers):
    seen = {}
    for exponent, table in enumerate(powers):
        if table in seen:
            return seen[table], exponent
        seen[table] = exponent
    return None
