"""Precision filter for merged harvest records.

A record passes if at least one of:
  - it has model_hints or operation_hints (already classified as relevant)
  - arxiv primary_category is in our physics/math whitelist
  - any concept / field_of_study matches a relevance keyword
  - title contains a relevance keyword
Otherwise rejected.
"""

from __future__ import annotations

import re

ARXIV_RELEVANT_CATEGORIES = {
    "math-ph",
    "nlin.SI",
    "math.QA",
    "math.CO",
    "math.RT",
    "math.RA",
    "math.AG",
    "cond-mat.stat-mech",
    "cond-mat.str-el",
    "hep-th",
}

RELEVANCE_KEYWORDS = [
    "integrable",
    "yang-baxter",
    "yang baxter",
    "bethe",
    "lattice",
    "exactly solvable",
    "exactly solved",
    "transfer matrix",
    "quantum group",
    "temperley-lieb",
    "temperley lieb",
    "rsos",
    "abf model",
    "six-vertex",
    "six vertex",
    "eight-vertex",
    "eight vertex",
    "spin chain",
    "xxz",
    "xyz",
    "vertex model",
    "loop model",
    "dimer",
    "rogers-ramanujan",
    "fusion hierarchy",
    "t-system",
    "y-system",
    "q-operator",
    "star-triangle",
    "reflection equation",
    "chiral potts",
    "ising model",
    "boltzmann weight",
    "partition function",
]


_RE_KW = re.compile("|".join(re.escape(k) for k in RELEVANCE_KEYWORDS))


def _has_keyword(text: str) -> bool:
    return bool(text and _RE_KW.search(text.lower()))


def keep(rec: dict) -> tuple[bool, str]:
    """Return (kept, reason)."""
    if rec.get("model_hints") or rec.get("operation_hints"):
        return True, "hints"
    pc = rec.get("primary_category") or ""
    if pc in ARXIV_RELEVANT_CATEGORIES:
        return True, f"arxiv_cat:{pc}"
    for c in rec.get("concepts") or []:
        if _has_keyword(c):
            return True, f"concept:{c[:40]}"
    for f in rec.get("fields_of_study") or []:
        if _has_keyword(f):
            return True, f"fos:{f[:40]}"
    title = rec.get("title") or ""
    if _has_keyword(title):
        return True, "title_kw"
    return False, "no_signal"
