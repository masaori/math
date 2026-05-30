"""OpenAlex harvest for the integrable-lattice project.

Stdlib only. https://docs.openalex.org/how-to-use-the-api/api-overview
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

OPENALEX_API = "https://api.openalex.org/works"
USER_AGENT = (
    "integrable-lattice-harvest/0.1 "
    "(mailto:masaori.hirono@hexagonal-computation.com)"
)


@dataclass
class OpenAlexRecord:
    id: str
    title: str
    authors: list[str]
    year: int | None
    source: str
    openalex_id: str
    arxiv_id: str
    doi: str
    url: str
    abstract: str
    venue: str
    concepts: list[str]
    cited_by_count: int
    matched_queries: list[str] = field(default_factory=list)


def reconstruct_abstract(inverted_index: dict[str, list[int]]) -> str:
    if not inverted_index:
        return ""
    positions = [(pos, word) for word, poss in inverted_index.items() for pos in poss]
    positions.sort()
    return " ".join(word for _, word in positions)


def build_search(query: Query) -> str:
    # OpenAlex "search" is a phrase-ish full-text. Quoted phrases survive.
    return query.raw


def fetch(query: Query, per_page: int = 100) -> dict:
    params = {
        "search": build_search(query),
        "per-page": str(per_page),
        "select": (
            "id,title,authorships,abstract_inverted_index,doi,ids,"
            "primary_location,publication_year,cited_by_count,concepts"
        ),
    }
    qs = "&".join(f"{k}={urllib.parse.quote(v, safe='')}" for k, v in params.items())
    url = f"{OPENALEX_API}?{qs}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=60) as resp:
        return json.loads(resp.read().decode("utf-8"))


def _extract_arxiv_id(work: dict) -> str:
    # arXiv IDs surface in two places: ids.openalex sometimes carries them,
    # but more reliably primary_location.landing_page_url for arXiv-hosted works.
    pl = work.get("primary_location") or {}
    src = pl.get("source") or {}
    if (src.get("display_name") or "").lower() == "arxiv":
        landing = pl.get("landing_page_url") or ""
        m = re.search(r"abs/([\w./-]+?)(?:v\d+)?$", landing)
        if m:
            return m.group(1)
    # Some records expose arXiv id under ids.
    for loc in [pl, *(work.get("locations") or [])]:
        landing = (loc or {}).get("landing_page_url") or ""
        m = re.search(r"arxiv\.org/abs/([\w./-]+?)(?:v\d+)?(?:[?#]|$)", landing)
        if m:
            return m.group(1)
    return ""


def parse_work(work: dict, query: Query) -> OpenAlexRecord | None:
    oa_url = work.get("id") or ""
    if not oa_url:
        return None
    openalex_id = oa_url.rsplit("/", 1)[-1]

    doi = (work.get("doi") or "").replace("https://doi.org/", "")
    arxiv_id = _extract_arxiv_id(work)

    title = work.get("title") or ""
    abstract = reconstruct_abstract(work.get("abstract_inverted_index") or {})
    year = work.get("publication_year")
    authors = [
        (a.get("author") or {}).get("display_name") or ""
        for a in (work.get("authorships") or [])
    ]
    venue = ""
    pl = work.get("primary_location") or {}
    src = pl.get("source") or {}
    if src:
        venue = src.get("display_name") or ""

    concepts = [
        c.get("display_name") or ""
        for c in (work.get("concepts") or [])
        if (c.get("level") or 99) <= 2
    ][:5]
    cited_by = work.get("cited_by_count") or 0

    return OpenAlexRecord(
        id=f"openalex:{openalex_id}",
        title=title,
        authors=authors,
        year=year,
        source="openalex",
        openalex_id=openalex_id,
        arxiv_id=arxiv_id,
        doi=doi,
        url=oa_url,
        abstract=abstract,
        venue=venue,
        concepts=concepts,
        cited_by_count=cited_by,
        matched_queries=[f"{query.section}::{query.raw}"],
    )


def harvest(
    queries: list[Query],
    out_path: Path,
    per_page: int = 100,
    sleep_seconds: float = 1.0,
    log=print,
) -> dict[str, OpenAlexRecord]:
    records: dict[str, OpenAlexRecord] = {}
    out_path.parent.mkdir(parents=True, exist_ok=True)
    for i, q in enumerate(queries):
        if i > 0:
            time.sleep(sleep_seconds)
        log(f"[{i+1}/{len(queries)}] {q.section} :: {q.raw}")
        try:
            data = fetch(q, per_page=per_page)
        except Exception as e:  # noqa: BLE001
            log(f"  ERROR: {e}")
            continue
        works = data.get("results") or []
        log(f"  -> {len(works)} results")
        new_count = 0
        for work in works:
            rec = parse_work(work, q)
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
