# SageMath Check: 121_multiplicative_group_of_cc

## 対象

**対象ラベル**: `multiplicative_group_of_cc` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`

- 範囲: C^× = C∖{0} が乗法群をなすこと、z^{-1} = 1/z

閉性（非零どうしの積が非零）・結合律・単位元・逆元を多数のサンプルで確認する。逆元は成分から明示的に構成したものと 1/z を突き合わせる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_group.sage` | 群の公理と逆元の表示 | 5520 | 3.163e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 121
```

実行ログは `sagemath/check/121_multiplicative_group_of_cc/logs/` に保存してある（この表の数値はそのログから取った）。
