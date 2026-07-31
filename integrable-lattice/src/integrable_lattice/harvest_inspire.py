"""INSPIRE-HEP harvest for the integrable-lattice project.

Stdlib only. https://inspirehep.net/help/api
INSPIRE focuses on hep / math-ph / nucl-th, very relevant for integrable lattice work.
"""

from __future__ import annotations

import json
import re
import time
import urllib.parse
import urllib.request
from dataclasses import asdict, dataclass, field
from pathlib import Path

from .harvest import Query

INSPIRE_API = "https://inspirehep.net/api/literature"
USER_AGENT = (
    "integrable-lattice-harvest/0.1 "
    "(mailto:masaori.hirono@hexagonal-computation.com)"
)


@dataclass
class InspireRecord:
    id: str
    title: str
    authors: list[str]
    year: int | None
    source: str
    inspire_id: str
    arxiv_id: str
    doi: str
    url: str
    abstract: str
    venue: str
    citation_count: int
    matched_queries: list[str] = field(default_factory=list)


def build_query(query: Query) -> str:
    # INSPIRE supports phrase search and boolean. Quoted phrases are honored.
    # Fall back to a simple full-text query.
    return query.raw


def fetch(query: Query, size: int = 100) -> dict:
    params = {
        "q": build_query(query),
        "size": str(size),
        "page": "1",
        "fields": ",".join([
            "titles",
            "authors.full_name",
            "abstracts",
            "arxiv_eprints",
            "dois",
            "publication_info",
            "citation_count",
            "control_number",
            "publication_info.year",
        ]),
        "sort": "mostrecent",
    }
    qs = "&".join(f"{k}={urllib.parse.quote(v, safe='')}" for k, v in params.items())
    url = f"{INSPIRE_API}?{qs}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=60) as resp:
        return json.loads(resp.read().decode("utf-8"))


def parse_hit(hit: dict, query: Query) -> InspireRecord | None:
    md = hit.get("metadata") or {}
    inspire_id = str(md.get("control_number") or hit.get("id") or "")
    if not inspire_id:
        return None
    titles = md.get("titles") or []
    title = (titles[0].get("title") if titles else "") or ""
    abstracts = md.get("abstracts") or []
    abstract = (abstracts[0].get("value") if abstracts else "") or ""

    authors = [(a.get("full_name") or "") for a in (md.get("authors") or [])][:20]
    arxiv_eprints = md.get("arxiv_eprints") or []
    arxiv_id = (arxiv_eprints[0].get("value") if arxiv_eprints else "") or ""
    if arxiv_id:
        arxiv_id = re.sub(r"v\d+$", "", arxiv_id)
    dois = md.get("dois") or []
    doi = (dois[0].get("value") if dois else "") or ""
    pubs = md.get("publication_info") or []
    venue = ""
    year = None
    for p in pubs:
        if not venue:
            venue = p.get("journal_title") or ""
        if not year:
            year = p.get("year")
    citation = md.get("citation_count") or 0

    return InspireRecord(
        id=f"inspire:{inspire_id}",
        title=title,
        authors=authors,
        year=year,
        source="inspire",
        inspire_id=inspire_id,
        arxiv_id=arxiv_id,
        doi=doi,
        url=f"https://inspirehep.net/literature/{inspire_id}",
        abstract=abstract,
        venue=venue,
        citation_count=citation,
        matched_queries=[f"{query.section}::{query.raw}"],
    )


def harvest(
    queries: list[Query],
    out_path: Path,
    size: int = 100,
    sleep_seconds: float = 1.0,
    log=print,
) -> dict[str, InspireRecord]:
    records: dict[str, InspireRecord] = {}
    out_path.parent.mkdir(parents=True, exist_ok=True)
    for i, q in enumerate(queries):
        if i > 0:
            time.sleep(sleep_seconds)
        log(f"[{i+1}/{len(queries)}] {q.section} :: {q.raw}")
        try:
            data = fetch(q, size=size)
        except Exception as e:  # noqa: BLE001
            log(f"  ERROR: {e}")
            continue
        hits = ((data.get("hits") or {}).get("hits")) or []
        total = ((data.get("hits") or {}).get("total")) or "?"
        log(f"  -> {len(hits)} hits (total: {total})")
        new_count = 0
        for hit in hits:
            rec = parse_hit(hit, q)
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
