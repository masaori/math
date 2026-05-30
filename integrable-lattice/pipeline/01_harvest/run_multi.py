"""Run harvest across multiple sources.

Usage:
    python pipeline/01_harvest/run_multi.py [--source NAME ...] [--dry-run]
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "src"))

from integrable_lattice.harvest import parse_queries  # noqa: E402

SOURCES = {
    "arxiv": (
        "integrable_lattice.harvest",
        "manifest.jsonl",
        {"max_results": 100, "sleep_seconds": 3.0},
    ),
    "openalex": (
        "integrable_lattice.harvest_openalex",
        "manifest_openalex.jsonl",
        {"per_page": 100, "sleep_seconds": 1.0},
    ),
    "semantic_scholar": (
        "integrable_lattice.harvest_semantic_scholar",
        "manifest_semantic_scholar.jsonl",
        {"limit": 100, "sleep_seconds": 3.5},
    ),
    "inspire": (
        "integrable_lattice.harvest_inspire",
        "manifest_inspire.jsonl",
        {"size": 100, "sleep_seconds": 1.0},
    ),
}


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--source",
        action="append",
        choices=list(SOURCES),
        help="May be repeated. Default: all non-arxiv sources.",
    )
    parser.add_argument(
        "--queries",
        type=Path,
        default=ROOT / "inputs" / "queries" / "seed-queries.md",
    )
    parser.add_argument(
        "--out-dir",
        type=Path,
        default=ROOT / "inputs" / "corpus",
    )
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    sources = args.source or ["openalex", "semantic_scholar", "inspire"]
    queries = parse_queries(args.queries)
    print(f"Parsed {len(queries)} queries from {args.queries}")

    if args.dry_run:
        return 0

    for src in sources:
        module_name, out_name, kwargs = SOURCES[src]
        print(f"\n=== {src} ===")
        mod = __import__(module_name, fromlist=["harvest"])
        out_path = args.out_dir / out_name
        mod.harvest(queries, out_path=out_path, **kwargs)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
