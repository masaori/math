"""Merge per-source manifests, dedup across sources, and apply precision filter.

Usage:
    python pipeline/01_harvest/merge.py [--include-classified] [--no-filter]
"""

from __future__ import annotations

import argparse
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "src"))

from integrable_lattice.dedup import merge_manifests, write_jsonl  # noqa: E402
from integrable_lattice.filter_relevance import keep  # noqa: E402

CORPUS = ROOT / "inputs" / "corpus"
SOURCE_FILES_DEFAULT = {
    "arxiv": CORPUS / "manifest.jsonl",
    "openalex": CORPUS / "manifest_openalex.jsonl",
    "semantic_scholar": CORPUS / "manifest_semantic_scholar.jsonl",
    "inspire": CORPUS / "manifest_inspire.jsonl",
}
SOURCE_FILES_CLASSIFIED = {
    **SOURCE_FILES_DEFAULT,
    "arxiv": CORPUS / "manifest_classified.jsonl",
}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--include-classified",
        action="store_true",
        help="Use manifest_classified.jsonl instead of manifest.jsonl for arxiv (carries model/operation/status hints).",
    )
    parser.add_argument(
        "--no-filter", action="store_true", help="Skip precision filter."
    )
    parser.add_argument(
        "--out-merged",
        type=Path,
        default=CORPUS / "manifest_merged.jsonl",
    )
    parser.add_argument(
        "--out-filtered",
        type=Path,
        default=CORPUS / "manifest_filtered.jsonl",
    )
    args = parser.parse_args()

    src = SOURCE_FILES_CLASSIFIED if args.include_classified else SOURCE_FILES_DEFAULT
    print("Inputs:")
    for k, v in src.items():
        exists = "OK" if v.exists() else "MISSING"
        print(f"  {k}: {v.name} [{exists}]")
    print()

    canonical = merge_manifests(src)
    print()
    print(f"Total unique records: {len(canonical)}")

    n = write_jsonl(canonical.values(), args.out_merged)
    print(f"Wrote merged: {n} → {args.out_merged}")

    src_counts = Counter()
    for r in canonical.values():
        for s in r.get("sources", []):
            src_counts[s] += 1
    print("Per-source coverage:")
    for s, c in src_counts.most_common():
        print(f"  {s}: {c}")
    overlap = Counter()
    for r in canonical.values():
        overlap[len(r.get("sources", []))] += 1
    print("Records by number of sources:")
    for n_src, c in sorted(overlap.items()):
        print(f"  in {n_src} source(s): {c}")

    if args.no_filter:
        return 0

    kept = []
    reasons = Counter()
    rejected_examples = []
    for rec in canonical.values():
        ok, reason = keep(rec)
        if ok:
            rec["filter_reason"] = reason
            kept.append(rec)
            reasons[reason.split(":")[0]] += 1
        else:
            if len(rejected_examples) < 5:
                rejected_examples.append(rec.get("title", "")[:80])
            reasons["REJECTED"] += 1
    n = write_jsonl(kept, args.out_filtered)
    print()
    print(f"Filter result: {len(kept)} kept / {len(canonical)} total")
    print("Reasons:")
    for r, c in reasons.most_common():
        print(f"  {r}: {c}")
    if rejected_examples:
        print("Sample rejected:")
        for t in rejected_examples:
            print(f"  - {t}")
    print(f"Wrote filtered: {n} → {args.out_filtered}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
