# integrable-lattice

## 目的

可積分格子模型の周辺で、有限の記号操作・局所関係式・代数計算によって証明できそうな未解決ステートメントを大量に発掘し、論文候補の母集団を作る。

このプロジェクトは、単なる文献サーベイではなく、以下を機械的に回す探索パイプラインを作る。

1. 既知の模型・操作・ステートメント型を入力する。
2. 論文コーパスから既解決ステートメントを抽出する。
3. 模型 × 条件 × 操作型の gap map を作る。
4. 空白セルから未解決ステートメント候補を生成する。
5. 解決済みリスクを文献で潰し、論文化見込みで順位付けする。

## 成果物

最終的に欲しいものは、次の形式の大量リスト。

```text
未解決ステートメント候補
既知結果との差分
有限記号操作の型
想定証明戦略
代表文献
解決済みリスク
論文化見込み
```

## 構成

```text
integrable-lattice/
├── README.md
├── MEMORY.md
├── main.typ
├── inputs/       # 入力: seed taxonomy, 検索クエリ, 文献コーパス, 人手ラベル
├── pipeline/     # パイプライン: 収集、抽出、分類、gap生成、候補生成、検証、順位付け
├── outputs/      # 出力: gap map、未解決候補、調査レポート、論文案
├── skills/       # このプロジェクト専用の Codex skill
├── src/          # 将来の実装コード
├── scripts/      # 実行用スクリプト
├── sagemath/     # 記号計算・小規模検証
├── parts/        # 論文化する証明本文の部品
└── docs/         # 設計メモ・スキーマ
```

## 入力・パイプライン・出力

### 入力

- `inputs/seeds/`: 模型、操作型、一般化軸、代表文献などの seed。
- `inputs/queries/`: arXiv / OpenAlex / Semantic Scholar などに投げる検索クエリ。
- `inputs/corpus/`: 取得した論文メタデータ、abstract、LaTeX source、PDF text。大きいデータは原則 git 管理しない。
- `inputs/labels/`: 人手で確認した分類、既解決判定、誤検出メモ。

### パイプライン

- `pipeline/01_harvest/`: 論文候補の収集。
- `pipeline/02_extract/`: abstract/source/PDF text から模型名・式・定型句を抽出。
- `pipeline/03_classify/`: ステートメントを操作型・模型・条件へ分類。
- `pipeline/04_gap_map/`: 既解決セルと空白セルの表を作る。
- `pipeline/05_generate/`: 空白セルから未解決ステートメント候補を生成。
- `pipeline/06_verify/`: 解決済みリスク、定義不能リスク、既知定理から従うリスクを確認。
- `pipeline/07_rank/`: 論文化見込みで順位付け。

### 出力

- `outputs/maps/`: 模型 × 条件 × 操作型の gap map。
- `outputs/candidates/`: 未解決ステートメント候補のリスト。
- `outputs/reports/`: 分野別・操作型別の調査レポート。
- `outputs/paper-plans/`: 実際に論文へ落とすための構成案。
- `outputs/papers/`: 執筆中・投稿予定の論文本体。

## Skills

`skills/` には、このプロジェクト専用の skill を置く。

- `integrable-lattice-harvest`
- `integrable-lattice-extract`
- `integrable-lattice-classify`
- `integrable-lattice-gap-map`
- `integrable-lattice-generate`
- `integrable-lattice-verify`
- `integrable-lattice-rank`

これらは一般用途ではなく、`integrable-lattice` の入力・パイプライン・出力の設計に合わせた作業手順である。

## MVP の意味（サイクル）

MVP は固定成果物（「30件出す」等）ではない。MVP とは **広く薄く集めて観察し、筋のいい方向を絞り込むサイクルを1周回すこと**。
良い方向は事前には分からない。だからこのプロジェクトは 01→07 の一方向パイプラインではなく、07 の観察を seed・スコープへ戻す**ループ**として回す。

```text
seed → harvest → … → generate → rank/観察 → 次サイクルの seed・スコープを絞り込む → …
```

事前に決めてはいけないもの（サイクルが観察で決めるべきもの）:

- 幅優先か深さ優先か。
- どの操作型・模型を残し、どれを切るか。
- どこにどれだけ投資するか。

### cycle 0（最初の1周）

- 対象: `inputs/seeds/canonical-papers.md` の4 slice（`six_vertex_dwbc_determinant` / `rsos_character_identity` / `tl_loop_finitized_character` / `dimer_pfaffian_boundary`）を **全て薄く** 通す。
- 各 slice を 01_harvest → 04_gap_map → 05_generate まで **浅く** 回す。候補は anchor 付きの粗い形でよい。`resolved_risk` / `novelty_risk` は `unchecked` のまま、06_verify・sagemath 数値検証は **この周ではやらない**（深さは方向が定まってから投下する）。
- その上で 07_rank（観察）を回し、「どの 模型 × 操作型 × 境界 方向が筋良さそうか・なぜか」を `outputs/reports/` に書く。

### cycle 0 の成功条件

- 件数ではない。**観察結果として、次サイクルで深掘りする方向を根拠付きで選べる状態**になること。
- 操作型・模型の取捨（star-triangle / transfer-matrix / T-system の slice を足すか、特定家族へ絞るか）は、この観察に基づいて cycle 1 で決める。

### per-item コストの原則

- cycle 0 では1候補あたりのコストを最小化する（深い anchor 固め・厳密な定理形・数値検証は cycle 0 では行わない）。
- 深さは、観察で方向が定まったセル/家族にのみ後続サイクルで集中投下する。
