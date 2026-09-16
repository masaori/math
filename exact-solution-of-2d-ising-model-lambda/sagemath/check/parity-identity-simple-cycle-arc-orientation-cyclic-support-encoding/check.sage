"""二つの正準弧型支持を巡回軌道と切断位置で損失なく符号化する。

対象ラベル: claim_kac_ward_determinant_fiber_stratified_phase_sum
一般の辺長についての命題ではない。ただし符号化写像そのものは任意の
空でない有限語に対して定義する。
"""

print("LOAD: reconstructing canonical arc lifts", flush=True)
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-cyclic-relation-arc-lifts/check.sage")
load("sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-support-encoding/construction.sage")

import ast
import json
from collections import Counter
from pathlib import Path


def integer_dict(counter):
    return {str(key): int(value) for key, value in sorted(counter.items())}


def support_summary(encoded_support):
    support = tuple(ast.literal_eval(text) for text in encoded_support)
    orbit_keys = tuple(arc_cyclic_orbit_key(arc_type) for arc_type in support)
    selectors = tuple(arc_cyclic_selector(arc_type) for arc_type in support)

    assert len(set(support)) == len(support)
    assert len(set(orbit_keys)) == len(support)
    assert all(
        decode_arc_cyclic_encoding(orbit_key, selector) == arc_type
        for arc_type, orbit_key, selector in zip(
            support, orbit_keys, selectors))

    lengths = Counter(len(arc_type[1]) for arc_type in support)
    orbit_sizes = {
        length: Counter(
            len(arc_cyclic_orbit(arc_type))
            for arc_type in support if len(arc_type[1]) == length)
        for length in sorted(lengths)
    }
    selector_counts = {
        length: Counter(
            arc_cyclic_selector(arc_type)
            for arc_type in support if len(arc_type[1]) == length)
        for length in sorted(lengths)
    }
    return {
        "support_weight": len(support),
        "orbit_count": len(set(orbit_keys)),
        "length_counts": integer_dict(lengths),
        "orbit_size_counts_by_length": {
            str(length): integer_dict(orbit_sizes[length])
            for length in sorted(orbit_sizes)
        },
        "selector_counts_by_length": {
            str(length): integer_dict(selector_counts[length])
            for length in sorted(selector_counts)
        },
    }, frozenset(orbit_keys)


summaries = {}
orbit_key_sets = {}
for name, result in results.items():
    summaries[name], orbit_key_sets[name] = support_summary(
        result["arc_support"])

expected_summaries = {
    "endpoint_only": {
        "support_weight": 462,
        "orbit_count": 462,
        "length_counts": {"1": 127, "2": 70, "3": 148, "5": 76, "6": 25, "7": 16},
        "orbit_size_counts_by_length": {
            "1": {"1": 127},
            "2": {"1": 70},
            "3": {"3": 148},
            "5": {"5": 76},
            "6": {"6": 25},
            "7": {"7": 16},
        },
        "selector_counts_by_length": {
            "1": {"0": 127},
            "2": {"0": 70},
            "3": {"0": 27, "1": 2, "2": 119},
            "5": {"2": 12, "3": 33, "4": 31},
            "6": {"3": 5, "4": 9, "5": 11},
            "7": {"2": 1, "3": 5, "4": 6, "5": 3, "6": 1},
        },
    },
    "step_endpoint": {
        "support_weight": 616,
        "orbit_count": 616,
        "length_counts": {"1": 170, "2": 92, "3": 198, "5": 102, "6": 33, "7": 21},
        "orbit_size_counts_by_length": {
            "1": {"1": 170},
            "2": {"1": 92},
            "3": {"3": 198},
            "5": {"5": 102},
            "6": {"6": 33},
            "7": {"7": 21},
        },
        "selector_counts_by_length": {
            "1": {"0": 170},
            "2": {"0": 92},
            "3": {"0": 28, "1": 23, "2": 147},
            "5": {"0": 1, "1": 2, "2": 25, "3": 48, "4": 26},
            "6": {"3": 4, "4": 14, "5": 15},
            "7": {"2": 4, "3": 6, "4": 5, "5": 4, "6": 2},
        },
    },
}
assert summaries == expected_summaries

shared_orbit_count = len(
    orbit_key_sets["endpoint_only"] & orbit_key_sets["step_endpoint"])
assert shared_orbit_count == 227

certificate = {
    "kind": "cyclic-arc-support-encoding",
    "encoding": "cyclic-reversal orbit key plus least cyclic selector",
    "summaries": summaries,
    "shared_orbit_count": shared_orbit_count,
}
certificate_path = Path(
    "sagemath/check/parity-identity-simple-cycle-arc-orientation-cyclic-support-encoding/certificate.json")
certificate_path.write_text(
    json.dumps(certificate, ensure_ascii=False, separators=(",", ":")) + "\n")

for name, summary in summaries.items():
    print(
        "ENCODING %s: support=%d distinct_orbits=%d" % (
            name,
            summary["support_weight"],
            summary["orbit_count"],
        ),
        flush=True,
    )
print("SHARED ORBITS: %d" % shared_orbit_count, flush=True)
print("CERTIFICATE: %s" % certificate_path, flush=True)
print("PASS: canonical arc supports encoded by cyclic orbits", flush=True)
