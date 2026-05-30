"""Semantic Scholar harvest for the integrable-lattice project.

Stdlib only. https://api.semanticscholar.org/api-docs/graph
Unauthenticated rate limit: ~100 requests / 5 minutes.
"""

from __future__ import annotations

import json
import time
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import asdict, dataclass, field
from pathlib import Path

from .harvest import Query

S2_API = "https://api.semanticscholar.org/graph/v1/paper/search"
USER_AGENT = (
    "integrable-lattice-harvest/0.1 "
    "(mailto:masaori.hirono@hexagonal-computation.com)"
)
S2_FIELDS = "externalIds,title,abstract,year,authors,venue,citationCount,fieldsOfStudy"


@dataclass
class S2Record:
    id: str
    title: str
    authors: list[str]
    year: int | None
    source: str
    s2_id: str
    arxiv_id: str
    doi: str
    url: str
    abstract: str
    venue: str
    fields_of_study: list[str]
    citation_count: int
    matched_queries: list[str] = field(default_factory=list)


def fetch(query: Query, limit: int = 100, offset: int = 0, max_retries: int = 4) -> dict:
    params = {
        "query": query.raw,
        "limit": str(limit),
        "offset": str(offset),
        "fields": S2_FIELDS,
    }
    qs = "&".join(f"{k}={urllib.parse.quote(v, safe='')}" for k, v in params.items())
    url = f"{S2_API}?{qs}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    backoff = 5.0
    for attempt in range(max_retries):
        try:
            with urllib.request.urlopen(req, timeout=60) as resp:
                return json.loads(resp.read().decode("utf-8"))
        except urllib.error.HTTPError as e:
            if e.code == 429 and attempt < max_retries - 1:
                time.sleep(backoff)
                backoff *= 2
                continue
            raise
    raise RuntimeError("unreachable")


def parse_paper(p: dict, query: Query) -> S2Record | None:
    s2_id = p.get("paperId") or ""
    if not s2_id:
        return None
    ext = p.get("externalIds") or {}
    arxiv_id = ext.get("ArXiv") or ""
    doi = ext.get("DOI") or ""
    authors = [(a.get("name") or "") for a in (p.get("authors") or [])]
    venue = p.get("venue") or ""
    fos = [
        (f if isinstance(f, str) else (f.get("category") or ""))
        for f in (p.get("fieldsOfStudy") or [])
    ]
    fos = [f for f in fos if f]
    return S2Record(
        id=f"s2:{s2_id}",
        title=p.get("title") or "",
        authors=authors,
        year=p.get("year"),
        source="semantic_scholar",
        s2_id=s2_id,
        arxiv_id=arxiv_id,
        doi=doi,
        url=f"https://www.semanticscholar.org/paper/{s2_id}",
        abstract=p.get("abstract") or "",
        venue=venue,
        fields_of_study=fos,
        citation_count=p.get("citationCount") or 0,
        matched_queries=[f"{query.section}::{query.raw}"],
    )


def harvest(
    queries: list[Query],
    out_path: Path,
    limit: int = 100,
    sleep_seconds: float = 3.5,
    log=print,
) -> dict[str, S2Record]:
    records: dict[str, S2Record] = {}
    out_path.parent.mkdir(parents=True, exist_ok=True)
    for i, q in enumerate(queries):
        if i > 0:
            time.sleep(sleep_seconds)
        log(f"[{i+1}/{len(queries)}] {q.section} :: {q.raw}")
        try:
            data = fetch(q, limit=limit)
        except Exception as e:  # noqa: BLE001
            log(f"  ERROR: {e}")
            continue
        papers = data.get("data") or []
        log(f"  -> {len(papers)} results (total estimate: {data.get('total', '?')})")
        new_count = 0
        for p in papers:
            rec = parse_paper(p, q)
            if rec is None:
                continue
            if rec.id in records:
                records[rec.id].matched_queries.extend(rec.matched_queries)
            else:
                records[rec.id] = rec
                new_count += 1
        log(f"  -> {new_count} new (total: {len(records)})")
    with out_path.open("w", encoding="utf-8") as f:
        for rec in records.values():
            f.write(json.dumps(asdict(rec), ensure_ascii=False) + "\n")
    log(f"Wrote {len(records)} records to {out_path}")
    return records
