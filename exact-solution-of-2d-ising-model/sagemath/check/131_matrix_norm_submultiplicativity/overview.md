# SageMath Check: 131_matrix_norm_submultiplicativity

## 対象

**対象ラベル**: `matrix_norm_submultiplicativity` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/002_linear_space_general.ts`

- 範囲: ‖AB‖ ≤ ‖A‖‖B‖

ランダム行列で不等式を確認し、さらに像と核が直交する構成（A が (1,1) 成分だけ、B が (n,n) 成分だけ）では ‖AB‖=0 < ‖A‖‖B‖ と真の不等号になることを見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_submult.sage` | 劣乗法性と真の不等号になる例 | 155 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

逆向きの不等式 ‖AB‖ ≥ ‖A‖‖B‖ は成り立たない。

## 実行時に出力された観測値

```
  等号に近い（比 > 0.999）事例: 50 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 131
```

実行ログは `sagemath/check/131_matrix_norm_submultiplicativity/logs/` に保存してある（この表の数値はそのログから取った）。
