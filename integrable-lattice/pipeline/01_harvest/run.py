"""CLI for 01_harvest.

Usage:
    python pipeline/01_harvest/run.py [--max-results N] [--dry-run]
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "src"))

from integrable_lattice.harvest import harvest, parse_queries  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-results", type=int, default=100)
    parser.add_argument("--sleep", type=float, default=3.0)
    parser.add_argument(
        "--queries",
        type=Path,
        default=ROOT / "inputs" / "queries" / "seed-queries.md",
    )
    parser.add_argument(
        "--out",
        type=Path,
        default=ROOT / "inputs" / "corpus" / "manifest.jsonl",
    )
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    queries = parse_queries(args.queries)
    print(f"Parsed {len(queries)} queries from {args.queries}")
    for q in queries:
        print(f"  [{q.section}] {q.raw}")

    if args.dry_run:
        return 0

    harvest(
        queries,
        out_path=args.out,
        max_results=args.max_results,
        sleep_seconds=args.sleep,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
