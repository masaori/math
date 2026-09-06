# Lean 4 + mathlib4 による機械的証明

`exact-solution-of-2d-ising-model` の人手証明を Lean 4 で機械的に検証するためのプロジェクト。
SageMath による数値検証（`sagemath/`）と併用する。

**人手証明の正本は `structured-latex/content/*.ts`（構造化TeX）**である
（`.mjs` は全廃済み。ファイル形式は TypeScript に統一されている）。
旧 Typst 一式は `_old/typst/` へ参照用に退避されており（更新されない）、
本 README で `parts/…/*.typ` と書いているのは `_old/typst/parts/…` のことである。
対応づけは**ラベル**（`labels` フィールド、例 `def_hatZ_hatY`）で辿る。

## セットアップ

### 1. elan（Lean のツールチェーン管理ツール）

```bash
curl -fsSL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -o elan-init.sh
sh elan-init.sh -y
export PATH="$HOME/.elan/bin:$PATH"   # 恒久化するには shell の rc に追記
```

`lean-toolchain` にツールチェーンが固定してあるので、このディレクトリで `lake` を実行すれば
elan が自動的に該当バージョン（`leanprover/lean4:v4.32.1`）を取得する。

### 2. 依存の取得と mathlib のビルド済みキャッシュ

```bash
cd exact-solution-of-2d-ising-model/lean
lake exe cache get     # mathlib のビルド済み .olean を取得（初回は数 GB のダウンロード）
lake build
```

`lake exe cache get` を省略すると mathlib 全体をローカルでビルドすることになるので必ず実行する。

### 3. バージョン固定

| ファイル | 内容 |
| --- | --- |
| `lean-toolchain` | `leanprover/lean4:v4.32.1` |
| `lakefile.toml` | mathlib4 を git tag `v4.32.1` に固定 |
| `lake-manifest.json` | mathlib4 と推移的依存の commit を固定（コミット対象） |

**mathlib を更新するときは `lean-toolchain` と `lakefile.toml` の `rev` を必ず同じタグに揃える。**
揃っていないと mathlib のビルド済みキャッシュが使えず、全ビルドが走る。

## ビルド

```bash
cd exact-solution-of-2d-ising-model/lean
lake build          # 全体
lake build Ising2D.Representation   # 単一モジュール
```

`sorry` を残したまま「証明済み」としないため、主要な定理の依存公理を確認するスクリプトを用意してある。

```bash
cd exact-solution-of-2d-ising-model/lean
./scripts/check-no-sorry.sh   # 終了コード 0 なら OK
```

ソース中の `sorry` / `admit` の有無と、主要定理の `#print axioms` に `sorryAx` が
現れないことを検査する（`propext` / `Classical.choice` / `Quot.sound` は
mathlib 標準の 3 公理で問題ない）。新しい定理を追加したら、このスクリプトの
`targets` 配列にも追加すること。

単発で確認する場合は次のようにする（`lean -` ではなく `--stdin` を使う）。

```bash
lake env lean --stdin <<'EOF'
import Ising2D
#print axioms Ising2D.tensorPowAlgEquiv
EOF
```

## 人手証明との対応の付け方

- Lean のファイルパスは `parts/` のディレクトリ番号・ファイル番号に合わせる。

  | 人手証明（Typst） | Lean |
  | --- | --- |
  | `parts/000_計算公式/045_claim_共役写像は環準同型.typ` | `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean` |
  | `parts/000_計算公式/046_claim_交換子と反交換子の関係.typ` | `Ising2D/Part000/Claim046_CommutatorViaAnticommutators.lean` |
  | `parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` | `Ising2D/Part002/Theorem000_TensorBasis.lean` |
  | `parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ` | `Ising2D/Part002/Lemma001_ScalarIdentityCommutes.lean` |
  | `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` | `Ising2D/Part002/Lemma003_CentralizerIsScalar.lean` |
  | `parts/004_転送行列/000_definition_転送行列の記号の定義.typ` | `Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` |
  | `parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` | `Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean` |
  | `parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ` | `Ising2D/Part004/Claim008_ExpSum.lean` |
  | `parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ` | `Ising2D/Part004/Definition009_HatZHatY.lean` |
  | `parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ` | `Ising2D/Part004/Definition010_H1H2V1V2.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/010,014,015,016,017` | `Ising2D/Part008/Definition016_TV.lean` |
  | `parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ` | `Ising2D/Part004/Claim012_HatPeriodicity.lean` |
  | `parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ` | `Ising2D/Part004/Claim013_RecoverZY.lean` |
  | `parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ` | `Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` |
  | `parts/006_ZとYの反交換関係/000_claim_Z_muとZ_nuとY_muとY_nuの反交換関係.typ` | `Ising2D/Part006/Claim000_AnticommutatorZY.lean` |
  | `parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ` | `Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/019,020,022,023,041`（`θ_μ`, `γ_1`, `γ_2`, `A(θ)`） | `Ising2D/Part008/Definition019_ThetaGamma.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/027,028,034`（固有値・対角化・`det A`） | `Ising2D/Part008/Claim027_EigenATheta.lean` |
  | `parts/008_T_V1_hatZとhatZ_hatYの関係/029,030,031`（`ψ` の定義・`V` との交換関係・反交換関係） | `Ising2D/Part008/Definition030_Fermi.lean` |
  | （表現の選択と両表現の同型） | `Ising2D/Basic.lean`, `Ising2D/Representation.lean` |

- 各 Lean ファイルの冒頭コメントに、対応する `.typ` ファイル名と Typst のラベル（`<...>`）を書く。
- 原文のステートメントをそのまま形式化できない場合（記号の重複・「元」と「族」の混同など）は、
  **冒頭コメントに原文の問題点と、形式化した修正版ステートメントを明記する**
  （例: `Ising2D/Part002/Theorem000_TensorBasis.lean`）。

## 具体版と必要十分版の 2 本立て

`exact-solution-of-2d-ising-model/README.md` 4 節の方針にしたがい、**同じ主張について
具体版と必要十分版の 2 つを置く**。

| | 何を書くか | 何のためか |
| --- | --- | --- |
| 具体版 | 人手証明と同じ抽象度（複素行列）で、1 対 1 に対応する主張 | 人手証明の正当性を保証する |
| 必要十分版 | 不要な構造を取り払い、証明に必要な概念だけを残した主張 | 何が本質的かを示す。具体版が過剰な構造を要求していないかの検査 |

規約:

- 両版のファイル冒頭コメントに**同じ人手証明のラベル**を書き、相互に参照させる。
- 必要十分版から具体版が特殊化で得られる場合は、**具体版を必要十分版の系として導出する**。
  ただし人手証明と 1 対 1 に対応する形の主張は必ず別に立てる。
- **必要十分版は Lean の中だけに置く。** 人手証明の本文（`structured-latex/content/`）にも
  参照用ノート（`structured-latex/notes/`）にも持ち込まない。
- 必要十分版は `Ising2D/NecSuf/` 以下、名前空間 `Ising2D.NecSuf` に置く。

**章 009〜020 の 2 本立ての対応表は、この README ではなく各章のドキュメント
（`lean/docs/ch0NN-formalization.md`）が正本である**（下記「章 009〜020 の形式化」節を参照）。
以下の表は章 008 までのものである。

現在 2 本立てになっている主張:

| 人手証明のラベル | 具体版 | 必要十分版 |
| --- | --- | --- |
| `<commutator_via_anticommutators>` | `Ising2D.matComm_mul_eq_matAcomm_sub_matAcomm`（`Mat(n, ℂ)`） | `Ising2D.commutator_via_anticommutators`（任意の環） |
| `<scalar_identity_commutes>` | `Ising2D.scalar_identity_commutes_fin`（体 `K` 上の `Mat(n, K)`） | `Ising2D.NecSuf.smul_one_commute` / `smul_one_sub_comm`（任意の `S`-代数） |
| `<centralizer_is_scalar>` | `Ising2D.centralizer_is_scalar`（`Mat(2,ℂ)^{⊗M}`） | `Ising2D.NecSuf.centralizer_is_scalar_semiring`（係数は任意の半環） |
| `<centralizer_is_scalar>` Step 2 の `E_{IJ}E_{KL} = δ_{JK}E_{IL}` | `Ising2D.E_mul_E` | `Ising2D.NecSuf.single_mul_single_eq_ite`（任意の半環・添字は 4 つとも別の型でよい） |
| `<centralizer_is_scalar>` Step 2 の `I = Σ_P E_{PP}` | `Ising2D.one_eq_sum_E` | `Ising2D.NecSuf.one_eq_sum_single`（任意の半環・任意の有限添字型） |
| `<anticommutator_of_psi>` | `Ising2D.acomm_psiDag_psiDag` / `acomm_psiDag_psi` / `acomm_psi_psi`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.acomm_psi_relations_of_car`） | `Ising2D.NecSuf.acomm_lincomb_clifford` / `NecSuf.car_of_coeffs`（係数は任意の可換環、台は任意の環） |
| `Z_Y_linearly_independent` | `Ising2D.ZY_linearIndependent`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.ZY_linearIndependent_of_necSuf`、`Part004/Claim001_ZYLinearlyIndependentFromNecSuf.lean`） | `Ising2D.NecSuf.linearIndependent_of_clifford_necSuf`（係数は任意の可換環、台は任意の環。仮定は Clifford 関係＋スカラーの忠実性＋`2` の非零因子性だけ。`NecSuf/CliffordIndependence.lean`） |
| `exp_sum` | `Ising2D.expPhase_sum`（複素指数関数。必要十分版からの導出は `Ising2D.expPhase_sum_of_necSuf`、`Part004/Claim008_ExpSumFromNecSuf.lean`） | `Ising2D.NecSuf.sum_zpow_primitiveRoot`（任意の体と 1 の原始 `M` 乗根。`NecSuf/RootOfUnitySum.lean`） |
| `anticommutator_of_hat_Z_and_hat_Y` | `Ising2D.acomm_hatZ_hatZ_same` / `acomm_hatZ_hatZ_opp` / `acomm_hatY_hatY` / `acomm_hatZPlus_hatZMinus`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.acomm_hatZ_hatZ_same_of_necSuf` / `acomm_hatY_hatY_of_necSuf` / `acomm_hatZPlus_hatZMinus_of_necSuf`、`Part007/Claim000_AnticommutatorHatZHatYFromNecSuf.lean`） | `Ising2D.NecSuf.acomm_fourier_clifford` / `acomm_fourier_clifford_flip` / `acomm_fourier_clifford_weights`（体上の任意の環、Clifford 関係と 1 の原始 `M` 乗根だけ。`NecSuf/FourierClifford.lean`） |
| `<exp_X_Y_exp_-X>` | `Ising2D.hasSum_matExp_conj` / `matExp_conj_eq_tsum`（`Mat(2,ℂ)^{⊗M}`、`Part008/Claim006_ExpConjugation.lean`） | `Ising2D.NecSuf.exp_adCLM_apply` / `NecSuf.hasSum_exp_conj`（ℂ 上の完備ノルム環なら何でもよい、`NecSuf/ExpConjugation.lean`） |
| `<exp_X_Y_exp_-X>` の 2 次元不変部分空間版（`<extract_taylor_coefficient_of_Z_Y>` の cosh/sinh の根拠） | `Ising2D.matExp_conj_two_dim_z` / `matExp_conj_two_dim_y` | `Ising2D.NecSuf.exp_conj_two_dim_z` / `exp_conj_two_dim_y` |
| `<commutator_of_H_and_Z_Y>` | `Ising2D.lie_H1_hatZ_same` / `lie_H1_hatY` / `lie_H1_hatZ_opp` / `lie_H2_hatZMinus` / `lie_H2_hatY` / `lie_H2_hatZPlus`（`Mat(2,ℂ)^{⊗M}`、`Part008/Claim001_CommutatorHZY.lean`） | `Ising2D.NecSuf.CliffordTriple.lie_sum_yz_z` ほか 6 本（台は任意の環、係数は任意の可換半環、族の添字型も任意。`NecSuf/CommutatorClifford.lean`） |
| `<ホロノミック量子場_p142下段_1>` / `<T_V_hatZ_hatY>`（exp 共役の 2 次元部分空間への「行列としての」作用） | `Ising2D.actsBy_TConj_matExpUnits` / `actsBy_TConj_smulUnits` / `actsBy_TConj_V1half` / `actsBy_TConj_V2` / `TV_hatZ_hatY`（`Mat(2,ℂ)^{⊗M}`、`Part008/Claim012_TVActions.lean`） | `Ising2D.NecSuf.twoDimConjMat` / `NecSuf.exp_conj_two_dim_actsBy` / `NecSuf.conj_smul_eq`（ℂ 上の完備ノルム環。スカラー相殺は任意の ℂ-代数。`NecSuf/TVAction.lean`） |
| `anticommutator_of_Z_and_Y` | `Ising2D.anticomm_Z_Z` / `anticomm_Z_Y` / `anticomm_Y_Y`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.anticomm_Z_Z_of_necSuf` / `anticomm_Z_Y_of_necSuf` / `anticomm_Y_Y_of_necSuf`、`Part006/Claim000_AnticommutatorZYFromNecSuf.lean`） | `Ising2D.NecSuf.acomm_jwStr` / `NecSuf.jwStr_sq` / `NecSuf.acomm_of_single_site`（台は任意の環、サイトごとの積は「単位的・乗法的・多重線型」な写像なら何でもよい。`NecSuf/SiteLocalAnticomm.lean`） |
| `hatZ_hatY_M_periodicity` | `Ising2D.hatZ_periodic` / `hatY_periodic` / `hatZMinus_M_eq_neg_M` / `hatY_M_eq_neg_M`（複素指数関数。必要十分版からの導出は `Ising2D.hatZ_periodic_of_necSuf` ほか、`Part004/Claim012_HatPeriodicityFromNecSuf.lean`） | `Ising2D.NecSuf.transform_periodic` / `NecSuf.zpow_mul_add_natCast`（任意の体、`ζ^M = 1` だけ。`NecSuf/DiscreteFourier.lean`） |
| `recover_Z_Y_from_hatZ_hatY` | `Ising2D.inverse_dft` / `recover_Y` / `recover_Z`（`Mat(2,ℂ)^{⊗M}`。必要十分版からの導出は `Ising2D.inverse_dft_of_necSuf` / `recover_Y_of_necSuf` / `recover_Z_of_necSuf`、`Part004/Claim013_RecoverZYFromNecSuf.lean`） | `Ising2D.NecSuf.inverse_dft_necSuf`（任意の体の 1 の原始 `M` 乗根と、その体上の任意の加群。`NecSuf/DiscreteFourier.lean`） |

必要十分版から得られた知見（本文には持ち込まないが、解説パートの素材になる）:

- `ψ` の反交換関係に効いているのは `hat(Z)^{(-)}, hat(Y)` の 4 本の反交換関係と、
  係数についてのスカラー恒等式 2 本だけである。`hat(Z)`, `hat(Y)` の具体形も、複素行列であることも、
  テンソル冪であることも、`M`・`δ^M_{μ+ν,0}`・`γ_2` も効いていない。

- `exp(X) A exp(-X) = exp(ad X)(A)` に効いているのは、**左乗法 `L_X` と右乗法 `R_X` が
  線型作用素として可換であること**（結合律から出る）と、**`(L_X)^n = L_{X^n}`・`(R_X)^n = R_{X^n}`**
  の 2 つだけである。行列であることも有限次元であることも効いておらず、ℂ 上の完備ノルム環なら成り立つ。
  リー群・リー環はもちろん、`L` が代数準同型であることすら使っていない。
  なお右乗法は反同型だが `(R_X)^n = R_{X^n}` は左乗法と同形なので、反対環を経由する必要がない。

- `H_1^{(±)}, H_2` と `hat(Z)^{(±)}, hat(Y)` の 6 本の交換関係に効いているのは、恒等式
  `[a b, c] = a [b,c]₊ - [a,c]₊ b` と、**反交換子が係数のスカラー倍の `1` になること**
  （`[z_μ,z_ν]₊ = D_z(μ,ν)·1`、`[z_μ,y_ν]₊ = 0`、`[y_μ,y_ν]₊ = D_y(μ,ν)·1`）だけである。
  `hat(Z), hat(Y)` の具体形（離散フーリエ変換）も、行列であることも、
  `D` の中身（`2M δ^M_{μ+ν,0}` や `-4 e^{-i2π(μ+ν)/M}`）も効いていない。
  `hat(Z)^{(±)}` と `hat(Z)^{(∓)}` の違いは `D_z` と `D_{z'}` という**別のスカラー関数**として
  抽象化でき、原文が符号ごとに書き分けている 6 本は必要十分版では
  「積の並びが `y z` か `z y` か」×「交換相手が `z` か `z'` か `y` か」の 6 通りに対応する。

- 原文が `<nesting_of_commutator_of_H_and_Z>`（`n` 重の入れ子交換子の偶奇による場合分け）と
  `<extract_taylor_coefficient_of_Z_Y>`（その係数を cosh/sinh のテイラー級数と突き合わせる）の
  2 段でやっていることは、**「`ad X` が `span{ẑ, ŷ}` を保つ」という 1 つの仮定に集約できる**。
  そこから先は `exp(X) z exp(-X) = cosh(s) z + α sinhc(s) y` という閉じた形が自動的に出る。
  入れ子交換子の偶奇は `adCLM_pow_even` / `adCLM_pow_odd_*` に、テイラー係数の抽出は
  `Complex.hasSum_cosh` / `hasSum_sinhc` に、それぞれ 1 対 1 で対応する。
- 原文が「`V_2` のスカラー因子 `(2s_2)^{M/2}` は共役で打ち消し合う」と一行で済ませている箇所に
  効いているのは、**任意の ℂ-代数で成り立つ `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`** だけである
  （`NecSuf.conj_smul_eq`）。ノルムも完備性も指数関数も要らない。
- `Z_m, Y_m` の線型独立性に効いているのは、**Clifford 関係 `[e_a,e_b]₊ = 2δ_{ab}·1` と、
  スカラーが台へ忠実に入ること（`s·1 = 0 ⇒ s = 0`）と、`2` が零因子でないこと**の 3 つだけである。
  行列であること・テンソル冪であること・`Z, Y` の具体形（Jordan–Wigner 文字列）・
  有限次元性・係数が体であることは効いていない（係数は任意の可換環でよい）。

- `exp_sum`（指数関数の和とクロネッカーのデルタ）に効いているのは、**位相因子が
  1 の原始 `M` 乗根であること**と、**係数の住む場所で割り算ができること**（等比数列の和）だけである。
  指数関数・円周率・複素数であること・絶対値・偏角は効いていない。
  さらに `M ≠ 0` も証明には不要である（`M = 0` なら両辺とも `0`）。

- `hat(Z), hat(Y)` の 4 本の反交換関係に効いているのは、**`Z, Y` の Clifford 関係**と
  **1 の原始 `M` 乗根の直交性**だけである。加えて `(±)` の重み（原文の `∓1`）については
  **両側の重みの積 `u_j v_j` しか結論に現れない**ので、原文の「複号同順／複号逆」は
  「積が全サイトで `1`」と「`j = 1` でだけ `-1`」の 2 通りに整理できる。
  原文が課している `η^2 = 1` は、積が `1` になるための十分条件にすぎない。

- `Z_μ, Y_ν` の反交換関係 3 式に効いているのは、**サイトごとの積を作る写像が
  「単位的・乗法的・多重線型」であること**（符号 `-1` が積の外へ出る）と、
  **食い違うサイトがちょうど 1 つであること**だけである。テンソル積・クロネッカー積の具体形も、
  成分が 2×2 であることも、複素数であることも、Pauli 行列の成分計算も効いていない
  （使うのは `A σ^x = -σ^x A` 型の関係式だけ）。
  Jordan–Wigner 文字列を書くのに要るのは「サイトの添字に線型順序があること」だけで、
  文字列に使う元が `σ^x` である必要もない（`NecSuf/SiteLocalAnticomm.lean`）。

- `hat(Z), hat(Y)` の `M` 周期性に効いているのは **`ζ^M = 1` の一点のみ**である。
  原始根であることすら要らず、`Z_j, Y_j` の代数的性質も、`hat(Z)^{(±)}` の重みも、
  指数の符号の取り方も効いていない。

- `hat(Z)^{(-)}, hat(Y)` からの復元（離散フーリエ逆変換）に効いているのは、
  **1 の原始 `M` 乗根の直交性**と、**変換される対象が係数体上の加群であること**だけである。
  行列であることも、積があることも、`Z, Y` の反交換関係も効いていない。
  原文が `hat(Z)^{(+)}` で復元を述べていない理由も必要十分版から一意に説明できる:
  必要十分版の仮定は「重みが一様」であり、`hat(Z)^{(+)}` は `j = 1` の重みだけが `-1` だからである。

- 交換子と反交換子の恒等式には、行列であることも複素数であることも効いていない
  （分配法則と結合法則だけで足りる）。
- スカラー倍の恒等行列が全行列と可換であることに効いているのは、スカラー作用と積の
  両立則だけである。次数 `n ≥ 1` は本質的でなく、引き算すら「差が `0`」という述べ方の
  ためにしか使っていない。
- 中心がスカラーであることに効いているのは、添字集合が有限で等号判定可能なことだけである。
  係数が非可換だとスカラーは「係数環の中心の元」に限られ、ℂ の可換性がその条件を消している。

## `Mat(2, ℂ)^{⊗M}` の表現方針（決定事項）

人手証明の `Mat(2, CC)^(times.o M)` は、Lean では次の 2 通りに表せる。

| | 定義 | 実装 |
| --- | --- | --- |
| 抽象テンソル冪 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.NecSufTensorPow` |
| 行列表現（Kronecker） | `Matrix (Fin M → Fin 2) (Fin M → Fin 2) ℂ` | `Ising2D.TensorPow` |

**両者が ℂ-代数として同型であることは `Ising2D.tensorPowAlgEquiv` で証明済み**
（同型写像は `⨂ₜ x ↦ [(s,t) ↦ ∏ᵢ (xᵢ)_{s(i)t(i)}]`、すなわち Kronecker 積）。
したがってどちらで述べた命題も他方へ移送できる。

そのうえで、**以降の証明の土台には行列表現 `TensorPow M` を採用する**。根拠は以下。

1. **行列指数関数が使える（決定的）。** 主対象 `V_1`, `V_2` は `exp` を含むが、
   `AbstractTensorPow M` には `NormedRing` インスタンスが無く `NormedSpace.exp` を適用できない
   （`infer_instance` が失敗することを確認済み）。`TensorPow M` では
   `Mathlib.Analysis.Normed.Algebra.MatrixExponential` の補題群
   （`Matrix.exp_units_conj`, `Matrix.exp_add_of_commute`, `Matrix.exp_diagonal` …）
   がそのまま使える。
2. **中心の決定が既存で済む。** `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`
   の 4 ステップ（行列単位の基底展開 → 積公式 → 係数比較 → 結論）は、
   `Matrix.center_eq_scalar_image` に帰着して数行で終わる。
3. **添字型がスピン配置そのもの。** `Fin M → Fin 2` は「各サイトの 2 準位の値」を表すので、
   サイト局所演算子（`σ^x_k` など）を Kronecker 積の再帰なしに直接書ける。
   なお `Fin (2^M)` を添字にした Kronecker 表現は
   **`TensorPow M` の添字の付け替えにすぎない**（`Ising2D.toFinPowAlgEquiv` で ℂ-代数同型を証明済み）。
   表現力は同じで、`Fin (2^M)` 側は `finFunctionFinEquiv` による添字変換が全体に散らばる分だけ不利。
4. **行列式・跡・固有値・`Matrix.reindex` など行列固有の API が全部使える。**
   対角化（`parts/008_...` の `P_μ`, `D_μ`）で必要になる。

抽象テンソル冪の利点は人手証明の記法に見た目が近いことだけで、
テンソル冪の基底（`<tensor_basis>`）も `Basis.piTensorProduct` 経由で
`Ising2D.tensorPowBasis` として用意してあるため、必要な結果は移送できる。

## 現在形式化済みの命題

| Lean の名前 | 内容 | 対応する人手証明 |
| --- | --- | --- |
| `Ising2D.tensorPowBasis` | 基底のテンソル冪はテンソル冪の基底 | `<tensor_basis>` |
| `Ising2D.matTensorPowBasis` | 上を `Mat(2,ℂ)` に適用したもの | `<tensor_basis>` の系 |
| `Ising2D.tensorPowAlgEquiv` | 抽象テンソル冪 ≃ₐ[ℂ] 行列表現 | 表現の選択（新規） |
| `Ising2D.toFinPowAlgEquiv` | 行列表現 ≃ₐ[ℂ] `Matrix (Fin (2^M)) (Fin (2^M)) ℂ` | 表現の選択（新規） |
| `Ising2D.E_mul_E` | 行列単位の積公式 `E_IJ E_KL = δ_JK E_IL` | `<centralizer_is_scalar>` Step 2 |
| `Ising2D.one_eq_sum_E` | `I = Σ_P E_PP` | `<centralizer_is_scalar>` Step 2 |
| `Ising2D.scalar_identity_commutes` | `[c·I, A] = 0` | `<scalar_identity_commutes>` |
| `Ising2D.centralizer_is_scalar` | 全元と可換な元はスカラー | `<centralizer_is_scalar>` |
| `Ising2D.centralizer_is_scalar_abstract` | 同上（抽象テンソル冪側） | 同上（移送の例） |
| `Ising2D.matExp_units_conj` | `exp(U A U⁻¹) = U (exp A) U⁻¹` | `parts/003_線型写像のexp` 系 |
| `Ising2D.Conjugation.T_mul` | 共役写像は乗法的 | `<conjugation_is_ring_homomorphism>` (1) |
| `Ising2D.Conjugation.T_one` | 共役写像は単位的 | `<conjugation_is_ring_homomorphism>` (2) |
| `Ising2D.Conjugation.T_comp` | `T_A ∘ T_B = T_{AB}` | `<conjugation_is_ring_homomorphism>` (3) |
| `Ising2D.Conjugation.TMonoidHom` | `B ↦ T_B` は群準同型 `Rˣ →* RingAut R` | (3) の言い換え |
| `Ising2D.Conjugation.matrix_conj_*` | 上記を `Matrix.inv` の記法で述べた版 | 原文の記法に忠実な版 |
| `Ising2D.acomm` / `Ising2D.commutator_via_anticommutators` | `[a b, c] = a [b,c]₊ - [a,c]₊ b`（任意の環） | `<commutator_via_anticommutators>` |
| `Ising2D.matrix_commutator_via_anticommutators` | 同上を `Mat(n, ℂ)` で述べた版 | 同上 |
| `Ising2D.pauliX/pauliY/pauliZ` と積公式 | Pauli 行列とその積・反可換関係 | `<Z_Y_generate_algebra>` Step 1 |
| `Ising2D.siteOp` | `I ⊗ ⋯ ⊗ A(k) ⊗ ⋯ ⊗ I`（`Mat(2,ℂ) →ₗ[ℂ] TensorPow M`） | `<def_transfer_matrix_symbols>` の `σ^a_k` |
| `Ising2D.sigmaX/sigmaY/sigmaZ` | `σ^x_k, σ^y_k, σ^z_k` | 同上 |
| `Ising2D.siteOp_mul_same` / `siteOp_mul_comm` | 同サイトの積・異サイトの可換性 | `<Z_Y_generate_algebra>` Step 1 |
| `Ising2D.Z` / `Ising2D.Y` / `Ising2D.epsilon` | Jordan–Wigner 文字列 `Z_m`, `Y_m` と `ε` | `<def_transfer_matrix_symbols>` |
| `Ising2D.Z_eq_xString_mul` / `Y_eq_xString_mul` | `Z_m = (σ^x_1⋯σ^x_{m-1}) σ^z_m` 等 | 同上 |
| `Ising2D.siteProd_anticomm_of_single_site` | 1 サイトだけ反可換 ⇒ テンソル積は反交換 | `<anticommutator_of_Z_and_Y>` の計算の一般化 |
| `Ising2D.anticomm_Z_Z` | `[Z_μ, Z_ν]₊ = 2 I δ^M_{(μ,ν)}` | `<anticommutator_of_Z_and_Y>` 第 1 式 |
| `Ising2D.anticomm_Z_Y` | `[Z_μ, Y_ν]₊ = 0` | 同 第 2 式（**原文は TODO**） |
| `Ising2D.anticomm_Y_Y` | `[Y_μ, Y_ν]₊ = 2 I δ^M_{(μ,ν)}` | 同 第 3 式（**原文は TODO**） |
| `Ising2D.matrix_two_decomp` | `Mat(2,ℂ)` の元の `{I, σ^x, σ^y, σ^z}` 展開 | `<Z_Y_generate_algebra>` Step 3 の成分比較 |
| `Ising2D.Z_Y_generate_algebra` | `Algebra.adjoin ℂ {Z_m, Y_m} = ⊤` | `<Z_Y_generate_algebra>` |
| `Ising2D.acomm_sum_smul` / `acomm_sum_smul_left` | 反交換子の双線型性（有限線型結合の展開） | 補助（原文は暗黙に使用） |
| `Ising2D.ZY_linearIndependent` | `(Z_1,…,Z_M,Y_1,…,Y_M)` は線型独立 | `004/001`（**原文は TODO**） |
| `Ising2D.ZYSet_linearIndepOn` | 同上を集合 `S` の形で述べた版 | 同上 |
| `Ising2D.expPhase` | 位相因子 `exp(-√-1·2πk/M)`（`k : ℤ`） | `<def_hatZ_hatY>` |
| `Ising2D.expPhase_eq_one_iff` | `exp(-√-1·2πk/M) = 1 ⟺ M ∣ k` | `<exp_sum>` (a)(b) の場合分け |
| `Ising2D.expPhase_sum` | `∑_{j=1}^M exp(-√-1·2πjk/M) = M δ^M_{k,0}` | `<exp_sum>` |
| `Ising2D.deltaMod` | `δ^M_{(μ,ν)}` の整数添字版 | `parts/004/007_definition_…` |
| `Ising2D.hatZ` / `hatZPlus` / `hatZMinus` / `hatY` | `hat(Z)_μ^{(±)}`, `hat(Y)_μ` | `<def_hatZ_hatY>` |
| `Ising2D.hatZMinus_eq` | `hat(Z)^{(-)}` は一様和 | `<recover_Z_Y_from_hatZ_hatY>` 冒頭 |
| `Ising2D.hatZ_periodic` / `hatY_periodic` | `hat(Z)_{μ+M} = hat(Z)_μ` ほか（一般の `μ`） | `<hatZ_hatY_M_periodicity>` の一般化 |
| `Ising2D.hatZMinus_M_eq_neg_M` / `hatY_M_eq_neg_M` | `hat(Z)_M^{(-)} = hat(Z)_{-M}^{(-)}` ほか | `<hatZ_hatY_M_periodicity>` |
| `Ising2D.inverse_dft` | 離散フーリエ逆変換（任意の族に対する形） | `<recover_Z_Y_from_hatZ_hatY>` Step 1/2 の共通部分 |
| `Ising2D.recover_Y` / `recover_Z` | `∑_μ hat(Y)_μ e^{√-1 m 2πμ/M} = M Y_m` ほか | `<recover_Z_Y_from_hatZ_hatY>` |
| `Ising2D.Y_eq_inverse_dft` / `Z_eq_inverse_dft` | `Y_m = (1/M)∑_μ …` ほか | 同 Step 3 |
| `Ising2D.acomm_hatZ_hatZ_same` | `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(±)}]₊ = 2M δ^M_{μ+ν,0} I` | `<anticommutator_of_hat_Z_and_hat_Y>` 1 |
| `Ising2D.acomm_hatZ_hatZ_opp` | `[hat(Z)_μ^{(±)}, hat(Z)_ν^{(∓)}]₊` | 同 2 |
| `Ising2D.acomm_hatZ_hatY` | `[hat(Z)_μ^{(±)}, hat(Y)_ν]₊ = 0` | 同 3（**原文は「同様」で省略**） |
| `Ising2D.acomm_hatY_hatY` | `[hat(Y)_μ, hat(Y)_ν]₊ = 2M δ^M_{μ+ν,0} I` | 同 4（**原文は「同様」で省略**） |
| `Ising2D.nextSite` | site 添字の巡回 `m ↦ m+1`（`M` で巻き戻る） | `Z_{M+1} := Z_1` の規約 |
| `Ising2D.H1` / `Ising2D.H2` | `H_1^{(±)}`, `H_2` | `transfer_matrix_011_definition_H1_H2` |
| `Ising2D.I_smul_H2_eq_sum_sigmaX` | `√-1 H_2 = ∑_m σ^x_m`（2 つの `V_2` 表式の一致） | 同上（**原文は暗黙**） |
| `Ising2D.V1` / `Ising2D.V1half` / `Ising2D.V2` | `V_1^{(±)}`, `(V_1^{(±)})^{1/2}`, `V_2` | `transfer_matrix_007_definition_V1_pm`, `011` |
| `Ising2D.V1half_sq` | `((V_1^{(±)})^{1/2})^2 = V_1^{(±)}` | 同上（「平方根」であることの確認） |
| `Ising2D.matExpUnits` / `smulUnits` | `exp X` と 0 でないスカラー倍の可逆性 | 補助（原文は暗黙に可逆性を使用） |
| `Ising2D.V1Units` / `V1halfUnits` / `V2Units` | 転送行列を単元 `(TensorPow M)ˣ` として | 同上（`V_2` には `s_2 > 0` が要る） |
| `Ising2D.isUnit_V1` / `isUnit_V1half` / `isUnit_V2` | 上記の `IsUnit` 版 | 同上 |
| `Ising2D.H1JordanWigner` / `sum_sigmaZ_sigmaZ_eq_jordanWigner` / `V1pauli_eq_jordanWigner` | `V_1 = exp(iK_1(Y_1Z_2+⋯+Y_{M-1}Z_M-εY_MZ_1))` | `V1_in_Z_Y_epsilon` |
| `Ising2D.TConj` | `T_g : X ↦ g X g⁻¹` を **ℂ-代数自己同型**として | `def_T_g` |
| `Ising2D.TConj_linear` / `TConj_trans` | `T_g` の ℂ-線型性、`T_g ∘ T_h = T_{gh}` | `linearity_of_T`, `conjugation_is_ring_homomorphism` (3) |
| `Ising2D.TV` | `T_{(V)}(X) = T_{g_1}(T_{g_2}(T_{g_1}(X)))` | `def_T_V` |
| `Ising2D.TV_eq_TConj` | `T_{(V)} = T_{g_1 g_2 g_1}`（合成則の帰結） | `def_T_V` の系（新規） |
| `Ising2D.TV_linear` / `TV_mul` / `TV_one` | `T_{(V)}` の ℂ-線型性・乗法性・単位性 | `linearity_of_T` |
| `Ising2D.ActsBy` | 行ベクトル記法 `(T z, T y) = (z, y) B` | `T_V_hatZ_hatY` の記法 |
| `Ising2D.ActsBy.comp` | 合成則 `Q P`（原文の `B_1 B_2 B_1` の根拠） | `T_V_hatZ_hatY` の証明 |
| `Ising2D.ActsBy.eigen` | **固有ベクトルの移送**（`B v = λ v ⇒ T(v_0 z + v_1 y) = λ(⋯)`） | 後段（`ψ` が `V` の固有ベクトル）への一般補題 |
| `Ising2D.B1mat` / `B2mat` | `B_1(θ)`, `B_2` | `T_V_hatZ_hatY` の証明 |
| `Ising2D.B1_mul_B2_mul_B1_eq_explicit` | `B_1(θ) B_2 B_1(θ)` の 4 成分の明示計算（5 個の複素パラメータで書いた右辺） | 同上（**双対関係 `c_2^* = s_2^* c_2` が必要**） |
| `Ising2D.B1_mul_B2_mul_B1_eq_AMat` | `B_1(θ) B_2 B_1(θ) = A(θ)`（`AMat` 版。上を実パラメータ・実 `θ` へ cast したもの） | 同上 |
| `Ising2D.TV_hatZ_hatY_of_action` | `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用（**`B_1`, `B_2` の作用を仮定**。作用行列は `AMat K θ`） | `T_V_hatZ_hatY` |

> **`A(θ)` の二重定義（解消済み・2026-07-26）**: 以前は `A(θ)` が `Ising2D.Amat`
> （`Part008/Definition016_TV.lean`、5 個の複素パラメータ版）と `Ising2D.AMat`
> （`Part008/Definition019_ThetaGamma.lean`、`IsingConst` と実 `θ` の版）の二重定義になっており、
> 名前が大文字小文字違いだけで紛らわしかった。**`AMat` に一本化し `Amat` を削除した。**
> 現在 `A(θ)` の定義は `Ising2D.AMat` ただ 1 つである。
>
> 具体的な変更:
>
> - `Part008/Definition016_TV.lean` が `Part008/Definition019_ThetaGamma.lean` を import するようにした
>   （`Definition019` は mathlib 以外に依存しないので循環しない）。
> - `Ising2D.Amat` の定義を削除。`B1_mul_B2_mul_B1_eq_Amat` は
>   **`B1_mul_B2_mul_B1_eq_explicit`**（右辺を `Amat` の代わりに同じ内容の `!![…]` リテラルで書いた版。
>   証明は元のまま）と、それを `AMat` へ移す **`B1_mul_B2_mul_B1_eq_AMat`** の 2 本に分けた。
>   重い行列計算（`maxHeartbeats 2000000`）は前者に閉じている。
> - `TV_hatZ_hatY_of_action` / `TV_hatZ_hatY_of_action'` のステートメントを
>   `(K : IsingConst) … (θ : ℝ)` を取り作用行列が `AMat K θ` になる形へ移した。
> - これにより不要になった橋渡し補題（`Part008/Definition030_Fermi.lean` 末尾の
>   `Amat_eq_AMat` / `B1_mul_B2_mul_B1_eq_AMat'` / `TV_hatZ_hatY_of_action_AMat`）を削除した。
>   `Amat_eq_AMat` の cast の証明（`Complex.ofReal_cos` / `Complex.ofReal_sin` /
>   `Complex.exp_mul_I` による三角関数の cast）は `B1_mul_B2_mul_B1_eq_AMat` の中へ移してある。
> - `scripts/check-no-sorry.sh` の `targets` から `Ising2D.Amat`,
>   `Ising2D.B1_mul_B2_mul_B1_eq_Amat`, `Ising2D.Amat_eq_AMat`,
>   `Ising2D.B1_mul_B2_mul_B1_eq_AMat'`, `Ising2D.TV_hatZ_hatY_of_action_AMat` を削除し、
>   `Ising2D.B1_mul_B2_mul_B1_eq_explicit`, `Ising2D.B1_mul_B2_mul_B1_eq_AMat` を追加した。
| `Ising2D.IsingConst` / `Ising2D.thetaMu` | モデル定数 `c_1, s_1, c_2, c_2^*, s_2^*` と `θ_μ := 2πμ/M` | `def_theta_mu`（`008` part1 の `019`） |
| `Ising2D.gamma1` / `Ising2D.gamma2` / `Ising2D.AMat` | `γ_1(θ)`, `γ_2(θ)`, `A(θ)` | `def_A_theta`、`008` part1 の `020` |
| `Ising2D.AMat_eq` | `A(θ) = !![γ_1, γ_2(θ); -γ_2(-θ), γ_1]` | 同上（原文の書き換えの検算） |
| `Ising2D.gamma2_neg_eq_neg_conj` | `γ_2(-θ) = -conj(γ_2(θ))` | `relation_of_gamma_2` |
| `Ising2D.gamma2_mul_gamma2_neg_eq_neg_normSq` | `γ_2(θ)γ_2(-θ) = -|γ_2(θ)|^2` | 同上 |
| `Ising2D.gamma2_neg_eq_zero_iff` | `γ_2(-θ) = 0 ⟺ γ_2(θ) = 0` | 同上の系 |
| `Ising2D.gamma2_add_int_mul_two_pi` / `gamma2_thetaMu_of_dvd` | `γ_2` の `2π` 周期性と `M ∣ μ+ν ⇒ γ_2(θ_ν) = γ_2(-θ_μ)` | `gamma_2_periodicity`（後段で必須） |
| `Ising2D.gamma2_eq_zero_iff` | `γ_2(θ) = 0 ⟺ s_2^* = 0 ∨ (sin θ = 0 ∧ c_1cos θ = s_1c_2)` | `gamma_2_theta_is_0`（**原文は `s_2^* = 0` を落としている**） |
| `Ising2D.sin_thetaMu_eq_zero_iff` | `sin θ_μ = 0 ⟺ M ∣ 2μ` | 同上（**原文の「⟺ μ = ±M」は不足**） |
| `Ising2D.charPoly_expand` / `charPoly_root` / `charPoly_factor` | 特性多項式 `λ^2 - 2γ_1λ + (γ_1^2 + γ_2γ_2(-θ))` とその根 `γ_1 ± s` | `eigenvector_of_A_theta` 前半 |
| `Ising2D.AMat_mulVec_eigen` / `AMat_mulVec_eigen'` | `s^2 = -γ_2(θ)γ_2(-θ)` のとき `(-s, γ_2(-θ))`, `(γ_2(θ), s)` が固有値 `γ_1+s` の固有ベクトル | `eigenvector_of_A_theta` 後半 |
| `Ising2D.AMat_mulVec_col_pos` / `AMat_mulVec_col_neg` | 原文の `v_± = c(±i√(γ_2γ_2(-θ)), γ_2(-θ))` に対応（固有値は `γ_1 ∓ i t`） | 同上（分枝の突き合わせ） |
| `Ising2D.AMat_of_gamma2_eq_zero` | `γ_2(θ) = 0 ⇒ A(θ) = γ_1(θ) I` | `eigenvector_of_A_theta` の場合分け 1) |
| `Ising2D.det_AMat` | `det A(θ) = γ_1^2 + γ_2(θ)γ_2(-θ)`（無条件） | `det_A_theta` |
| `Ising2D.det_AMat_eq_one` | 上が `1` になるのは `c_1^2-s_1^2 = 1`, `(c_2^*)^2-(s_2^*)^2 = 1`, `c_2s_2^* = c_2^*` の下 | `det_A_theta`（**追加関係が必要**） |
| `Ising2D.lambda_mul_lambda` | `λ_+λ_- = det A(θ)` | `det_A_theta` の第 3 式 |
| `Ising2D.Pmat` / `Ising2D.Dmat` | `P_μ`, `D_μ`（平方根は `t^2 = γ_2(θ)γ_2(-θ)` の仮定として持つ） | `diagonalization_P_D` |
| `Ising2D.det_Pmat` / `det_Pmat_ne_zero` | `det P_μ = i t/(2(√M)^2γ_2(-θ)) ≠ 0`（`P_μ` は可逆） | 同上（原文は可逆性を確認していない） |
| `Ising2D.AMat_mul_Pmat` / `AMat_eq_Pmat_mul_Dmat_mul_inv` | `A P = P D` および `A(θ) = P D P⁻¹` | `diagonalization_P_D` |
| `Ising2D.AMat_thetaMu_eq_Pmat_mul_Dmat_mul_inv` | 上を `θ_μ`, `√M = Real.sqrt M`, `M ≠ 0` で具体化した版 | 同上 |
| `Ising2D.acomm_lin2` | 反交換子の双線型性（2 元の線型結合どうし） | `anticommutator_of_psi` の「双線型性より」 |
| `Ising2D.acomm_hatZMinus_hatY_lin2` | `hat(Z)^{(-)}, hat(Y)` の線型結合どうしの反交換子 | 同上（4 つの反交換関係を代入した形） |
| `Ising2D.sqrtM` / `sqrtM_ne_zero` / `sqrtM_sq` | `√M`（`M ∈ ℕ`）を ℂ の元として | `def_fermi` の正規化因子 |
| `Ising2D.psiDag` / `Ising2D.psi` | `ψ_μ^†`, `ψ_μ`（`P_μ` の第 0 列・第 1 列） | `def_fermi` |
| `Ising2D.psiDag_eq` / `psi_eq` | 原文の「すなわち」の明示式と一致すること | `def_fermi` の検算 |
| `Ising2D.t_ne_zero` | `γ_2(θ) ≠ 0` なら `t ≠ 0`（`t^2 = γ_2(θ)γ_2(-θ)`） | `anticommutator_of_psi`（原文は暗黙） |
| `Ising2D.gamma2_neg_mul_gamma2_neg_of_dvd` | `M ∣ μ+ν` ⇒ `γ_2(-θ_μ)γ_2(-θ_ν) = γ_2(θ_μ)γ_2(-θ_μ)` | 同上 |
| `Ising2D.t_sq_eq_of_dvd` | `M ∣ μ+ν` ⇒ `t_ν^2 = t_μ^2`（**分枝は決まらない**） | 同上 |
| `Ising2D.acomm_psiDag_psiDag` / `acomm_psi_psi` | `[ψ_μ^†, ψ_ν^†]₊ = 0`, `[ψ_μ, ψ_ν]₊ = 0` | `anticommutator_of_psi`（**同一分枝の仮定が必要**） |
| `Ising2D.acomm_psiDag_psi` | `[ψ_μ^†, ψ_ν]₊ = δ^M_{μ+ν,0} I` | 同上（**同上**） |
| `Ising2D.AMat_mulVec_Pmat_col_zero` / `..._col_one` | `P_μ` の各列は `A(θ_μ)` の固有ベクトル（固有値は `D_μ` の対角成分） | `commutation_V_psi` |
| `Ising2D.TV_psiDag_of_action` / `TV_psi_of_action` | `T(ψ_μ^†) = λ_{+,μ}ψ_μ^†`, `T(ψ_μ) = λ_{-,μ}ψ_μ`（**`T` の作用を仮定**） | `commutation_V_psi` |
| `Ising2D.TV_psiDag_psi_of_action` | 上を `λ_{±,μ} = γ_1 ∓ i t` の明示形で述べた版 | 同上 |
| `Ising2D.NecSuf.acomm_lincomb` / `NecSuf.acomm_lincomb_clifford` | 反交換関係を満たす 4 元の線型結合の反交換子 `= ((pp'+qq')D)·1`（**必要十分版**、任意の ℂ-代数） | `anticommutator_of_psi` |
| `Ising2D.NecSuf.car_of_coeffs` | 必要十分版 CAR（仮定は反交換関係＋係数のスカラー恒等式 2 本だけ） | 同上 |
| `Ising2D.acomm_hatZMinus_hatY_lin2_of_necSuf` | `acomm_hatZMinus_hatY_lin2` が必要十分版の特殊化であることの確認 | 同上 |
| `Ising2D.acomm_psi_relations_of_car` | `ψ` の反交換関係 3 式を**必要十分版の系として**導出した版（具体版と同じ主張） | 同上 |
| `Ising2D.acomm_psiDag_psiDag_of_opposite_branch` | **逆分枝 `t_ν = -t_μ` では `[ψ_μ^†, ψ_ν^†]₊ = I`**（同一分枝の仮定が必要なことの証明） | 同上 |
| `Ising2D.acomm_psiDag_psi_of_opposite_branch` | **逆分枝では `[ψ_μ^†, ψ_ν]₊ = 0`**（原文第 2 式が破れる） | 同上 |
| `Ising2D.NecSuf.sinhc` | `sinhc(s) = sinh(s)/s`（`s = 0` では `1`）と冪級数 `Σ s^{2k}/(2k+1)!` | 新規（0 割りを避けるため導入） |
| `Ising2D.NecSuf.lmulCLM` / `rmulCLM` / `adCLM` | 左乗法 `L_X`、右乗法 `R_X`、随伴作用 `ad X = L_X - R_X`（連続 ℂ-線型作用素） | `<def_ad_X_matrix>` |
| `Ising2D.NecSuf.commute_lmulCLM_rmulCLM` | **`L_X` と `R_Y` は可換**（級数展開ルートの核） | `<matrix_exp_conjugation>` の証明の骨格 |
| `Ising2D.NecSuf.exp_lmulCLM` / `exp_rmulCLM` | `exp(L_X) = L_{exp X}`, `exp(R_X) = R_{exp X}` | 同上 |
| `Ising2D.NecSuf.exp_adCLM_apply` | `exp(ad X)(A) = exp(X) A exp(-X)`（**必要十分版**） | `<exp_X_Y_exp_-X>` |
| `Ising2D.NecSuf.hasSum_exp_conj` / `exp_conj_eq_tsum` | 級数 `Σ_n (1/n!) ad_X^n(A)` の収束と和 | 同上 |
| `Ising2D.NecSuf.exp_conj_two_dim_z` / `..._y` | `ad X` が `span{z,y}` を保つときの閉じた形 `cosh(s) z + α sinhc(s) y` | `<extract_taylor_coefficient_of_Z_Y>` の cosh/sinh の根拠 |
| `Ising2D.adPow` | `ad_X^n(A)`（`n` 重の入れ子交換子、人手証明の再帰そのまま） | `<ad_binomial>` の再帰定義 |
| `Ising2D.hasSum_matExp_conj` / `matExp_conj_eq_tsum` | `exp(X) A exp(-X) = Σ_n (1/n!) ad_X^n(A)`（**具体版**、`Mat(2,ℂ)^{⊗M}`） | `<exp_X_Y_exp_-X>` |
| `Ising2D.matExpUnits_conj_eq_tsum` | 上を単元 `matExpUnits X` の共役 `Ad_{exp X}` の形で述べた版 | 同 (3) |
| `Ising2D.matExp_conj_two_dim_z` / `..._y` | 2 次元不変部分空間での閉じた形（具体版） | `<extract_taylor_coefficient_of_Z_Y>` |
| `Ising2D.NecSuf.conj_smul_eq` | `(c g) a (c⁻¹ g⁻¹) = g a g⁻¹`（スカラー因子は共役で打ち消える。**必要十分版**、任意の ℂ-代数） | `<ホロノミック量子場_p142下段_1>` の「`(2s_2)^{M/2}` は共役で打ち消し合う」 |
| `Ising2D.NecSuf.twoDimConjMat` / `NecSuf.exp_conj_two_dim_actsBy` | exp 共役の `span{z,y}` への作用行列 `!![cosh s, β sinhc s; α sinhc s, cosh s]`（**必要十分版**） | `<ホロノミック量子場_p142下段_1>` |
| `Ising2D.expPhase_eq_exp_neg_thetaMu` / `expPhase_neg_eq_exp_thetaMu` | `exp(-i2πμ/M) = e^{-iθ_μ}`、`exp(i2πμ/M) = e^{iθ_μ}` | `def_theta_mu` との突き合わせ |
| `Ising2D.B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat` | 原文の `B_1(θ)`, `B_2` が必要十分版の作用行列に一致すること（`α = i K_1 e^{-iθ}`, `s = K_1` 等） | `<extract_taylor_coefficient_of_Z_Y>` の係数の検算（**原文の誤りは無し**） |
| `Ising2D.actsBy_TConj_matExpUnits` / `actsBy_TConj_smulUnits` | 上を `ActsBy` の形にした具体版と、スカラー倍した単元でも作用行列が変わらないこと | 同上 |
| `Ising2D.ad_V1half_hatZMinus` / `ad_V1half_hatY` / `ad_V2_hatZMinus` / `ad_V2_hatY` | `ad((1/2)iK_1H_1^{(-)})` と `ad(iK_2^*H_2)` が `span{Ẑ_μ^{(-)}, Ŷ_μ}` を保つこと | `<commutator_of_H_and_Z_Y>` (1)(3)(4)(6) の帰結 |
| `Ising2D.actsBy_TConj_V1half` / `actsBy_TConj_V2` | **`T_{(V_1^{(-)})^{1/2}}`, `T_{V_2}` の作用行列が `B_1(θ_μ)`, `B_2` であること（証明済み。以前は仮定）** | `<ホロノミック量子場_p142下段_1>` |
| `Ising2D.TV_hatZ_hatY` | **原文 `T_V_hatZ_hatY` の無条件版**（`ActsBy` の仮定なし。残るのは `IsingConst` と `K_1,K_2^*` の関係と双対関係 `hdual` だけ） | `<T_V_hatZ_hatY>` |
| `Ising2D.TV_psiDag` / `TV_psi` / `TV_psiDag_psi` | **原文 `commutation_V_psi` の無条件版**（`ActsBy` の仮定なし） | `<commutation_V_psi>` |
| `Ising2D.expPhase_congr` / `hatZ_congr` / `hatY_congr` | 添字が `M` を法として合同なら位相因子・`hat(Z)`・`hat(Y)` は等しい（`M` 周期性の一般形） | `<commutator_of_H_and_Z_Y>` の場合分けの代用 |
| `Ising2D.dvd_succ_sub_iff_eq_nextSite` | `M ∣ (k_1 - k_2 + 1) ⟺ k_2 = nextSite k_1`（原文の 2 通りの場合分けの一意性） | `<H1_H2_via_hatZ_hatY>` |
| `Ising2D.firstSign_nextSite` | `hat(Z)^{(±)}` の `j = 1` の係数と `H_1^{(±)}` の `m = M` の係数が同じ `η` で対応すること | 同上 |
| `Ising2D.H1_eq_hat_sum` / `H2_eq_hat_sum` | `H_1^{(±)} = (1/M)∑_j e^{-i2πj/M} hat(Y)_j hat(Z)^{(±)}_{-j}`、`H_2 = (1/M)∑_j hat(Z)^{(-)}_{-j} hat(Y)_j` | `<H1_H2_via_hatZ_hatY>` |
| `Ising2D.sum_deltaMod_select` | `∑_{j=1}^M δ^M_{μ-j,0} F(j) = F(μ)`（`F` が `M` を法として合同不変なら） | `<commutator_of_H_and_Z_Y>` の 3 通りの場合分けの代用 |
| `Ising2D.sum_hatY` / `sum_expPhase_neg_smul_hatY` | `∑_j hat(Y)_j = M Y_M`、`∑_j e^{i2πj/M} hat(Y)_j = M Y_1` | 同上（**原文が `0` と置いた項の正体**） |
| `Ising2D.hatCliffordTriple` | `hat(Z)^{(η)}, hat(Z)^{(-η)}, hat(Y)` を必要十分版の Clifford 3 族として与える橋渡し | 同上 |
| `Ising2D.lie_H1_hatZ_same` | `[H_1^{(±)}, hat(Z)_μ^{(±)}] = 2e^{-iθ_μ}hat(Y)_μ` | `<commutator_of_H_and_Z_Y>` (1) |
| `Ising2D.lie_H1_hatY` | `[H_1^{(±)}, hat(Y)_μ] = -2e^{iθ_μ}hat(Z)_μ^{(±)}` | 同 (3) |
| `Ising2D.lie_H2_hatZMinus` | `[H_2, hat(Z)_μ^{(-)}] = -2 hat(Y)_μ` | 同 (4) |
| `Ising2D.lie_H2_hatY` | `[H_2, hat(Y)_μ] = 2 hat(Z)_μ^{(-)}` | 同 (6) |
| `Ising2D.lie_H1_hatZ_opp` | `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2e^{-iθ_μ}hat(Y)_μ - 4e^{-iθ_μ}Y_M`（**原文 (2) の訂正版**） | 同 (2) |
| `Ising2D.lie_H2_hatZPlus` | `[H_2, hat(Z)_μ^{(+)}] = -2 hat(Y)_μ + 4e^{-iθ_μ}Y_1`（**原文 (5) の訂正版**） | 同 (5) |
| `Ising2D.Y_ne_zero` | `Y_m ≠ 0`（`Y_m^2 = I` より） | 上 2 件の反証に使用 |
| `Ising2D.lie_H1_hatZ_opp_ne_orig` / `lie_H2_hatZPlus_ne_orig` | **原文 (2), (5) が偽であることの証明** | 同上 |

## 章 009〜020 の形式化（2026-07-27）— 章ごとの正本は `lean/docs/`

**分配関数の定義から Onsager の厳密解までの経路が、Lean 側で通った。**
結論は `Ising2D.onsager_exact_solution`（`Ising2D/Part018/`）である。

章ごとの詳細——形式化した定理の一覧、具体版と必要十分版の対応表、必要十分版で判明した本質、
形式化できなかった主張とその理由——は、**各章のドキュメントが正本**である。
この README に転記せず、そちらを参照すること。

| 章 | 内容 | Lean | ドキュメント |
| --- | --- | --- | --- |
| 009 | 転送行列 `V` の固有値（個数演算子・同時固有空間分解・`c = (2 sinh 2K_2)^{M/2}`） | `Part009/` | [ch009](docs/ch009-formalization.md) |
| 010 | 橋渡し（分配関数と Pauli 表示の同一視・偶奇セクター分解） | `Part010/` | [ch010](docs/ch010-formalization.md) |
| 011 | 最大固有値（Rayleigh 商の上限による分配関数の挟み撃ち） | `Part011/` | [ch011](docs/ch011-formalization.md) |
| 012 | 自由エネルギーと熱力学極限（Onsager の表式） | `Part012/` | [ch012](docs/ch012-formalization.md) |
| 013 | 偶セクターの半整数運動量モード | `Part013/` | [ch013](docs/ch013-formalization.md) |
| 014 | 偶セクターでの `T` の作用 | `Part014/` | [ch014](docs/ch014-formalization.md) |
| 015 | `A(θ~)` の対角化 | `Part015/` | [ch015](docs/ch015-formalization.md) |
| 016 | 偶セクターのフェルミオン（`V^{(+)} = c V̌'`） | `Part016/` | [ch016](docs/ch016-formalization.md) |
| 017 | 偶セクターの固有値 | `Part017/` | [ch017](docs/ch017-formalization.md) |
| 018 | 偶セクターの完結（**`onsager_exact_solution`**） | `Part018/` | [ch018](docs/ch018-formalization.md) |
| 019 | 最大固有値の所在（`c(M) = c_+(M)`、偶セクターへの確定） | `Part019/` | [ch019](docs/ch019-formalization.md) |
| 020 | 臨界点での比熱の対数発散 | `Part020/` | [ch020](docs/ch020-formalization.md) |

### 2 本立てが出した最大の答え

**整数運動量版（章 004〜009）と半整数運動量版（章 013〜017）は、同じ必要十分版の別の特殊化である。**

- `e^{-iθ~}` は 1 の原始 `2M` 乗根 `ξ` であり、半整数運動量とはその**奇数周波数** `ξ^{j(2μ-1)}`、
  整数運動量とは `ζ = ξ^2` の偶数周波数のことである。本文が「仕組みは 1 つの等式
  `e^{-iMθ~} = -1` に集約される」と書く等式の正体は `ξ^M = -1` で、その証明は
  「`(ξ^M)^2 = 1` かつ原始性から `≠ 1`、体だから `-1`」の 3 行である。
  指数関数も円周率も効いていない（`NecSuf/AntiperiodicFourier.lean`）。
- 対の添字が `μ+ν ≡ 0` から `≡ 1` へずれる理由は `(2μ-1)+(2ν-1) = 2(μ+ν-1)` の `-1` の 1 点だけ。
- 章 013・014・017 の大半は、章 004〜009 の必要十分版をそのまま特殊化して得られた
  （逆離散 Fourier 変換だけは新設が必要だったが、骨格は同一）。

### 半整数運動量で消える例外処理

**半整数運動量では `γ_2(θ~_μ) ≠ 0` が常に成り立つ**（`Ising2D.gamma2_thetaTilde_ne_zero`、章 015）。
`sin θ~_μ = 0` となるのは `θ~_μ = π`（`M` 奇数）だけで、そのとき `-c_1 = s_1 c_2 > 0` で矛盾する。
したがって整数運動量にあった臨界点の例外処理（`μ = M` の除外、`m = M-1`）は偶セクターでは不要である。
さらに、章 008 で問題になった**平方根の分枝の一致**（原文の穴）も、半整数運動量では係数が
非負実数 `|γ_2(θ~_μ)|` になるため**生じない**（`lean/docs/ch016-formalization.md`）。

### 実数解析へ移行した箇所（README 2 節の要求）

- 章 012 の `riemann_sum_to_integral` ただ 1 つで、外部から持ち込むのは Heine–Cantor と
  連続関数の Riemann 可積分性の 2 つ（ただし `γ` の連続性を示すのに `cos` / `√` / `log` の
  連続性も使っており、本文の「2 つだけ」という記述は不正確。`docs/tasks/` に記録済み）。
- 章 020（臨界点）は別途 (R3)〜(R6) を持ち込む。うち mathlib に原文の形で無いのは
  **(R5)（連続性だけを仮定した積分記号下の微分）だけ**である。

### 形式化の過程で見つかった人手証明の問題

**本文は一切編集していない**（本文の修正は別セッションの担当）。指摘は
`docs/tasks/2026-07_lean-ch009-013/` に一次情報つきで記録した（13 件）。
結論を覆す誤りは見つかっていない。内訳は、添字指定の誤り（章 011 の `trace_power_sandwich`
Step 2。結論は正しい）、根拠の欠落（章 011 の `c_±(M)` の `sup` が定義できること。
章 019 が `𝓕^{(-)}` 側を埋めた）、記述の不正確さ（章 012 の「外部事実は 2 つだけ」）、
過剰な仮定・冗長な手順（章 011・014・017・018・019・020）である。

## 形式化の過程で見つかった原文の問題

| 箇所 | 問題 | 対応 |
| --- | --- | --- |
| `parts/002_線型空間の一般論/000_theorem_...`（`<tensor_basis>`） | 「各元が基底」「添字 `m` の二重使用」 | `Ising2D/Part002/Theorem000_TensorBasis.lean` 冒頭に修正版を明記 |
| `parts/004_転送行列/000_definition_...`（`<def_transfer_matrix_symbols>`） | `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の `+` は**積の誤り**（`M = 2` で反例） | `Ising2D/Part004/Definition000_...` 冒頭に記載。`Z_mul_Y_same`（`Z_m Y_m = -√-1 σ^x_m`）と `xString_succ_eq` が積であることの根拠 |
| `parts/006_ZとYの反交換関係/000_claim_...`（`<anticommutator_of_Z_and_Y>`） | `[Z_μ, Y_ν]₊`, `[Y_μ, Y_ν]₊` の証明が TODO のまま | Lean 側で 3 式とも証明済み（`Ising2D/Part006/Claim000_AnticommutatorZY.lean`） |
| `parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` | 形式化時点で証明が「TODO: 証明略」のままだった（その後、別経路の人手証明が追記されている）。また線型独立性は**族**の性質なのに集合 `{Z_1,…,Y_M}` で述べている | Lean 側で証明済み（`Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean`）。族の形（`ZY_linearIndependent`）と集合の形（`ZYSet_linearIndepOn`）の両方を用意 |
| `parts/007_hatZとhatYの反交換関係/000_claim_...`（`<anticommutator_of_hat_Z_and_hat_Y>`） | `[hat(Z), hat(Y)]₊` と `[hat(Y), hat(Y)]₊` を「同様」として省略（原文自身が省略と明記） | Lean 側で 4 式とも証明済み（`Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean`） |
| `transfer_matrix_001_definition_symbols` と `transfer_matrix_011_definition_H1_H2`（`V_2` の 2 つの表式） | 一方は `exp(K_2^*(σ^x_1+⋯+σ^x_M))`、他方は `exp(√-1 K_2^* H_2)` と書かれているが、一致の根拠（`√-1 Z_m Y_m = σ^x_m`）が明示されていない | `Ising2D/Part004/Definition010_H1H2V1V2.lean` 冒頭に記載。`I_smul_H2_eq_sum_sigmaX` として証明 |
| `TV1_hatZ_hatY_017_definition_A_theta`（`def_A_theta`）と `TV1_hatZ_hatY_018_claim_T_V_action`（`T_V_hatZ_hatY`） | `A(θ)` の非対角成分に `c_2` が現れるが、`B_1 B_2 B_1` を計算すると同じ位置に出るのは `c_2^*` である。一致には双対関係から従う等式 `c_2^* = s_2^* c_2` が要るのに、原文はどこにも書いていない | `Ising2D/Part008/Definition016_TV.lean` 冒頭に記載。`B1_mul_B2_mul_B1_eq_explicit` / `B1_mul_B2_mul_B1_eq_AMat` の仮定 `hdual` として明示 |
| `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（`ホロノミック量子場_p142下段_1`） | （かつて）ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）に依存し、本リポジトリでは未形式化だった | **解消済み（2026-07-26）**。`Ising2D/Part008/Claim012_TVActions.lean` の `actsBy_TConj_V1half` / `actsBy_TConj_V2` として証明した。係数を独立に導出して原文の `cosh K_1`, `±i e^{∓iθ_μ} sinh K_1`, `cosh 2K_2^*`, `±i sinh 2K_2^*` と突き合わせた結果、**原文の誤りは無かった**（`B1mat_eq_twoDimConjMat` / `B2mat_eq_twoDimConjMat`） |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_022`（`gamma_2_theta_is_0`） | 形式化時点の原文は `γ_2(θ_μ) = 0` の同値条件で **`s_2^* = 0` の場合を落としていた**（`γ_2` は `s_2^*` を因子に持つ）。また「`sin θ_μ = 0 ⟺ μ = ±M`」は単独では偽で、正しくは `M ∣ 2μ`（`M` が偶数なら `μ = ±M/2` も該当） | **並行して原文側が修正済み**（現在は `K_1, K_2 ∈ ℝ_{>0}` を前提に置き、`μ = ±M/2` が排除される理由も明記）。Lean 側は `gamma2_eq_zero_iff` と `sin_thetaMu_eq_zero_iff` として機械的裏づけを残した |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_035`（`det_A_theta`） | `det A(θ_μ) = 1` は `A(θ)` の定義からは出ず、**`c_2 s_2^* = c_2^*`（双対関係の帰結）が要る**。原文は `A = B_1B_2B_1` からこれを出しているが、`B_1, B_2` には `c_2^*, s_2^*` しか現れず `c_2` は展開の結果 `c_2^*/s_2^*` として出る。つまり (iii) は `factorization_of_A_theta`（proof が原文では TODO）に埋め込まれた前提 | `Ising2D/Part008/Claim027_EigenATheta.lean` の `det_AMat`（無条件）と `det_AMat_eq_one`（3 関係を仮定）に分離 |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_027`（`eigenvector_of_A_theta`） | 固有値と固有ベクトルの符号対応（`λ_± = γ_1 ± √(-γ_2γ_2)` と `v_± = c(±i√(γ_2γ_2), γ_2(-θ))`）は、**`arg^{[0,2π)}` 分枝での `√(-1·z) = -√(-1)√z` を使ってはじめて整合する**。原文は proof 中でこの分枝規約を導いているが statement 側に分枝の指定が無い | 検算の結果**原文は正しい**。Lean 側は平方根関数を使わず `t^2 = γ_2(θ)γ_2(-θ)` の仮定形にし、`i t` 側の固有値が `γ_1 - i t` であることを明示（`AMat_mulVec_col_pos`） |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_028`（`diagonalization_P_D`） | `A(θ_μ) = P_μ D_μ P_μ^{-1}` と書くが、**`P_μ` が可逆であること（`det P_μ ≠ 0`）を確認していない** | `det_Pmat` / `det_Pmat_ne_zero` で `det P_μ = i t/(2(√M)^2γ_2(-θ_μ))` を計算し、`γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で非零を証明 |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_032`（`anticommutator_of_psi`） | `M ∣ μ+ν` のとき、原文は `√(γ_2(θ_ν)γ_2(-θ_ν)) = √(γ_2(θ_μ)γ_2(-θ_μ))` を根号の中身が等しいことだけから使っている。**中身が等しいことから従うのは `t_ν = ±t_μ` までで、`μ` と `ν` で分枝が同じであることは自明でない。**検算の結果、逆分枝だと 3 式のうち第 1・第 2 式が偽になる（`t_μ ≠ 0` なので符号は結論に効く） | `Ising2D/Part008/Definition030_Fermi.lean` 冒頭に検算を記載。同一分枝の選択を仮定 `hbr : (M:ℤ) ∣ (μ+ν) → tν = tμ` として明示 |
| `008_TV1_hatZ_hatY_part1.mjs` の `TV1_hatZ_hatY_001`（`commutator_of_H_and_Z_Y`）の第 2 式 | `[H_1^{(±)}, hat(Z)_μ^{(∓)}] = 2e^{-iθ_μ}hat(Y)_μ` は**偽**。原文自身が最終段で余分な項 `-(4/M)e^{-iθ_μ}∑_{k=1}^M Y_k M δ^M_{(k,0)}` を持ちながら、それを `0` と置いて結論している。`k ∈ {1,…,M}` で `δ^M_{(k,0)} = 1` になるのは `k = M` なので、この項は `-4e^{-iθ_μ}Y_M` であり消えない（原文ブロックの `conversion.notes` にも「正当化が不完全」と記録済み） | `Ising2D/Part008/Claim001_CommutatorHZY.lean` 冒頭に記載。訂正版を `lie_H1_hatZ_opp` として証明し、原文の主張が偽であることを `lie_H1_hatZ_opp_ne_orig` で証明した |
| 同ブロックの第 5 式（`[H_2, hat(Z)_μ^{(+)}]`） | 原文の値 `-2hat(Y)_μ + (1/M)∑_j(-2e^{-i(2π/M)(-j+μ)}hat(Y)_j)` は**偽**。`-[hat(Z)_μ^{(+)}, hat(Z)_{-j}^{(-)}]₊` の展開でマイナス符号を第 1 項にしか分配しておらず（第 2 項の符号が変わっていない）、さらに次の行で係数 `4` が `2` になっている。正しくは `-2hat(Y)_μ + 4e^{-iθ_μ}Y_1`（`hat(Z)^{(+)}_μ = hat(Z)^{(-)}_μ - 2e^{-iθ_μ}Z_1` と `[H_2, Z_1] = -2Y_1` からの独立な検算でも一致） | 同上。訂正版を `lie_H2_hatZPlus`、原文が偽であることを `lie_H2_hatZPlus_ne_orig` で証明した。**後段（`nesting_of_commutator_of_H_and_Z` 以降）が使うのは (1)(3)(4)(6) の 4 本だけ**なので、この誤りは後段の結論には波及しない |
| `008_TV1_hatZ_hatY_part2.mjs` の `TV1_hatZ_hatY_031`（`commutation_V_psi`） | 原文の証明は `T_V_hatZ_hatY`（かつて未形式化）に依存する | **解消済み（2026-07-26）**。`Ising2D/Part008/Claim012_TVActions.lean` の `TV_psiDag` / `TV_psi` / `TV_psiDag_psi` が無条件版。`Definition030_Fermi.lean` の仮定つき版（`T` が任意の線型写像の一般形）も残してある |

## 今後の方針

- **章 009〜020 は形式化済み（2026-07-27）**。本文の全 20 章のうち、機械証明が無い章は無くなった。
  結論は `Ising2D.onsager_exact_solution`。残っている作業は各章のドキュメント
  （`lean/docs/ch0NN-formalization.md`）の「形式化できなかった主張とその理由」節にまとまっている。
  主なものは、(a) 同時固有空間分解の `DirectSum.IsInternal` 形と「対角化可能」の主張
  （原文に無い `Submodule` 言語への翻訳が必要。後段が使う固有値と重複度は形式化済み）、
  (b) `tr(εV^{(+)})` を配置基底で直接計算する枝（章 018。主鎖とは独立な組合せ論的計算）。
- **次の形式化対象**（人手証明側で自己完結しており依存が浅い順）
  1. ~~`transfer_matrix_012_claim_H1_H2_via_hatZ_hatY`（`<H1_H2_via_hatZ_hatY>`）~~ **形式化済み**
     （`Ising2D/Part004/Claim011_H1H2ViaHat.lean`）
  2. ~~`parts 008` の 001〜005（`exp(X) Y exp(-X)` の級数展開と**ネストした交換子の
     テイラー係数抽出**）、およびそこから `T_V_hatZ_hatY` / `commutation_V_psi` を
     無条件の定理にすること~~ **完了（2026-07-26）**。
     `<exp_X_Y_exp_-X>` と `ad X` が 2 次元部分空間を保つ場合の閉じた形（cosh/sinhc）は
     `Ising2D/NecSuf/ExpConjugation.lean` と `Ising2D/Part008/Claim006_ExpConjugation.lean`、
     `<commutator_of_H_and_Z_Y>` は `Ising2D/Part008/Claim001_CommutatorHZY.lean`
     （必要十分版は `Ising2D/NecSuf/CommutatorClifford.lean`）。
     この 2 つを `matExp_conj_two_dim_z` / `..._y` に代入して
     `<extract_taylor_coefficient_of_Z_Y>` / `<ホロノミック量子場_p142下段_1>` の
     `B_1(θ_μ)`, `B_2` を導き（`Ising2D/Part008/Claim012_TVActions.lean`、必要十分版は
     `Ising2D/NecSuf/TVAction.lean`）、`Ising2D.TV_hatZ_hatY_of_action` の仮定
     `hT1`, `hT2` と `Ising2D.TV_psiDag_of_action` / `TV_psi_of_action` の仮定 `hT` を
     除去した無条件版 `Ising2D.TV_hatZ_hatY` / `TV_psiDag` / `TV_psi` / `TV_psiDag_psi` を得た。
     **これにより「未形式化に由来する仮定」は本リポジトリから無くなった。**
     残っている非自明な仮定は次の 2 種類だけで、いずれも**数学的に必要**なものである。
     - `ψ` の反交換関係の `hbr`（平方根の分枝の選択）— **原文の穴**に由来
     - `B_1B_2B_1 = A(θ)` の `hdual : s_2^* c_2 = c_2^*`（双対関係の帰結）と、
       `IsingConst` の成分が `K_1, K_2^*` の双曲線関数であること — **原文が明示していない前提**

     いずれも上の「原文の問題」表を参照
  3. ~~`V_1` を `Z, Y, ε` で表す表式（`V1_in_Z_Y_epsilon`）~~ **形式化済み**
     （`Ising2D/Part010/V1JordanWigner.lean`）。`V_2` を `Z, Y` で表す表式は未形式化。
  4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。
     現状は再帰形 `xString_succ_eq` まで。順序つき積（`List.prod` / `Finset.noncommProd`）の
     整備が要る
- **mathlib に無いことが分かっているもの**
  - ~~`Real.arccosh`（自前定義が必要）~~ **これは誤りだった（2026-07-27 に訂正）**。
    現行 mathlib（v4.32.1）には `Real.arcosh`（`arccosh` ではない綴り）が同じ定義式で存在する。
    章 012 の形式化で確認済み（`Ising2D/NecSuf/Arcosh.lean`, `lean/docs/ch012-formalization.md`）。
  - **等分割リーマン和から積分への収束**（`(1/M)∑ g(t_μ) → (1/(b-a))∫g`）。
    これは本当に無い（章 012 で grep により確認）。自前に証明した
    （`Ising2D/NecSuf/RiemannSum.lean` の `tendsto_riemann_sum`）。
    使う外部事実は Heine–Cantor と連続関数の可積分性だけで、いずれも mathlib にある。
  - **連続性だけを仮定した積分記号下の微分**（章 020 が持ち込む (R5)）。
    mathlib にあるのは可測性・優関数の仮定つきの形で、原文が宣言する形そのままは無い
    （`lean/docs/ch020-formalization.md`）。
  - **トレースが「閉じた道の総和」であること**（`tr(A^{n+1}) = ∑ ...`）。無いので自前に証明した
    （`Ising2D/NecSuf/*`、章 010）。
  - `sinh t ≤ t cosh t`（章 020 で使う初等評価。他の初等評価はすべて mathlib にある）。
  - 一般の `Ad(exp X) = exp(ad X)`。ただし本プロジェクトは級数展開ルート
    （`parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003, 007`）を持つので回避可能。
    **回避済み**: `Ising2D/NecSuf/ExpConjugation.lean` で、リー環を使わず
    「`L_X` と `R_X` が可換」＋「可換な作用素の指数法則 `NormedSpace.exp_add_of_commute`」
    だけから証明した。
  - `sinhc`（`sinh s / s` を `s = 0` へ延長したもの）。自前定義した
    （`Ising2D.NecSuf.sinhc`）。`Complex.hasSum_cosh` / `Complex.hasSum_sinh` は
    `Mathlib.Analysis.SpecialFunctions.Trigonometric.Series` にある。
- **leanblueprint の導入検討**: 人手証明（Typst / 構造化TeX）と Lean の対応を機械的に追跡し、
  未形式化箇所を可視化する。導入の前提として、`docs/tasks/2026-07_toolchain-and-rigor` の
  Phase 2（構造化TeX への全面移行）の完了状況を確認する必要がある
  （leanblueprint は LaTeX ベースなので、移行後のソースに対して張るのが自然）。
