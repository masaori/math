"""Cross-source deduplication and merging for harvest manifests.

Canonical key priority: arxiv_id > doi > normalized_title.
Merging keeps all matched_queries, source-specific ids, and the richest fields.
"""

from __future__ import annotations

import json
import re
from collections.abc import Iterable
from pathlib import Path


def normalize_arxiv_id(aid: str) -> str:
    s = aid.strip().lower()
    s = re.sub(r"v\d+$", "", s)
    return s


def normalize_doi(doi: str) -> str:
    s = doi.strip().lower()
    s = s.replace("https://doi.org/", "").replace("http://doi.org/", "")
    return s


def normalize_title(t: str) -> str:
    s = t.lower()
    s = re.sub(r"[^a-z0-9]+", "", s)
    return s[:120]


def canonical_key(rec: dict) -> str:
    aid = rec.get("arxiv_id") or ""
    if aid:
        return f"arxiv:{normalize_arxiv_id(aid)}"
    doi = rec.get("doi") or ""
    if doi:
        return f"doi:{normalize_doi(doi)}"
    t = rec.get("title") or ""
    n = normalize_title(t)
    return f"title:{n}" if n else f"id:{rec.get('id', '')}"


def _cited(rec: dict) -> int:
    return int(rec.get("cited_by_count") or rec.get("citation_count") or 0)


def merge_into(dst: dict, src: dict, src_name: str) -> None:
    dst.setdefault("sources", set()).add(src_name)
    dst.setdefault("source_ids", {})[src_name] = (
        src.get(f"{src_name}_id") or src.get("id") or ""
    )
    dst.setdefault("matched_queries", []).extend(src.get("matched_queries") or [])
    for field in ("abstract", "doi", "arxiv_id", "title", "venue", "url"):
        if not dst.get(field) and src.get(field):
            dst[field] = src[field]
    if not dst.get("authors") and src.get("authors"):
        dst["authors"] = src["authors"]
    if not dst.get("year") and src.get("year"):
        dst["year"] = src["year"]
    # Preserve classified hints (only arxiv has them initially)
    for field in ("model_hints", "operation_hints", "status_hints"):
        if src.get(field) and not dst.get(field):
            dst[field] = src[field]
    # Concepts / fields_of_study: union
    for field in ("concepts", "fields_of_study"):
        if src.get(field):
            dst.setdefault(field, [])
            for v in src[field]:
                if v not in dst[field]:
                    dst[field].append(v)
    # Cited: max
    new_cited = max(_cited(dst), _cited(src))
    if new_cited:
        dst["cited_by_count"] = new_cited
    # primary_category from arxiv only
    if src_name == "arxiv" and src.get("primary_category"):
        dst["primary_category"] = src["primary_category"]


def merge_manifests(
    sources: dict[str, Path], log=print
) -> dict[str, dict]:
    """sources = {source_name: path_to_jsonl}. Returns canonical_key -> merged record."""
    canonical: dict[str, dict] = {}
    for src_name, path in sources.items():
        if not path.exists():
            log(f"[skip] {src_name}: {path} not found")
            continue
        count = 0
        new_count = 0
        with path.open(encoding="utf-8") as f:
            for line in f:
                if not line.strip():
                    continue
                rec = json.loads(line)
                count += 1
                key = canonical_key(rec)
                if key in canonical:
                    merge_into(canonical[key], rec, src_name)
                else:
                    # Seed merged record
                    seed = dict(rec)
                    seed["canonical_key"] = key
                    seed["sources"] = set()
                    seed["source_ids"] = {}
                    seed["matched_queries"] = []
                    merge_into(seed, rec, src_name)
                    canonical[key] = seed
                    new_count += 1
        log(f"[{src_name}] {count} read, {new_count} new (total unique: {len(canonical)})")
    # Convert sets to sorted lists for JSON
    for r in canonical.values():
        r["sources"] = sorted(r["sources"])
    return canonical


def write_jsonl(records: Iterable[dict], path: Path) -> int:
    path.parent.mkdir(parents=True, exist_ok=True)
    n = 0
    with path.open("w", encoding="utf-8") as f:
        for r in records:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")
            n += 1
    return n
