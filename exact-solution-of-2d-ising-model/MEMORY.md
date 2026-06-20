# MEMORY — exact-solution-of-2d-ising-model

## 次回やること（優先度順）

### 0. 構造化テキストのリアルタイム Web プレビュー（未着手・別ツール）

汎用ツールとしてリポジトリ直下 `realtime-web-preview/` に切り出した。要件は
`realtime-web-preview/docs/requirements.md`。本プロジェクトの `structured-latex/` は
その入力ソースのリファレンス実装という位置づけ。ビューア等は未実装、技術スタック未決定。

### 1. 038 の SageMath 数値検証（未実施・ローカルで実行が必要）

**重要**: この remote 実行環境には SageMath（`sage` バイナリ）が無く、numpy も既定では未導入。`sagemath/check/031`, `037` に残る PASS 記録は過去の別環境で実行したもの。**038 の数値検証は未実施。ローカル（SageMath が動く環境）で実行すること。**

検証したい内容（小さい `M`、例 M=2,3 で十分）:
- `T_(V)(x) = T_(V')(x)`、すなわち `V x V^(-1) = V' x V'^(-1)` を生成元 `Z_m, Y_m`（および基底 `sigma_k^(x,y,z)`）上で確認
- 途中の鍵となる等式: 逆DFTで `Z_m, Y_m ∈ span{hat(Z)_mu^((minus)), hat(Y)_mu}`、`Z_m Y_m = -sqrt(-1) sigma_m^x`、`P_mu` の可逆性
- フル SageMath は不要で、2×2 のテンソル積（numpy 可）で書ける

検証コードは `sagemath/check/038_claim_T_V_eq_T_Vprime/` に配置し、結果を overview.md に記録する想定。

### 2. 039 `V = cV'` の proof

038（proof 完了済み）の後に着手する。T の単射性が必要。009（クリフォード群の定義、TODO）に依存。

## 次回やること（数学的フォローアップ）

### 縮退モード `gamma_2(theta_mu) = 0` の扱い（038 の前提）

038 の proof は「`V'` が well-defined ⇒ 全 `nu ∈ {1,..,M}` で `gamma_2(theta_nu) != 0`」という標準仮定で縮退を回避している（フェルミオンは `gamma_2 != 0` のときのみ定義されるため）。裏を返すと、特定パラメータ（`c_1 = s_1 c_2`、μ=±M で縮退）では `V'`（032/037）自体が定義されない。この縮退条件を 032 か別 Claim に明記すべき（現状 032/037 は制約を書いていない）。

## 完了済み（2026-06-20）

### 038 `T_V = T_{V'}` の proof 完成

`038_claim_T_V_eq_T_Vprime.typ` の `#proof[TODO]` を 6 Step 構成の厳密証明に置換（`<T_V_eq_T_Vprime>` ラベル付与）。

- 構成: (1) 共役写像 `T_g` の乗法性 `T_g(h1 h2)=T_g(h1)T_g(h2)`・`T_g(I)=I` → (2) `mat_conj`/`linearity_of_T` で線型性 ⇒ 両写像は C-代数準同型 → (3) `psi` 上で固有値一致（030+033 と 037）→ (4) `P_mu` 可逆性で `hat(Z), hat(Y)` 上の一致 → (5) 逆DFTで `Z_m, Y_m` を復元し `Z_m Y_m = -sqrt(-1) sigma_m^x` 等で全 `sigma_k` を生成、`tensor_basis` で代数全体を生成 → (6) 任意の `x` で一致。
- MEMORY 旧方針の「線型性で対象空間全体」は不十分だった（線型包までしか届かない）。乗法性＋生成集合の議論を追加して代数全体に拡張。
- 参照のため既存の無ラベル文に最小限ラベル付与: 030→`<action_of_T_V_on_psi>`, 033(claim)→`<lambda_eq_exp_gamma>`, 010→`<def_T_g>`, 015→`<def_T_V>`, 027→`<a_theta_P_mu_D_mu>`, 004/000→`<def_転送行列記号>`, 002/000→`<tensor_basis>`。
- コンパイル検証: ローカル typst 0.13.1 は `times.o` を弾くため、一時コピーで `times.o→times.circle` 置換してコンパイル → exit 0・PDF 生成・未解決参照ゼロを確認（実ツリーは `times.o` 規約のまま）。

### `times.o` 規約について（重要・触らない）

stock typst 0.13.1 は `times.o` をエラー扱いするが、**CI（`setup-typst@v4`）の typst バージョンでは `times.o` は有効で、直近の main まで全ビルド success**。よって `times.o` がプロジェクト規約。`times.circle` への一括置換はしないこと（CI を壊すリスク）。ローカルで PDF を見たいときだけ一時コピーで置換してコンパイルする。

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
