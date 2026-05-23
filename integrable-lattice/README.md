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

## 最初のMVP

まずは以下に絞る。

1. 模型: six-vertex/XXZ, RSOS/ABF, loop/Temperley-Lieb, dimer/Pfaffian。
2. 操作型: Yang-Baxter, star-triangle, transfer matrix commutativity, T-system/Y-system, determinant/Pfaffian formula, character/q-series identity。
3. 出力: `outputs/candidates/000_seed_candidates.md` に未解決候補を30件以上出す。
