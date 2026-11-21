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
bash ../../scripts/lean-concrete-necsuf-separation/check.sh .   # 具体版と必要十分版が互いを参照していないこと（既知の違反は concrete-necsuf-separation-ledger.txt。行は減らすだけ）
bash ../../scripts/lean-concrete-general-theory/check.sh .   # 具体版が mathlib の線型代数の一般論を使っていないこと（本文が「定義せずに用いる」と明示したものは declared-general-theory.txt で許す。既知の違反は concrete-general-theory-ledger.txt。行は減らすだけ）
node scripts/verify-label-correspondence.ts   # 本文のラベルと具体版・必要十分版・導出版の対応（下の「本文のラベルとの対応の検査」）
```

`lean-toolchain`（`leanprover/lean4:v4.32.1`）と `lakefile.toml` の mathlib の `rev`（`v4.32.1`）は
`exact-solution-of-2d-ising-model/lean/` と同じ版に揃えてある。更新するときは両方を同じタグにする。

`scripts/check-no-sorry.sh` は三つを確かめる。どの `.lean` も入口 `CliffordMatrixIsomorphism.lean` から
import されていること、字面に `sorry`・`admit` が無いこと、名前空間 `CliffordMatrixIsomorphism` の
すべての宣言の依存する公理が Lean の標準の三つ（`propext`・`Classical.choice`・`Quot.sound`）に限られること
（`sorryAx` も、`axiom` で置いた仮定も、ほかの公理も落ちる。宣言の一覧は環境から拾うので、定理を足しても
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
  必要十分版は具体版の宣言を一つも引かない。ℂ を含まない定義（環の組・番号付け・部分集合全体と 2 進の番号付け・個数 N_i(T)・
  Pauli 行列のラベルなど）も、必要十分版の名前空間に同じ形で別に置き、主張にも必要十分版と導出版を置く。
  検査はリポジトリ直下の `scripts/lean-concrete-necsuf-separation/check.sh`（違反の台帳 `concrete-necsuf-separation-ledger.txt` は空）。
- **導出版**は、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。
  構造を作る主張（双対空間・直和・ℂ^vec が線型空間であること）は、必要十分版から作った構造が
  具体版の構造と同じであること（`…_eq_of_necSuf`、`rfl`）も示す。
- 導出版は、二つの版に同じ形で別に置いた定義を行き来する写像（`UnitalRing.toNecSuf`・`IsNumbering.toNecSuf`・`IsFiniteSet.toNecSuf`・
  `PauliLabel.toNecSuf` など。`Ring/UnitalRingFromNecSuf.lean`・`FiniteSetSum/NumberingFromNecSuf.lean`）を通す。2^M・個数 N_i(T)・
  整数の番号順の和のような再帰の定義は、二つの版の値が再帰の展開でしか一致しないので、章「複素行列環」「同型の証明」の導出版のファイルは
  `set_option smartUnfolding false` を置く。導出版の宣言の名前は `eq_` で始めない（分離の検査が自動生成の等式の補題と見なし、親の宣言に数える）。
- 各宣言の docstring に、対応する本文のラベルを書く。各ファイルの冒頭に、本文のラベルと宣言の対応表を置く。

## 本文のラベルとの対応の検査

`node scripts/verify-label-correspondence.ts`（lean/ の外から打つときは `node lean/scripts/verify-label-correspondence.ts`）は、
ソースの字面を読んで次を確かめ、終了コードで成否を返す。

- 本文（`../structured-latex/content/chapters/`）の見出しでないブロックのラベルが、どれも具体版の宣言の docstring に現れること。
- 本文の主張と定理のどれにも、必要十分版の宣言と導出版の宣言（名前が `…_of_necSuf`・`…_eq_of_necSuf`・`…_eq_necSuf` で終わるもの）があること。
  docstring にラベルが無い宣言は、具体版と同じ名前（導出版は接尾辞を除いた名前）で対応を取り、名前は名前空間まで比べる
  （必要十分版の名前空間は具体版の名前空間に `NecSuf.` を挟んだもの。線型空間と代数だけは `VectorSpace`・`AlgebraOver`）。
- 本文の主張と定理のどれでも、導出版が必要十分版を特殊化していること。導出版の本文が、対応する必要十分版の宣言を
  `NecSuf.…` か `….toNecSuf.…` の形で引いていなければならない。本文のラベルを持たない導出版の補題（系の定理の本体の導出版など）を
  一段だけ中継してよく、その補題は自分の名前から接尾辞を除いた必要十分版の宣言を同じ形で引く。本文のラベルを持つ別の主張の
  導出版から組み立てたものと、具体版の同じ名前の定理を引いたものは落ちる。
- docstring が引く本文のラベルが本文に実在すること。

規約の例外として、次の二つを置く。

- ℂ についての事実で必要十分版では K の仮定になるもの（1 + 1 ≠ 0、i · i = -1）には、
  必要十分版と導出版を置かない。既存の記号に名前を付けるだけの定義と、各宣言の前提（引数）になる定義には、具体版の宣言を置かない。
  どれも `scripts/label-correspondence-exceptions.ts` に理由と一緒に載せ、検査はその一覧のラベルだけを外す。一覧のラベルに宣言を置いたら、検査が落ちるので一覧から消す。
- 本文のラベルを持たない Lean の中だけの途中の補題（`partialOrderedSum_eq_zero_of_terms_eq_zero`・`splitFamily_first` など）には、導出版を置かない。
  検査も本文のラベルだけを見る。

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
- 本文の「(k+l)+p = k+(l+p) なので両辺は同じ集合の元である」のように、番号の等しい二つの集合を同じ集合として読む文は、
  Lean では型が別の式になるので、その間の写像に名前を付ける：組には `castTuple`、T_j には `TensorPowers.castT`。どちらも番号の等式を
  `subst` すると恒等写像になり、加法・スカラー倍・τ と交換する。テンソル代数の積の項 m_{i,p-i}(x_i, y_{p-i}) は castT で T_p へ運ぶ。
- {0,…,N} は ℕ の部分型 `UpTo N` で、番号付けは本文どおり e(s) := s - 1（`upToNumbering`）。
- 各成分が 1 か 2 の組 I ∈ 𝓘_M は `Idx M → Idx 2`（写像の等しさが I = J になるよう、{1,…,M} の外の値を持たせない）。番号 t ∈ ℕ を受け取る式には
  {1,…,M} の外で値 1 に延ばした `extendFamily I idxOne` を渡す。整数の番号順の和 Σ_{t=a}^{b}（a, b ∈ ℤ）は ℤ → ℤ の族について項の個数で値を定め、
  本文の二つの場合の式（b < a、b ≥ a）を補題にして以後はそれだけを引く。num_M の値は ℤ の元で、{1,…,2^M} への写像は `tupleNumberIdx`、その逆写像は `tupleNumberInv`。
- テンソル代数の積・単位元・ℂ-代数であることは任意の j 重テンソル積の族 `P : TensorPowers SV` の上で書き、本文の T(V) は
  P := `coordinateTensorPowers SV n b hb`（座標による構成）の場合である。座標による構成を使うのは、埋め込みの像が生成することと普遍性だけである。
- テンソル代数の普遍性の A は任意の宇宙 w の型に置く。F_k を定めるのに (T_k, τ_k) の普遍性を U = U_vec(A) に当てるので、
  族が宇宙 w について k 重テンソル積であること `hP` を引数に取り、座標による構成ではそれを `coordinateTensor_isTensorProduct` から渡す。

- 章「同型の証明」のクリフォード代数の中の定義と主張（Φ・a†_S・a_T・P など）は、前提の組 D から引けるように名前空間 `Clifford.SplitData` に置く
  （`D.vacuumElement` など）。行列の側の補題は `Isomorphism` に置く。
- 章「クリフォード代数」の前提「V は ℂ-線型空間、b は基底、q は二次形式」は structure `QuadraticSpaceWithBasis` の欄に置き、
  T(V)・ι・I_q・Cl(V,q)・π_{I_q}・γ はその上の def である。分裂した二次空間の前提（W、基底 w、双対基底 f）は `SplitData` に置き、
  `SplitData.space` が V := W ⊕ W^*、q := q_W、基底 c の `QuadraticSpaceWithBasis` を作る。
- クリフォード代数の章の導出版は、具体版の T(V)・I_q が必要十分版のものと命題として等しい（定義による一致ではない）ので、
  各主張の必要十分版を T(V) の構造 S・ι・I を変数にした形に書き直してから具体版のものを入れる。
  分裂した二次空間の節は、具体版の W^* と必要十分版の W^* が別の部分型でクリフォード代数が別の集合になるので、
  二つのクリフォード代数の間に普遍性で準同型 Φ・Ψ（Ψ ∘ Φ = 恒等写像）を作り、必要十分版の主張を Φ で引き戻す（`GeneratorsFromNecSuf.lean` の冒頭）。

- 具体版の前提から作ったクリフォード代数と、具体版の前提を写した必要十分版の前提のクリフォード代数が別の集合になるとき
  （分裂した二次空間、系「一般の偶数次元」と系「Jordan–Wigner 行列への接続」の Cl(Y,Q)、系「奇数次元」の Cl(V',q')）、
  導出版は二つの間に互いに逆な準同型 T・S を置き、具体版の主張の両辺を T で写して必要十分版の主張に当て、S ∘ T = 恒等写像で戻す。
  T・S は、二つの空間の点を互いに写す線型な写像の組 `QuadraticSpaceWithBasis.PointTransport` から二つの普遍性で作る
  （`TransportToNecSufFromNecSuf.lean`）。具体版の写像（Φ・Ψ、Φ_Y・Ψ_Y、Ω・Ω'、Ω̂・Ω̂'、Φ'・Ψ'）は、必要十分版の写像と T・S の合成に
  等しいことを示してから、必要十分版の主張を移す。主定理と三つの系の定理も、必要十分版の定理を特殊化してこの等式で移す
  （各段の導出版から定理を組み立て直さない。対応の検査が落とす）。
- 必要十分版の calc が具体版より長い箇所（系「奇数次元」の `OddExtension.lean`・`HomomorphismToPairOfMatrices.lean` など）は、
  具体版が `ring` や ℂ の補題で一行にした「ℂ の四則」の行を、K の公理を一つずつ当てる行に割ったものである。割った行の外の calc の行と論法は具体版と同じである。

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
| テンソル代数の代数の構造と普遍性（テンソルの積の結合法則、積・単位元、ℂ-代数であること、埋め込みと生成、普遍性、代数の中の積の補題） | `MathematicalToolkit/TensorAlgebra/` の `AssociativityOfTensorProduct`・`TensorAlgebraStructure`・`EmbeddingAndGeneration`・`UniversalPropertyOfTensorAlgebra`・`MultiplicationInAlgebra`・`InitialSegmentFromZero`（ℂ を含まず両版が引く） | `NecSuf/MathematicalToolkit/TensorAlgebra/` の同じ名前の 5 ファイル | `TensorAlgebraStructureFromNecSuf.lean`・`MultiplicationInAlgebraFromNecSuf.lean` |
| 二次形式 | `MathematicalToolkit/QuadraticForm/QuadraticForm.lean` | `NecSuf/MathematicalToolkit/QuadraticForm/QuadraticForm.lean` | `QuadraticFormFromNecSuf.lean` |
| クリフォード代数の定義と普遍性（章「クリフォード代数」の前半） | `CliffordAlgebra/DefinitionAndUniversalProperty/CliffordAlgebra.lean` | `NecSuf/CliffordAlgebra/DefinitionAndUniversalProperty/CliffordAlgebra.lean` | `CliffordAlgebraFromNecSuf.lean` |
| 分裂した二次空間のクリフォード代数の生成元 | `CliffordAlgebra/SplitQuadraticSpace/Generators.lean` | `NecSuf/CliffordAlgebra/SplitQuadraticSpace/Generators.lean` | `GeneratorsFromNecSuf.lean` |
| 章「複素行列環」：行列の集合と演算、ℂ-代数であること | `ComplexMatrixAlgebra/MatrixAlgebra/` の 4 ファイル | `NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/` の 4 ファイル | `MatrixAlgebraFromNecSuf.lean` |
| 章「複素行列環」：行列単位、成分を取り出す写像、単位行列と行列の分解 | `ComplexMatrixAlgebra/MatrixUnits/MatrixUnits.lean` | `NecSuf/ComplexMatrixAlgebra/MatrixUnits/MatrixUnits.lean` | `MatrixUnitsFromNecSuf.lean` |
| 章「複素行列環」：部分集合全体 P_M と 2 進の番号付け、組の番号付け | `ComplexMatrixAlgebra/PowerSetNumbering/` の 3 ファイル | 置かない（ℂ を含まず両版が引く） | なし |
| 章「複素行列環」：番号付けによる行列の添字の付け替えと 2 進の番号付けによる行列環の同型 | `ComplexMatrixAlgebra/MatrixReindexing/` の 2 ファイル | `NecSuf/ComplexMatrixAlgebra/MatrixReindexing/` の 2 ファイル | `MatrixReindexingFromNecSuf.lean` |
| 章「複素行列環」：クロネッカー積と、二つの行列で挟む写像 | `ComplexMatrixAlgebra/KroneckerProduct/` の 4 ファイル（`MembershipIndex.lean` は ℂ を含まず両版が引く） | `NecSuf/ComplexMatrixAlgebra/KroneckerProduct/` の 3 ファイル | `KroneckerProductFromNecSuf.lean` |
| 章「複素行列環」：番号を逆順に付け替える写像と番号 1 を最上位の桁にする番号付け r_M、各成分が 1 か 2 の組と組の番号 num_M、整数の番号順の和、r_M による付け替え ν_{r_M}・μ_{r_M}、番号で添字づけたクロネッカー積、一つの因子だけを残したクロネッカー積の番号順の積 | `ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/` の 6 ファイル（`SubsetReversal`・`TuplesOfOnesAndTwos`・`OrderedIntegerSum`・`TupleNumber` は ℂ を含まず両版が引く） | `NecSuf/ComplexMatrixAlgebra/FirstSiteHighestDigitNumbering/` の 2 ファイル | `FirstSiteHighestDigitNumberingFromNecSuf.lean` |
| 章「同型の証明」のうち、生成作用素の行列の定義とその成分・反交換関係・空集合の位置の行列単位 | `Isomorphism/CreationOperatorMatrices/` の 7 ファイル（`CountAndSign.lean`・`IndexSetOperations.lean`・`VacuumIndexSets.lean` は ℂ を含まず両版が引く） | `NecSuf/Isomorphism/CreationOperatorMatrices/` の 4 ファイル | `CountAndSignFromNecSuf.lean`・`CreationMatricesFromNecSuf.lean`・`VacuumMatrixUnitFromNecSuf.lean` |
| 章「同型の証明」のうち、クリフォード代数から行列環への準同型（c_i² = 0・(c_i^T)² = 0、φ、Φ の存在と一意性、Φ(a†_i) = c_i・Φ(a_i) = c_i^T） | `Isomorphism/HomomorphismToMatrixAlgebra/HomomorphismToMatrixAlgebra.lean` | `NecSuf/Isomorphism/HomomorphismToMatrixAlgebra/HomomorphismToMatrixAlgebra.lean` | `HomomorphismToMatrixAlgebraFromNecSuf.lean` |
| 章「同型の証明」のうち、クリフォード代数の中の局所的な等式（a†_S・a_T・P の定義、a_i P = 0・P a†_i = 0、生成元を左から・消滅元を右から掛けた式） | `Isomorphism/LocalIdentities/LocalIdentities.lean` | `NecSuf/Isomorphism/LocalIdentities/LocalIdentities.lean` | `LocalIdentitiesFromNecSuf.lean` |
| 章「同型の証明」のうち、クリフォード代数の中の大域的な等式（番号の違う因子の交換、a†_{U,≤m}・P_{≤m}・Q^{T,U}_m の定義と分解、(P (a_T a†_U)) P = δ_{T,U} ∗ P、u^S_i の定義、部分集合の和の主張、1 の分解） | `Isomorphism/GlobalIdentities/GlobalIdentities.lean` | `NecSuf/Isomorphism/GlobalIdentities/GlobalIdentities.lean` | `GlobalIdentitiesFromNecSuf.lean` |
| 章「同型の証明」のうち、行列環からクリフォード代数への準同型（ℰ_{S,T} の定義と積の規則、Ψ の定義、Ψ が線型・行列単位を ℰ_{S,T} へ移す・行列単位どうしの積を保つ・ℂ-代数の準同型であること） | `Isomorphism/HomomorphismFromMatrixAlgebra/HomomorphismFromMatrixAlgebra.lean` | `NecSuf/Isomorphism/HomomorphismFromMatrixAlgebra/HomomorphismFromMatrixAlgebra.lean` | `HomomorphismFromMatrixAlgebraFromNecSuf.lean` |
| 章「同型の証明」のうち、二つの準同型が互いに逆であること（Φ(ℰ_{S,T}) = E_{S,T}、Φ ∘ Ψ = 恒等写像、生成作用素の列の和・消滅作用素の行の和、Ψ(c_i) = a†_i・Ψ(c_i^T) = a_i、γ((x, g)) の分解、Ψ ∘ Φ = 恒等写像、主定理） | `Isomorphism/MutuallyInverseHomomorphisms/MutuallyInverseHomomorphisms.lean` | `NecSuf/Isomorphism/MutuallyInverseHomomorphisms/MutuallyInverseHomomorphisms.lean` | `MutuallyInverseHomomorphismsFromNecSuf.lean` |
| 章「同型の証明」のうち、系「行列単位にあたる元はクリフォード代数の基底をなす」（b の定義、Φ(Σ λ_m ∗ b_m) の成分、一次独立、張ること、基底であること） | `Isomorphism/BasisOfMatrixUnitElements/BasisOfMatrixUnitElements.lean` | `NecSuf/Isomorphism/BasisOfMatrixUnitElements/BasisOfMatrixUnitElements.lean` | `BasisOfMatrixUnitElementsFromNecSuf.lean` |
| 章「同型の証明」の系「一般の偶数次元の非退化な二次空間」のうち、二次形式の補題と直交基底の存在（1+1≠0、偏極の第二引数の線型性・対角での値、一つの元の倍を足した族、第 k 元まで直交化された基底と直交化の一歩） | `Isomorphism/GeneralEvenDimensional/OrthogonalBasis.lean` | `NecSuf/Isomorphism/GeneralEvenDimensional/OrthogonalBasis.lean` | `OrthogonalBasisFromNecSuf.lean` |
| 同じ系のうち、虚数単位、ℂ の元の平方根の存在、値が 1 の直交基底の存在、直交する族の線型結合での二次形式の値 | `Isomorphism/GeneralEvenDimensional/OrthonormalBasis.lean` | `NecSuf/Isomorphism/GeneralEvenDimensional/OrthonormalBasis.lean` | `OrthonormalBasisFromNecSuf.lean` |
| 章「同型の証明」の系「一般の偶数次元の非退化な二次空間」のうち、基底の座標を係数にした族の線型結合の写像 L_{b,u}、基底を動かさない線型写像は恒等写像、等長写像の右逆、等長写像が誘導するクリフォード代数の準同型 Cl(θ) と逆向きの合成 | `Isomorphism/GeneralEvenDimensional/InducedHomomorphism.lean` | `NecSuf/Isomorphism/GeneralEvenDimensional/InducedHomomorphism.lean` | `InducedHomomorphismFromNecSuf.lean` |
| 同じ系のうち、分裂した二次空間の記号と一般の非退化な二次空間の設定、族 u・v、等長写像 θ・θ' と互いに逆であること、系の定理 | `Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean` | `NecSuf/Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean` | `IsometryToSplitSpaceFromNecSuf.lean` |
| 章「同型の証明」の系「奇数次元の二次空間」のうち、V' := V ⊕ ℂ^vec と q'、族 o、q' の偏極・二次形式であること・in'_1 が等長写像・q'(u) = 1・in'_1 の像と u の直交、設定、j := Cl(in'_1) と j ∘ γ = γ' ∘ in'_1、u・g、g·g = 1、g と j(γ(v)) の反交換 | `Isomorphism/OddDimensional/OddExtension.lean` | `NecSuf/Isomorphism/OddDimensional/OddExtension.lean` | `OddExtensionFromNecSuf.lean` |
| 同じ系のうち、一般の ℂ-代数の主張（二元のどちらとも反交換する元は積と交換する、C_y とそれが部分代数であること、生成する部分集合で交換すれば全体と交換する） | `Isomorphism/OddDimensional/CommutingElements.lean` | `NecSuf/Isomorphism/OddDimensional/CommutingElements.lean` | `CommutingElementsFromNecSuf.lean` |
| 同じ系のうち、符号の因子 χ_i と ε、χ_i と a_i・a†_i の積と反交換、χ_i·χ_i = 1、番号の違う生成元・χ との交換、ε·ε = 1、生成元・γ(v) と ε の反交換 | `Isomorphism/OddDimensional/ParityElement.lean` | `NecSuf/Isomorphism/OddDimensional/ParityElement.lean` | `ParityElementFromNecSuf.lean` |
| 同じ系のうち、g と j(χ_i)・j(ε) の交換、z := j(ε)·g、z·z = 1、z と j(γ(v))・g の交換、γ'((v,t)) の分解、z が中心に入ること | `Isomorphism/OddDimensional/CentralElement.lean` | `NecSuf/Isomorphism/OddDimensional/CentralElement.lean` | `CentralElementFromNecSuf.lean` |
| 同じ系のうち、二つの ℂ-代数の直積とそれが ℂ-代数であること、⟨φ1,φ2⟩ と準同型であること、反交換する平方 1 の元の倍を足した元の平方 | `Isomorphism/OddDimensional/ProductOfAlgebras.lean` | `NecSuf/Isomorphism/OddDimensional/ProductOfAlgebras.lean` | `ProductOfAlgebrasFromNecSuf.lean` |
| 同じ系のうち、φ' とその線型性・平方、Φ' の存在と一意性、Φ' ∘ j、Φ'(g) | `Isomorphism/OddDimensional/HomomorphismToPairOfMatrices.lean` | `NecSuf/Isomorphism/OddDimensional/HomomorphismToPairOfMatrices.lean` | `HomomorphismToPairOfMatricesFromNecSuf.lean` |
| 同じ系のうち、Φ'(z)、e_± := ½(1 ± z) と、e_σ·e_σ = e_σ・e_σ·e_{-σ} = 0・e_+ + e_- = 1・e_+ − e_- = z・中心に入ること、Φ'(e_σ) | `Isomorphism/OddDimensional/Idempotents.lean` | `NecSuf/Isomorphism/OddDimensional/Idempotents.lean` | `IdempotentsFromNecSuf.lean` |
| 同じ系のうち、Ψ' とそれが準同型であること、Φ' ∘ Ψ' = 恒等写像、Ψ' ∘ Φ' = 恒等写像、系の定理 | `Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean` | `NecSuf/Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean` | `HomomorphismFromPairOfMatricesFromNecSuf.lean` |
| 章「同型の証明」の系「複素行列版イジングの Jordan–Wigner 行列への接続」の前半（Pauli 行列 σx・σy・σz、K・K' とその積・K で挟んだ Pauli 行列、σz の対角成分の部分積、c_m・c_m^T のクロネッカー積による表示、Z_m・Y_m、U・U' とその積、c_m + c_m^T などを U と U' で挟んだ行列、Φ_Y が直交基底の元を送る先、Ω・Ω' と系の定理） | `Isomorphism/JordanWignerMatrices/` の 5 ファイル（`TwoElementSetMembers.lean` は ℂ を含まず両版が引く） | `NecSuf/Isomorphism/JordanWignerMatrices/` の 4 ファイル | `PauliMatricesFromNecSuf.lean`・`CreationMatricesAsKroneckerProductsFromNecSuf.lean`・`JordanWignerConjugationFromNecSuf.lean`・`ConjugatedIsomorphismFromNecSuf.lean` |
| 同じ系の後半（番号で添字づけたサイトごとの Pauli 行列 σ^a_k、Jordan–Wigner 行列の因子 F^{(b)}_{m,j}、番号で添字づけた Z^{(2^M)}_m・Y^{(2^M)}_m、ν_{r_M}(Z_m) = Z^{(2^M)}_m・ν_{r_M}(Y_m) = Y^{(2^M)}_m、Ω̂ := ν_{r_M} ∘ Ω・Ω̂' := Ω' ∘ μ_{r_M}、Ω̂ が直交基底の元の像を送る先、系の定理） | `Isomorphism/JordanWignerMatrices/` の `PauliLabels`（ℂ を含まず両版が引く）・`IndexedByNumbers`・`IsomorphismIndexedByNumbers` | `NecSuf/Isomorphism/JordanWignerMatrices/` の `IndexedByNumbers`・`IsomorphismIndexedByNumbers` | `IndexedByNumbersFromNecSuf.lean`・`IsomorphismIndexedByNumbersFromNecSuf.lean` |

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

## 必要十分版が示したこと（節「テンソル代数」の代数の構造と普遍性）

- 代数の中の積の補題のうち、左右から掛ける写像の線型性と番号順の積の六つの主張は、係数の性質を一つも使わない。
  零との積・線型結合との反交換子・部分代数が有限集合の上の和で閉じていることは 0 + 0 = 0 だけ、平方が零の元の線型結合の平方が零であることは
  0 + 0 = 0 と a · 0 = 0、反交換する二元の入れ替えは 1 + n = 0 となる n と 0 + 0 = 0 を使う。
- テンソルの積の結合法則、空の組の像が積の単位元であること、castT・castTuple の性質、μ^f_k が k 重線型であること、F_k を定めることは、
  係数の性質を使わない（m_{k,l} を含む主張は、m_{k,l} を定めるための乗法の交換法則を仮定に持つだけである）。
- テンソル代数が K-代数であることには、乗法の交換法則（m_{k,l} を定めるためと、積のスカラー倍の行で 1 · λ を λ · 1 に替えるため）、
  0 + 0 = 0 と a · 0 = 0（零の境・デルタで一項を取り出す行・和のスカラー倍）、直和の加法の逆元を作る 1 + n = 0 となる n が要る。
- F が線型写像であることのスカラー倍の行に要るのは、1 と λ が交換することだけである。

## 必要十分版が示したこと（節「二次形式」、章「クリフォード代数」）

- 偏極の対称性は加法の結合法則と交換法則だけを、偏極の等式はそれに a + (-a) = 0 と 0 + a = a を足しただけを使う（どちらも本文どおり任意の写像 q について成り立つ）。
- q_W の偏極の値と q_W が二次形式であることには、W^* を線型空間にする性質のほかに a + (-a) = 0 だけが要る。
- 章「クリフォード代数」のどの主張も、q が二次形式であることを使わない。必要十分版の前提の組は q を V から K への任意の写像とし、
  「q は二次形式」の欄を持たない（普遍性の証明が q について使うのは、f(v)·f(v) = q(v) ∗ 1 という仮定と I_q の生成元の形だけである）。
- クリフォード代数を作り、γ が線型であることと γ(V) が生成することを示すのに K に要るのは、T(V) を座標で作る性質（テンソル代数の節と同じ）、
  乗法の交換法則（テンソルの積と、商代数のスカラー倍で n · λ = λ · n）、合同の四つの性質だけである。
  a + (-a) = 0 は、γ(v)² の計算・反交換子・普遍性の存在の三つの主張だけが使う。
- 分裂した二次空間の反交換関係と平方が零であることは、章の前半の仮定のほかに K の性質を足さない
  （W^* を線型空間にする性質と、双対基底が基底であることに要る a · 1 = a は、どちらも章の前半の仮定から出る）。

## 必要十分版が示したこと（章「複素行列環」、章「同型の証明」の生成作用素の行列）

- 行列の積を定めるには、係数を自分自身の上の線型空間にする八つの性質 L（`ValuedMapsLaws`）が要る（積の成分が K^vec の中の和なので）。
  左右の分配法則、二つの付け替えが互いの逆であること、2 進の番号付けが全単射であることは、L のほかに係数の性質を使わない。
- 乗法の交換法則が要るのは、積の結合法則（本文の経路が和のスカラー倍を左から掛けるため）と、スカラー倍の右の因子との両立
  （主張そのものが λ の交換を要する）である。したがって行列の集合が K-代数であることは交換法則を要る。
- 単位行列を右から掛けること・行列単位の積の規則・行列の行列単位による分解・生成作用素の行列を右から掛けた成分は、
  δ の値が 0 か 1 なので、乗法の交換法則全体ではなく 0 と 1 がどの元とも交換することだけで足りる。
- 符号 ς は -1 の代わりの元 n で定まり、ς(k)·ς(k) = 1 には n·n = 1 と 1 + n = 0 などの n についての個別の等式と、
  n がどの元とも交換することだけが要る。ς の値どうしの交換は、乗法の結合法則と 1·a = a から ς(a)·ς(b) = ς(a+b) を経て出る。
- 空集合の位置の行列単位についての三つの主張は、本文の前提 M ∈ ℤ_{≥1} を使わない（M = 0 でも同じ証明が通る）。
  第二・第三の主張は n について何も仮定しない（使う符号は ς(0) = 1 だけ）。

## 必要十分版が示したこと（章「複素行列環」の、番号 1 を最上位の桁にする番号付けと番号で添字づけたクロネッカー積）

- ϱ_M・r_M・𝓘_M・ō_M・pos_M・整数の番号順の和・num_M と、それらの主張（r_M が番号付けであること、num_M が全単射で ō_M ∘ r_M の逆であること）は
  ℂ を含まず、係数の性質を一つも使わない。
- ν_{r_M}・μ_{r_M}・番号で添字づけたクロネッカー積、部分集合全体で添字づけたクロネッカー積を ν_{r_M} で付け替えると番号で添字づけたクロネッカー積になること、
  因子ごとに等しい族の番号で添字づけたクロネッカー積が等しいことは、係数の性質を一つも使わない。
- 一つの因子だけを残したクロネッカー積の番号順の積の主張は、K について、行列の集合を代数にするための乗法の交換法則と a · 0 = 0 のほかに足す性質が無い
  （a · 1 = a と 0 · a = 0 は、交換法則と L の 1 · a = a、a · 0 = 0 から出る）。証明の準備 f^{[≤p]}_t · f^{[p+1]}_t = f^{[≤p+1]}_t は、0 と 1 の交換だけで足りる。
- 本文の前提 M ∈ ℤ_{≥1}（番号で添字づけたクロネッカー積とその主張、一つの因子だけを残した族）と p ∈ {0,…,M}・j ∈ {1,…,M} は、どの証明も使わない（M = 0 でも、p > M でも同じ証明が通る）。

## 必要十分版が示したこと（章「同型の証明」のクリフォード代数から行列環への準同型と、クリフォード代数の中の局所的な等式）

- c_i · c_i = 0 と c_i^T · c_i^T = 0 には、`ValuedMapsLaws`（L）・a · 1 = a・a · 0 = 0・0 · a = 0 だけが要る。具体版が ℂ の乗法の交換法則を当てる
  成分の入れ替えは `creationMatrix_entries_comm` で済み、乗法の交換法則は要らない。
- 行列の側の ς を定める n は、クリフォード代数の合同に使う n（1 + n = 0）と同じ K の元でよい。`SignLaws K n` の欄はどれも `CliffordLaws K n` の欄から出る。
- φ が線型であることと φ(v)² = q(v) ∗ 1 は、章「クリフォード代数」の仮定 `CliffordLaws K n` のほかに K の性質を足さない。
  φ(v)² の計算の μ_l · δ = δ · μ_l の行は、δ の値が 0 か 1 なので 0 と 1 の交換だけで足りる。
- a + (-a) = 0 が要るのは、Φ をクリフォード代数の普遍性から得る段（Φ の存在と一意性・定義・Φ(a†_i) = c_i・Φ(a_i) = c_i^T）と、
  生成元の反交換関係と平方が零であることを引く局所的な等式だけである。局所的な等式の定義の七つと、番号順の積の分解
  （a_{T,≤m} = z^T_m · a_{T,≤m-1}、a_{T,≤M} = a_T、a_T の分解）は使わない。
- 局所的な等式の行で使う K の性質は、n · n = 1・1 + n = 0（本文の (-1_ℂ)·(-1_ℂ) = 1_ℂ と反交換する二元の入れ替え）、0 + 0 = 0、
  a · 0 = 0（i ∈ T の場合だけ）、ς(N) · n = n · ς(N) である。具体版が ℂ の乗法の交換法則を当てる行は ς(N)·(-1) = (-1)·ς(N) だけである。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない（M = 0 でも同じ証明が通る）。

## 必要十分版が示したこと（章「同型の証明」のクリフォード代数の中の大域的な等式）

- a†_{U,≤m}・P_{≤m}・Q^{T,U}_m・u^S_i の定義、a†_{U,≤m} と P_{≤m} の分解、Q^{T,U}_M = (P (a_T a†_U)) P、a_{T,≤m} a†_{U,≤m} の分解は、
  章「クリフォード代数」の仮定 `CliffordLaws K n` のほかに K の性質を足さない。
- ほかのクリフォード代数の中の主張に要るのは、a + (-a) = 0（生成元の反交換関係と平方が零であることを引くため）だけである。
  行の中で使う K の性質は 0 + 0 = 0（零のスカラー倍・零との積）と、a_i と a†_j a_j の交換の 1 + n = 0・n · n = 1 だけである。
- 部分集合の和の主張（一般の K-代数 B）は、B の乗法の交換法則も K の乗法の性質も使わない。使う K の性質は 0 + 0 = 0 だけで、
  右から掛ける写像が線型結合を線型結合へ移す主張の仮定から来る。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない。

## 必要十分版が示したこと（章「同型の証明」の帰り Ψ と主定理）

- 主定理（Φ と Ψ が互いに逆な代数の準同型であること）の必要十分版の仮定は、`CliffordLaws K n` に a + (-a) = 0 を足したものである。
  `CliffordLaws K n` は、K の加法の結合法則・交換法則・0 の性質・各元の逆元の存在、乗法の結合法則・交換法則・1 · a = a、
  分配法則と、1 + n = 0・n · n = 1 を満たす元 n の組で、実質的に単位元をもつ可換環で -1 に当たる元 n を一つ固定したものである
  （a · 1 = a は乗法の交換法則と 1 · a = a から出る）。a + (-a) = 0 は、K の記号 `-` が加法の逆元を与えることである。
  a + (-a) = 0 は、Φ を普遍性から得る段と、1 の分解・真空で挟んだ元・生成元を掛けた局所的な等式を引く段で使う。
  γ((x, g)) を a†_k と a_k の線型結合に分ける主張は a + (-a) = 0 も使わない。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない（M = 0 でも同じ証明が通る）。
- 乗法の交換法則が行の中で要るのは、Ψ が線型であることの 1 · ρ = ρ · 1 と、Ψ(E_{S,T}) の δ_{S,S'} · δ_{T,T'} の入れ替えと、
  行列単位の積の規則・行列の分解の 0 と 1 の交換だけである。どれも 0 か 1 とほかの元の交換で足りるが、行列環が K の上の代数であることが
  交換法則を要するので、主張全体からは外せない。

## 必要十分版が示したこと（章「同型の証明」の系「行列単位にあたる元はクリフォード代数の基底をなす」）

- 主定理の仮定（`CliffordLaws K n` と a + (-a) = 0）のほかに行の中で使う K の性質は、0 + 0 = 0・1 · 1 = 1・a · 0 = 0・0 · a = 0 と、
  0 と 1 がどの元とも交換することだけである。具体版が ℂ の乗法の交換法則を当てる λ_m · δ_{m,j} = δ_{m,j} · λ_m の行は、δ の値が 0 か 1 なので
  0 と 1 の交換で足りる。
- 2 の可逆性と平方根は、どの主張も使わない。本文の前提 M ∈ ℤ_{≥1} も、どの主張も使わない。

## 必要十分版が示したこと（系「一般の偶数次元の非退化な二次空間」の、等長写像が誘導する準同型）

- 線型写像が基底を動かさなければ恒等写像であることは、係数の性質のうち 0 + 0 = 0 だけを使う。一次独立は使わず、b が張ることだけで足りる。
- L_{b,u} が線型であることと b_j を u_j へ移すことは、係数の一意性の仮定の組 `UniquenessLaws` だけで足りる（乗法の結合法則・交換法則・左分配法則は使わない）。
- 二つの和の和の並べ替えと、等長写像の右逆の線型写像が等長写像であることは、係数の性質を一つも使わない。
- Cl(θ) の存在と一意性、逆向きの等長写像が誘導する準同型の合成が恒等写像であることは、`CliffordLaws K n` と a + (-a) = 0 のほかに K の性質を足さない。
  三つとも q・q' が二次形式であることを使わないので、必要十分版は等長写像の仮定を「θ が線型」と「q'(θ(x)) = q(x)」の二つに分けて置く。

## 必要十分版が示したこと（系「一般の偶数次元の非退化な二次空間」の、直交基底と値が 1 の直交基底）

- 直交基底の存在までは、K の乗法の交換法則も平方根も使わない。
- 2 の可逆性（1+1≠0）は「0 でない二元の積は 0 でない」と組で、B_q(v,v)=(1+1)·q(v) が 0 でないことを出す二か所（第 k+1 元の取り替えと直交化の一歩）だけが使う。
  1≠0 は一次独立な族の元が零ベクトルでないことで要り、0 でない元の逆元は直交化の一歩だけが使う。
- 平方根の存在と乗法の交換法則が要るのは、値が 1 の直交基底の存在だけである。平方根の主張の K の側は、可換な環の性質・i·i=-1・ρ が加法と乗法を保つことだけを使い、
  順序と ℝ の完備性は ℝ だけの主張 (★)（uu−vv=a・2uv=b を満たす u, v がある）の仮定の中に閉じる。
- 「1+1≠0」「i·i=-1」は ℂ の前提の事実で、必要十分版では宣言を置かず、使う主張の仮定にした（導出版も置かない）。
- 互いに直交する族の線型結合での二次形式の値は、加法の性質と a·0=0・0·a=0 だけを使う。

## 必要十分版が示したこと（系「一般の偶数次元の非退化な二次空間」の、等長写像の構成と系の定理）

- K の各元が平方根をもつこと（ℂ では ℝ の完備性への脱出）と、0 でない元の逆元と、Q の非退化性は、値が 1 の直交基底 e を固定する段（`orthonormalBasis`）だけが使う。
  θ・v・θ' の主張と、誘導される準同型で主定理を運ぶ段は、e が三つの条件（基底・直交・値が 1）を満たすことしか使わない。
- 2 の可逆性が要るのは逆向きの写像 θ' の族 v だけで、θ が等長写像であることには要らない。
- i·i = -1 は、族 u の各元での q の値が 1 であることと、θ・θ' が u・v を互いの基底へ移すことに要る。u の異なる二元が直交することは i·i = -1 を使わない。
- 主定理の仮定（`CliffordLaws K n` と a + (-a) = 0）のほかに行の中で足す K の性質は、(-a)·b = -(a·b) と -(-a) = a と、Q が二次形式であることである。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。

## 必要十分版が示したこと（系「奇数次元の二次空間」）

- q' についての主張は、どれも q が q_W であることを使わない（任意の二次形式に一次元を足しても同じ証明が通る）。q' が二次形式であることには K の乗法の交換法則が要る（スカラー倍の行の t'·(λt) = λ(t'·t)）。
- j・g・χ_i・ε・z と、それらの積・交換・反交換の主張は、章「クリフォード代数」の仮定 `CliffordLaws K n` と a + (-a) = 0 のほかに K の性質を足さない。
  -1 の役の n に要るのは n·n = 1 と n + 1 = 0 だけで、z·z = 1 は g·g = 1 と ε·ε = 1 だけから出る。
- 二つの ℂ-代数の直積が ℂ-代数であること、⟨φ1,φ2⟩ が準同型であること、C_y が部分代数であること、生成する部分集合で交換すれば全体と交換することは、K の性質を一つも使わない。
  反交換する平方 1 の元の倍を足した元の平方の主張が使うのは、s ∗_A 0_A = 0_A の行の 0 + 0 = 0 と a·0 = 0 だけである。
- φ'・Φ' とその値（Φ' ∘ j、Φ'(g)、Φ'(z)、Φ'(e_σ)）は、K の乗法の交換法則も 2 の可逆性も使わない。
- 2 の可逆性（h·(1+1) = 1）が要るのは、e_σ·e_σ = e_σ、e_+ + e_- = 1、e_+ − e_- = z の三つだけである。e_σ·e_{-σ} = 0、e_σ が中心に入ること、Φ'(e_σ) は h が K の任意の元でも通る。
  1 + 1 ≠ 0 そのものと (1+1)·h = 1 は、どの主張も使わない。
- Ψ' が準同型であること・Φ' ∘ Ψ' = 恒等写像・Ψ' ∘ Φ' = 恒等写像は、e_± の性質（平方・積・和・差・中心に入ること）を仮定に置くと 2 の可逆性なしで通る。
  系の段の仮定 h·(1+1) = 1 は、どれも e_± を作る段（平方・和・差、Φ'(e_±) の値）から来る。行の中で足す K の性質は 0 + 0 = 0、a·0 = 0、1 + (-1) = 0、
  -n = 1、1 + n = 0、a·n = -a だけで、K の乗法の交換法則は使わない。
- 本文の前提 M ∈ ℤ_{≥1} と、主張の「i ∈ {1,…,M}」（g と j(χ_i) の交換）・「σ ∈ {1,-1}」（e_σ の交換と Φ'(e_σ)）は、証明が使わないので仮定に置かない。

## 必要十分版が示したこと（系「複素行列版イジングの Jordan–Wigner 行列への接続」の前半）

- K と K' が互いの逆であること（したがって U と U' が互いの逆であること）に要る 2 の可逆性は (1 + 1) · h = 1 の片側だけで、準備 h + h = 1 の一か所から来る。
  Φ_Y が e_m・e_{M+m} を送る先（c_m + c_m^T、(-i) ∗ c_m + i ∗ c_m^T）は 2 の可逆性を使わない。Ω' を作る段（Ψ_Y）だけが h · (1 + 1) = 1 も使う。
- i · i = -1 は、この節のどの行も使わない。σy・Y_m と K G' = σy K は i が K のどの元でも成り立ち、i · i = -1 は Φ_Y を作る段（θ が等長写像であること）から来るだけである。
- {1,2} の行列の等式（K K' = 1、K' K = 1、K σz = σx K、K G = σz K、K G' = σy K）と非対角の行列単位の線型結合の成分は、K の乗法の交換法則を使わない。
  具体版の「ℂ の四則」の行で要るのは、0・1・-1 との積の規則（a · 0 = 0、0 · a = 0、a · 1 = a、1 · a = a、(-a) · b = -(a · b)、a · (-b) = -(a · b)）と
  -(-a) = a、a + (-a) = 0 だけである。乗法の交換法則が要るのは、クロネッカー積の積の主張と行列の積の結合法則を経由する U・U' と Z_m・Y_m の主張からである。
- σz の対角成分の部分積が ς(N_i(T)) であることには、σz の (2,2) 成分 -1（加法の逆元）と ς を定める n が等しいこと（-1 = n）と、-1 がどの元とも交換することが要る。
  -1 = n は、章「クリフォード代数」の仮定 `CliffordLaws K n`（1 + n = 0 と加法の公理）と a + (-a) = 0 から出る（`neg_one_eq_n`）。
- c_m^T のクロネッカー積による表示の δ_{1,a} · δ_{2,b} = δ_{2,b} · δ_{1,a} の行は、0 と 1 の交換で足りる。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない。σz の部分積の主張は i ≤ M を使わない。

## 必要十分版が示したこと（系「複素行列版イジングの Jordan–Wigner 行列への接続」の後半）

- σ^a_k・F^{(b)}_{m,j} の定義と、ν_{r_M}(Z_m) = Z^{(2^M)}_m・ν_{r_M}(Y_m) = Y^{(2^M)}_m の証明の場合分け（（一）と（二））、
  番号で添字づけたクロネッカー積への付け替え、番号順の積の因子ごとの等号は、K の性質を一つも使わない。
- K の性質（L・乗法の交換法則・a · 0 = 0）は、Mat_{P_M}(K) と Mat_{1,…,2^M}(K) を K-代数にすることから来る。行の中では、
  一つの因子だけを残したクロネッカー積の番号順の積の主張と、ν_{r_M} が番号順の積を保つこと（K-代数の準同型であること）の二行が使う。
- Y^{(2^M)}_m の主張は i が K のどの元でも成り立つ（i · i = -1 を使わない）。σ^a_k を a ∈ {x, y, z} の全体で一度に定めるので、
  必要十分版の F^{(b)}_{m,j}・Z^{(2^M)}_m も i を引数にとるが、値は i によらない。
- Ω̂・Ω̂' と系の定理は、前半の Ω・Ω' と系の定理が要する K の性質に何も足さない。ν_{r_M}・μ_{r_M} が互いの逆であることは K の性質を使わず、
  準同型であることに要る性質は `CliffordLaws K n` の欄にある。
- 本文の前提 M ∈ ℤ_{≥1} と、ν_{r_M}(Z_m) = Z^{(2^M)}_m・ν_{r_M}(Y_m) = Y^{(2^M)}_m の m ∈ {1,…,M} は、どの証明も使わない。
  Ω̂ の二つの主張が m ∈ {1,…,M} を要するのは、前半の Ω の主張（c_m を作る）からである。
