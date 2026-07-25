# Lean 4 + mathlib4 による機械的証明

`exact-solution-of-2d-ising-model` の人手証明（正本は `parts/**/*.typ`）を Lean 4 で
機械的に検証するためのプロジェクト。SageMath による数値検証（`sagemath/`）と併用する。

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
  | `parts/002_線型空間の一般論/000_theorem_テンソル積の基底は基底のテンソル積.typ` | `Ising2D/Part002/Theorem000_TensorBasis.lean` |
  | `parts/002_線型空間の一般論/001_lemma_スカラー倍の恒等行列は全行列と可換.typ` | `Ising2D/Part002/Lemma001_ScalarIdentityCommutes.lean` |
  | `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ` | `Ising2D/Part002/Lemma003_CentralizerIsScalar.lean` |
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

## 今後の方針

- **次の形式化対象**（人手証明側で自己完結しており依存が浅い順）
  1. `parts/000_計算公式/046_...`（交換子と反交換子の恒等式）
  2. `parts/004_転送行列/000_definition_...` の `σ^x_k, σ^y_k, σ^z_k, Z_m, Y_m, ε` を
     `TensorPow M` 上で定義し、反交換関係（`parts/006_ZとYの反交換関係`）を証明する
  3. `parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ`
- **mathlib に無いことが分かっているもの**
  - `Real.arccosh`（自前定義が必要）
  - 一般の `Ad(exp X) = exp(ad X)`。ただし本プロジェクトは級数展開ルート
    （`parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003, 007`）を持つので回避可能。
- **leanblueprint の導入検討**: 人手証明（Typst / 構造化TeX）と Lean の対応を機械的に追跡し、
  未形式化箇所を可視化する。導入の前提として、`docs/tasks/2026-07_toolchain-and-rigor` の
  Phase 2（構造化TeX への全面移行）の完了状況を確認する必要がある
  （leanblueprint は LaTeX ベースなので、移行後のソースに対して張るのが自然）。
