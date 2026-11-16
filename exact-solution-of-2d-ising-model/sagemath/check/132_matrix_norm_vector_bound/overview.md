# SageMath Check: 132_matrix_norm_vector_bound

## 対象

**対象ラベル**: `matrix_norm_vector_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: ‖Aw‖ ≤ ‖A‖‖w‖、およびその証明が使う行列 W（第 1 列が w、他が 0）の構成

ランク 1 の A と対応する w で等号になることも確認する（評価が緩すぎないこと）。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_vector_bound.sage` | 不等式と等号 | 155 | 2.237e-16 | **PASS** |
| 02 | `check_02_proof_path_W.sage` | 証明の経路: ‖AW‖ = ‖Aw‖、‖W‖ = ‖w‖ | 358 | 2.883e-16 | **PASS** |
| 03 | `check_03_zero_columns_chain.sage` | 第 2 列以降の成分の鎖 Σ a_ik W_kj = Σ a_ik·0 = Σ 0 と、K = ℂ の Σ 0_C = 0_C、K = ℝ の Σ 0 = ι(n)·0 = 0。和は左から 1 項ずつ足す定義どおり。n = 1..4、QQ 上の多項式環の厳密計算。否定コントロール付き | 8 | 厳密 | **PASS** |
| 04 | `check_04_zero_columns_absolute_square_chain.sage` | ‖AW‖ と ‖W‖ の鎖の前の準備: 2 ≤ j ≤ n の \|(AW)_ij\|^2・\|W_ij\|^2 = \|0\|^2 = 0^2 = 0·0 = 0（matrix_norm_triangle_inequality の Step 1・square_of_real_number_is_product・real_times_zero_is_zero）と、内側の和 Σ_j \|X_ij\|^2 を第 1 列の項 \|X_i1\|^2 に縮める等式（finite_sum_of_real_numbers_with_single_nonzero_term）。K = ℝ と K = ℂ、n = 1..4、QQ 上の多項式環の厳密計算。否定コントロール付き | 10 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

01 は不等式そのもの（直接経路）を見ている。02 は本文が劣乗法性へ帰着させるために構成する行列 W を実際に組み立て、‖AW‖ = ‖Aw‖ と ‖W‖ = ‖w‖ を確かめる。証明ステップの書き写しミス（列の位置・共役・転置の取り違え）はここで落ちる。試験対象には乱数・退化行列に加え Ising 側の実際の作用素（`hatZ`, `H_1`, `H_2`）と、w として零ベクトル・基底ベクトルも含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 132
```

実行ログは `sagemath/check/132_matrix_norm_vector_bound/logs/` に保存してある（この表の数値はそのログから取った）。
