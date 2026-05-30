"""arXiv harvest for the integrable-lattice project.

Stdlib only. Hits the arXiv Atom API, parses each entry into a manifest record,
and writes JSONL with deduplication by arXiv id.
"""

from __future__ import annotations

import json
import re
import time
import urllib.parse
import urllib.request
import xml.etree.ElementTree as ET
from dataclasses import asdict, dataclass, field
from pathlib import Path

ARXIV_API = "http://export.arxiv.org/api/query"
ARXIV_NS = {
    "atom": "http://www.w3.org/2005/Atom",
    "arxiv": "http://arxiv.org/schemas/atom",
}
RATE_LIMIT_SECONDS = 3.0
USER_AGENT = "integrable-lattice-harvest/0.1 (research; contact via repo)"


@dataclass
class Query:
    section: str
    raw: str

    def to_arxiv_search(self) -> str:
        # Pull out quoted phrases first, then treat the remainder as bare tokens.
        # Encode spaces/quotes here so the caller can drop the string into the URL.
        phrases = re.findall(r'"([^"]+)"', self.raw)
        remainder = re.sub(r'"[^"]+"', " ", self.raw)
        bare = [w for w in remainder.split() if w]
        enc = lambda s: urllib.parse.quote(s, safe="")
        terms = [f"all:%22{enc(p)}%22" for p in phrases] + [f"all:{enc(w)}" for w in bare]
        if not terms:
            return f"all:%22{enc(self.raw.strip())}%22"
        return "+AND+".join(terms)


@dataclass
class Record:
    id: str
    title: str
    authors: list[str]
    year: int | None
    source: str
    arxiv_id: str
    doi: str
    url: str
    abstract: str
    primary_category: str
    model_hints: list[str] = field(default_factory=list)
    operation_hints: list[str] = field(default_factory=list)
    source_available: bool = True
    matched_queries: list[str] = field(default_factory=list)
    notes: str = ""


def parse_queries(path: Path) -> list[Query]:
    text = path.read_text(encoding="utf-8")
    queries: list[Query] = []
    section = "unknown"
    in_block = False
    for line in text.splitlines():
        if line.startswith("## "):
            section = line[3:].strip()
            continue
        if line.strip().startswith("```"):
            in_block = not in_block
            continue
        if not in_block:
            continue
        stripped = line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        queries.append(Query(section=section, raw=stripped))
    return queries


def fetch_arxiv(query: Query, max_results: int = 100, start: int = 0) -> str:
    # search_query is pre-encoded by Query.to_arxiv_search; do not re-encode.
    qs = (
        f"search_query={query.to_arxiv_search()}"
        f"&start={start}"
        f"&max_results={max_results}"
        f"&sortBy=relevance&sortOrder=descending"
    )
    url = f"{ARXIV_API}?{qs}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    with urllib.request.urlopen(req, timeout=60) as resp:
        return resp.read().decode("utf-8")


def parse_entry(entry: ET.Element, query: Query) -> Record | None:
    def text_of(tag: str) -> str:
        el = entry.find(f"atom:{tag}", ARXIV_NS)
        return (el.text or "").strip() if el is not None else ""

    atom_id = text_of("id")
    if not atom_id:
        return None
    arxiv_id = atom_id.rsplit("/", 1)[-1]
    # Strip version suffix v1, v2, ... for dedup stability.
    arxiv_id = re.sub(r"v\d+$", "", arxiv_id)

    title = " ".join(text_of("title").split())
    abstract = " ".join(text_of("summary").split())
    published = text_of("published")
    year = int(published[:4]) if published[:4].isdigit() else None

    authors = []
    for a in entry.findall("atom:author/atom:name", ARXIV_NS):
        if a.text:
            authors.append(a.text.strip())

    doi = ""
    doi_el = entry.find("arxiv:doi", ARXIV_NS)
    if doi_el is not None and doi_el.text:
        doi = doi_el.text.strip()

    primary_category = ""
    pc_el = entry.find("arxiv:primary_category", ARXIV_NS)
    if pc_el is not None:
        primary_category = pc_el.attrib.get("term", "")

    alt_url = ""
    for link in entry.findall("atom:link", ARXIV_NS):
        if link.attrib.get("rel") == "alternate":
            alt_url = link.attrib.get("href", "")
            break

    return Record(
        id=f"arxiv:{arxiv_id}",
        title=title,
        authors=authors,
        year=year,
        source="arxiv",
        arxiv_id=arxiv_id,
        doi=doi,
        url=alt_url or f"https://arxiv.org/abs/{arxiv_id}",
        abstract=abstract,
        primary_category=primary_category,
        matched_queries=[f"{query.section}::{query.raw}"],
    )


def harvest(
    queries: list[Query],
    out_path: Path,
    max_results: int = 100,
    sleep_seconds: float = RATE_LIMIT_SECONDS,
    log=print,
) -> dict[str, Record]:
    records: dict[str, Record] = {}
    out_path.parent.mkdir(parents=True, exist_ok=True)
    for i, q in enumerate(queries):
        if i > 0:
            time.sleep(sleep_seconds)
        log(f"[{i+1}/{len(queries)}] {q.section} :: {q.raw}")
        try:
            xml = fetch_arxiv(q, max_results=max_results)
        except Exception as e:  # noqa: BLE001
            log(f"  ERROR: {e}")
            continue
        root = ET.fromstring(xml)
        entries = root.findall("atom:entry", ARXIV_NS)
        log(f"  -> {len(entries)} entries")
        new_count = 0
        for entry in entries:
            rec = parse_entry(entry, q)
            if rec is None:
                continue
            if rec.id in records:
                records[rec.id].matched_queries.extend(rec.matched_queries)
            else:
                records[rec.id] = rec
                new_count += 1
        log(f"  -> {new_count} new (total unique: {len(records)})")

    with out_path.open("w", encoding="utf-8") as f:
        for rec in records.values():
            f.write(json.dumps(asdict(rec), ensure_ascii=False) + "\n")
    log(f"Wrote {len(records)} records to {out_path}")
    return records
