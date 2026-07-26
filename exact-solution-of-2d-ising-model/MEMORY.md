# MEMORY — exact-solution-of-2d-ising-model

## 完了（2026-07-26）: 転送行列 V1/V2 の定義と共役作用 T_g / T_V を Lean で形式化

新規ファイル 2 つ（`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

- `lean/Ising2D/Part004/Definition010_H1H2V1V2.lean`
  - `H1 η`（`Y_m Z_{m+1}` の和、最終項の符号を `η : ℂ` で持つ）と `H2`。
    site 添字の巡回は `Fin M` の加法（`NeZero M` を要求する）を避け、
    自前の `nextSite m = ⟨(m+1) % M, _⟩` で表す（`M` に追加仮定を置かないため）
  - `V1`, `V1half`, `V2`（`(2s_2)^{M/2}` は `Real.rpow`）と、その可逆性
    （`V1Units` / `V1halfUnits` / `V2Units`。`V_2` のスカラー因子が 0 でないために `s_2 > 0` が要る）
- `lean/Ising2D/Part008/Definition016_TV.lean`
  - `TConj g`（原文 `def_T_g`）を **ℂ-代数自己同型**として構成（既存の
    `Ising2D.Conjugation.*` を再利用し、`commutes'` だけ足した）
  - `TV g1 g2`（原文 `def_T_V`）と `TV_eq_TConj : T_{(V)} = T_{g_1 g_2 g_1}`、
    ℂ-線型性・乗法性・単位性
  - 行ベクトル記法 `(T z, T y) = (z, y) B` の述語 `ActsBy` と合成則 `ActsBy.comp`、
    および**固有ベクトル移送の一般補題 `ActsBy.eigen`**（後段で ψ が V の固有ベクトルで
    あることを導く鍵）
  - 行列等式 `B_1(θ) B_2 B_1(θ) = A(θ)` を証明（`B1_mul_B2_mul_B1_eq_Amat`）
  - 原文 `T_V_hatZ_hatY` は、`B_1`, `B_2` の作用（`parts 008` の 001〜005 のテイラー係数
    抽出に依存し未形式化）を**明示的な仮定 `hT1`, `hT2`** として持つ定理
    `TV_hatZ_hatY_of_action` の形で述べた。仮定から先は完全に証明済み

### 形式化で見つかった原文の問題（原文は書き換えていない）

1. **`V_2` の 2 つの表式の一致が未説明。**
   `transfer_matrix_001_definition_symbols` は `V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^*(σ^x_1+⋯+σ^x_M))`、
   `transfer_matrix_011_definition_H1_H2` は `V_2 = (2s_2)^{M/2} exp(√-1 K_2^* H_2)` と書くが、
   一致には `√-1 Z_m Y_m = σ^x_m`（`Z_m Y_m = -√-1 σ^x_m` から従う）が要る。原文は「よって、」
   とだけ書いて根拠を示していない。Lean では `I_smul_H2_eq_sum_sigmaX` として補って証明した。
2. **`A(θ)` に `c_2` が現れるのに、その出所（双対関係）が明示されていない。**
   `def_A_theta` の非対角成分は `s_2^*(c_1 cos θ ∓ i sin θ - s_1 c_2)` だが、
   `B_1(θ) B_2 B_1(θ)` を計算して同じ位置に出るのは `c_2^*` である。両者が一致するには
   `c_2^* = s_2^* c_2`（`sinh 2K_2 · sinh 2K_2^* = 1` から従う）が必要。原文は
   `def_A_theta` でも `T_V_hatZ_hatY` の証明でもこの等式に触れていない。
   Lean では `B1_mul_B2_mul_B1_eq_Amat` の仮定 `hdual : s_2^* c_2 = c_2^*` として明示した。
3. **`(V_1^{(±)})^{1/2}` の意味が未定義。** 原文は `exp(X)^{1/2}` を無断で `exp(X/2)` と
   読み替えているが、一般に行列の平方根は一意でない。Lean では `V1half := exp(X/2)` を定義とし、
   `V1half_sq : V1half^2 = V1` を証明して「平方根であること」を確認した。

## 完了（2026-07-25）: データモデルの穴を塞いだ（本文ブロックは注記欄を持てない）

ノート分離の狙いは「最終成果物は content のみから生成するので、ノートは構造上混入しない」こと。
ところが**本文ブロック側に注記欄（`notes`）が残っており、ビューアも描画していた**（使用は0件だが、
書けば出版物へ漏れる経路）。これを塞いだ。

- `structured-latex/schema.mjs`: 本文ブロックの `notes` を**明示的に拒否**（エラーメッセージで
  「参照用は notes/ へ、出版本文で述べる必要があるものは statement/proof へ」と誘導）。負テスト済み。
- `schema.d.ts` と ビューアの契約（`realtime-web-preview/domain-model/src/block.ts`）からも型を削除。
- ビューアの本文カードから注記欄の描画を削除（参照用ノートの表示は別経路で維持）。

### データモデル（確定形）

- **文書本体** `content/*.mjs`: ブロックの配列。**並びが文書順の正準表現**。
  共通フィールドは id / kind / sourcePath / sourceOrdinal / title / **labels** / conversion。
  定理型は + statement, proof。見出しは + level（本文を持てない）。**注記欄は持てない。**
- **参照用ノート** `notes/*.mjs`: id / **targets（紐づけ先ラベル、1件以上必須）** / title / sourcePath / body。
- ノード（本文の中身、両者共通）: text / math / displayMath / paragraph / list / **ref** / todo。
- 紐づけは**ノート → 本文の一方向**で、**ラベル**で指す（パス非依存）。数値検証との対応も同じくラベル基準。

### 残っている検討事項

`kind` に `note` / `remark` が残っているが content では**使用0件**（heading 10 / theorem 14 /
definition 50 / claim 72）。出版物の Remark 環境として将来使う余地はあるが、
「不要な構造を持ち込まない」方針からは削除候補。判断待ち。


## 完了（2026-07-25）: Phase 3 継続 — 線型独立性・離散フーリエ変換（hatZ/hatY）・その反交換関係を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 **84 件**が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル（人手証明の正本は `structured-latex/content/004_transfer_matrix.mjs` ほか）

| Lean | 人手証明（ラベル） |
| --- | --- |
| `lean/Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean` | `004/001`（`<Z_Y_linearly_independent>`。**形式化時点では原文が TODO**） |
| `lean/Ising2D/Part004/Claim008_ExpSum.lean` | `004/008`（`<exp_sum>`）＋ `004/007` の `δ^M` |
| `lean/Ising2D/Part004/Definition009_HatZHatY.lean` | `004/009`（`<def_hatZ_hatY>`） |
| `lean/Ising2D/Part004/Claim012_HatPeriodicity.lean` | `004/012`（`<hatZ_hatY_M_periodicity>`） |
| `lean/Ising2D/Part004/Claim013_RecoverZY.lean` | `004/013`（`<recover_Z_Y_from_hatZ_hatY>`） |
| `lean/Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean` | `007/000`（`<anticommutator_of_hat_Z_and_hat_Y>`） |

既存の `Part000/Claim046_...` へ、反交換子の双線型性（有限線型結合の展開）を補助補題として追加した。

### 形式化した命題（主なもの）

- **線型独立性**（形式化時点で原文は「TODO: 証明略」。その後、別セッションが
  `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底を使う人手証明を追記している）: Lean 側は
  `{Z_μ, Y_ν}` が Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たすことから、
  `∑ g_a e_a = 0` と `e_b` の反交換子をとって `2 g_b I = 0` を出す、という 3 行の議論で済んだ。
  既存の `Z_Y_generate_algebra` も `matrixUnitBasis` も不要だった。
- **離散フーリエ変換**: 位相因子 `expPhase M k = exp(-√-1·2πk/M)`（`k : ℤ`）を定義し、
  `expPhase M k = 1 ⟺ M ∣ k` を mathlib の `Complex.isPrimitiveRoot_exp` +
  `IsPrimitiveRoot.zpow_eq_one_iff_dvd` に帰着。`<exp_sum>` は原文どおり (a) 全項 1、
  (b) 等比和 `geom_sum_eq` の 2 ケースで証明。
- `hat(Z)_μ^{(±)}`, `hat(Y)_μ` の定義。`(±)` の符号は `j = 1` の項の係数 `η : ℂ` として持たせ、
  以降で効くのは `η² = 1` だけであることを明示した（`hatZPlus = hatZ (-1)`, `hatZMinus = hatZ 1`）。
  `M` 周期性は原文の特殊値 `μ = ±M` ではなく一般の `μ ∈ ℤ` で証明し、原文の主張を系として得た。
- **逆変換（復元）**: `Z` と `Y` で証明が同一なので、任意の族に対する `inverse_dft` を先に証明して
  両者を特殊化した。これにより「原文が `hat(Z)^{(-)}`（一様和）でしか復元を述べない理由」も明確になる
  （`hat(Z)^{(+)}` は `j = 1` の重みが `-1` なのでこの形の逆変換は成り立たない）。
- **`hat(Z), hat(Y)` の反交換関係 4 式すべて**（原文は後ろ 2 つを「同様」として省略）。
  原文の二重和展開を、(1) 反交換子の双線型性 → (2) `[Z_j,Z_k]₊ = 2Iδ_{jk}` で対角項だけ残す →
  (3) `<exp_sum>` を適用、の 3 段に整理した。

### 添字づけの規約（重要・以降も踏襲する）

原文のサイト添字は `1, …, M`、Lean は `Fin M`（`0, …, M-1`）。**原文の `j` は Lean の `(j : ℕ) + 1`。**
したがって位相因子は `expPhase M (((j : ℕ) + 1) * μ)` と書き、原文の「`j = 1` の項」は
Lean の `(j : ℕ) = 0` の項である。`hat` の添字 `μ` は `ℤ` のまま扱う（原文の `ℳ = {-M,…,-1,1,…,M}` は
定義式の意味には不要で、`M` 周期性も `μ ∈ ℤ` で成り立つ）。

## 完了（2026-07-25）: 出版を見据えたノートの分離（本文＝出版対象、ノート＝参照用）

構造化テキスト化の狙いは最終的に**論文・書籍**にすること。そこで
**「文書本体には出版に載るものだけを置き、ノートは別置きにしてラベルで紐づける」**構成にした。
最終成果物の生成は `content/` だけを読むので、**ノートは構造上いっさい混入しない**
（フラグの付け忘れで漏れる事故が起きない設計）。

- **原則: 「正しさに必要ならそれは注記ではない」。** 定義が意味をもつ条件・well-defined 性・
  主張から従う数学的帰結は `statement`（証明中の事柄なら `proof`）へ。補足計算・具体例・参考公式・
  原文由来のメモ・物理的解釈・先行研究との比較は `notes/` へ。
- **格上げ 5 件**（注記 → 本文）: 直交座標写像の well-defined 性 / フェルミオンは γ₂≠0 のときのみ定義
  （臨界点では ψ_M が存在しない）/ V' の和の限定で一般性を失わないこと / X の各項の well-defined 性
  （proof 冒頭へ）/ γ₂(θ_M)=0 ⟺ Ising 臨界点。
- **移設 16 件**（→ `structured-latex/notes/`、4ファイル）。本文が移設前とノード列レベルで完全一致することを
  機械確認済み（要約・圧縮なし）。独立していた注記ブロック2件も移設し、本文は 142→140 ブロックに。
- 事前判定から変えたもの: テンソル基底定理と平方根の3件は「statement で正しさが完結しており、注記は
  読み方・特殊化にすぎない」ため格上げせず移設。逆に直交座標写像の well-defined 性は格上げに追加。
- **検証**: `validate-content` が notes も検査し、**targets（紐づけ先ラベル）の未解決はエラーで落とす**。
  現在 140ブロック・ラベル78・参照143 全解決 / ノート16件・targets 16 全解決。
- ビューアはノートを紐づけ先ブロック内に折りたたみ（琥珀色の破線）で表示し
  「参照用ノート・最終成果物には載りません」と明示。ノートが無くても動作する（ドメイン非依存を維持）。
- 描画確認: 数式1655件エラー0・リンク切れ0・注記の非掲載明示が33箇所。

**非移行のまま**: 旧 main.typ 末尾の作業ログ134行（日付つき作業記録・デバッグ試行・数値スニペット）は
引き継ぎメモとタスク管理に置き換わっているため `_old/typst/` に残置。

## 完了（2026-07-25）: Typst を廃止し `_old/typst/` へ温存退避（証明の正本が構造化TeXへ）

**証明の正本は `structured-latex/content/`（142ブロック）になった。** Typst 一式
（`main.typ` / `theorem.typ` / `parts/` 130ファイル）は削除せず `_old/typst/` へ退避し、
参照用に**温存**する（削除候補ではない。破棄は改めて判断する）。

- 退避先 `_old/typst/README.md` に、温存の趣旨・現在の正本の所在・「ここを直しても正本には
  反映されない」旨を明記。**退避先で `typst compile main.typ` が成功することを確認済み**
  （作業ディレクトリをそこにすれば `parts` への相対パスがそのまま効く）。
- 出自パスを新所在へ一括更新（構造化TeX の `sourcePath` 131件 + 見出し10件、数値検証の
  overview 6件）。**全130種の出自パスが実在することを機械確認**。
- リポジトリ直下 `CLAUDE.md` のプロジェクト構成を更新（Typst 前提 → 構造化TeX 前提。
  「相互参照・数値検証の対応はラベルで張る」「変更したら通す検証コマンド3種」を明記）。
- 移行の健全性: `validate-content` 142ブロック・ラベル72・参照144全解決 /
  `verify-check-linkage` 6件 / ビューア描画 数式1659件エラー0・リンク切れ0。

### 今後の作業場所（重要）

証明の修正は**必ず `structured-latex/content/` 側**に入れる。`_old/typst/` は更新しない。

## 完了（2026-07-25）: Phase 3 継続 — 転送行列の記号定義・Z/Y の反交換関係・生成定理を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 43 件が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル

| Lean | 人手証明 |
| --- | --- |
| `lean/Ising2D/Part000/Claim046_CommutatorViaAnticommutators.lean` | `000/046`（`<commutator_via_anticommutators>`） |
| `lean/Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` | `004/000`（`<def_transfer_matrix_symbols>`） |
| `lean/Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` | `004/014`（`<Z_Y_generate_algebra>`） |
| `lean/Ising2D/Part006/Claim000_AnticommutatorZY.lean` | `006/000`（`<anticommutator_of_Z_and_Y>`） |

### 形式化した命題（主なもの）

- `[a b, c] = a [b,c]₊ - [a,c]₊ b` を**任意の環**で（`Ising2D.commutator_via_anticommutators`）。
  反交換子 `Ising2D.acomm` は mathlib に無いので自前定義。交換子は mathlib の Lie 括弧と一致することも示した。
- Pauli 行列 `pauliX/Y/Z` と積公式（mathlib に Pauli 行列は**無い**ので自前）。
- サイト局所作用素 `siteOp k : Mat(2,ℂ) →ₗ[ℂ] TensorPow M`。
  `siteProd`（既存）の多重線型性から `MultilinearMap.toLinearMap` で作ったので、線型性はタダで付く。
  `sigmaX/sigmaY/sigmaZ`、同サイトの積 `siteOp_mul_same`、異サイトの可換性 `siteOp_mul_comm`。
- Jordan–Wigner 文字列 `Z m`, `Y m`（`m : Fin M`、0 始まり）、`xString`（`P_m = σ^x_1⋯σ^x_m`）、`epsilon`。
  原文が場合分けで書く `Z_1 := σ^z_1` は、空文字列 `xString M 0 = 1` から自動で従う（特別扱い不要）。
- **反交換関係 3 式すべて**: `anticomm_Z_Z`, `anticomm_Z_Y`, `anticomm_Y_Y`（原文は後ろ 2 つが TODO）。
  核は `siteProd_anticomm_of_single_site`（1 サイトだけ反可換ならテンソル積は反交換）。
  原文の「サイト μ の因子だけ符号が違う」という計算を、`MultilinearMap.map_smul_univ`
  （各サイトのスカラーがテンソル積の外へ ∏ で出る）で一般化した。
- **`Z_Y_generate_algebra`**: `Algebra.adjoin ℂ ({Z_m} ∪ {Y_m}) = ⊤`。
  原文 Step 2（帰納法）はそのまま写した。Step 3 だけ経路が違い、原文の `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底ではなく
  既存の**行列単位基底** `matrixUnitBasis` を使った（どちらも `<tensor_basis>` の帰結で論法は同じ）。

### 形式化で表面化した原文の要修正点（新規）

- **`004/000` の `ε` の定義式が誤り**。`ε := σ^x_1 ⋯ σ^x_M = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の
  右辺は**和ではなく積** `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`。
  根拠: `Z_m Y_m = σ^z_m σ^y_m = -√-1 σ^x_m`（Lean: `Ising2D.Z_mul_Y_same`）なので積なら一致するが、
  和だと `M = 2` で `(√-1)^2 (Z_1Y_1 + Z_2Y_2) = √-1 (σ^x_1 + σ^x_2) ≠ σ^x_1 σ^x_2` となり反例になる。
  Lean 側は `ε := σ^x_1⋯σ^x_M`（左辺）を定義とし、積表示の再帰形 `xString_succ_eq` まで証明済み。
- **`006/000` の証明が未完（TODO 2 箇所）**。`[Z_μ,Y_ν]₊` と `[Y_μ,Y_ν]₊` の計算が原文に無い。
  Lean 側で 3 式とも証明したので、原文へ書き戻すべき。
  なお `[Z_μ,Y_ν]₊ = 0` は `μ = ν` でも成立する（`σ^y σ^z = -σ^z σ^y` で対角も消える）。

### 次にやること（Lean 側）

1. `004/001`（`Z_m, Y_m` は線型独立）— `Z_Y_generate_algebra` と `matrixUnitBasis` が使える。
2. `004/009` の `hat Z, hat Y` と `007`（その反交換関係）— `siteProd_anticomm_of_single_site` がそのまま効く。
3. `004/002`（`V_1 V_2` を `Z, Y, ε` で表す）— `V_1, V_2` の定義自体がまだ未形式化。
   `matExp` と `sigmaZ`/`sigmaX` で定義するところから。
4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。順序つき積（`List.prod` / `Finset.noncommProd`）の整備が要る。

## 完了（2026-07-25）: Phase 3 着手 — Lean 4 + mathlib4 の基盤構築と最初の formalization

実体は `lean/`。セットアップ手順・人手証明との対応規約・表現方針の根拠は `lean/README.md` に集約した。
**このセッションでは commit / push をしていない**（`lean/` 配下は作業ツリーに未コミットで存在）。

### 環境（バージョン固定済み）

- elan を新規導入（`~/.elan`）。`lean/lean-toolchain` = `leanprover/lean4:v4.32.1`。
- mathlib4 を **同名タグ `v4.32.1`** に固定（`lean/lakefile.toml` の `rev`、`lean/lake-manifest.json`）。
  toolchain とタグを揃えないとビルド済みキャッシュが効かないので、更新時は必ず両方同時に変える。
- `lake exe cache get` → `lake build` 成功（2405 jobs）。`.lake/` はリポジトリ直下 `.gitignore` で除外済み。

### `Mat(2,ℂ)^{⊗M}` の表現 — **行列表現を採用（最重要の設計判断）**

| | Lean での型 | 実装名 |
| --- | --- | --- |
| 採用 | `Matrix (Fin M → Fin 2) (Fin M → Fin 2) ℂ` | `Ising2D.TensorPow` |
| 比較 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.AbstractTensorPow` |

**両者の ℂ-代数同型を証明済み**（`Ising2D.tensorPowAlgEquiv`）。同型写像は
`⨂ₜ x ↦ [(s,t) ↦ ∏ᵢ (xᵢ)_{s(i)t(i)}]`（= Kronecker 積）。構成は `PiTensorProduct.liftAlgHom` +
`Basis.piTensorProduct` と行列標準基底の突き合わせ。したがってどちらの表現で述べた命題も移送できる。

採用根拠（実際に両方書いて確認した事実）:

1. **抽象テンソル冪には `NormedRing` インスタンスが無く `NormedSpace.exp` が使えない**
   （`infer_instance` が失敗することを確認）。`V_1, V_2` が `exp` を含む本プロジェクトでは致命的。
   行列表現なら `Mathlib.Analysis.Normed.Algebra.MatrixExponential`（`Matrix.exp_units_conj` 等）が直接使える。
2. `<centralizer_is_scalar>`（`002/003`）が mathlib の `Matrix.center_eq_scalar_image` に帰着して数行で済む。
   人手証明の 4 ステップ（基底展開→積公式→係数比較→結論）が丸ごと既存で賄える。
3. 添字型 `Fin M → Fin 2` がスピン配置そのものなので、サイト局所演算子 `σ^x_k` 等を
   Kronecker 積の再帰なしに書ける。`Fin (2^M)` を使うと `finFunctionFinEquiv` の添字変換が散らばる
   （必要なら `Matrix.reindex finFunctionFinEquiv` で移せる）。
4. 行列式・跡・固有値・`Matrix.reindex` が全部使える（`008` の対角化 `P_μ, D_μ` で必要）。

### 形式化した命題（`sorry` 0。`lean/scripts/check-no-sorry.sh` で機械確認）

- `<tensor_basis>`（`002/000`）→ `Ising2D.tensorPowBasis` / `matTensorPowBasis`。
  mathlib の `Basis.piTensorProduct` に完全に帰着（自前で積んだ部分は「テンソル冪への特殊化」のみ）。
- `<conjugation_is_ring_homomorphism>`（`000/045`）→ `Ising2D.Conjugation.T_mul/T_one/T_add/T_comp/TMonoidHom`。
  mathlib の `MulSemiringAction (ConjAct Rˣ) R` に帰着（加法性まで込みで環準同型が出る）。
  原文の `Matrix.inv` 記法版も `matrix_conj_mul/one/comp` として併記。
- `<scalar_identity_commutes>`（`002/001`）→ `Ising2D.scalar_identity_commutes`。
- `<centralizer_is_scalar>`（`002/003`）→ `Ising2D.centralizer_is_scalar`（抽象側へ移送した版も併記）。
- 補助: 行列単位の積公式 `E_IJ E_KL = δ_JK E_IL`（`Ising2D.E_mul_E`）、`I = Σ_P E_PP`（`one_eq_sum_E`）、
  `exp(U A U⁻¹) = U (exp A) U⁻¹`（`matExp_units_conj`）。

### 形式化で表面化した原文の要修正点

- **`002/000`（`<tensor_basis>`）のステートメントが不正確**。
  (a) 「各 `(i_1,…,i_m)` について `e_{i_1}⊗⋯⊗e_{i_m}` **は基底である**」は誤り。基底なのは**族全体**。
  (b) 添字 `m` を「`V` の次元」と「テンソル冪の階数」に二重使用している（独立な量なので分離が必要）。
  Lean 側では修正版（基底の添字集合 `ι`、階数 `M` を分離し、族が基底）を形式化してある。
- **`000/045` Step 3 の正則性仮定は冗長**。合成則 `T_A ∘ T_B = T_{AB}` は
  `Matrix.mul_inv_rev`（mathlib では特異行列込みで成立）から仮定なしに従う。

### 次にやること（Lean 側）※ 1–3 は上の「Phase 3 継続」で完了済み

1. ~~`000/046`（交換子と反交換子の恒等式）~~ → 完了。
2. ~~`004/000` の記号定義と `006`（Z,Y の反交換関係）~~ → 完了。
3. ~~`004/014`（`Z, Y` が環として生成）~~ → 完了。
4. leanblueprint の導入検討は Phase 2（構造化TeX 移行）の完了状況を見てから。
5. mathlib に無いことが分かっているもの: `Real.arccosh`（自前定義が必要）。
   `Ad(exp X) = exp(ad X)` は `005/003, 007` の級数展開ルートで回避可能。

## 完了（2026-07-25）: Phase 2 T3/T4b — 章見出し・文書順・記号表を構造化TeXへ移行

`main.typ` にしか無かった「章題」「文書順」「インライン記号表」を `structured-latex/content/` へ移した。
これで証明本体で main.typ にしか無い情報は無くなった（残るは作業メモのみ。非移行と確定）。

- **schema に `heading` ブロックを追加**（`structured-latex/schema.mjs` / `schema.d.ts`）。
  `kind: "heading"` + `level`（1 が最上位。Typst の `=` が 1、`==` が 2）+ 必須 `title`。
  本文（statement/proof/notes）は持てない。ビューア側の契約
  （`realtime-web-preview/domain-model/src/block.ts`）も `kind` による discriminated union に更新し、
  `frontend/.../ui/heading-view.tsx` で描画。タイトルの `tex` を KaTeX で描く `TitleView` を追加
  （従来はブロックタイトルの LaTeX ソースが生文字列で表示されていた）。
- **文書順の正準表現＝ブロック配列の並び**（`content/*.mjs` をファイル名昇順 → 各ファイル内は配列順）。
  旧 `main.typ` の `#include` 順と完全一致することを機械照合済み（130 include / 130 sourcePath、差分0）。
  `sourceOrdinal` は「parts 章内でのソースファイル通し番号」であり文書順ではない。
  002章（000,001,**003,002**）と 008章（017 の直後に **036**、031 の後は 034,035,033,032,037,044,041,042,
  038,039,040,043）を実文書順へ並べ替え。008 の content 2ファイルは連番範囲で命名できなくなったため
  `008_TV1_hatZ_hatY_part{1,2}.mjs` へ改名。
- **記号表**: main.typ のインライン `#definition("記号の定義")` は `parts/004_転送行列/000`
  （`def_transfer_matrix_symbols`）との重複だった（相違は双対関係注記の旧版 `sinh(K)sinh(K*)=1` のみで、
  P1-1 で `sinh(2K)sinh(2K*)=1` に訂正済み）。重複ブロックは作らず、インライン側にのみ在った
  σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, Z_m/Y_m の p_m/q_m 対応を既存ブロックへ補記して集約。
- **非移行（確定）**: main.typ 末尾の作業メモ（`= 全体のノリ` / `= メモ` / 「次回やること」と
  埋め込み SageMath スニペット）は証明本体でないため移さない。
- 検証: `node structured-latex/tools/validate-content.mjs` → 142ブロック/14ファイル（見出し10・ラベル72・
  ref142 全解決）。`pnpm -r build` / `pnpm -r typecheck` / `biome check` 通過。KaTeX 全1647式 0エラー。
  `GET /api/document` で見出し10件が文書順に配信されることを確認。

## 完了（2026-07-22）: Phase 1 方針B — per-μ γ₂≠0 限定でフェルミオン定義域を厳密化

`docs/tasks/2026-07_toolchain-and-rigor` Phase 1 を Typst 上で完了。方針は **大域非臨界仮定（方針A）を採らず、per-μ の `γ_2(θ_μ)≠0` 条件で限定**。041/042 は削除せず γ₂=0 モードのカバレッジを保持。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。**push はしていない**（ブランチ worktree-cozy-sparking-token に未コミットで保持）。

変更/追加ファイルと要点:
- `parts/004_転送行列/000`: 双対注記を `sinh(2K_i)sinh(2K_i^*)=1` に訂正（旧 `sinh(K_i)sinh(K_i^*)=1` は誤り。K_i^*=-1/2 log(tanh K_i) と整合するのは 2K_i 版）。
- `008/023`（`<arg_of_gamma_2_mu>`）: 前提「γ₂(θ_μ)≠0 なる μ」を追加。末尾 `<0` を `|γ_2(θ_μ)|²=(s_2^*)²·((c_1cosθ_μ-s_1c_2)²+sin²θ_μ)` 経由で B>0 を明示して正当化し、負の実数ゆえ arg=π で claim を閉じた（従来は dangling）。
- `008/024`: 前提「γ₂(θ_μ)≠0」を追加（arg は非零でのみ定義、relation_of_gamma_2 で両者同値を明示）。
- `008/029`（`<def_fermi>`）: ψ_μ, ψ_μ^† を **γ₂(θ_μ)≠0 なる μ にのみ定義**と本体で限定。#note で「γ₂(θ_μ)=0（021 より μ=±M かつ臨界 c_1=s_1c_2、= 043 の Ising 臨界点 sinh2K_1 sinh2K_2=1）では正規化 1/γ_2(-θ_μ) が不能で **ψ_μ は存在しない**」を明記。臨界の μ は 041/042 場合2で hatZ,hatY 経由で直接処理。
- `008/030`,`031`,`037`: ステートメントを γ₂(θ_μ)（031 は γ₂(θ_ν) も）≠0 の μ,ν に限定。037 の X の和も 032 と同じ限定和に更新。特定される ν が限定和の添字集合に属することを明示。
- `008/032`（`<def_Vprime>`）: V' の和を `sum_(mu in {1..M} : γ_2(θ_mu)≠0)` に限定。除外 μ（臨界 μ=M）は 041 Step1 より γ(θ_μ)=0 ゆえ寄与なしを note で明示（041 の旧「規約」依存を解消）。
- `008/041`: 冒頭 #note の「係数0で項を落とす規約」を撤去し「032 の定義で和は γ₂≠0 の ν のみ」に変更。X を限定和に。Step 3 の場合分け「(i) γ(θ_ν)=0」を撤去（限定和では常に γ₂(θ_ν)≠0 ⟹ ψ_ν,ψ_{-ν} 定義済み、Step 2 対偶で δ=0）。Step 2 見出しの結論を γ_2(θ_ν)=0（ゆえに γ(θ_ν)=0）に。
- `008/044`（新規, `<A_theta_is_identity_when_gamma2_zero>`）: 小補題「γ₂(θ_μ)=0 ⟹ A(θ_μ)=I」を証明追加（γ₂(θ_μ)=0 ⟹ γ₂(-θ_μ)=0 [022] かつ det [034]+γ₁≥1 [035] で γ₁=1 ⟹ A=I）。main.typ に 037 と 041 の間で #include。042 場合2の A=I 裏打ちを 027（proof 無し）から本補題へ張り替え。026 の「TODO: 証明」コメントと 027 の A=I も本補題を #ref するよう更新（044 は 016/022/034/035/036 のみ依存、026/027 非依存ゆえ循環なし）。
- `038`/`039`: ステートメント不変。042（全 μ∈cal(M) で両場合カバー）+ 013（全 μ の DFT）経由で臨界含め全 x で成立を維持（compile・ref 解決で確認）。

未着手/TODO 保持:
- `021`（`<gamma_2_theta_is_0>`）と `043`（`<critical_condition_c1_eq_s1_c2>`）の proof は本 Phase では TODO 保持（方針Bの厳密性には非必須）。
- SageMath 数値再検証（X-1）は横断タスクとして継続（今回の変更はステートメント限定と補題追加が主で、030/037/038/039 の数値結論は不変のはず）。

## 進行中（2026-06-27）: 臨界点と γ₂(θ_M)=0 / V' 定義の穴のトレース

- 新規 claim `008/043`（`<critical_condition_c1_eq_s1_c2>`）: `c_1 = s_1 c_2 ⟺ s_1 s_2 = 1`（= Ising 臨界条件 sinh2K_1 sinh2K_2=1）。**proof は TODO**。数値確認済み（c_1=s_1c_2 の曲線上で sinh2K_1 sinh2K_2=1.0000）。
- これにより `γ_2(θ_M)=0`（θ_M=2π、021 `<gamma_2_theta_is_0>` で μ=±M かつ c_1=s_1c_2）⟺ **臨界点**。すなわち ψ_M が def_fermi で未定義になる特異点は臨界点そのもの。
- **「臨界点を除かないと議論できない」最初の箇所のトレース**:
  - 026（A(θ) 固有値・固有ベクトル）: γ₂=0/≠0 で場合分け済み、全 μ で OK（γ₂=0 では A=I）。
  - **027（P_μ, D_μ）が最初に明示的に `γ_2(θ_μ)≠0` を要求**（正規化 c=1/(2√M γ₂(-θ_μ)) に 1/γ₂）。臨界では μ=M で破れる。
  - 029（def_fermi）: ψ_μ を P_μ 経由で定義 → ψ_M が臨界点で未定義。
  - 030/031/037: 「μ∈cal(M) 全体」と称するが proof は ψ/P_μ 経由 → 実質 γ₂≠0 のモードのみ（臨界では μ=M を暗黙除外、ステートメントが過剰に広い）。
  - **032（V' 定義）で和 Σ_{μ=1}^M が μ=M を含むため、臨界点では V' という対象自体が大域的に未定義** = ここから議論が成立しない。038/039 はこれを継承。
- 対処方針（未着手）: 032 の和を「γ_2(θ_μ)≠0 の μ」に限定し非臨界の主張として閉じる / 臨界ゼロモードを別扱い。自由エネルギー導出の方針に依存。

## 完了済み（2026-06-21）: 013 符号バグ修正

数値検証（SageMath）で 013 の符号バグが判明し修正した。`typst compile main.typ` は exit 0（既存 cetz deprecation と 002 linebreak の2件のみ）。

- バグ内容: `<def_hatZ_hatY>`（004/009）の定義では `hat(Z)_mu^((-))` は全 j で重み +1（uniform）。superscript `(-)` のとき `minus.plus` の下側 = +1。ところが `013` が `c_j := cases(-1 if j=1, 1 else)` と置き j=1 を -1 にしていて定義と矛盾していた。
- 数値確認: 正しい復元は `Z_m = (1/M) sum_mu hat(Z)_mu^((-)) exp(+i m 2π μ/M)`（c_m なし）で誤差 1e-16。c_m 版は m=1 で `-Z_1` を返し誤差 2.0（誤り）。
- 修正: `004/013`（`<recover_Z_Y_from_hatZ_hatY>`）から c_j/c_m を全廃し hat(Z)^((-)) を uniform として Y 側と完全対称に再導出。`008/038`（`<T_V_eq_T_Vprime>`）Step2 の `c_m/M` を `1/M` に統一（c_m 定義削除）。`grep c_m|c_j` で 013/038 に残存なし（031 の c_mu はフェルミオン正規化因子で無関係）。
- 038 の定理自体は元々正しく結論 `T_((V))=T_((V'))` は不変。修正は誤った符号規約依存箇所のみ。042/030/037/def_fermi は正しい uniform 版を使用しており未変更。
- 038/039 は数値検証で全空間成立を確認済み（セクター '-'、hat(Z)^((-)) uniform）。`T_V(psi)=e^gamma psi` 全空間 1e-15、037 と整合。

## 次回やること（優先度順）

### 0. 構造化テキストのリアルタイム Web プレビュー（未着手・別ツール）

汎用ツールとしてリポジトリ直下 `realtime-web-preview/` に切り出した。要件は
`realtime-web-preview/docs/requirements.md`。本プロジェクトの `structured-latex/` は
その入力ソースのリファレンス実装という位置づけ。ビューア等は未実装、技術スタック未決定。

### 1. 038 `T_V = T_{V'}` の proof（完了 2026-06-21）

`038_claim_T_V_eq_T_Vprime.typ` の `#proof[TODO]` を完成。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 の linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（環準同型 + 生成元一致）:
- Step1: 合成則 `<conjugation_is_ring_homomorphism>`（新規 000/045）で `T_(V) = T_V`（`V := (V_1^pm)^(1/2) V_2 (V_1^pm)^(1/2)`）。`T_(V), T_(V')` ともに単位的・乗法的・線型。
- Step2: `<recover_Z_Y_from_hatZ_hatY>`（新規 004/013, DFT逆変換）+ `<T_V_eq_T_Vprime_on_hatZ_hatY>`（新規 008/042）で各 `Z_m, Y_m` 上で一致。
- Step3-4: 一致元の集合が部分多元環をなし、`<Z_Y_generate_algebra>`（新規 004/014）より全空間。

新規ファイル: 000/045（共役写像は環準同型）, 000/046（交換子と反交換子 `[ab,c]=a[b,c]_+-[a,c]_+b`）, 004/013（DFT逆変換）, 004/014（Z,Y が環を生成）, 008/041（gamma_2=0 のとき T_(V') が hatZ,hatY を固定）, 008/042（T_(V) と T_(V') が hatZ,hatY 上で一致）。
ラベル付与した既存: 010(`def_T_g`),015(`def_T_V`),018(`def_theta_mu`),027(`diagonalization_P_D`),030(`commutation_V_psi`),033(`def_gamma_theta_mu`,`lambda_eq_exp_gamma`),034(`det_A_theta`),035(`gamma1_geq_1`),002/000(`tensor_basis`),004/000(`def_transfer_matrix_symbols`)。

gamma_2=0 障害の処理: gamma_2(theta_mu)=0 の mu ではフェルミオン未定義で P_mu 経路が使えない。041 で T_(V') が `[X,hatZ_mu]=[X,hatY_mu]=O` 経由で hatZ,hatY を固定と直接証明（鍵: gamma_2=0 ⇔ sin theta=0 かつ c_1 cos theta=s_1 c_2、mu≡±nu mod M ⇒ cos,sin 保存 ⇒ gamma_2(theta_nu)=0 ⇒ gamma(theta_nu)=0 で X の該当項が消える。普遍反交換子 `<anticommutator_of_hat_Z_and_hat_Y>` 使用）。042 で gamma_2≠0 は P_mu 可逆経由、gamma_2=0 は 041 + A(theta_mu)=I で統合。

【未解決の基盤上の注意】032 の V' 定義 `sum_(mu=1)^M psi_mu^dagger psi_(-mu)` は mu=M（gamma_2=0）で psi_M が未定義。041 では「係数 gamma(theta_M)=0 ゆえ当該項を省く」規約を note で明示し Step1 で coefficient=0 を別証。完全厳密化するなら 032 の和を「gamma_2(theta_mu)≠0 の mu に限定」へ書き換えるのが望ましい（今回は既存 proof を壊さない方針で規約対応）。

### 2. 039 `V = cV'` の proof（完了 2026-06-21）

`039_claim_V_eq_Vprime.typ` の `#proof[TODO]` を完成。**009（クリフォード群、TODO）には依存しない**方針に変更（中心性で証明）。`typst compile main.typ` は exit 0（既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（中心性経由、クリフォード群を経由しない）:
- 新規中心補題 `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`（`<centralizer_is_scalar>`）: `Mat(2,CC)^(⊗M)` の中で全元と可換な元は `c·I` に限る。行列単位 `E_(ij)` の積公式 `E_(ij)E_(kl)=δ_(jk)E_(il)` を `<tensor_basis>` でテンソル積に持ち上げ、`W=Σw_(IJ)E_(IJ)` を全 `E_(KL)` と可換 ⟹ 対角一定・非対角0 ⟹ スカラー。`002/001`（`<scalar_identity_commutes>`、逆向き）と対。main.typ に 001 の直後で #include 追加。
- 039 本体: `W := V'^(-1)V`（可逆）。`<T_V_eq_T_Vprime>`（Step1 の `T_((V))=T_(V)` 含む）+ `<mat_conj>` から全 x で `VxV^(-1)=V'xV'^(-1)`、`V=V'W`・`V^(-1)=W^(-1)V'^(-1)`（`<conjugation_is_ring_homomorphism>` の逆元公式）を代入し `Wx=xW`。中心補題で `W=cI`、可逆ゆえ `c≠0`、よって `V=cV'`、`c∈CC^×`。
- 039 のステートメントの `V` は `<def_T_V>` 由来の `V=(V_1^pm)^(1/2)V_2(V_1^pm)^(1/2)` と同一視（claim 本文と note に明記）。

## 完了済み（2026-05-30）

### structured-latex 残りファイルの変換

`structured-latex/content/` 以下へ残りの `parts/**/*.typ` の変換を追加済み。`node structured-latex/tools/validate-content.mjs` は 123 blocks で通過。

### 032/037 V' 符号修正と SageMath 検証

005（P_μ 正規化）の修正により、新しい反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0} I$ で 031 が成立することは数値検証済み。しかし、現状の $V' := exp(-Σ_{μ∈M} γ(θ_μ)(ψ†_μ ψ_μ - 1/2))$ では:

$
"ad"(X)(ψ†_μ) = -2γ(θ_μ) ψ†_{-μ}
$

となり、$ψ†_μ$ は $"ad"(X)$ の固有ベクトルでない（$ψ†_{-μ}$ に写る）。よって 037 の Claim「$T_{(V')}(ψ†_μ) = e^{-γ}ψ†_μ$」は成立しない。

修正案:
$
V' := exp(+ sum_{μ=1}^M γ(θ_μ) (ψ†_μ ψ_{-μ} - 1/2))
$

- $ψ†_μ ψ_μ → ψ†_μ ψ_{-μ}$（反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0}$ と整合）
- 和を $μ ∈ \{1, ..., M\}$ に半分（モードの二重計上を回避）
- 符号は $T_V$ と一致させるため $+$（030 で $T_V ψ†_μ = e^{+γ}ψ†_μ$）

これにより `[ψ†_μ ψ_{-μ}, ψ†_ν] = δ^M_{ν-μ,0} ψ†_μ` で、$ψ†_ν$ が固有ベクトルになる。

実施済み:
- `032_definition_Vprimeの定義.typ`: `V' = exp(+Σ γ(ψ†_μ ψ_{-μ} - 1/2))` に修正
- `037_claim_T_Vprimeのpsiへの作用.typ`: `T_(V')(ψ†_μ) = e^(+γ)ψ†_μ`, `T_(V')(ψ_μ) = e^(-γ)ψ_μ` に修正
- `sagemath/check/037_claim_T_Vprimeのpsi/`: `M=2,4`、`K1,K2` 7組で PASS
- `structured-latex/content/008_TV1_hatZ_hatY_20_40.mjs`: 032/037 の符号を同期
- `typst compile main.typ`: 警告のみで成功

### main.pdf の追跡停止

`exact-solution-of-2d-ising-model/main.pdf` は生成物として Git から削除し、`.gitignore` に追加した。

## 完了済み（2026-05-02）

### 005 P_μ 正規化の修正

- 026: claim 末尾に `<eigenvector_of_A_theta>` ラベル追加
- 027: $P_μ$ の自由定数を $c = 1/(2√M γ_2(-θ_μ))$ に固定
- 029: フェルミオン定義を新 P_μ に合わせて更新（note の簡約形に符号 $ε_μ$ 追加）
- 030: proof を $P_μ$ 抽象的に扱う形に簡素化（A = P D P^{-1} 構造を直接利用）
- 031: ステートメントを $δ^M_{μ+ν,0}$ に統一、proof で $c_μ c_ν$ 因子を頭で因子分け、係数 1 を導出
- 037: 反交換関係参照を更新、proof 構造の破綻を明示（remark + 中断 NOTE）
- SageMath: `sagemath/check/031_claim_psiの反交換関係/` で 3 ケース全 PASS（M=100、7 パラメータ）
- typst compile: エラーなし

## 完了済み（2026-04-04）

- 032: claim → definition に変更（`032_definition_Vprimeの定義.typ`）
- 033: `gamma(theta_mu)` の定義 + `lambda_pm = e^{+-gamma}` の claim/proof
- 034: `det A(theta_mu) = 1` の claim/proof（036 の行列分解を利用）
- 035: `gamma_1(theta_mu) >= 1` の claim/proof
- 036: `A(theta_mu) = B_1 B_2 B_1` の行列分解 claim/proof
- 037: `T_{V'}` の psi への作用 claim/proof（→ 005 で構造的問題が判明）
- 038, 039: claim のみ（proof TODO）
