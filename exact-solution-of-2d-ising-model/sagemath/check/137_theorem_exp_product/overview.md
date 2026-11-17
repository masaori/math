# SageMath Check: 137_theorem_exp_product

## 対象

**対象ラベル**: `theorem_exp_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`

- 範囲: AB=BA ⟹ exp A exp B = exp(A+B)

可換な組（同じ行列の多項式、対角行列）で等式を確認し、**非可換な組では実際に破れる**ことも数えている。可換性の仮定が本質的であることの確認。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_exp_product.sage` | 可換な場合の等式と、非可換な場合に破れること | 76 | 5.972e-16 | **PASS** |
| 02 | `check_02_step5_remainder_bound_row.sage` | Step 5 の鎖の最後の不等号 ‖I‖²((Σ_{j=P_N}^{N}a^j/j!)(Σ_{l=0}^{N}b^l/l!) + (Σ_{j=0}^{N}a^j/j!)(Σ_{l=P_N}^{N}b^l/l!)) ≤ ‖I‖²(R_{P_N−1}(a)E(b) + E(a)R_{P_N−1}(b))（real_exp_series_converges (2)(3)）。各因子への (3)（p = P_N, q = N。P_N ≤ N のとき。P_N > N となる N = 0 では空の和 0 を (3) の前半の R_{P_N−1} ≥ 0 で抑える）と (2)、積へ運ぶのに使う各因子の非負性、行そのものを、部分和は QQ で厳密に作る。E・R は ℝ にしか住まないので、E(a) を exp(a) として RealIntervalField(256) の区間で囲み、区間の上端 ≤ 下端で比べる（ℝ への脱出）。a ∈ {0, 1/2, 2, 9/2}、b ∈ {0, 1, 3}、N = 0〜14、‖I‖² ∈ {1, 4, 7}。否定の対照 1 件（剰余の添字を N にすると抑えられない） | 1441 | 0 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  非可換な組で等式が破れた事例: 30 件（可換性の仮定が本質的）
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 137
```

実行ログは `sagemath/check/137_theorem_exp_product/logs/` に保存してある（この表の数値はそのログから取った）。
