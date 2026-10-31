# SageMath Check: critical_point_sinh_K_c_and_second_derivative_log_divergence

## 対象

**対象ラベル**: `critical_point_sinh_K_c_and_second_derivative_log_divergence` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/critical_point_and_log_divergence.ts`
  （ブロック `critical_point_claim_sinh_K_c_and_second_derivative_log_divergence`）
- 主張: `K_1 = K_2 = K > 0`、`f(K) := (1/2) log(2 sinh 2K) + (1/4π)∫_0^{2π} γ(θ) dθ` について
  (1) `kappa_of_K_basic` の `K_c`（`sinh 2K_c = 1` で定めたもの）は `K_c = (1/2) log(1+√2) > 0` を満たし、`sinh 2K = 1` を満たす `ℝ_{>0}` の元は `K_c` だけ、
  (2) `0 < |K−K_c| ≤ 1/10` で `|f''(K) − (8/π) log(1/|K−K_c|)| ≤ 49`
- 範囲: proof の (1)（`kappa_of_K_basic` の `K_c` と `K_c > 0` の式変形）、(2) の式変形
  （`f = (1/2) log(2 sinh 2K) + G(κ(K))`）と、引いた不等式（`specific_heat_log_divergence`）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
|---------|---------|-----------|------|
| check_goal_chain.sage | (1) `x := exp(2K_c) = 1+√2` として `sinh 2K_c = (x − 1/x)/2 = 1` と `x > 1`（`K_c > 0`）を QQbar で厳密に確かめる。一意性は `sinh` の狭義単調性によるので、`K = 0.001,…,3` で `sinh 2K − 1` の符号の変化が 1 回であることを例示として見る。(2) arccosh 表示の `f` と `(1/2) log(2 sinh 2K) + G(κ(K))` の一致（6 点）。`|K−K_c| ∈ {0.1, 0.05, 0.01, 1e-3, 1e-6, 1e-12, 1e-24}` の両側で `|f'' − (8/π) log(1/|K−K_c|)| ≤ 49`。`|K−K_c| ≥ 1e-3` では arccosh 表示の `f` を直接 2 回微分した値とも比べる。否定コントロール: (1) を `K_c' = (1/2) log 2` にしたもの、(2) の係数を `4/π` にしたものが成り立たないこと | PASS | (1) 厳密に成立、符号の変化 1 回。(2) 二つの表示の差 ≤ 4.6e-41、2 回微分した値の差 0（作業精度 40 桁で一致）。誤差の最大 4.29（≤ 49）。否定コントロールはどちらも破れた（`sinh 2K_c' = 3/4`、係数 `4/π` は `|K−K_c| = 1e-24` で誤差 > 49） |

## 備考

- **ℝ 脱出（実対数・積分）**: `f` は実対数と Riemann 積分の値なので厳密計算できない。mpmath（dps=40）で計算した。
  (1) は代数的数だけで書けるので QQbar で厳密に確かめた。
- `f''` は数値微分（`mp.diff`）で作った。2 回微分可能であることそのものは数値では確かめられない。
- 共通定義は `055_claim_critical_point/_prelude.sage` を使う。

## 実行方法

```bash
cd sagemath/check/critical_point_sinh_K_c_and_second_derivative_log_divergence
sage check_goal_chain.sage
```

実行ログは `logs/` に保存してある（2026-10-31）。
