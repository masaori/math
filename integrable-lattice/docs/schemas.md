# スキーマ

## StatementCandidate

未解決ステートメント候補の最小スキーマ。

```yaml
id:
title:
status: candidate
model_family:
model:
operation_type:
statement_type:
parameters:
boundary_condition:
known_result_anchor:
missing_generalization:
candidate_statement:
finite_symbol_process:
expected_proof_strategy:
small_case_experiment:
resolved_risk:
novelty_risk:
paper_potential:
references:
notes:
```

## フィールド

- `known_result_anchor`: 既知結果。ここから何をずらすかを明確にする。
- `missing_generalization`: 空白セルの説明。
- `candidate_statement`: 論文で定理/予想にできる形の文。
- `finite_symbol_process`: 書換え、局所関係式、行列計算、determinant/Pfaffian、q展開比較など。
- `expected_proof_strategy`: 期待する証明方針。
- `small_case_experiment`: 小サイズで検証できる場合の方針。
- `resolved_risk`: 既に解決済みであるリスクの確認状況。
- `novelty_risk`: 既知定理から自明に出るリスク。
- `paper_potential`: high / medium / low。

## ManifestRecord（harvest 出力の共通スキーマ）

各 source（arxiv/openalex/semantic_scholar/inspire）の harvest 出力 + merge 出力で共有するフィールド。source ごとに source-specific フィールドが追加される。

共通フィールド:

```yaml
id:                    # canonical id: "arxiv:<id>" / "openalex:W..." / "s2:<id>" / "inspire:<id>"
title:
authors:               # list[str]
year:                  # int | null
source:                # "arxiv" | "openalex" | "semantic_scholar" | "inspire"
arxiv_id:              # 抽出できれば（version suffix を剥がした形）
doi:
url:
abstract:              # OpenAlex の場合は inverted index を復元
matched_queries:       # list[str] — どの query にヒットしたか
```

merge 後の追加フィールド:

```yaml
canonical_key:         # "arxiv:<id>" / "doi:<doi>" / "title:<norm>"
sources:               # list[str] — どの source に存在したか
source_ids:            # dict[source -> id]
```

LLM 分類後の追加フィールド:

```yaml
model_hints:           # list[str] from inputs/seeds/models.md enum
operation_hints:       # list[str] from inputs/seeds/operations.md enum
status_hints:          # "open" | "solved" | "review" | "unknown"
```

filter 後の追加フィールド:

```yaml
filter_reason:         # "hints" | "arxiv_cat:..." | "concept:..." | "fos:..." | "title_kw"
```

## OperationType

```yaml
- yang_baxter
- star_triangle
- transfer_matrix_commutativity
- fusion_relation
- t_system
- y_system
- determinant_formula
- pfaffian_formula
- character_identity
- q_series_identity
- algebra_relation
- vertex_face_correspondence
```

## StatementType

```yaml
- equivalence
- commutativity
- exact_formula
- recurrence
- finite_size_identity
- normal_form
- representation_equivalence
- boundary_generalization
- parameter_specialization
```

