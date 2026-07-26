# SageMath Check: 041_claim_TV1_TV2_actions

## 対象

**対象ラベル**: `ホロノミック量子場_p142下段_1` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`（ブロック `TV1_hatZ_hatY_012_claim_TV1_TV2_actions`）
- 範囲: `T_{(V_1^{(±)})^{1/2}}` と `T_{V_2}` の `hatZ_mu^{(-)}`, `hatY_mu` への作用（4 式）と、その行ベクトル×列ベクトル表示

### 何を確定させるための検証か

原文（`_old/typst/parts/008_.../011_claim_ホロノミック量子場_p142下段.typ`）は、`hatY_mu` への作用について

- scalar 表示: `-i e^{i2πμ/M} sinh(K1) hatZ_mu^{(-)} + cosh(K1) hatY_mu`
- 行列（列ベクトル）表示: 第 1 成分が `i e^{-i2πμ/M} sinh(K1)`

と書いており、**符号と exp の両方**が食い違っていた。どちらが正しいかを数値的に確定させ、
誤っている側（行列表示）を直すためにこの検証を置く。

## 検証の枠組み

`sagemath/_shared/spin_ops.sage` で `Mat(2,C)^{⊗M}` 上の演算子を明示的な複素行列として構成し
（構成の詳細は `040_claim_extract_taylor_coefficient_of_Z_Y/overview.md` を参照）、

- `(V_1^{(-)})^{1/2} = exp((1/2) i K_1 H_1^{(-)})`
- `V_2 = (2 s_2)^{M/2} exp(i K_2^* H_2)`（`s_2 = sinh 2K_2`）

を**行列指数関数として直接計算**し、`T_g(X) = g X g^{-1}` を素の行列積で評価する。
すなわち交換子の級数展開（`exp_X_Y_exp_-X`）にも `extract_taylor_coefficient_of_Z_Y` にも
依存しない独立な経路で確認している。

パラメータは `M = 3, 4, 5`、`μ ∈ calM = {-M,…,-1,1,…,M}` の全域、`(K1,K2)` は
`spin_ops.sage` の `SPIN_TEST_PARAMS`（4 組）。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_T_actions.sage | `T_{(V1)^{1/2}}`, `T_{V2}` の 4 つの作用（scalar 表示） | PASS | 最大残差 1.9e-11 (tol=1e-8) |
| 02 | check_02_hatY_column_vector.sage | `hatY` への作用の列ベクトル表示（修正後 vs 原文） | PASS | 修正版の最大残差 1.9e-11、原文版の最大残差 0.40〜15.1 |

## 検証した式

check_01:

```
T_{(V1)^{1/2}}(hatZ_mu^{(-)}) = cosh(K1) hatZ_mu^{(-)} + i e^{-iθ} sinh(K1) hatY_mu
T_{(V1)^{1/2}}(hatY_mu)       = -i e^{iθ} sinh(K1) hatZ_mu^{(-)} + cosh(K1) hatY_mu
T_{V2}(hatZ_mu^{(-)})         = cosh(2K2*) hatZ_mu^{(-)} - i sinh(2K2*) hatY_mu
T_{V2}(hatY_mu)               = i sinh(2K2*) hatZ_mu^{(-)} + cosh(2K2*) hatY_mu
```

`V_2` は前因子 `(2 s_2)^{M/2}` を明示的に付けた形で評価しており、共役 `V_2 X V_2^{-1}` で
この前因子が相殺することも同時に確認している。

check_02（列ベクトル表示、`(hatZ, hatY) (a; b) = a hatZ + b hatY`）:

```
修正後 T_{(V1)^{1/2}}(hatY_mu) = (hatZ_mu^{(-)}, hatY_mu) ( -i e^{iθ} sinh K1 ; cosh K1 )   -> 成立
原文   T_{(V1)^{1/2}}(hatY_mu) = (hatZ_mu^{(-)}, hatY_mu) (  i e^{-iθ} sinh K1 ; cosh K1 )  -> 不成立
       T_{V2}(hatY_mu)         = (hatZ_mu^{(-)}, hatY_mu) (  i sinh 2K2*      ; cosh 2K2* ) -> 成立
```

修正後の形は、下流の `calc_of_TxT_hatZxhatY`（ブロック `TV1_hatZ_hatY_014_claim_product_action_computation`）が
既に使っている `B_1(θ)` の (1,2) 成分 `-i e^{iθ} sinh K1` と一致する。すなわち原文の行列表示だけが
文書内で孤立して食い違っていた。

## 備考

- `H_1^{(±)}` の符号は `(-)` を採った。本主張は `hatZ_mu^{(-)}` に作用させているため、
  `extract_taylor_coefficient_of_Z_Y` の (h1.z)/(h1.y) を `± = -` で適用する場合に対応する。
- 一致判定は行列差の 1-ノルム、tol は 1e-8。実測の最大残差は 1.9e-11
  （`K2 = 0.1` すなわち `sinh(2K2*) ≈ 5.0` で成分の絶対値が大きくなるケース）、それ以外は 1e-14 以下。
- **不一致の判定は「ある mu で不一致」で行う（「すべての mu で不一致」ではない）。**
  2 つの列ベクトルの差は

  ```
  (i e^{-iθ} - (-i e^{iθ})) sinh(K1) hatZ = 2 i cos(θ_mu) sinh(K1) hatZ
  ```

  なので、`cos(θ_mu) = 0` となる mu では両者がたまたま一致する。実際 `M = 4` では
  `mu = ±1, ±3` で `θ_mu = ±π/2, ±3π/2` となり残差が 0 になる（check_02 はこの mu を明示的に列挙して出力する）。
  `M = 3, 5` にはそのような mu は無い。原文の行列表示が誤りであることの証拠としては、
  一致しない mu が存在すれば十分である（実測の最大残差は 0.40〜15.1）。

## 実行方法

```bash
for f in sagemath/check/041_claim_TV1_TV2_actions/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
