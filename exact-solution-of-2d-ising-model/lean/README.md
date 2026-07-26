# Lean 4 + mathlib4 による機械的証明

`exact-solution-of-2d-ising-model` の人手証明を Lean 4 で機械的に検証するためのプロジェクト。
SageMath による数値検証（`sagemath/`）と併用する。

**人手証明の正本は `structured-latex/content/*.mjs`（構造化TeX、140ブロック）**である。
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
  | （表現の選択と両表現の同型） | `Ising2D/Basic.lean`, `Ising2D/Representation.lean` |

- 各 Lean ファイルの冒頭コメントに、対応する `.typ` ファイル名と Typst のラベル（`<...>`）を書く。
- 原文のステートメントをそのまま形式化できない場合（記号の重複・「元」と「族」の混同など）は、
  **冒頭コメントに原文の問題点と、形式化した修正版ステートメントを明記する**
  （例: `Ising2D/Part002/Theorem000_TensorBasis.lean`）。

## `Mat(2, ℂ)^{⊗M}` の表現方針（決定事項）

人手証明の `Mat(2, CC)^(times.o M)` は、Lean では次の 2 通りに表せる。

| | 定義 | 実装 |
| --- | --- | --- |
| 抽象テンソル冪 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.AbstractTensorPow` |
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
| `Ising2D.TConj` | `T_g : X ↦ g X g⁻¹` を **ℂ-代数自己同型**として | `def_T_g` |
| `Ising2D.TConj_linear` / `TConj_trans` | `T_g` の ℂ-線型性、`T_g ∘ T_h = T_{gh}` | `linearity_of_T`, `conjugation_is_ring_homomorphism` (3) |
| `Ising2D.TV` | `T_{(V)}(X) = T_{g_1}(T_{g_2}(T_{g_1}(X)))` | `def_T_V` |
| `Ising2D.TV_eq_TConj` | `T_{(V)} = T_{g_1 g_2 g_1}`（合成則の帰結） | `def_T_V` の系（新規） |
| `Ising2D.TV_linear` / `TV_mul` / `TV_one` | `T_{(V)}` の ℂ-線型性・乗法性・単位性 | `linearity_of_T` |
| `Ising2D.ActsBy` | 行ベクトル記法 `(T z, T y) = (z, y) B` | `T_V_hatZ_hatY` の記法 |
| `Ising2D.ActsBy.comp` | 合成則 `Q P`（原文の `B_1 B_2 B_1` の根拠） | `T_V_hatZ_hatY` の証明 |
| `Ising2D.ActsBy.eigen` | **固有ベクトルの移送**（`B v = λ v ⇒ T(v_0 z + v_1 y) = λ(⋯)`） | 後段（`ψ` が `V` の固有ベクトル）への一般補題 |
| `Ising2D.B1mat` / `B2mat` / `Amat` | `B_1(θ)`, `B_2`, `A(θ)` | `def_A_theta` と `T_V_hatZ_hatY` の証明 |
| `Ising2D.B1_mul_B2_mul_B1_eq_Amat` | `B_1(θ) B_2 B_1(θ) = A(θ)` | 同上（**双対関係 `c_2^* = s_2^* c_2` が必要**） |
| `Ising2D.TV_hatZ_hatY_of_action` | `T_{(V)}` の `hat(Z)^{(-)}, hat(Y)` への作用（**`B_1`, `B_2` の作用を仮定**） | `T_V_hatZ_hatY` |

## 形式化の過程で見つかった原文の問題

| 箇所 | 問題 | 対応 |
| --- | --- | --- |
| `parts/002_線型空間の一般論/000_theorem_...`（`<tensor_basis>`） | 「各元が基底」「添字 `m` の二重使用」 | `Ising2D/Part002/Theorem000_TensorBasis.lean` 冒頭に修正版を明記 |
| `parts/004_転送行列/000_definition_...`（`<def_transfer_matrix_symbols>`） | `ε = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の `+` は**積の誤り**（`M = 2` で反例） | `Ising2D/Part004/Definition000_...` 冒頭に記載。`Z_mul_Y_same`（`Z_m Y_m = -√-1 σ^x_m`）と `xString_succ_eq` が積であることの根拠 |
| `parts/006_ZとYの反交換関係/000_claim_...`（`<anticommutator_of_Z_and_Y>`） | `[Z_μ, Y_ν]₊`, `[Y_μ, Y_ν]₊` の証明が TODO のまま | Lean 側で 3 式とも証明済み（`Ising2D/Part006/Claim000_AnticommutatorZY.lean`） |
| `parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ` | 形式化時点で証明が「TODO: 証明略」のままだった（その後、別経路の人手証明が追記されている）。また線型独立性は**族**の性質なのに集合 `{Z_1,…,Y_M}` で述べている | Lean 側で証明済み（`Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean`）。族の形（`ZY_linearIndependent`）と集合の形（`ZYSet_linearIndepOn`）の両方を用意 |
| `parts/007_hatZとhatYの反交換関係/000_claim_...`（`<anticommutator_of_hat_Z_and_hat_Y>`） | `[hat(Z), hat(Y)]₊` と `[hat(Y), hat(Y)]₊` を「同様」として省略（原文自身が省略と明記） | Lean 側で 4 式とも証明済み（`Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean`） |
| `transfer_matrix_001_definition_symbols` と `transfer_matrix_011_definition_H1_H2`（`V_2` の 2 つの表式） | 一方は `exp(K_2^*(σ^x_1+⋯+σ^x_M))`、他方は `exp(√-1 K_2^* H_2)` と書かれているが、一致の根拠（`√-1 Z_m Y_m = σ^x_m`）が明示されていない | `Ising2D/Part004/Definition010_H1H2V1V2.lean` 冒頭に記載。`I_smul_H2_eq_sum_sigmaX` として証明 |
| `TV1_hatZ_hatY_017_definition_A_theta`（`def_A_theta`）と `TV1_hatZ_hatY_018_claim_T_V_action`（`T_V_hatZ_hatY`） | `A(θ)` の非対角成分に `c_2` が現れるが、`B_1 B_2 B_1` を計算すると同じ位置に出るのは `c_2^*` である。一致には双対関係から従う等式 `c_2^* = s_2^* c_2` が要るのに、原文はどこにも書いていない | `Ising2D/Part008/Definition016_TV.lean` 冒頭に記載。`B1_mul_B2_mul_B1_eq_Amat` の仮定 `hdual` として明示 |
| `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`（`ホロノミック量子場_p142下段_1`） | ネストした交換子のテイラー係数抽出（`parts 008` の 001〜005）に依存し、本リポジトリでは未形式化 | `Ising2D/Part008/Definition016_TV.lean` では**明示的な仮定 `hT1`, `hT2`** として持ち、そこから先は完全に証明（未証明の穴は残していない） |

## 今後の方針

- **次の形式化対象**（人手証明側で自己完結しており依存が浅い順）
  1. `transfer_matrix_012_claim_H1_H2_via_hatZ_hatY`（`<H1_H2_via_hatZ_hatY>`）。
     `expPhase_sum`・`hatZ`/`hatY`・`H1`/`H2` が揃い、添字の巡回も `Ising2D.nextSite`
     （`Part004/Definition010_H1H2V1V2.lean`）で確定したので、原文の二重和の計算をそのまま写せる
  2. `parts 008` の 001〜005（`exp(X) Y exp(-X)` の級数展開と**ネストした交換子の
     テイラー係数抽出**）。ここが埋まると `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`
     （`B_1(θ)`, `B_2` の作用）が証明でき、`Ising2D.TV_hatZ_hatY_of_action` の仮定
     `hT1`, `hT2` を外して `T_V_hatZ_hatY` を無条件の定理にできる。
     **現状で唯一残っている仮定はこの 2 つだけ**である
  3. `V_1, V_2` を `Z, Y, ε` で表す表式（`parts/004_転送行列/002_claim_...`）。
     `V_1`, `V_2` の定義自体は `Ising2D.V1`, `Ising2D.V2` で形式化済み
  4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。
     現状は再帰形 `xString_succ_eq` まで。順序つき積（`List.prod` / `Finset.noncommProd`）の
     整備が要る
- **mathlib に無いことが分かっているもの**
  - `Real.arccosh`（自前定義が必要）
  - 一般の `Ad(exp X) = exp(ad X)`。ただし本プロジェクトは級数展開ルート
    （`parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003, 007`）を持つので回避可能。
- **leanblueprint の導入検討**: 人手証明（Typst / 構造化TeX）と Lean の対応を機械的に追跡し、
  未形式化箇所を可視化する。導入の前提として、`docs/tasks/2026-07_toolchain-and-rigor` の
  Phase 2（構造化TeX への全面移行）の完了状況を確認する必要がある
  （leanblueprint は LaTeX ベースなので、移行後のソースに対して張るのが自然）。
