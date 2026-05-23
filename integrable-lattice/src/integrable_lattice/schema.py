from dataclasses import dataclass, field


@dataclass(frozen=True)
class StatementCandidate:
    """Minimal in-code representation of an unresolved statement candidate."""

    id: str
    title: str
    model_family: str
    model: str
    operation_type: str
    statement_type: str
    candidate_statement: str
    known_result_anchor: str = ""
    missing_generalization: str = ""
    boundary_condition: str = ""
    finite_symbol_process: str = ""
    expected_proof_strategy: str = ""
    small_case_experiment: str = ""
    resolved_risk: str = "unchecked"
    novelty_risk: str = "unchecked"
    paper_potential: str = "unknown"
    references: list[str] = field(default_factory=list)
    notes: str = ""

