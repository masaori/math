# SageMath Check: 259_T_Vprime_fixes_hatZ_hatY_when_gamma2_zero

## 対象

**対象ラベル**: `T_Vprime_fixes_hatZ_hatY_when_gamma2_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part2.ts`

- 範囲: γ₂(θ_μ) = 0 のとき T_{(V′)} が hatZ^{(−)}_μ, hatY_μ を固定すること

**臨界点ちょうどに乗せたパラメータ**（K₁ = arcsinh(1/sinh 2K₂)/2）でのみ γ₂ = 0 が起きるので、そこを狙って踏む。踏んだ事例数を出力しており、検証が空回りしていないことが確認できる。そこで A(θ_μ) = I になることも併せて見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_fixed.sage` | T_(V′) による固定と A = I | 73 | 1.741e-14 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

256 は同じ状況を T_(V) = T_(V′) の側から見ている。

## 実行時に出力された観測値

```
  gamma_2 = 0 を実際に踏んだ (M,mu,K2) の事例: 24 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 259
```

実行ログは `sagemath/check/259_T_Vprime_fixes_hatZ_hatY_when_gamma2_zero/logs/` に保存してある（この表の数値はそのログから取った）。
