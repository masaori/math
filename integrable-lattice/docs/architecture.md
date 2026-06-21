# アーキテクチャ

## 基本方針

このプロジェクトの単位は「論文」ではなく「ステートメント」。

論文はステートメントを発見するための入力であり、最終的な出力は、我々が証明して論文にできる未解決ステートメント候補の集合である。

### サイクル（一方向パイプラインではない）

01→07 は一方向の処理列に見えるが、運用は **ループ**。07_rank の観察結果を seed・スコープへ戻し、次サイクルで対象を絞り込む。

```text
seed → harvest → extract → classify → gap_map → generate → verify → rank/観察
   ↑                                                                    │
   └──────────── 観察に基づきスコープ・seed を絞り込む ───────────────────┘
```

良い方向は事前に分からないため、幅/深さ・操作型や模型の取捨・投資量は事前決定せず、各サイクルの観察で決める。1周目（cycle 0）は per-item コストを最小化し、広く薄く回す。詳細は `README.md` の「MVP の意味（サイクル）」を参照。

## 入力の分解

### `inputs/seeds/`

手で管理する出発点。

- `models.md`: six-vertex, eight-vertex, RSOS, ABF, dimer, loop, Potts など。
- `operations.md`: Yang-Baxter, star-triangle, fusion, T-system, Pfaffian など。
- `axes.md`: 境界条件、rank、表現、非一様化、楕円化、root of unity、有限サイズ版など。
- `canonical-papers.md`: seed になる代表論文。

### `inputs/queries/`

検索式を管理する。

- arXiv query
- OpenAlex query
- Semantic Scholar query
- Google Scholar 用の手動検索クエリ

### `inputs/corpus/`

取得済みデータの置き場。

- metadata
- abstract
- arXiv source
- PDF text
- extracted equations

大きいデータは git 管理しない。再現に必要な取得条件を `inputs/queries/` に置く。

### `inputs/labels/`

人手レビューの結果。

- 誤検出
- 既解決判定
- 未解決らしい根拠
- 後続論文で解決済みだった例

## パイプラインの分解

### `01_harvest`: 文献候補の収集

目的: seed query から候補論文を広めに集める。

出力:

- paper id
- title
- authors
- year
- venue
- abstract
- arXiv id / DOI / URL
- cited/citing metadata

### `02_extract`: ステートメント断片の抽出

目的: 論文から模型名、操作型、定型句、式を拾う。

抽出対象:

- model name
- boundary condition
- algebraic object
- equation-like phrase
- theorem/proposition/conjecture/open problem
- formula labels

### `03_classify`: ステートメント型の分類

目的: 抽出断片を taxonomy に写す。

分類軸:

- model family
- operation type
- statement type
- boundary/parameter condition
- evidence type
- solved/open/unknown status

### `04_gap_map`: 既解決セルと空白セルの構築

目的: **Λ 梯子と四軸**で表を作る（文献の操作型分類ではない）。cell key:

```text
model × direction(A–F) × target_quantity × home × complexity × solvability × decidable × formal_verifiable
```

- `home`: 対象量の住処（ℤ[x] / Λ / ℚ̄ / ℝ脱出箇所）。
- `complexity`: 有限 N の手間（poly / #P / unknown）。
- `solvability`: 極限の閉形式（closed / none / unknown）。
- `decidable`: 等号・順序判定（yes(素因数分解/根分離) / schanuel / no）。
- `formal_verifiable`: yes(decide/QQbar) / partial / no。

例:

```text
2D Ising | A 零点 | Fisher 零点 | ℚ̄ | poly(平面) | closed | yes(QQbar) | yes
2D Ising | C 構造 | 転送行列 T(x) | M(ℤ[x]) | poly | closed | yes | partial
RSOS     | D Φ    | Massieu Φ_N | Λ | poly | unknown | yes | partial
3D Ising | E 分類 | Z_N | ℤ[x] | #P | none(未解決) | yes(有限) | no(極限)
```

詳細な語彙は `inputs/seeds/lambda-statement-program.md`。

### `05_generate`: 未解決候補の生成

目的: 空白セルを自然なステートメントに変換する。

生成テンプレート:

- この模型の分配関数は determinant/Pfaffian で書けるか。
- この境界条件で transfer matrix family は可換か。
- この有限サイズ character は既知 q-series と一致するか。
- この表現に対応する fusion hierarchy は閉じるか。
- この局所関係式は高rank/楕円/root of unity 版へ拡張できるか。

### `06_verify`: 解決済みリスクの確認

目的: 候補がすでに知られていないか、または自明に従わないかを確認する。

確認項目:

- 同じステートメントが既に論文にあるか。
- 用語違いで既知結果になっていないか。
- より一般の定理から直ちに従うか。
- 定義不能または反例既知ではないか。
- 小サイズ計算で反例が出ないか。

### `07_rank`: 論文化見込みの順位付け

目的: 我々が書ける順に候補を並べる。

評価軸:

- 新規性
- 証明可能性
- 有限記号操作としての明確さ
- 計算実験のしやすさ
- 代表文献との差分の説明しやすさ
- 1本の論文としてのまとまり

## 出力の分解

### `outputs/maps/`

gap map と taxonomy map。

### `outputs/candidates/`

未解決候補の主出力。

### `outputs/reports/`

分野別・操作型別の調査結果。

### `outputs/paper-plans/`

候補を論文化するための具体案。

### `outputs/papers/`

実際に執筆する論文本体。

`paper-plans` は論文案・アウトライン・採用判断の置き場であり、`papers` は書くと決めた論文の本文、証明、計算、参考文献の置き場である。

標準構成:

```text
outputs/papers/001_<topic>/
├── main.typ
├── refs.bib
├── parts/
├── computations/
└── notes.md
```

## 命名方針

- 入力は `seed`, `query`, `corpus`, `label`。
- 処理は動詞で `harvest`, `extract`, `classify`, `map`, `generate`, `verify`, `rank`。
- 出力は `map`, `candidate`, `report`, `paper-plan`, `paper`。

この名前にしておくと、「文献を集めているのか」「未解決候補を生成しているのか」「論文化候補を選別しているのか」が混ざりにくい。
