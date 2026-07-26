# SageMath Check: 119_negative_number_to_sqrt

## 対象

**対象ラベル**: `negative_number_to_sqrt` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`

- 範囲: x < 0 について x = −√((−x)²)

主張が x<0 に限られる理由（x>0 では符号が逆になる）も併せて確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_negative.sage` | 等式と符号条件の必要性 | 138 | 2.183e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 119
```

実行ログは `sagemath/check/119_negative_number_to_sqrt/logs/` に保存してある（この表の数値はそのログから取った）。
