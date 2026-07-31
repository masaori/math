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

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

01 は不等式そのもの（直接経路）を見ている。02 は本文が劣乗法性へ帰着させるために構成する行列 W を実際に組み立て、‖AW‖ = ‖Aw‖ と ‖W‖ = ‖w‖ を確かめる。証明ステップの書き写しミス（列の位置・共役・転置の取り違え）はここで落ちる。試験対象には乱数・退化行列に加え Ising 側の実際の作用素（`hatZ`, `H_1`, `H_2`）と、w として零ベクトル・基底ベクトルも含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 132
```

実行ログは `sagemath/check/132_matrix_norm_vector_bound/logs/` に保存してある（この表の数値はそのログから取った）。
