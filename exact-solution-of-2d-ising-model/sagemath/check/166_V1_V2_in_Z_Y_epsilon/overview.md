# SageMath Check: 166_V1_V2_in_Z_Y_epsilon

## 対象

**対象ラベル**: `V1_V2_in_Z_Y_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.mjs`

- 範囲: V₁ = exp(iK₁(Y₁Z₂+…+Y_{M−1}Z_M − εY_MZ₁))、V₂ = (2s₂)^{M/2}exp(iK₂*(Z₁Y₁+…+Z_MY_M))

**指数の肩の一致（check_01）と行列としての一致（check_02）を分けている。** 行列指数を取る前の段階で比べておくと、不一致が出たときに原因を切り分けられる。左辺は <def_transfer_matrix_symbols> の σ^zσ^z / σ^x による定義から、右辺は Z,Y,ε から独立に構成している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_exponents.sage` | 指数の肩の一致、各項ごとの Jordan–Wigner 置換、境界項に ε が付くこと、ε の積表示 | 55 | 0.000e+00 | **PASS** |
| 02 | `check_02_V1_V2_matrices.sage` | V₁, V₂ の行列としての一致と、規格化因子 (2s₂)^{M/2} の必要性 | 72 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

check_01 で確認した各項の置換 σ^z_mσ^z_{m+1} = i Y_m Z_{m+1}（m<M）と σ^z_Mσ^z_1 = −i ε Y_M Z_1 が、境界項にだけ ε が現れる理由をそのまま示している。ε = i^M(Z₁Y₁)(Z₂Y₂)…(Z_MY_M) が**積であって和ではない**ことも確認済み。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 166
```

実行ログは `sagemath/check/166_V1_V2_in_Z_Y_epsilon/logs/` に保存してある（この表の数値はそのログから取った）。
