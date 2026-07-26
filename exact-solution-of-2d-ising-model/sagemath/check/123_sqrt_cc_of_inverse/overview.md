# SageMath Check: 123_sqrt_cc_of_inverse

## 対象

**対象ラベル**: `sqrt_cc_of_inverse` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.mjs`

- 範囲: (√z)^{-1} = 1/√z = ±√(1/z)

arg z = 0 のときだけ符号が一致する。arg が 0 の「すぐ上」は倍精度で分岐が定まらないので境界として分離している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_sqrt_of_inverse.sage` | 場合分けの両方と境界 | 155 | 4.965e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

111 は同じ内容を √(1/z) の側から述べた <inverse_of_sqrt_cc> を対象にしている。両者は同値だが別ラベルなので独立に張っている。

## 実行時に出力された観測値

```
  arg=0 の場合 3 件、0<arg<2pi の場合 73 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 123
```

実行ログは `sagemath/check/123_sqrt_cc_of_inverse/logs/` に保存してある（この表の数値はそのログから取った）。
