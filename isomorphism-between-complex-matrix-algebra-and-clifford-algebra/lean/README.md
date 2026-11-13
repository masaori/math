# Lean 4 + mathlib4 による機械的証明

複素行列環とクリフォード代数の同型の論文（`structured-latex/content/`）の人手証明を、Lean 4 で検証する。
規約の正本は、リポジトリ直下の `docs/context/証明の書き方.md` の「Lean 具体版」「Lean 必要十分版」と、
このプロジェクトの `docs/tasks/proof-runbook.md` の「Lean」の節である。

## セットアップとビルド

```bash
cd isomorphism-between-complex-matrix-algebra-and-clifford-algebra/lean
lake exe cache get          # mathlib のビルド済み .olean を取得する（省くと mathlib 全体をビルドする）
lake build
bash scripts/check-no-sorry.sh
```

`lean-toolchain`（`leanprover/lean4:v4.32.1`）と `lakefile.toml` の mathlib の `rev`（`v4.32.1`）は
`exact-solution-of-2d-ising-model/lean/` と同じ版に揃えてある。更新するときは両方を同じタグにする。

`scripts/check-no-sorry.sh` は三つを確かめる。どの `.lean` も入口 `CliffordMatrixIsomorphism.lean` から
import されていること、字面に `sorry`・`admit` が無いこと、名前空間 `CliffordMatrixIsomorphism` の
すべての宣言の依存する公理に `sorryAx` が無いこと（宣言の一覧は環境から拾うので、定理を足しても
スクリプトを直す必要は無い）。

## 置き場と名前空間

| 版 | フォルダ | 名前空間 |
| --- | --- | --- |
| 具体版 | `CliffordMatrixIsomorphism/<章>/<節>/` | `CliffordMatrixIsomorphism` |
| 必要十分版 | `CliffordMatrixIsomorphism/NecSuf/<章>/<節>/` | `CliffordMatrixIsomorphism.NecSuf` |
| 導出版 | 具体版と同じフォルダの `…FromNecSuf.lean` | 具体版と同じ |

- **具体版**は、本文が自分で定義した構造（環・ℂ-線型空間・線型写像・線型形式・双対空間など）を、
  本文の定義どおりの Lean の `structure` と `def` で書く。mathlib の `Module`・`LinearMap`・`Basis`・
  `DirectSum` などの一般論では置き換えない。ℂ の四則とその補題（`add_assoc`・`mul_add` など）は使う。
  証明は `calc` の一行を本文の式変形の一行に対応させ、本文が「定義による」とする行は `rfl`、
  公理を一つ当てる行はその公理を引数を明示して一回 `rw` する。具体版のファイルは必要十分版を引かない。
- **必要十分版**は、具体版と同じ `structure` と同じ `calc` の行のまま、係数 ℂ を型の変数 `K` に替え、
  証明が実際に使う `K` の性質だけを仮定に置く。`K` には演算の記号（`Add`・`Mul`・`Zero`・`One`）だけを
  与え、公理は仮定として明示的に渡す（mathlib の代数の型クラスの階層は使わない）。
- **導出版**は、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。
  構造を作る主張（双対空間・直和・ℂ^vec が線型空間であること）は、必要十分版から作った構造が
  具体版の構造と同じであること（`…_eq_of_necSuf`、`rfl`）も示す。
- 各宣言の docstring に、対応する本文のラベルを書く。各ファイルの冒頭に、本文のラベルと宣言の対応表を置く。

## 表し方の約束

- 番号付けた族 `b:{1,…,n}→V` は `ℕ → V` で表し、1,…,n の外の値は使わない。線型結合・一次独立・
  張ること・番号順の和は、どれも 1,…,n での値だけを見る形に書いてある。
- 線型結合 Σ_{k=1}^{n} λ_k ·_V x_k は、本文の定義の部分和 L_m を `partialLinearCombination` として書き、
  その m = n を `linearCombination` とする。本文の m についての帰納法は `partialLinearCombination` についての
  `induction` になる。ℂ の中の番号順の和も同じ（`partialOrderedSum`・`orderedSum`）。
- 有限集合 X の番号付け e:{1,…,n}→X は `Idx n → X`（`Idx n` は {1,…,n} の部分型）で表す。X が空集合でも書けるように
  `ℕ → X` にしない。X の上の族 f から線型結合に渡す `ℕ` の族は `numberedFamily e f d`（{1,…,n} の外は値 d）で作る。
- 有限集合の上の和 Σ_{x∈X} λ_x ·_V v_x は、X が有限集合であることの証明から番号付けを `Classical.choose` で一つ選んで定め、
  どの番号付けで開いても同じであること（本文の定義のブロックの後半）を `sumOverFiniteSet_eq` として示す。
- ℂ-代数は `UnitalRing` の欄を持ち（`extends`）、スカラー倍の四つの公理と両立の二つを足した structure である。
  線型空間の加法の四つの公理は環の加法の四つと同じ式なので重ねて置かない。
- 両側イデアルを法とする合同は、本文どおり a +_A ((-1_ℂ) ∗_A b) ∈ I で定める。剰余類 [a]_I は `Set A`、商集合 A/I は
  「ある a について X = [a]_I となる部分集合 X」の部分型で、A/I の元の等号は部分集合の等号である。商代数の演算と誘導される写像は、
  代表を射影の全射性から `Classical.choose` で一つ選んで定め、任意の代表で開いてよいこと（本文の定義の後半）を
  `quotientAdd_eq`・`inducedMap_eq` 等として示す。mathlib の `Quotient`・`Setoid`・`Ideal` は使わない。
- 座標の写像 β^b_k は、張ることから存在する係数を `Classical.choose` で一つ選んで定め、それが一つしか
  ないことを本文の二つ目の性質として示す。
- V の元の k 個の組 V^{1,…,k} は `Idx k → V`（`Tuple V k`）、写像 {1,…,k} → {1,…,n} の全体 X_{n,k} は `Idx k → Idx n` で表す。
  k 重テンソル積の普遍性は「任意の ℂ-線型空間 U」を量化するので、U の宇宙を `IsTensorProduct` の宇宙の引数にする。
- n 進の番号付け η_{n,k} は、本文の組 (a, r) を余りのある割り算 a := (m-1)/n^{k-1} + 1、r := (m-1) mod n^{k-1} + 1 で定め、
  存在と一意性を `digit_decomposition`・`digit_unique` に書く。番号の整数の計算は `omega` と ℕ の割り算の補題で行う。
- ℂ の中の番号順の積は、番号順の和と同じく `ℕ → ℂ` の族の部分積 P_m（`partialOrderedProduct`）で書く。
- X_{n,k} の二元のクロネッカーのデルタは、X_{n,k} の等号の判定に `Classical.decEq` を使う。
- 番号付けた線型空間の族 (E_j) は `E : ℕ → Type v` と各 j の線型空間で、直和 D は零の境をもつ族 (j : ℕ) → E j の部分型で表す。
  emb_k(y) の第 j 成分は、j = k のとき y を型の等式で E k から E j へ運んだもの（`cast`）である。
- j 重テンソル積の族 (T_j, τ_j) は structure `TensorPowers` で表す。普遍性を U := T_{k+l} に当てるので、どの T_j も同じ宇宙に置く。
  ρ_{u'}・θ_F は普遍性の存在から `Classical.choose` で選び、ただ一つであることは普遍性の一意性の欄で書く。

## 形式化済みの節

| 本文の節 | 具体版 | 必要十分版 | 導出版 |
| --- | --- | --- | --- |
| 環 | `MathematicalToolkit/Ring/UnitalRing.lean` | 置かない（二つの定義はどちらも ℂ を含まず、具体版がそのまま必要十分） | なし |
| ℂ-線型空間 | `MathematicalToolkit/ComplexVectorSpace/` の 7 ファイル | `NecSuf/MathematicalToolkit/ComplexVectorSpace/` の 7 ファイル | `ComplexVectorSpaceFromNecSuf.lean` |
| 有限集合の上の和 | `MathematicalToolkit/FiniteSetSum/` の 4 ファイル（`Numbering.lean` は ℂ を含まず両版が引く） | `NecSuf/MathematicalToolkit/FiniteSetSum/` の 3 ファイル | `FiniteSetSumFromNecSuf.lean` |
| ℂ-代数 | `MathematicalToolkit/ComplexAlgebra/` の 2 ファイル | `NecSuf/MathematicalToolkit/ComplexAlgebra/` の 2 ファイル | `ComplexAlgebraFromNecSuf.lean` |
| 両側イデアルと商代数 | `MathematicalToolkit/IdealAndQuotientAlgebra/` の 5 ファイル（節の末尾に置かれた直和の基底の主張は `DirectSumBasis.lean`） | `NecSuf/MathematicalToolkit/IdealAndQuotientAlgebra/` の 5 ファイル | `IdealAndQuotientAlgebraFromNecSuf.lean` |
| テンソル積 | `MathematicalToolkit/TensorProduct/` の 5 ファイル（`BaseNNumbering.lean` は ℂ を含まず両版が引く） | `NecSuf/MathematicalToolkit/TensorProduct/` の 4 ファイル | `TensorProductFromNecSuf.lean` |
| テンソル代数の土台（族の直和、つなげた組、テンソルの積とその双線型性） | `MathematicalToolkit/TensorAlgebra/` の 5 ファイル（`IndexShift.lean` は ℂ を含まず両版が引く） | `NecSuf/MathematicalToolkit/TensorAlgebra/` の 4 ファイル | `TensorAlgebraFromNecSuf.lean` |

## 必要十分版が示したこと（節「ℂ-線型空間」）

- 双対空間のスカラー倍が定まるには、係数の乗法の交換法則が要る（`pointwiseScalarMultiple_isLinearForm`。
  (μλ)f(x) = (λμ)f(x) の行）。乗法が可換でない係数では、線型形式の各点ごとのスカラー倍は線型形式にならない。
- 零のスカラー倍が零ベクトルであることに要る係数の性質は 0 + 0 = 0 だけである（`zero_smul_eq_zero`）。
- 線型結合の和・項ごとの比較・分割は、係数の公理を一つも使わない。係数の一意性は、加法の結合法則・交換法則、
  0 の左右の単位性、1 + n = 0 となる n の存在、1 · a = a、右分配法則、a · 0 = 0、0 · a = 0 を使い、
  乗法の結合法則・交換法則・左分配法則を使わない。
- 二つの線型空間の直和が線型空間であることは、係数の性質を一つも使わない。

## 必要十分版が示したこと（節「有限集合の上の和」「ℂ-代数」）

- 有限集合の上の和を定めること、番号付けによらないこと、和どうしの和、項ごとの比較、二重和の順序の入れ替えは、
  係数の公理を一つも使わない。
- 和のスカラー倍には 0 + 0 = 0 と a · 0 = 0 が要り、線型写像が和を値の和へ移すこと・係数 δ の和が一項を取り出すことには
  0 + 0 = 0 だけが要る（どちらも 0 ·_V x = 0_V を経由する）。
- ℂ-代数の節の五つの主張（部分積、生成元で一致する準同型、合成、恒等写像、番号順の積の像）は、係数の性質を一つも使わず、
  代数の公理（環の公理・スカラー倍の公理・両立の二つ）も使わない。使うのは演算の定義と準同型の条件だけである。

## 必要十分版が示したこと（節「両側イデアルと商代数」）

- 合同の定義の -1_ℂ は K の元 n に替え、n が 1 の加法の逆元であることは使う主張の仮定に置いた。
- 両側イデアル・生成する両側イデアルの三つの主張・両側イデアルがスカラー倍で閉じていること・合同が加法と両立すること・
  射影の全射性は、係数の性質を一つも使わない。
- 合同の反射性には 1 + n = 0 と 0 + 0 = 0、対称性には n · n = 1、推移性と乗法との両立には n + 1 = 1 + n・1 + n = 0・0 + 0 = 0 が要る。
  剰余類の同値と、それを経由する商代数の加法・乗法・環の構造には、この四つ（`CongruenceLaws`）が要る。
- 合同がスカラー倍と両立することには、n とすべての λ の交換 n · λ = λ · n が要る。商集合のスカラー倍・線型空間・代数の構造と、
  射影・誘導される写像が準同型であることは、これを経由する。K に環の公理を置けば分配法則から従う性質だが、
  K に公理を置かない必要十分版では仮定として残る。
- 準同型が零へ移す元の全体が両側イデアルであることには 0 + 0 = 0 だけが要る。
- 二つの基底を並べた族が直和の基底であることには 0 + 0 = 0 と a · 0 = 0 だけが要る（成分への埋め込みが線型写像であることから来る）。

## 必要十分版が示したこと（節「テンソル積」）

- k 重線型写像の後に線型写像を合成しても k 重線型写像であることは、係数の性質を一つも使わない。
- K^X を線型空間にするのは、K を自分自身の上の線型空間にするのと同じ八つの性質（`ValuedMapsLaws`）で、乗法の交換法則と a · 1 = a は使わない。
- 番号順の積が一つの因子の和を積の和へ移すことには左右の分配法則だけ、一つの因子のスカラー倍を積のスカラー倍へ移すことには
  乗法の結合法則と、λ がどの元とも交換することが要る。二つの積の積には 1 · 1 = 1・結合法則・交換法則、後ろの因子が 1 の主張には a · 1 = a が要る。
  0 の因子の主張は本文どおりスカラー倍の主張を λ := 0 で当てるので、結合法則と 0 の交換を連れてくる。
- 基底の座標による構成が k 重テンソル積であることには、係数の乗法の交換法則が要る。τ が各成分のスカラー倍を保つ行で、
  λ を番号順の積の前の部分 P_{r-1} の前へ出すためである。ほかに使うのは、K^X の八つの性質、係数の一意性の仮定の組
  （座標の写像が線型形式であることと、双対基底であること）、0 + 0 = 0、a · 0 = 0 である。
- 基底の元の組で値が一致する二つの k 重線型写像が等しいことには、0 + 0 = 0 だけが要る（線型写像が線型結合を移すことから来る）。

## 必要十分版が示したこと（節「テンソル代数」の土台）

- 族の直和が線型空間であることには、スカラー倍が零の境を保つための 0 + 0 = 0 と a · 0 = 0（λ ·_{E_j} 0_{E_j} = 0_{E_j} から来る）と、
  加法の逆元 (-1_ℂ) ∗_D x を作るための 1 + n = 0 となる n が要る。成分ごとの和が零の境をもつことは係数の性質を使わない。
- 二つの組をつなげること、成分の置き換えとの交換、k + l 重線型写像に後ろの組を固定して入れた写像が k 重線型であることは、係数の性質を一つも使わない。
- 線型写像の各点ごとの和が線型写像であることは係数の性質を使わず、各点ごとのスカラー倍 μ ⊡ f が線型写像であることには、
  μ がどの係数とも交換することが要る。
- テンソルの積 m_{k,l} を定めるには、係数の乗法の交換法則が要る。ρ_•(F) が後ろにつなげる組についてスカラー倍を保つことを、
  λ ⊡ ρ_b = ρ_d で示すためである。前の因子についての線型性は、λ ⊡ θ_F が線型写像であることで同じ性質をもう一度使う。

