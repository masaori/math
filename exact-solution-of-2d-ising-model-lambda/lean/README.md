# Lean 4 + mathlib4 による形式検証

[docs/context/証明の書き方.md](../../docs/context/証明の書き方.md) の四層検証の第 3・第 4 層。
**同じ主張に 2 つの証明を置く。**

| | 何を書くか | 何のためか | 置き場所 |
| --- | --- | --- | --- |
| 具体版 | 人手証明と**同じ抽象度**で、**1 対 1 に対応する**証明 | 人手証明そのものの正当性を保証する | `Ising2DLambda/<章名>/` |
| 必要十分版 | 具体版と**同じ手順のまま**、抽象度だけ必要十分まで上げた証明 | 何が本質的かを示し、具体版が過剰な構造を要求していないか検査する | `Ising2DLambda/NecSuf/<章名>/` |

名前空間は具体版が `Ising2DLambda`、必要十分版が `Ising2DLambda.NecSuf`。
具体版を必要十分版から導出するファイルは `*FromNecSuf.lean`。

## 必要十分版の要件（満たさないものは必要十分版と認めない）

1. 証明手順が具体版と同じであること。別の論法への差し替えは認めない。
2. 仮定が「具体版の証明が実際に使っている性質」だけであること。
   削ったせいで通らなくなった仮定は残し、**なぜ必要かをコメントに書く**（これが検査の本体）。
3. mathlib の高抽象度の既製定理へ丸投げしない。一行で終わる宣言・単なる別名定義は認めない。
   既製定理との一致を見たいなら、自前の証明を書いたうえで一致を述べる補題を 1 本だけ添える。
4. 具体版が必要十分版の特殊化として得られることを導出側に明示する。
5. 必要十分版は Lean の中だけに置く。人手証明にも参照用ノートにも持ち込まない。
6. 上の 1–3 は具体版にも対称に適用する。

## 本プロジェクト固有の規約（住処を Lean の型で担わせる）

人手証明の各ブロックは量の住処（`N` / `Z` / `Q` / `Lambda` / `Qbar` / `R` / `C` / `mixed`）を
宣言している。**Lean 側はその宣言と同じ住処の型で書く。**

- 可算側を宣言したブロックの具体版に `ℝ` / `ℂ` を出さない。数え上げは `ℕ`、
  分配多項式は `Polynomial ℤ`、零点は `Polynomial ℤ` の根として扱う。
- 非可算側を宣言したブロックだけが `ℝ` / `ℂ` を使ってよい。ファイル冒頭に
  人手証明の `realEscape` と同じ理由をコメントで書く。
- 人手証明のどのステップがどの補題かをコメントで対応づける。`sorry` を残さない。

対応づけは人手証明側のブロックの `lean` フィールド（Lean の定理名の配列）でも宣言する。

## セットアップと検証

```sh
# elan（Lean のツールチェイン管理）が入っていること。lake は ~/.elan/bin にあり、
# 非対話シェルの PATH には入っていないので通しておく。
cd lean
lake update          # 依存の解決と取得。lake-manifest.json を作る（追跡している）
lake exe cache get   # mathlib のビルド済み olean を取得する。**省略してはならない**
lake build
bash scripts/check-no-sorry.sh
```

`lake exe cache get` を省くと mathlib を原本から building することになり、
自動ループの 1 tick（25 分で打ち切る）では終わらない。取得済みの olean は `.lake/` に入り、
`.lake/` は git 管理外である（依存の固定は `lake-manifest.json` が担う）。

## 現状

章「分配多項式」の定義 4 件と、主張「多重度の総和は配位の総数に等しい」
（人手証明のラベル `claim_coefficient_sum`）を形式化済み。

| | 状態 |
| --- | --- |
| `lake update` / `lake exe cache get` | 2026-08-08 実行済み（mathlib は `lakefile.toml` の `v4.32.1`、実体は `lake-manifest.json` が固定） |
| `lake build` | 通る |
| `bash scripts/check-no-sorry.sh` | 通る（検査対象の定理 3 件を登録済み） |

| ファイル | 中身 |
| --- | --- |
| `Ising2DLambda/PartitionPolynomial/Basic.lean` | 格子・辺の番号と端点写像・配位・破れボンド数・多重度・分配多項式の定義（具体版） |
| `Ising2DLambda/PartitionPolynomial/CoefficientSum.lean` | 具体版の定理。人手証明の Step 1–5 と 1 対 1 |
| `Ising2DLambda/NecSuf/PartitionPolynomial/CoefficientSum.lean` | 必要十分版。有限型 `α` と有界な写像 `f : α → ℕ` だけを仮定する |
| `Ising2DLambda/PartitionPolynomial/CoefficientSumFromNecSuf.lean` | 具体版が必要十分版の特殊化として得られることの導出 |

必要十分版が示したのは、この主張の証明が使っているのは「配位の集合が有限であること」
「破れボンド数が `2L²` 以下の自然数を返す写像であること」だけであり、
格子の形・周期境界条件・スピンの値が `{+1,-1}` であることは一切使っていない、ということである。

Step 3 の「互いに素な有限個の有限集合の合併の元の個数は個数の和」は人手証明が明示的に
適用している定理なので mathlib の `Finset.card_biUnion` を引く。一方
`Finset.card_eq_sum_card_fiberwise` は人手証明の Step 2 と Step 3 を一度に済ませてしまうため、
1 対 1 対応が崩れる。使っていない。

### まだ形式化していないもの

分配多項式の係数表示 `Z_L = Σ_m Ω_L(m) x^m`（人手証明の定義ブロック「分配多項式」の中の等式）。
`partitionPolynomial` の定義そのものは書いたが、この等式は未証明である。
