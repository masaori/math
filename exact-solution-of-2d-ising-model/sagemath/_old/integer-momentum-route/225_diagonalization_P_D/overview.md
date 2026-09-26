# SageMath Check: 225_diagonalization_P_D

## 対象

**対象ラベル**: `diagonalization_P_D` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.ts`

- 範囲: A(θ_μ) = P_μ D_μ P_μ^{-1}

P_μ の可逆性（行列式）と条件数を記録したうえで、対角化を確認する。γ₂ = 0 の μ は P_μ が定義されないので除外している。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_PDPinv.sage` | 対角化と P_μ の可逆性・条件数 | 616 | 5.168e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  P_mu の条件数の最大値: 1.000000e+00
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 225
```

実行ログは `sagemath/check/225_diagonalization_P_D/logs/` に保存してある（この表の数値はそのログから取った）。
