# SageMath Check: 135_real_exp_series_converges

## 対象

**対象ラベル**: `real_exp_series_converges` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: (1) 単調非減少・上に有界、(2) E_N(a) ≤ E(a)、(3) 剰余 R_N(a) → 0 と Σ_{m=p}^{q} a^m/m! ≤ R_{p-1}(a)

a = 0 から 20 まで振って、部分和の単調性・上界・剰余評価を確認する。(3) の部分和の評価は p,q の複数の組で見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_real_series.sage` | (1)〜(3) | 168 | 4.018e-16 | **PASS** |
| 02 | `check_02_step2_bound.sage` | 証明 Step 2 の上界 C = E_{m₀−1}(a) + 2a^{m₀}/m₀! の構成そのもの | 1089 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

01 は (1)〜(3) の**帰結**（単調性・上界の存在・剰余 → 0）を見ている。02 は Step 2 が上界 C を作る手順そのものを追う: m₀ ≥ 2a なる整数について (i) a^{m+1}/(m+1)! ≤ (1/2)·a^m/m!（m ≥ m₀）、(ii) a^{m₀+k}/(m₀+k)! ≤ (1/2)^k·a^{m₀}/m₀!、(iii) Σ_{m=m₀}^{N} a^m/m! ≤ 2a^{m₀}/m₀!、(iv) E_N(a) ≤ C が全 N で成立し e^a ≤ C であること。a は 0〜20 に加え、Ising 側の指数の肩のノルム ‖iK₁H₁‖・‖iK₂*H₂‖（臨界点近傍のパラメータを含む）も実際に使っている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 135
```

実行ログは `sagemath/check/135_real_exp_series_converges/logs/` に保存してある（この表の数値はそのログから取った）。
