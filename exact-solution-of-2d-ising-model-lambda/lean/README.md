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

章「分配多項式」・章「有限系の自由エントロピー」・章「転送行列」の全体と、
章「固有値の代数性」の行配位の辞書式順序・置換の符号・行列式までを形式化済み。
どこまで進んだかの正本は `docs/tasks/auto-loop-state.md` のセクション台帳である。

| | 状態 |
| --- | --- |
| `lake update` / `lake exe cache get` | 2026-08-08 実行済み（mathlib は `lakefile.toml` の `v4.32.1`、実体は `lake-manifest.json` が固定） |
| `lake build` | 通る |
| `bash scripts/check-no-sorry.sh` | 通る（検査対象の定理 69 件を登録済み） |

| ファイル | 中身 |
| --- | --- |
| `Ising2DLambda/PartitionPolynomial/Basic.lean` | 格子・辺の番号と端点写像・配位・破れボンド数・多重度・分配多項式の定義（具体版） |
| `Ising2DLambda/PartitionPolynomial/CoefficientSum.lean` | 多重度の総和は配位の総数に等しい（具体版）。人手証明の 3 つの等号と 1 対 1 |
| `Ising2DLambda/PartitionPolynomial/CoefficientRepresentation.lean` | 分配多項式の係数は多重度である（具体版）。人手証明の 5 つの等号と 1 対 1 |
| `Ising2DLambda/NecSuf/PartitionPolynomial/CoefficientSum.lean` | 必要十分版。有限型 `α` と有界な写像 `f : α → ℕ` だけを仮定する |
| `Ising2DLambda/NecSuf/PartitionPolynomial/CoefficientRepresentation.lean` | 必要十分版。上に加えて値の側は可換モノイド `M` と `g : ℕ → M` だけを仮定する |
| `Ising2DLambda/PartitionPolynomial/CoefficientSumFromNecSuf.lean` | 具体版が必要十分版の特殊化として得られることの導出 |
| `Ising2DLambda/PartitionPolynomial/CoefficientRepresentationFromNecSuf.lean` | 同上（係数表示） |
| `Ising2DLambda/FreeEntropy/Basic.lean` | 素因数分解の指数・対数順序群 `Λ`・正の有理数の対数・有限系の自由エントロピーの定義（具体版） |
| `Ising2DLambda/FreeEntropy/RationalExponent.lean` | 有理数の指数は表示の取り方によらない（具体版）。人手証明の Step 1–4 と 1 対 1 |
| `Ising2DLambda/FreeEntropy/Additivity.lean` | 対数の加法性と冪の法則（具体版）。加法性は人手証明の 7 つの等号、冪の法則は帰納法の 2 段と 1 対 1 |
| `Ising2DLambda/FreeEntropy/ValuePositive.lean` | 分配多項式の正の有理点での値は正（具体版）。人手証明の Step 1–4 と 1 対 1 |
| `Ising2DLambda/NecSuf/FreeEntropy/RationalExponent.lean` | 必要十分版。可換群 `G` と積を和へ移す写像だけを仮定する |
| `Ising2DLambda/NecSuf/FreeEntropy/ValuePositive.lean` | 必要十分版。狭義順序半環と、空でない有限添字集合だけを仮定する |
| `Ising2DLambda/FreeEntropy/RationalExponentFromNecSuf.lean` | 具体版が必要十分版の特殊化として得られることの導出 |
| `Ising2DLambda/FreeEntropy/ValuePositiveFromNecSuf.lean` | 同上（有理点での正値性） |
| `Ising2DLambda/TransferMatrix/Basic.lean` | 行配位・行への制限・行内破れ数・行間破れ数の定義と、辺の集合の行ごとの分割（具体版） |
| `Ising2DLambda/TransferMatrix/WeightProduct.lean` | 転送行列の定義と、配位の重みが行に沿った成分の積であること（具体版） |
| `Ising2DLambda/TransferMatrix/PowerEntry.lean` | 行列の冪の成分は道に沿った積の和である（具体版） |
| `Ising2DLambda/TransferMatrix/Trace.lean` | 分配多項式は転送行列の冪のトレースである（具体版） |
| `Ising2DLambda/NecSuf/TransferMatrix/RowDecomposition.lean` | 必要十分版。有限型と判定できる述語、および (行, 列) との 1 対 1 対応だけを仮定する |
| `Ising2DLambda/NecSuf/TransferMatrix/WeightProduct.lean` | 必要十分版。値の側は可換モノイド、添字の側は有限型だけを仮定する |
| `Ising2DLambda/NecSuf/TransferMatrix/PowerEntry.lean` | 必要十分版。値の側は可換半環だけを仮定する |
| `Ising2DLambda/NecSuf/TransferMatrix/Trace.lean` | 必要十分版。値の側は可換半環、添字の側は有限型、周期の長さが 0 でないことだけを仮定する |
| `Ising2DLambda/TransferMatrix/*FromNecSuf.lean` | 具体版が必要十分版の特殊化として得られることの導出（4 件） |
| `Ising2DLambda/AlgebraicEigenvalue/RowConfigOrder.lean` | 行配位の辞書式順序と、それが線形順序であること（具体版） |
| `Ising2DLambda/AlgebraicEigenvalue/PermutationSign.lean` | 置換・転倒数・符号の定義と、符号の値・乗法性（具体版） |
| `Ising2DLambda/NecSuf/AlgebraicEigenvalue/RowConfigOrder.lean` | 必要十分版。被覆と、値の集合から `ℕ` への単射だけを仮定する |
| `Ising2DLambda/NecSuf/AlgebraicEigenvalue/PermutationSign.lean` | 必要十分版。有限型と判定できる二項関係、および**三分律だけ**を仮定する（推移律を使っていない） |
| `Ising2DLambda/AlgebraicEigenvalue/Determinant.lean` | 定数多項式を与える写像・単位行列・行列式の定義と、恒等でない置換が 2 点以上を動かすこと・対角行列の行列式（具体版） |
| `Ising2DLambda/NecSuf/AlgebraicEigenvalue/Determinant.lean` | 必要十分版。添字の側は有限型と相等の判定、値の側は可換半環、重みには `w 1 = 1` **だけ**を仮定する（符号の乗法性を使っていない） |
| `Ising2DLambda/AlgebraicEigenvalue/SecondPolynomial.lean` | もう 1 つの不定元 `t` の多項式環 `ℤ[x][t]`・定数として送る写像・次数の上界 `D_n`・モニックな次数 `n` の元 `M_n` の定義と、4 主張（有限和・有限積の次数、モニックな元の有限積、モニック + 低次）（具体版） |
| `Ising2DLambda/NecSuf/AlgebraicEigenvalue/SecondPolynomial.lean` | 必要十分版。係数環に**半環だけ**を仮定する（引き算も零因子の非存在も使っていない。2 元の補題は可換性さえ要らない） |
| `Ising2DLambda/AlgebraicEigenvalue/*FromNecSuf.lean` | 具体版が必要十分版の特殊化として得られることの導出（4 件） |

必要十分版が示したのは次の 4 点である。

- 多重度の総和の主張の証明が使っているのは「配位の集合が有限であること」
  「破れボンド数が `2L²` 以下の自然数を返す写像であること」だけであり、
  格子の形・周期境界条件・スピンの値が `{+1,-1}` であることは一切使っていない。
- 係数表示の主張の証明は、これに加えて値の側に可換モノイドの構造しか使っていない。
  多項式であること・係数が `ℤ` であること・足す量が不定元の冪であることは使っていない
  （足す量が「破れボンド数だけで決まる」ことだけが効いている）。
- 有理数の指数が表示によらないことの証明は、可換群と「積を和へ移す写像」しか使っていない。
  素数であること・指数が素因数分解から来ることは使っていない。
- 有理点での正値性の証明は、狭義順序半環と「添字集合が空でない有限集合」しか使っていない。
  値が有理数であること・多項式であること・指数が破れボンド数であることは使っていない。

「互いに素な有限個の有限集合の合併の元の個数は個数の和」（および和の版）は
人手証明が明示的に適用している定理なので mathlib の `Finset.card_biUnion` / `Finset.sum_biUnion`
を引く。一方 `Finset.card_eq_sum_card_fiberwise` は、人手証明が配位全体の類別と数え上げに
分けている 2 つの段を一度に済ませてしまうため、1 対 1 対応が崩れる。使っていない。
