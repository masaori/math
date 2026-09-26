# SageMath Check: 258_center_of_multiplicative_group_is_scalar

## 対象

**対象ラベル**: `center_of_multiplicative_group_is_scalar` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.ts`

- 範囲: Z(R^×) = {cI | c ∈ C∖{0}}

すべての生成元と可換な W の空間が 1 次元であることを連立一次方程式の特異値で確認し、スカラー行列が実際に中心に属すること（正則性込み）と、非スカラーは属さないことを両方見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_center.sage` | 解空間の次元、スカラーの所属、非スカラーの非所属 | 93 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

253 は独立した直後の主張 <injectivity_of_T_up_to_scalar> を対象にしている。

## 実行時に出力された観測値

```
  M=1: すべての生成元と可換な W の空間の次元 = 1
  M=2: すべての生成元と可換な W の空間の次元 = 1
  M=3: すべての生成元と可換な W の空間の次元 = 1
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 258
```

実行ログは `sagemath/check/258_center_of_multiplicative_group_is_scalar/logs/` に保存してある（この表の数値はそのログから取った）。
