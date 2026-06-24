# integrable-lattice

## 目的（3トラック。2026-06-24 再整理）

可積分格子模型・統計力学について、**Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能**を共通土台に、次の3トラックで成果を生産する（正典 `docs/themes.md`）:

1. **Reframe（本流）**: 理論物理の既知結果を、可算（Λ/ℚ̄）で数学的に厳密化し、自動証明可能（Lean/decide, witness）な形に書き換える。
2. **Solve**: YBE 可積分だが厳密解（自由エネルギー・相関）が未確定の模型（`outputs/maps/integrable_unsolved_catalog.md`）に正面から挑む。
3. **Pure（追加）**: 本プロジェクトの道具（Λ, ℚ̄, p 進, 決定可能性, 逆数学, 形式検証）が効く基礎論・数論の純粋数学未解決問題。

共通土台の整理軸・選別軸は **決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）と四軸（帰属／計算可能性／複雑性／可解性）**（`inputs/seeds/lambda-statement-program.md`）。理論的背景は `docs/discussion/対数順序群上の統計力学/`。文献の「厳密可解」分類（determinant か character か）では整理しない。

このプロジェクトは、単なる文献サーベイではなく、以下を機械的に回す探索パイプラインを作る。

1. Λ-statement プログラム（梯子・四軸・台帳・選別基準）を入力する。
2. 各模型・境界について、量がどの集合（ℤ[x]/Λ/ℚ̄/ℝ脱出箇所）に住むかを同定する。
3. 模型 × 探索方向(A–F) × 帰属/複雑性/可解性 の gap map を作る。
4. 「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」を満たす未解決候補を生成する。
5. 解決済みリスクを潰し、決定可能性・形式検証可能性で順位付けする。

> 注: 旧アプローチ（文献の exact 分類で集めた cycle 0）は削除した。復元点 `918af09`。経緯は `inputs/seeds/lambda-statement-program.md` 末尾。

## 成果物

最終的に欲しいものは、次の形式の大量リスト（各候補は `inputs/seeds/lambda-statement-program.md` の選別基準 (i)–(iv) を満たす）。

```text
未解決 Λ-statement 候補
対象量の帰属（ℤ[x] / Λ / ℚ̄ / ℝ脱出箇所）
四軸での位置（帰属○・複雑性 poly/#P・可解性 有/無）
ℝ脱出が隔離される一点（または ℝ 不使用）
形式検証の道（SageMath ZZ/QQ/QQbar・decide 可能性・witness）
既知結果との差分（単一軸のずれ）
解決済みリスク
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

### cycle 0（再定義後の最初の1周。Λ-statement の広い探索）

- 入力: `inputs/seeds/lambda-statement-program.md`（梯子・四軸・台帳・選別基準・探索方向 A–F）と `models.md`（基質）。
- 探索方向 **A–F を絞らず全部** 広く浅く回す（A 零点∈ℚ̄ / B 臨界点代数性・双対 / C ℝ脱出隔離・自由フェルミオン / D Massieu Φ∈Λ 有限恒等式 / E 複雑性×可解性分類 / F 形式検証可能性）。
- 各 (模型 × 方向) について、量の帰属（ℤ[x]/Λ/ℚ̄/ℝ脱出箇所）を同定し、選別基準 (i)–(iv) を満たす候補を **粗い形** で起こす。`resolved_risk` は `unchecked` のまま、06_verify・sagemath 厳密検証は **この周ではやらない**（深さは方向が定まってから）。

### cycle 0 の成功条件

- 件数ではない。**A–F × 模型 を広く見渡した上で、次サイクルで深掘りする「Λ-statement の筋」を根拠付きで選べる状態**になること。
- 方向の取捨（A–F のどれを深掘りするか、どの模型に絞るか）は、この観察に基づいて cycle 1 で決める。事前に絞らない。

### per-item コストの原則

- cycle 0 では1候補あたりのコストを最小化する（深い anchor 固め・厳密な定理形・数値検証は cycle 0 では行わない）。
- 深さは、観察で方向が定まったセル/家族にのみ後続サイクルで集中投下する。
